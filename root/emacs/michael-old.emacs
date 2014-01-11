;;; Setup for bobcat stuff

;;; Can you believe that ELisp doesn't have member !?!?

(defun member (x lis)
  (cond ((null lis) nil)
	((equal x (car lis)) lis)
	(t (member x (cdr lis)))))

;(load "paths")
;(load "rmail")
;(load "time")
;(display-time)
;(load "dabbrevs")

(load "term/bobcat")


;; Get my terminal type.

(setq TERMTYPE (getenv "TERM"))

(cond ((equal TERMTYPE "hp9836")
       (set-screen-height 36))
      ; Gnu can deal with the X window system correctly, but only from vaxen
      ;  or suns. Bobcats still have a problem.
      ((member TERMTYPE '("xterm" "xterms"))
       (load "term/x-win")  ; Have to load this for Gnu to work in X.
;       (load "x-mouse")
;       (load "utah/new-mouse")
; comment next line out for X11...
;       (x-create-x-window "=80x40+200+100")
       (x-set-font "9x15")
       (x-set-background-color "black")
       (x-set-foreground-color "white")
       (x-set-cursor-color "white")
;       (x-set-mouse-color "black")
       (x-set-border-color "green")))


;;; Figure out which machine so some details get set properly

(setq MACHINE (getenv "HOST"))

;(cond ((member MACHINE '("orion" "cs" "gr"))   ; case for Vaxen...
;       ; All the stuff is really on cs-vax
;       (setq exec-directory "/n/cs/usr/site/lib/emacs/etc/")
;       (setq load-path '("/u/shebs/emacs"
;			 "/u/stoller/gnu"
;			 "/usr/local/lib/gnu/lisp"
;			 "/usr/site/lib/emacs/lisp"))
;       (setq lisp-startup "pcls")
;      )
;      ((member MACHINE '("jensen" "jaguar"))
;      )
;      (t  ; assumes vanilla Bobcat
;       (setq lisp-startup "/lisp/bin/cl")
;      )
;)


;;; Make load look for local hacks first.

(setq load-path (cons "/usr/staff/sandra/emacs" load-path))


;;; I don't want to have to retrain my fingers, so use Gosling's bindings

(set-gosmacs-bindings)


;;; Autosaving is done by default, but I want it turned off.

(setq auto-save-default nil)


;;; Why isn't this bound to anything?

(global-set-key "\ej" 'fill-paragraph)

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


