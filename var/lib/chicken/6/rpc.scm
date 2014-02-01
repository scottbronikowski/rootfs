;;;; rpc.scm
;;;; A flexible peer-to-peer RPC system


(module rpc (rpc:publish-procedure!
	     rpc:withdraw-procedure!
	     rpc:default-server-port rpc:connect-procedure
	     rpc:is-connected? rpc:get-connection
	     rpc:close-connection! rpc:close-all-connections!
	     rpc:current-peer
	     rpc:procedure
	     rpc:make-server)
  (import scheme chicken)

(use extras srfi-18 srfi-69 tcp tcp-server s11n data-structures ports)
(import matchable)

;;; Published procedures management

(define name->procedure-map
  (make-mutex 'name->procedure-map))
(mutex-specific-set!
 name->procedure-map
 (make-hash-table equal?))

(define procedure->name-map
  (make-mutex 'procedure->name-map))
(mutex-specific-set!
 procedure->name-map
 (make-hash-table eqv?))

(define-syntax with-mutex
  (syntax-rules ()
    ((_ mtx var stuff ...)
     (let* ((m mtx)
	    (var (mutex-specific m)))
       (dynamic-wind
	   (cut mutex-lock! m)
	   (lambda () stuff ...)
	   (cut mutex-unlock! m))))))

(define (rpc:publish-procedure! name proc #!optional (callback-outgoing? #t))
  (with-mutex name->procedure-map n->p
    (hash-table-set! n->p name proc))
  (if callback-outgoing?
      (with-mutex procedure->name-map p->n
	(hash-table-set! p->n proc name))))

(define (rpc:withdraw-procedure! name-or-procedure)
  (if (procedure? name-or-procedure)
      (with-mutex procedure->name-map p->n
	(let ((n (hash-table-ref p->n name-or-procedure)))
	  (hash-table-delete! p->n name-or-procedure)
	  (with-mutex name->procedure-map n->p
	    (hash-table-delete! n->p n))))
      (with-mutex name->procedure-map n->p
	(let ((p (hash-table-ref n->p name-or-procedure)))
	  (hash-table-delete! n->p name-or-procedure)
	  (with-mutex procedure->name-map p->n
	    (hash-table-delete! p->n p))))))

;;; RPC connections management

(define rpc:default-server-port
  (make-parameter 29296))

(define rpc:connect-procedure
  (make-parameter tcp-connect))

;; !!! Do make sure that this is set to a different value for every thread !!!
(define connections
  (make-parameter (make-hash-table equal?)))
(define connections-owner
  (make-parameter (current-thread)))

(define (ensure-local-connections)
  (unless (eq? (connections-owner) (current-thread))
    (connections (make-hash-table equal?))
    (connections-owner (current-thread))))

(define (rpc:is-connected? host #!optional (port (rpc:default-server-port)))
  (ensure-local-connections)
  (hash-table-exists?
   (connections) (if port (sprintf "~a:~a" host port) host)))

(define (rpc:get-connection host #!optional (port (rpc:default-server-port)))
  (ensure-local-connections)
  (let ((key (if port (sprintf "~a:~a" host port) host)))
    (apply
     values
     (hash-table-ref
      (connections) key
      (lambda ()
	(let ((con (receive ((rpc:connect-procedure) host port))))
	  (hash-table-set! (connections) key con)
	  con))))))

(define (rpc:close-connection! host #!optional (port (rpc:default-server-port)))
  (ensure-local-connections)
  (let ((key (if port (sprintf "~a:~a" host port) host)))
    (let ((con (hash-table-ref (connections) key)))
      (hash-table-delete! (connections) key)
      (close-input-port (car con))
      (close-output-port (cadr con)))))

(define (rpc:close-all-connections!)
  (ensure-local-connections)
  (hash-table-walk
   (connections)
   (lambda (key con)
      (hash-table-delete! (connections) key)
      (close-input-port (car con))
      (close-output-port (cadr con)))))

;;; Client side functionality

(define rpc:current-peer
  (make-parameter #f))

(define (make-callback name)
  (lambda params
    (apply (rpc:procedure name (rpc:current-peer)) params)))

(define (rpc:procedure name host #!optional (port (rpc:default-server-port)))
  (lambda params
    (let-values (((in out) (rpc:get-connection host port)))
      (serialize
       (append
	(list 'call name)
	(map
	 (lambda (p)
	   (call-with-current-continuation
	    (lambda (q)
	      (with-mutex procedure->name-map p->n
		(make-callback
		 (hash-table-ref p->n p (lambda () (q p))))))))
	 params))
       out)
      (match (deserialize in)
	(('results o e . r)
	 (display o (current-output-port))
	 (display e (current-error-port))
	 (apply values r))
	(('exception . x)
	 (signal x))
	(any
	 (signal
	  (make-composite-condition
	   (make-property-condition
	    'exn
	    'message "reply from RPC server not understood"
	    'location 'rpc:procedure
	    'arguments (list any))
	   (make-property-condition
	    'rpc))))))))

;;; Server side functionality

(define (rpc:make-server listener)
  (make-tcp-server
   listener
   (lambda ()
     (rpc:current-peer
      (call-with-values
	  (cut (tcp-server-get-addresses-procedure) (current-input-port))
	(lambda (local remote) remote)))
     (let loop ()
       (unless (eof-object? (peek-char))
	 (let ((req (deserialize)))
	   (unless (eq? req (void))
	     (match req
	       (('call name . params)
		(handle-exceptions ex
		    (serialize (cons 'exception ex))
		  (let* ((p (with-mutex name->procedure-map n->p
					(hash-table-ref
					 n->p name
					 (lambda ()
					   (signal
					    (make-composite-condition
					     (make-property-condition
					      'exn
					      'message "no such public procedure"
					      'location 'rpc:server
					      'arguments (list name))
					     (make-property-condition
					      'rpc)))))))
			 (o (open-output-string))
			 (e (open-output-string))
			 (r
			  (parameterize ((current-input-port
					  (make-input-port
					   (constantly #!eof)
					   (constantly #f)
					   void
					   (constantly #!eof)))
					 (current-output-port o)
					 (current-error-port e))
			    (receive (apply p params)))))
		    (serialize
		     (append
		      (list
		       'results
		       (get-output-string o) (get-output-string e))
		      r)))))
	       (any
		(signal
		 (make-composite-condition
		  (make-property-condition
		   'exn
		   'message "request from RPC client not understood"
		   'location 'rpc:server
		   'arguments (list any))
		  (make-property-condition
		   'rpc)))))
	     (loop))))))))

)
