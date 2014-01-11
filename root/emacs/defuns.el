;;; Changed dot to point for emacs-19
;;; Removed member and manual-entry for emacs-19

;(defun member (element list)
; (cond ((null list) nil)
;       ((equal element (car list)) t)
;       (t (member element (cdr list)))))

(defun remove (item list)
 (cond ((null list) list)
       ((equal item (car list)) (remove item (cdr list)))
       (t (cons (car list) (remove item (cdr list))))))

(defun find-buffer (name list)
 (cond ((null list) (message "No Buffer Editor"))
       ((equal name (buffer-name (car list))) (car list))
       (t (find-buffer name (cdr list)))))

(defun find-buffer-not (name-list list)
 (cond ((null list) (message "No Buffers"))
       ((null (cdr list)) (car list))
       ((member (buffer-name (car list)) name-list)
	(find-buffer-not name-list (cdr list)))
       (t (car list))))

(defun my-list-buffers ()
 "List buffers selecting the buffer editor buffer"
 (interactive)
 (list-buffers)
 (other-window 1)
 ;; This is a real kludge. This used to fix a bug but it appears to be fixed
 ;; in 19.29 or so and later. But I don't know of an easy way to do arithmetic
 ;; on version numbers and I'm too lazy to do this right.
 (cond ((or (equal emacs-version "19.25.3")
	    (equal emacs-version "19.22.21")
	    (equal emacs-version "19.22.20")
	    (equal emacs-version "19.28.1"))
	(next-line 2))))

(defun select-shell ()
 "Select the shell buffer in one window mode"
 (interactive)
 (delete-other-windows)
 (shell))

(defun select-editor ()
 "Select the other buffer in one window mode"
 (interactive)
 (delete-other-windows)
 (switch-to-buffer
  (find-buffer-not '("*Help*" "*shell*" "*scratch*" "*Buffer List*"
		     "*lucid*" "*clim*" "*Completions*" "*Aborted Commands*"
		     "*Errors*" "*Output*" "*Error Output*" "*ilisp-send*"
		     "*Edit-Definitions*" "*All-Callers*" "*Last-Changes*"
		     "*Changed-Definitions*" "*Minibuf-0*" "*mail*" "rmail"
                     "rmail-summary" "*cmushell*")
		   (buffer-list))))

;;; My rmail entry

(defun mhs-rmail (&optional use-temp-file)
 (interactive "P")
 (if (not (null use-temp-file))
     (message "No temporary rmail file"))
 (rmail)
 (rmail-summary)			;Create the summary window
 ;;(summary-two-windows-mode))		;set up my 2 window summary mode
 (other-window 1))			;for now

(defun c-indent-buffer ()
 (interactive)
 (goto-char (point-min))
 (beginning-of-line)
 (c-indent-command)
 (while (not (= (point) (point-max)))
  (beginning-of-line 2)
  (c-indent-command)))

;;; From Olin

(defun switch-to-other-buffer ()
 "Switch window to show previous buffer"
 (interactive)
 (switch-to-buffer (other-buffer)))

(defun move-line-to-top-of-window ()
 "Move the current line to the top of the window"
 (interactive)
 (recenter 0))

(defun move-line-to-bottom-of-window ()
 "Move the current line to the bottom of the window"
 (interactive)
 (recenter -1))

(defun reposition-window-around-defun ()
 "Show as much of the current defun as you can"
 (interactive)
 (let (beginning-visible-p end-visible-p was-at-beginning-p was-at-end-p
			   begin-point end-point)
  (forward-char 1)
  (beginning-of-defun)
  (setq begin-point (point)
	beginning-visible-p (pos-visible-in-window-p begin-point))
  (forward-sexp 1)			;Leaves the point on the last line of
					; the
					; function, not the first blank line.
  (beginning-of-line)
  (setq end-point (point)
	end-visible-p (pos-visible-in-window-p end-point))
  ;; Now decide if I was already at any of these interesting places.
  (move-to-window-line 0)
  (setq was-at-beginning-p (= (point) begin-point))
  (move-to-window-line -1)		;Move to the bottom of the window
  (setq was-at-end-p (= (point) end-point))
  (cond ((or (and beginning-visible-p end-visible-p)
	     (and beginning-visible-p (not was-at-beginning-p)))
	 ;; If the whole function's visible, or the beginning is, and I
	 ;; wasn't already looking at it, then go to the beginning.
	 (goto-char begin-point)
	 (recenter 0))
	((and end-visible-p (not was-at-end-p))
	 ;; Else, if the end is in sight, and I wasn't there, go there.
	 (goto-char end-point)
	 (recenter -1))			; then put the end at the bottom of
	(t				; the window.
	 ;; Finally, default to the beginning
	 (goto-char begin-point)	;Default: put the beginning at the top
	 (recenter 0)))))

(defun count-words ()
 "Count the words in the buffer"
 (interactive)
 (save-excursion
  (beginning-of-buffer)
  (count-matches "\\(\\w\\)*")))

;;; gnu-outline-mode is what I use on the lispm

(defun gnu-outline-mode ()
 (interactive)
 (outline-mode)
 (setq mode-name "Gnu Outline")
 (make-local-variable 'outline-regexp)
 (setq outline-regexp "[ 	]*[*\^l]+")
 (setq indent-tabs-mode nil))

(defun tex-outline-mode ()
 (interactive)
 (outline-mode)
 (setq mode-name "TeX Outline")
 (make-local-variable 'outline-regexp)
 (setq outline-regexp "%+[ 	]*[*\^l]+")
 (setq indent-tabs-mode nil))

(defun hide-top-level ()
 (interactive)
 (beginning-of-buffer)
 (save-excursion
  (condition-case ()
      (while t
       (outline-next-visible-heading 1)
       (hide-subtree))
   (error (message "Done")))))

(defun show-previous-outline-heading ()
 (interactive)
 (save-excursion
  (outline-previous-visible-heading 1)
  (if (looking-at outline-regexp)
      (message (buffer-substring (point)
				 (progn
				  (re-search-forward "[\^M\^J]")
				  (backward-char)
				  (point))))
      (message "No previous header"))))

(defun block-exits ()
 (interactive)
 (global-unset-key "\^X\^C")
 (global-unset-key "\^X\^Z"))

;;; Useful for writers

(defun find-next-repeated-word ()
 (interactive)
 (catch 'found-one
  (progn
   (if (and (forward-word 1)
	    (forward-word -1))
       (let ((a nil) (b nil))
	(message "Searching ...")
	(setq a (downcase (buffer-substring
			   (point)
			   (progn (forward-word 1) (point)))))
	(while (forward-word 1)
	 (setq b (downcase (buffer-substring
			    (save-excursion (forward-word -1) (point))
			    (point))))
	 (if (string-equal a b)
	     (progn
	      (message "Here is a repetition.  Hit space to continue, anything else to stop")
	      (if (not (= 32		;Couldn't get #\space to work
			  (read-char)))
		  (throw 'found-one nil))
	      (message "Searching ...")))
	 (setq a b))))
   (message "No more repeated words"))))

;;; This is a redefinition

;;; Modified to chose a buffer name based on the man argument.

;(defun manual-entry (topic &optional section)
; "Display the Unix manual entry for TOPIC."
; (interactive "sManual entry (topic): ")
; (if (and (null section)
;	  (string-match "\\`[ \t]*\\([^( \t]+\\)[ \t]*(\\(.+\\))[ \t]*\\'" topic))
;     (setq section (substring topic (match-beginning 2)
;			      (match-end 2))
;	   topic (substring topic (match-beginning 1)
;			    (match-end 1))))
; (with-output-to-temp-buffer (concat "*Man "
;				     section
;				     (if section " " "")
;				     topic
;				     " *")
;  (buffer-flush-undo standard-output)
;  (save-excursion
;   (set-buffer standard-output)
;   (message "Looking for formatted entry for %s%s..."
;	    topic (if section (concat "(" section ")") ""))
;   (let ((dirlist manual-formatted-dirlist)
;	 (case-fold-search nil)
;	 name)
;    (if (and section (file-exists-p
;		      (setq name (concat manual-formatted-dir-prefix
;					 (substring section 0 1)
;					 "/"
;					 topic "." section))))
;	(insert-man-file name)
;	(while dirlist
;	 (let* ((dir (car dirlist))
;		(name1 (concat dir "/"
;			       topic "." (or section (substring dir -1))))
;		completions)
;	  (if (file-exists-p name1)
;	      (insert-man-file name1)
;	      (condition-case ()
;		  (progn
;		   (setq completions (file-name-all-completions
;				      (concat topic "." (or section ""))
;				      dir))
;		   (while completions
;		    (insert-man-file (concat dir "/" (car completions)))
;		    (setq completions (cdr completions))))
;	       (file-error nil)))
;	  (goto-char (point-max)))
;	 (setq dirlist (cdr dirlist)))))
;
;   (if (= (buffer-size) 0)
;       (progn
;	(message "No formatted entry, invoking man %s%s..."
;		 (if section (concat section " ") "") topic)
;	(if section
;	    (call-process manual-program nil t nil section topic)
;	    (call-process manual-program nil t nil topic))
;	(if (< (buffer-size) 80)
;	    (progn
;	     (goto-char (point-min))
;	     (end-of-line)
;	     (error (buffer-substring 1 (point)))))))
;
;   (message "Cleaning manual entry for %s..." topic)
;
;   ;; Nuke underlining and overstriking (only by the same letter)
;   (goto-char (point-min))
;   (while (search-forward "\b" nil t)
;    (let* ((preceding (char-after (- (point) 2)))
;	   (following (following-char)))
;     (cond ((= preceding following)
;	    ;; x\bx
;	    (delete-char -2))
;	   ((= preceding ?\_)
;	    ;; _\b
;	    (delete-char -2))
;	   ((= following ?\_)
;	    ;; \b_
;	    (delete-region (1- (point)) (1+ (point)))))))
;
;   ;; Nuke headers: "MORE(1) UNIX Programmer's Manual MORE(1)"
;   (goto-char (point-min))
;   (while (re-search-forward "^ *\\([A-Za-z][-_A-Za-z0-9]*([0-9A-Z]+)\\).*\\1$" nil t)
;    (replace-match ""))
;
;   ;; Nuke footers: "Printed 12/3/85	27 April 1981	1"
;   ;;    Sun appear to be on drugz:
;   ;;     "Sun Release 3.0B  Last change: 1 February 1985     1"
;   ;;    HP are even worse!
;   ;;     "     Hewlett-Packard   -1- (printed 12/31/99)"  FMHWA12ID!!
;   ;;    System V (well WICATs anyway):
;   ;;     "Page 1			  (printed 7/24/85)"
;   ;;    Who is administering PCP to these corporate bozos?
;   (goto-char (point-min))
;   (while (re-search-forward
;	   (if (eq system-type 'hpux)
;	       "^ *Hewlett-Packard.*(printed [0-9/]*)$"
;	       (if (eq system-type 'usg-unix-v)
;		   "^ *Page [0-9]*.*(printed [0-9/]*)$"
;		   "^\\(Printed\\|Sun Release\\) [0-9].*[0-9]$"))
;	   nil t)
;    (replace-match ""))
;
;   ;; Crunch blank lines
;   (goto-char (point-min))
;   (while (re-search-forward "\n\n\n\n*" nil t)
;    (replace-match "\n\n"))
;
;   ;; Nuke blanks lines at start.
;   (goto-char (point-min))
;   (skip-chars-forward "\n")
;   (delete-region (point-min) (point))
;
;   (set-buffer-modified-p nil)
;
;   (message ""))))

;;; This is a redefinition

;;; Redefine the parentheses blinker so it will always blink the cursor,
;;; and never just echo the line with the matching paren.
;;; It appears that the time passed to "sit-for" must include the time 
;;; necessary to redraw the screen, so I make a guess based on baud-rate.

;(defun blink-matching-open ()
; "Move cursor momentarily to the beginning of the sexp before point."
; (and (> (point) (1+ (point-min)))
;      (/= (char-syntax (char-after (- (point) 2))) ?\\ )
;      blink-matching-paren
;      (let* ((oldpos (point))
;	     (blinkpos)
;	     (mismatch))
;       (save-excursion
;	(condition-case ()
;	    (setq blinkpos (scan-sexps oldpos -1))
;	 (error nil))
;	(and blinkpos (/= (char-syntax (char-after blinkpos))
;			  ?\$)
;	     (setq mismatch
;		   (/= (char-after (1- oldpos))
;		       (logand (lsh (aref (syntax-table)
;					  (char-after blinkpos))
;				    -8)
;			       255))))
;	(cond (mismatch				  
;	       (message "Mismatched parentheses"))
;	      (blinkpos
;	       (goto-char blinkpos)
;	       (if (pos-visible-in-window-p)
;		   (sit-for 1)
;		   (sit-for (+ 1 (/ 4800 (baud-rate)))))))))))
