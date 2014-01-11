;;; Renamed buffer-change-hook to after-change-function for emacs-19.
;;; Also new version of automatically-mark-change-lisp.

(require 'ilisp)
(load "ilisp-bat")

(defun safe-lisp-defun-begin ()
 ;; obsolete
 (let ((c (point)))
  (catch 'exit
   (while (> c (point-min))
    (if (and (< c (point-max))
	     (= (char-after c) ?\()
	     (= (char-after (1- c)) ?\C-j))
	(throw 'exit c))
    (setq c (1- c)))
   (point-min))))

(defun automatically-mark-change-lisp-18 ()
 ;; obsolete
 (let ((c (safe-lisp-defun-begin)))
  (if (and (not (equal (buffer-name) "*ilisp-send*"))
	   (not (lisp-memk c lisp-changes 'marker-position)))
      (let ((new (make-marker)))
       (set-marker new c)
       (setq lisp-changes (cons new lisp-changes))))))

(defun automatically-mark-change-lisp (beginning end length)
 (save-match-data
  (save-excursion
   (goto-char beginning)
   (beginning-of-defun)
   (let ((c (point)))
    (if (and (not (equal (buffer-name) "*ilisp-send*"))
	     (not (lisp-memk c lisp-changes 'marker-position)))
	(let ((new (make-marker)))
	 (set-marker new c)
	 (setq lisp-changes (cons new lisp-changes))))))))

(defun lisp-change-name (change)
 (save-excursion
  (set-buffer (marker-buffer change))
  (goto-char change)
  (lisp-def-name)))

(defun valid-lisp-change (change)
 (save-excursion
  (set-buffer (marker-buffer change))
  (goto-char change)
  (lisp-defun-begin)
  (= change (point))))

(defun empty-lisp-change (change)
 (save-excursion
  (set-buffer (marker-buffer change))
  (goto-char change)
  (lisp-def-name)
  (forward-sexp)
  (= change (point))))

(defun duplicate-lisp-change (name changes)
 (and (not (null changes))
      (or (equal name (lisp-change-name (car changes)))
	  (duplicate-lisp-change name (cdr changes)))))

(defun munge-lisp-changes ()
 (let ((new-changes nil)
       (old-changes lisp-changes))
  (while old-changes
   (let ((change (car old-changes)))
    (if (and (marker-buffer change)
	     (valid-lisp-change change)
	     (not (empty-lisp-change change))
	     (not (duplicate-lisp-change (lisp-change-name change)
					 new-changes)))
	(setq new-changes (cons change new-changes))
	(set-marker change nil)))
   (setq old-changes (cdr old-changes)))
  (setq lisp-changes (reverse new-changes))))

(defun list-changes-lisp ()
 "List the name of LISP forms currently marked as being changed."
 (interactive)
 (munge-lisp-changes)
 (let ((names (reverse (mapcar (function lisp-change-name) lisp-changes))))
  (if names
      (with-output-to-temp-buffer "*Changed-Definitions*"
       (display-completion-list names)
       (save-excursion
	(set-buffer "*Changed-Definitions*")
	(goto-char (point-min))
	(kill-line)
	(insert "Changed LISP forms:")))
      (error "No changed definitions"))))

(defun lisp-changes (command message)
 "Apply COMMAND to each of the changes and use MESSAGE to print a
message given the name of the change.  If there is a positive prefix,
the change list will not be changed."
 (munge-lisp-changes)
 (save-excursion
  (set-buffer (ilisp-buffer))
  (let ((keep (and current-prefix-arg (not (eq current-prefix-arg '-))))
	(changes (reverse lisp-changes))
	(lisp-wait-p nil))
   (setq ilisp-pending-changes (nconc ilisp-pending-changes changes)
	 current-prefix-arg nil)	;Prevent buffer insertion
   (if comint-queue-emptied
       (save-excursion
	(setq comint-queue-emptied nil)
	(set-buffer (get-buffer-create "*Errors*"))
	(delete-region (point-min) (point-max))))
   (while changes
    (let* ((change (car changes))
	   name)
     (set-buffer (marker-buffer change))
     (goto-char change)
     (setq name (lisp-def-name))
     (forward-sexp)
     (funcall command change (point) nil (format message name)
	      nil 'lisp-change-handler)
     (setq changes (cdr changes))))
   (comint-send-code
    (ilisp-process)
    (function (lambda ()
     (save-excursion
      (set-buffer (get-buffer-create "*Last-Changes*"))
      (delete-region (point-min) (point-max))
      (insert (save-excursion
	       (set-buffer "*Errors*")
	       (buffer-string)))))))
   (if lisp-changes
       (if keep
	   (message "Started, but keeping changes")
	   (message "Started changes")
	   (setq lisp-changes nil))
       (error "No changed definitions")))))

(defun toggle-automatic-change-marking-lisp ()
 (interactive)
 (cond (after-change-function
	(setq after-change-function nil)
	(message "Automatic marking of lisp changes now disabled"))
       (t (setq after-change-function 'automatically-mark-change-lisp)
	  (message "Automatic marking of lisp changes now enabled"))))

(setq lisp-mode-hook
      (function (lambda ()
       (make-local-variable 'after-change-function)
       (setq after-change-function 'automatically-mark-change-lisp))))

(let ((ilisp-prefix (concat ilisp-prefix "*")))
 (ilisp-defkey ilisp-mode-map "a" 'toggle-automatic-change-marking-lisp)
 (if (boundp 'lisp-mode-map)
     (ilisp-defkey lisp-mode-map "a" 'toggle-automatic-change-marking-lisp))
 (if (boundp 'scheme-mode-map)
     (ilisp-defkey scheme-mode-map "a" 'toggle-automatic-change-marking-lisp)))
(defkey-ilisp "\M-A" 'toggle-automatic-change-marking-lisp)
(defkey-ilisp "\M-C" 'compile-changes-lisp)
(defkey-ilisp "\M-E" 'eval-changes-lisp)
(defkey-ilisp "\M-L" 'list-changes-lisp)
(defkey-ilisp "\M-Z" 'clear-changes-lisp)
