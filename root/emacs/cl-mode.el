;;; cl-mode.el -- improved Common Lisp mode
;;;
;;; Copyright (C) 1988 Evans & Sutherland Computer Corporation
;;;
;;;
;;; Revision History
;;;
;;; Sandra Loosemore, Mon Mar 21 13:23:52 1988
;;;    Initial version
;;;


;;; Make some characters back into word characters

(modify-syntax-entry ?_ "w   " lisp-mode-syntax-table)
(modify-syntax-entry ?: "w   " lisp-mode-syntax-table)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;    Change some of the key bindings
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Reindent the current defun.  Unlike indent-sexp, this will work with the
;;;    cursor positioned anywhere inside the form.

(defun reindent-current-form ()
    (interactive)
    (save-excursion
        (beginning-of-defun)
        (indent-sexp)))


;;; Create a block comment.

(defun comment-header (comment)
    (interactive "sComment: ")
    (newline)
    (insert "")
    (newline)
    (make-comment-line)
    (insert ";;;\n")
    (insert ";;;    ")
    (insert comment)
    (newline)
    (insert ";;;\n")
    (make-comment-line)
    (newline))

(defun make-comment-line ()
    (let ((i  1))
	(while (< i 78)
	    (insert ";")
	    (setq i (+ 1 i)))
	(newline)))


;;; Add a standard file header at the beginning of the buffer.
;;; The global variable my-name holds the user's full name for including
;;;    in the header.

(defun insert-author-and-date ()
    (insert ";;;\n")
    (insert ";;; Qobi")
    (insert ", ")
    (insert (current-time-string))
    (insert "\n"))

(defun insert-standard-header (description)
    (insert ";;; ")
    (insert (buffer-name))
    (insert " -- ")
    (insert description)
    (insert "\n;;;\n;;; Copyright (C) ")
    (insert (substring (current-time-string) -4))
    (insert " Jeffrey Mark Siskind\n")
    (insert ";;;\n")
    (insert ";;;\n")
    (insert ";;; Revision History\n")
    (insert-author-and-date)
    (insert ";;;    Initial version\n;;;\n"))

(defun insert-revision-note (description)
    (next-line 1)
    (beginning-of-line)
    (insert-author-and-date)
    (insert ";;;    ")
    (insert description)
    (insert "\n"))

(defun file-header (description)
    (interactive "sDescription: ")
    (save-excursion
	(beginning-of-buffer)
	(if (condition-case ()
		    (progn (search-forward "Revision History") t)
		(error nil))
	    (insert-revision-note description)
	    (insert-standard-header description))))


;;; Establish the new key bindings

(define-key lisp-mode-map "\t" 'lisp-indent-line)
;(define-key lisp-mode-map "\e;" 'comment-header)
(define-key lisp-mode-map "\eh" 'file-header)
