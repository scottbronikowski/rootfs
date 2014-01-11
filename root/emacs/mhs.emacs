;;; -*-Lisp-*-
;;; Mhs' init for Gnu Emacs

(setq stack-trace-on-error t)
(put 'eval-expression 'disabled nil)

;;; Bindings

(define-key global-map "\177"	'backward-delete-char-untabify)
(define-key global-map "\^X<"	'move-line-to-top-of-window)
(define-key global-map "\^X>"	'move-line-to-bottom-of-window)
(define-key global-map "\^X\^C" 'suspend-emacs)
(define-key global-map "\^X\^Z" 'suspend-emacs)
(define-key global-map "\e?"    'describe-key)
(define-key global-map "\e\?"	'describe-key-briefly)
(define-key global-map "\e\^Q"	'indent-sexp)
(define-key global-map "\e\^Z"	'save-buffers-kill-emacs)
(define-key global-map "\e\^r"	'reposition-window-around-defun)
(define-key global-map "\e\r"   'back-to-indentation)
(define-key global-map "\e\s"   'center-line)
(define-key global-map "\eo"    'open-rectangle)
(define-key global-map "\e\^l"  'switch-to-other-buffer)
(define-key global-map "\^Z" nil)	; I kept hitting these by accident.

(define-key global-map "\^Cs" 'word-search-forward)
(define-key global-map "\^Cr" 'word-search-backward)

(define-key Buffer-menu-mode-map " " 'Buffer-menu-select)

;;; Make ESC complete in the minibuffer
(define-key minibuffer-local-completion-map "\C-[" 'minibuffer-complete)
(define-key minibuffer-local-must-match-map "\C-[" 'minibuffer-complete)

;;; Variables

(setq ask-about-buffer-names t)
(setq default-fill-column 78)
(setq default-major-mode 'text-mode)
(setq delete-auto-save-files t)
(setq explicit-shell-file-name "/bin/csh") ; So shell mode won't have those
					   ; annoying ^M's
(setq indent-tabs-mode nil)		;Put this into text-mode-hook
(setq inhibit-startup-message t)
(setq meta-flag t)			;so meta works from lisp machines
(setq next-screen-context-lines 1)
(setq parse-sexp-ignore-comments nil)
(setq pop-up-windows nil)
(setq search-slow-window-lines -1)
(setq scroll-step 3)
(setq tab-stop-list '(4 8 12 16 24 32 40 48 56 64 72 80))
(setq TeX-default-mode 'latex-mode)
(setq TeX-mode-hook
      '(lambda ()
	 (setq paragraph-start "^[ \t]*$\\|^[\f%]" ;don't look at backslash
	       paragraph-separate paragraph-start)))
(setq text-mode-hook '(lambda () (auto-fill-mode 1)))
(setq version-control t)

;;; gnus (uucp netnews reader)
(setq load-path (append '("/import/local/emacs/") load-path))
(autoload 'gnus "gnus" "Read netnews" t)
(autoload 'gnus-post-news "gnus" "Post a netnews item" t)

;;; I don't know why "~/Emacs" didn't work here.
(if (not (string-equal "/piglet/shirley/Emacs" (car load-path)))
  (setq load-path (cons "/piglet/shirley/Emacs" load-path)))

;;; This is here rather than earlier, because LISP-MODE-MAP is defined by
;;; LISP-MODE.
(setq lisp-mode-hook '(lambda ()
			(define-key lisp-mode-map "\^c;" 'kill-comment)))

;;; tcsh looses big in a buffer
(setq explicit-shell-file-name "/bin/csh")

;;; Mail customization
(define-key ctl-x-map "r" 'rmail)
(define-key ctl-x-map "r" 'mhs-rmail)
(setq rmail-mode-hook '(lambda ()
			 (load "~shirley/.mail/mhs-rmail")
;			 (make-local-variable 'make-backup-files)
;			 (setq make-backup-files nil)
			 (define-key global-map "\^C\r" 
			   'rmail-extract-rejected-message)))

(setq mail-self-blind t)
(setq rmail-babyl-compatibility " ")

;;; My rmail entry
(defun mhs-rmail (&optional use-temp-file)
  (interactive "P")
  (if (not (null use-temp-file))
      (message "No temporary rmail file"))
  (rmail)
  (rmail-summary)			;Create the summary window
  (summary-two-windows-mode))		;set up my 2 window summary mode

;;; RMAIL-MODE-HOOK can't do this, 'cause by the time the hook runs, 
;;; RMAIL-FILE-NAME's already been looked at.
(setq rmail-file-name "~shirley/.mail/rmail")

;;; make this work later
;(if (string-equal (substring (getenv "TERM") 0 3) "sun")
;    (progn
;      (load "term/sun")
;      (emacstool-start)))


(defun from-lispm ()
  "I'm coming from a lispm"
  (interactive)
  (define-key global-map "\^X\^C" 'suspend-emacs)
  (define-key global-map "\^X\^Z" 'suspend-emacs)
  (set-screen-width 80)
  (set-screen-height 30))

;;; Other customization

;;; From Olin
(defun switch-to-other-buffer ()
  "Switch window to show previous buffer"
  (interactive)
  (switch-to-buffer (other-buffer)))

;;; Assume if the baud rate is low, that I'm home and using sysline.
(if (> (baud-rate) 1200)
    (display-time))

;;; Definitions

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
			    begin-dot end-dot)
    (forward-char 1)
    (beginning-of-defun)
    (setq begin-dot (dot)
	  beginning-visible-p (pos-visible-in-window-p begin-dot))
    (forward-sexp 1)			;Leaves the dot on the last line of the
					; function, not the first blank line.
    (beginning-of-line)
    (setq end-dot (dot)
	  end-visible-p (pos-visible-in-window-p end-dot))
    ;; Now decide if I was already at any of these interesting places.
    (move-to-window-line 0)
    (setq was-at-beginning-p (= (dot) begin-dot))
    (move-to-window-line -1)		;Move to the bottom of the window
    (setq was-at-end-p (= (dot) end-dot))
    (cond ((or (and beginning-visible-p end-visible-p)
	       (and beginning-visible-p (not was-at-beginning-p)))
	   ;; If the whole function's visible, or the beginning is, and I
	   ;; wasn't already looking at it, then go to the beginning.
	   (goto-char begin-dot)
	   (recenter 0))
	  ((and end-visible-p (not was-at-end-p))
	   ;; Else, if the end is in sight, and I wasn't there, go there.
	   (goto-char end-dot)
	   (recenter -1))		; then put the end at the bottom of
	  (t				; the window.
	   ;; Finally, default to the beginning
	   (goto-char begin-dot)	;Default: put the beginning at the top
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
		      (if (not (= 32	;Couldn't get #\space to work
				  (read-char)))
			  (throw 'found-one nil))
		      (message "Searching ...")))
		(setq a b))))
	(message "No more repeated words"))))

;;; Modified to chose a buffer name based on the man argument.
(load "man.el")

(defun manual-entry (topic &optional section)
  "Display the Unix manual entry for TOPIC."
  (interactive "sManual entry (topic): ")
  (if (and (null section)
	   (string-match "\\`[ \t]*\\([^( \t]+\\)[ \t]*(\\(.+\\))[ \t]*\\'" topic))
      (setq section (substring topic (match-beginning 2)
				     (match-end 2))
	    topic (substring topic (match-beginning 1)
				   (match-end 1))))
  (with-output-to-temp-buffer (concat "*Man "
				      section
				      (if section " " "")
				      topic
				      " *")
    (buffer-flush-undo standard-output)
    (save-excursion
      (set-buffer standard-output)
      (message "Looking for formatted entry for %s%s..."
	       topic (if section (concat "(" section ")") ""))
      (let ((dirlist manual-formatted-dirlist)
	    (case-fold-search nil)
	    name)
	(if (and section (file-exists-p
			   (setq name (concat manual-formatted-dir-prefix
					      (substring section 0 1)
					      "/"
					      topic "." section))))
	    (insert-man-file name)
	  (while dirlist
	    (let* ((dir (car dirlist))
		   (name1 (concat dir "/"
				  topic "." (or section (substring dir -1))))
		   completions)
	      (if (file-exists-p name1)
		  (insert-man-file name1)
		(condition-case ()
		    (progn
		      (setq completions (file-name-all-completions
					 (concat topic "." (or section ""))
					 dir))
		      (while completions
			(insert-man-file (concat dir "/" (car completions)))
			(setq completions (cdr completions))))
		  (file-error nil)))
	      (goto-char (point-max)))
	    (setq dirlist (cdr dirlist)))))

      (if (= (buffer-size) 0)
	  (progn
	    (message "No formatted entry, invoking man %s%s..."
		     (if section (concat section " ") "") topic)
	    (if section
		(call-process manual-program nil t nil section topic)
	        (call-process manual-program nil t nil topic))
	    (if (< (buffer-size) 80)
		(progn
		  (goto-char (point-min))
		  (end-of-line)
		  (error (buffer-substring 1 (point)))))))

      (message "Cleaning manual entry for %s..." topic)

      ;; Nuke underlining and overstriking (only by the same letter)
      (goto-char (point-min))
      (while (search-forward "\b" nil t)
	(let* ((preceding (char-after (- (point) 2)))
	       (following (following-char)))
	  (cond ((= preceding following)
		 ;; x\bx
		 (delete-char -2))
		((= preceding ?\_)
		 ;; _\b
		 (delete-char -2))
		((= following ?\_)
		 ;; \b_
		 (delete-region (1- (point)) (1+ (point)))))))

      ;; Nuke headers: "MORE(1) UNIX Programmer's Manual MORE(1)"
      (goto-char (point-min))
      (while (re-search-forward "^ *\\([A-Za-z][-_A-Za-z0-9]*([0-9A-Z]+)\\).*\\1$" nil t)
	(replace-match ""))

      ;; Nuke footers: "Printed 12/3/85	27 April 1981	1"
      ;;    Sun appear to be on drugz:
      ;;     "Sun Release 3.0B  Last change: 1 February 1985     1"
      ;;    HP are even worse!
      ;;     "     Hewlett-Packard   -1- (printed 12/31/99)"  FMHWA12ID!!
      ;;    System V (well WICATs anyway):
      ;;     "Page 1			  (printed 7/24/85)"
      ;;    Who is administering PCP to these corporate bozos?
      (goto-char (point-min))
      (while (re-search-forward
	       (if (eq system-type 'hpux)
		   "^ *Hewlett-Packard.*(printed [0-9/]*)$"
		 (if (eq system-type 'usg-unix-v)
		     "^ *Page [0-9]*.*(printed [0-9/]*)$"
		   "^\\(Printed\\|Sun Release\\) [0-9].*[0-9]$"))
	       nil t)
	(replace-match ""))

      ;; Crunch blank lines
      (goto-char (point-min))
      (while (re-search-forward "\n\n\n\n*" nil t)
	(replace-match "\n\n"))

      ;; Nuke blanks lines at start.
      (goto-char (point-min))
      (skip-chars-forward "\n")
      (delete-region (point-min) (point))

      (set-buffer-modified-p nil)

      (message ""))))

;; Faster apropos command.
;; Copyright (C) 1989 Free Software Foundation, Inc.
;; Author: Joe Wells
;; jbw%bucsf.bu.edu@bu-it.bu.edu (school year)
;; joew%uswest@boulder.colorado.edu (summer)
;; Modified to replace apropos - Mhs

(fset 'old-apropos (symbol-function 'apropos))

(defun apropos (string &optional pred noprint)
  "Show all symbols whose names contain match for REGEXP.
If optional arg PRED is non-nil, (funcall PRED SYM) is done
for each symbol and a symbol is mentioned if that returns non-nil.
Returns list of symbols found; if third arg NOPRINT is non-nil,
does not display them, just returns the list."
  (interactive "sFast-Apropos: ")
  (let ((list (old-apropos string pred t)))
    (or noprint
	(with-output-to-temp-buffer "*Help*"
	  (fast-apropos1 string pred list)))
    list))

(defun fast-apropos1 (string pred list)
  "Helping function for fast-apropos.
Equivalent to apropos1 in src/keymap.c except that it's a lot faster
and it's written in lisp.  Using REGEXP and PRED, displays LIST of
symbols in the buffer pointed to by standard-output, along with neat
info like function and variable documentation and key bindings.
Should only be called by fast-apropos."
  (let ((keys (match-all-keys string pred))
;;	(current-local-map (current-local-map))
	symbol tem)
    (save-excursion
      (set-buffer standard-output)
      (while (consp list)
	(setq symbol (car list)
	      list (cdr list))
	(prin1 symbol nil)
	(cond ((commandp symbol)
	       (indent-to 30 1)
;;	       (setq tem (where-is-internal symbol current-local-map nil))
	       (setq tem (assq symbol keys))
	       (if tem
		   (princ (mapconcat 'key-description
;;				     tem
				     (cdr tem)
				     ", ") nil)
		 (insert "(not bound to any keys)"))))
	(terpri nil)
	(cond ((fboundp symbol)
	       (setq tem (documentation symbol))
	       (if (stringp tem)
		   (insert "  Function: "
			   (substring tem 0 (string-match "\n" tem))
			   "\n"))))
	(setq tem (documentation-property symbol 'variable-documentation))
	(if (stringp tem)
	    (insert "  Variable: "
		    (substring tem 0 (string-match "\n" tem))
		    "\n")))))
  nil)

(defun match-all-keys (regexp pred)
  "Find key bindings for symbols matching REGEXP and passing PRED.
If PRED is non-nil, (funcall PRED SYMBOL) is done before a symbol is
included in the list.  The return value is in the form ((SYMBOL KEYS
...) ...)."
  (let* ((current-local-map (current-local-map))
	 (maps (nconc (accessible-keymaps current-local-map)
		      (accessible-keymaps (current-global-map))))
	 map				;map we are now inspecting
	 sequence			;key sequence to reach map
	 i				;index into vector map
	 found				;key bindings found so far
	 command			;what is bound to current keys
	 key				;last key to reach command
	 local				;local binding for sequence + key
	 item)				;key binding in found list
    ;; examine all reachable keymaps
    (while (consp maps)
      (setq map (cdr (car maps))
	    sequence (car (car maps))	;keys to reach this map
	    maps (cdr maps))
      (cond ((consp map)
	     (setq map (cdr map))))	;skip keymap symbol
      (setq i 0)
      (while (and map (< i 128))	;vector keymaps have 128 entries
	(cond ((consp map)
	       (setq command (cdr (car map))
		     key (car (car map))
		     map (cdr map)))
	      ((vectorp map)
	       (setq command (aref map i)
		     key i
		     i (1+ i))))
	;; if is a symbol, and matches regexp, and passes pred, and is
	;; not shadowed by a different local binding, record it
	(and (symbolp command)
	     (string-match regexp (symbol-name command))
	     (if pred (funcall pred symbol) t)
	     (setq key (concat sequence (char-to-string key)))
	     ;; checking if shadowed by local binding
	     ;; either no local binding, or runs off the binding tree
	     ;; (number), or is the same binding
	     (or (not (setq local (lookup-key current-local-map key)))
		 (numberp local)
		 (eq command local))
	     (setq key (cons key nil))
	     ;; if this command is already in found, just add the key
	     ;; sequence, else add the (command keys) item
	     (if (setq item (assq command found))
		 (nconc item key)
	       (setq found (cons (cons command key) found))))))
    found))


;;; Lisp indentation
(put '*catch 'lisp-indent-hook 2)	;This doesn't seem to work??
(put 'catch 'lisp-indent-hook 2)
(put 'defflavor 'lisp-indent-hook 3)
(put 'define-predicate 'lisp-indent-hook 1)
(put 'defmethod 'lisp-indent-hook 2)
(put 'defrule 'lisp-indent-hook 1)	;For baby prolog
(put 'defrule 'lisp-indent-hook 2)
(put 'defun 'lisp-indent-hook 2)
(put 'destructuring-bind 'lisp-indent-hook 2)
(put 'dolist 'lisp-indent-hook 1)
(put 'dotimes 'lisp-indent-hook 1)
(put 'equal-instants 'lisp-indent-hook 0)
(put 'lambda 'lisp-indent-hook 1)
(put 'lets 'lisp-indent-hook 1)
(put 'loose-sequence 'lisp-indent-hook 0)
(put 'multiple-value 'lisp-indent-hook 1)
(put 'multiple-value-bind 'lisp-indent-hook 2)
(put 'selectq 'lisp-indent-hook 1)
(put 'tight-sequence 'lisp-indent-hook 0)
(put 'when 'lisp-indent-hook 1)
(put 'with-theories 'lisp-indent-hook 1)
(put 'with-query-satisfied 'lisp-indent-hook 1)
(put 'sys:with-indentation 'lisp-indent-hook 1)

;(load "macmouse")
(load "uncompress")

(setq stack-trace-on-error nil)
