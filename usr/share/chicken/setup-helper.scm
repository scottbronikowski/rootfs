;;;; setup-helper.scm -*- Hen -*-
;;;; Kon Lovett, Mar '09

;;Issues
;;
;; - Accepts anything as a pathname component (see '->string' use).
;;
;; - Static support is limited.

;;; Release 4 Only!

(use
  srfi-1
  posix
  extras
  data-structures
  files
  setup-api)

(define *has-emit-inline* #f)
(define *has-emit-types* #f)
(when (version>=? (chicken-version) "4.0.0")
  (set! *has-emit-inline* #t) )
(when (version>=? (chicken-version) "4.7.3")
  (set! *has-emit-types* #t) )

;;; Extension Information

(define (verify-extension-name nam)
  (let ((extnam (->string nam)))
    (unless (string=? extnam (extension-name))
      (error "unexpected extension-name" extnam (extension-name)) ) ) )

;;; Support

;; Simple type error report

(define (sh:error-type loc obj #!optional typmsg)
  (let* ((msg "bad argument type")
         (msg (if typmsg (string-append msg " - not a " typmsg))) )
    (##sys#signal-hook #:type-error loc msg obj) ) )

;; Filename Support

(define CHICKEN-SOURCE-EXTENSION "scm")
(define CHICKEN-IMPORT-EXTENSION "import")
(define CHICKEN-INLINE-EXTENSION "inline")
(define CHICKEN-TYPES-EXTENSION "types")
(define HTML-EXTENSION "html")
(define STATIC-ARCHIVE-EXTENSION "a")
(define OBJECT-BINARY-EXTENSION "o")
(cond-expand
  (windows
    (define EXECUTABLE-EXTENSION "exe")
    (define DIRECTORY-SEPARATOR "\\") )
  (else
    (define EXECUTABLE-EXTENSION #f)
    (define DIRECTORY-SEPARATOR "/") ) )

(define (installation-chicken-home)
  (if (not (installation-prefix)) (chicken-home)
    (make-pathname `(,(installation-prefix) "share") "chicken") ) )

; from repo-path in setup-helper.scm
(define (installation-repository-path)
  (if (deployment-mode)
    (installation-prefix) ; deploy: copy directly into destdir
    (let ((p (destination-prefix)))
      (if p
        ; installation-prefix changed: use it
        (make-pathname p (sprintf "lib/chicken/~a" (##sys#fudge 42)))
        ; otherwise use repo-path
        (repository-path) ) ) ) )

(define (directory-separator? obj)
  (string=? (->string obj) DIRECTORY-SEPARATOR) )

(define (filename bn #!optional en)
  (make-pathname #f (->string bn) (and en (->string en))) )

(define (make-directory-name dir)
  (let ((dir (if (symbol? dir) (symbol->string dir) dir)))
    (cond
      ((string? dir)
        (let ((end (sub1 (string-length dir))))
          (if (not (directory-separator? (string-ref dir end))) dir
              (substring dir 0 end) ) ) )
      ((pair? dir)
        (let ((len (length dir)))
          (if (= 1 len) (->string (car dir))
              ;Ensures no trailing directory separator.
              (make-pathname
                (map ->string (take dir (sub1 len)))
                (->string (last dir))) ) ) )
      (else
        (sh:error-type 'make-directory-name dir) ) ) ) )

(define (document-filename bn)
  (filename bn HTML-EXTENSION) )

(define (source-filename bn)
  (filename bn CHICKEN-SOURCE-EXTENSION) )

(define (shared-library-filename bn)
  (filename bn ##sys#load-library-extension) )

(define (shared-filename bn)
  (filename bn ##sys#load-dynamic-extension) )

(define (static-library-filename bn)
  (filename bn STATIC-ARCHIVE-EXTENSION) )

(define (static-filename bn)
  (filename bn OBJECT-BINARY-EXTENSION) )

(define (import-filename bn)
  (filename bn CHICKEN-IMPORT-EXTENSION) )

(define (source-import-filename bn)
  (source-filename (import-filename bn)) )

(define (shared-import-filename bn)
  (shared-filename (import-filename bn)) )

(define (inline-filename bn)
  (filename bn CHICKEN-INLINE-EXTENSION) )

(define (types-filename bn)
  (filename bn CHICKEN-TYPES-EXTENSION) )

(define (program-filename bn)
 (filename bn EXECUTABLE-EXTENSION) )

(define (make-home-pathname bn)
  (make-pathname (installation-chicken-home) bn) )

(define (make-repository-pathname bn)
  (make-pathname (installation-repository-path) bn) )

;; File Support

;This subverts the "installation-prefix" relative insurance.
;(and uses the builtin to-path creation "feature").

(define (copy-file-relative fn dn)
  (copy-file `(,fn ,fn) dn #t dn) )

;Keeps the "installation-prefix" relative insurance.
;(and uses the builtin to-path creation "feature").

(define (copy-file-absolute fn dn)
  (copy-file `(,fn ,fn) dn) )

(define (copy-file-to-directory fn dn)
  (copy-file-relative fn dn) )

(define (copy-to-installation-repository fn)
  (copy-file-relative fn (installation-repository-path)) )

(define (copy-to-repository fn)
  (copy-to-installation-repository fn) )

(define (copy-to-home fn)
  (copy-file-relative fn (installation-chicken-home)) )

(define (built-filename nam knd)
  (cond
    ((symbol? knd)
      (case knd
        ((static) (static-filename nam))
        ((shared) (shared-filename nam))
        ((inline) (inline-filename nam))
        ((types) (types-filename nam))
        ((import) (shared-import-filename nam))
        ((document) (document-filename nam))
        (else
          (sh:error-type 'built-filename knd "symbolic kind" ) ) ) )
    ((procedure? knd)
      (knd nam) )
    (else
      (sh:error-type 'built-filename knd "symbol or procedure") ) ) )

(define (built-file nam . knds)
  (let loop ((knds (if (and (null? (cdr knds)) (list? (car knds))) (car knds) knds))
            (ls '()))
    (if (null? knds) (reverse ls)
      (let ((gnflnm (built-filename nam (car knds))))
        (loop (cdr knds)
              (if (file-exists? gnflnm) (cons gnflnm ls) ls))) ) ) )

;; Single File Install Support

(define (install-in-repository fn)
  (when (setup-install-mode)
    (copy-to-repository fn) ) )

(define (install-in-home fn)
  (when (setup-install-mode)
    (copy-to-home fn) ) )

;; SRFI-29 Bundle Support

(define (srfi-29-bundles-home)
  (make-repository-pathname "srfi-29-bundles") )

(define (make-srfi-29-bundle-directory-name spec)
  (if (null? spec) (srfi-29-bundles-home)
    (make-directory-name
      (append (list (srfi-29-bundles-home)) spec)) ) )

(define (install-srfi-29-bundle nam . spec)
  (when (setup-install-mode)
    (unless (directory? (srfi-29-bundles-home))
      (error "missing SRFI-29 bundles directory; please install SRFI-29") )
    (let* ((spec (map ->string spec))
           (nam (->string nam))
           (dir (make-srfi-29-bundle-directory-name spec)) )
      ;Explicit curdir ('.') because problems in the past.
      (copy-file
        (make-pathname (append '(".") spec) nam)
        (make-pathname dir nam)
        #t
        dir) ) ) )

;; Compile Support

;FIXME -...o style!
(define (output-file-option compile-options)
  (or (memq '-o compile-options)
      (memq '-output-file compile-options)) )

(define (optional-output-file compile-options)
  (let ((of (output-file-option compile-options)))
    (if of (list (cadr of)) '()) ) )

;;; Compile

;; Default Options

#;
(define include-path-options
  (make-parameter
    (cond-expand
      (macosx    '(-I/opt/local/include -I/sw/include))
      (else      '()))))

#;
(define library-path-options
  (make-parameter
    (cond-expand
      (macosx    '(-L/opt/local/lib -L/sw/lib))
      (else      '()))))

;Bad idea to make `-local' the default for a module compile (but not an import
;compile) since it means something like `fluid-let' cannot be used on an
;exported binding.

;The import filename base must be the module name!
;The inline filename base must be the output name!
;So assume unused when explicit output name.

(define default-static-compile-options
  (make-parameter '(
    -c
    -optimize-leaf-routines -inline)))

(define default-shared-compile-options
  (make-parameter '(
    -shared
    -optimize-leaf-routines -inline)))

(define default-import-compile-options
  (make-parameter '(
    -shared
    -optimize-leaf-routines -inline
    -local
    -no-trace -no-lambda-info)))

;; Compile Action

(define (has-emit-inline inline? nam)
  (if (not (and *has-emit-inline* inline?)) '()
    `(-emit-inline-file ,(inline-filename nam)) ) )

(define (has-emit-types types? nam)
  (if (not (and *has-emit-types* types?)) '()
    `(-emit-type-file ,(types-filename nam)) ) )

;compile expands using back-quote

(define (compile-static nam #!key (options '()) inline? types?)
  (compile
    ,(source-filename nam)
    ,@(default-static-compile-options)
    -unit ,nam
    ,@(if (output-file-option options) '() `(-output-file ,(static-filename nam)))
    ,@(has-emit-inline inline? nam)
    ,@(has-emit-types types? nam)
    ,@options) )

(define (compile-shared nam #!key (options '()) inline? types?)
  (compile
    ,(source-filename nam)
    ,@(default-shared-compile-options)
    ,@(if (output-file-option options) '() `(-output-file ,(shared-filename nam)))
    ,@(has-emit-inline inline? nam)
    ,@(has-emit-types types? nam)
    ,@options) )

(define (compile-static-module nam #!key (options '()) inline? types?)
  (compile
    ,(source-filename nam)
    ,@(default-static-compile-options)
    -unit ,nam
    ,@(if (output-file-option options) '() `(-output-file ,(static-filename nam)))
    -emit-import-library ,nam
    ,@(has-emit-inline inline? nam)
    ,@(has-emit-types types? nam)
    ,@options)
  (compile
    ,(source-import-filename nam)
    ,@(default-import-compile-options)
    -output-file ,(shared-import-filename nam)) )

(define (compile-shared-module nam #!key (options '()) inline? types?)
  (compile
    ,(source-filename nam)
    ,@(default-shared-compile-options)
    ,@(if (output-file-option options) '() `(-output-file ,(shared-filename nam)))
    -emit-import-library ,nam
    ,@(has-emit-inline inline? nam)
    ,@(has-emit-types types? nam)
    ,@options)
  (compile
    ,(source-import-filename nam)
    ,@(default-import-compile-options)
    -output-file ,(shared-import-filename nam)) )

;;; Install

(define default-static-install-options
  (make-parameter '()))

(define default-shared-install-options
  (make-parameter '()))

(define default-static-module-install-options
  (make-parameter '()))

(define default-shared-module-install-options
  (make-parameter '()))

(define default-shared+static-module-install-options
  (make-parameter '()))

;;

(define (install-static-extension nam ver #!key (options '()) (files '()) output-file?)
  (install-extension nam
   `(,@(built-file nam 'static 'inline 'types)
     ,@files)
   `(,@(default-static-install-options)
     (version ,ver)
     ;FIXME what about explicit output file
     (static ,(static-filename nam))
     (documentation ,(document-filename nam))
     ,@options)) )

(define (install-shared-extension nam ver #!key (options '()) (files '()) output-file?)
  (install-extension nam
   `(,@(built-file nam 'shared 'inline 'types)
     ,@files)
   `(,@(default-shared-install-options)
     (version ,ver)
     (documentation ,(document-filename nam))
     ,@options)) )

(define (install-static-extension-module nam ver #!key (options '()) (files '()) output-file?)
  (install-extension nam
   `(,@(built-file nam 'static 'import 'inline 'types)
     ,@files)
   `(,@(default-static-module-install-options)
     (version ,ver)
     ;FIXME what about explicit output file & .a
     (static ,(static-filename nam))
     (documentation ,(document-filename nam))
     ,@options)) )

(define (install-shared-extension-module nam ver #!key (options '()) (files '()) output-file?)
  (install-extension nam
   `(,@(built-file nam 'shared 'import 'inline 'types)
     ,@files)
   `(,@(default-shared-module-install-options)
     (version ,ver)
     (documentation ,(document-filename nam))
     ,@options)) )

(define (install-shared+static-extension-module nam ver
          #!key (options '()) (files '()) shared-output-file? static-output-file?)
  (install-extension nam
   `(,@(built-file nam 'shared 'import 'static 'inline 'types)
     ,@files)
   `(,@(default-shared+static-module-install-options)
     (version ,ver)
     ;FIXME what about explicit output file & .a
     (static ,(static-filename nam))
     (documentation ,(document-filename nam))
     ,@options)) )

;;; Setup

(define (setup-static-extension nam ver
          #!key (compile-options '())
                inline? types?
                (install-options '()) (files '()))
  (let ((files (append files (optional-output-file compile-options))))
    (compile-static nam #:options compile-options #:inline? inline? #:types? types?)
    (install-static-extension nam ver #:options install-options #:files files) ) )

(define (setup-shared-extension nam ver
          #!key (compile-options '())
                inline? types?
                (install-options '()) (files '()))
  (let ((files (append files (optional-output-file compile-options))))
    (compile-shared nam #:options compile-options #:inline? inline? #:types? types?)
    (install-shared-extension nam ver #:options install-options #:files files) ) )

(define (setup-static-extension-module nam ver
          #!key (compile-options '())
                inline? types?
                (install-options '()) (files '()))
  (let ((files (append files (optional-output-file compile-options))))
    (compile-static-module nam #:options compile-options #:inline? inline? #:types? types?)
    (install-static-extension-module nam ver #:options install-options #:files files) ) )

(define (setup-shared-extension-module nam ver
          #!key (compile-options '())
                inline? types?
                (install-options '()) (files '()))
  (let ((files (append files (optional-output-file compile-options))))
    (compile-shared-module nam #:options compile-options #:inline? inline? #:types? types?)
    (install-shared-extension-module nam ver #:options install-options #:files files) ) )

;cannot support -output-file option
(define (setup-shared+static-extension-module nam ver
          #!key (shared-compile-options '())
                (static-compile-options '())
                (compile-options '())
                inline? types?
                (install-options '()) (files '()))
  (compile-shared-module nam
    #:options (append compile-options shared-compile-options)
    #:inline? inline? #:types? types?)
  (compile-static nam #:options (append compile-options static-compile-options))
  (install-shared+static-extension-module nam ver #:options install-options #:files files) )

;; Empty "Conglomerate" Extension Support

(define (install-extension-tag nam ver) (install-extension nam '() `((version ,ver))))
