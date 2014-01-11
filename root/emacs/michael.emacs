(setq load-path (cons "/usr/staff/michael/emacs" load-path))

;;; Now load improved definitions for editing Common Lisp code.

(load-library "cl-mode")


;;; Redefine the parentheses blinker so it will always blink the cursor,
;;;	and never just echo the line with the matching paren.
;;; It appears that the time passed to "sit-for" must include the time 
;;;     necessary to redraw the screen, so I make a guess based on baud-rate.

(defun blink-matching-open ()
  "Move cursor momentarily to the beginning of the sexp before point."
  (and (> (point) (1+ (point-min)))
       (/= (char-syntax (char-after (- (point) 2))) ?\\ )
       blink-matching-paren
       (let* ((oldpos (point))
	      (blinkpos)
	      (mismatch))
	 (save-excursion
	     (condition-case ()
		 (setq blinkpos (scan-sexps oldpos -1))
	         (error nil))
	     (and blinkpos (/= (char-syntax (char-after blinkpos))
	  		     ?\$)
	  	  (setq mismatch
		      (/= (char-after (1- oldpos))
			  (logand (lsh (aref (syntax-table)
					     (char-after blinkpos))
				       -8)
				  255))))
             (cond (mismatch				  
		    (message "Mismatched parentheses"))
	           (blinkpos
	  	    (goto-char blinkpos)
		    (if (pos-visible-in-window-p)
			(sit-for 1)
		        (sit-for (+ 1 (/ 4800 (baud-rate)))))
		   ))))))

   
;;; This variable controls what mode GNU goes into when editing various
;;;    kinds of files.  This list is somewhat different than its default
;;;    value, and corresponds to the kinds of files I usually edit.

(setq auto-mode-alist
      '(("\\.txt$" . text-mode)
	("\\.doc$" . text-mode)
	("\\.mai$" . text-mode)
	("\\.tex$" . LaTeX-mode)
	("\\.l$"   . lisp-mode)
	("\\.lsp$" . lisp-mode)
	("\\.lisp$" . lisp-mode)
	("\\.cl$"  . lisp-mode)
	("\\.el$" . emacs-lisp-mode)
	("\\.c$" . c-mode)
	("\\.h$" . c-mode)
	("\\.sty$" . LaTeX-mode)
	("\\.bbl$" . LaTeX-mode)
	("\\.bib$" . latex-bib-mode)
	("\\.texinfo$" . texinfo-mode)
	("[]>:/]\\..*emacs" . emacs-lisp-mode)
	("\\.ml$" . lisp-mode)))

(autoload 'latex-bib-mode "latex-bib")


;;; Don't complain when I try to do things that are disabled by default.





(setq make-backup-files nil)


;;; C indenting style - classic but compact :-)

(setq c-indent-level 4)
(setq c-continued-statement-offset 4)
(setq c-argdecl-indent 0)
(setq c-label-offset -4)



(put 'eval-expression 'disabled nil)
