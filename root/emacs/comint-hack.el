;;;
;;; Similar input -- contributed by ccm and highly winning.
;;;
;;; Reenter input, removing back to the last insert point if it exists. 
;;;

(require 'comint)

(setq comint-input-ring-size 1000)

(defvar comint-last-similar-string "" 
 "The string last used in a similar string search.")

(defun comint-previous-similar-input (arg)
 "Fetch the previous (older) input that matches the string typed so far.
Successive repetitions find successively older matching inputs.
a negative argument
fetches following (more recent) inputs."
 (interactive "p")
 (if (not (comint-after-pmark-p))
     (error "Not after process mark"))
 (if (null comint-input-ring-index)
     (setq comint-input-ring-index
	   (if (> arg 0) -1
	       (if (< arg 0) 1 0))))
 (if (not (or (eq last-command 'comint-previous-similar-input)
	      (eq last-command 'comint-next-similar-input)))
     (setq comint-last-similar-string 
	   (buffer-substring 
	    (process-mark (get-buffer-process (current-buffer)))
	    (point))))
 (let* ((size (length comint-last-similar-string))
	(len (ring-length comint-input-ring))
	(n (+ comint-input-ring-index arg))
	entry)
  (while (and (< n len) 
	      (or (< (length (setq entry (ring-ref comint-input-ring n))) size)
		  (not (equal comint-last-similar-string 
			      (substring entry 0 size)))))
   (setq n (+ n arg)))
  (cond ((< n len)
	 (setq comint-input-ring-index n)
	 (if (or (eq last-command 'comint-previous-similar-input)
		 (eq last-command 'comint-next-similar-input))
	     (delete-region (mark) (point)) ; repeat
	     (push-mark (point)))	; 1st time
	 (insert (substring entry size)))
	(t (error "Not found")))
  (message "%d" (1+ comint-input-ring-index))))

(defun comint-next-similar-input (arg)
 "Fetch the next (newer) input that matches the string typed so far.
Successive repetitions find successively newer matching inputs.
A prefix argument serves as a repeat count; a negative argument
fetches previous (older) inputs."
 (interactive "p")
 (comint-previous-similar-input (- arg)))

(define-key comint-mode-map "\er" 'comint-previous-similar-input)
(define-key comint-mode-map "\es" 'comint-next-similar-input)
