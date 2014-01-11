;;; Commands to make using the Lucid debugger from ILISP Inferior Lisp Mode
;;; more like Symbolics debugger. ---Jeffrey Mark Siskind

;;; Inferior Lisp   Symbolics   Lucid Equivalent   Overwrites
;;; ---------------------------------------------------------
;;; m-A             <Abort>     :A                 backward-sentence
;;; m-C             <Resume>    :C                 capitalize-word
;;; c-m-N           c-N         :N (with c-U arg)  forward-list
;;; c-m-P           c-P         :P (with c-U arg)  backward-list
;;; c-C <           m-<         :< (with c-U arg)
;;; c-C >           m->         :> (with c-U arg)
;;; m-B             c-B         :B (with c-U arg)  backward-word
;;; c-m-D           c-L         :D                 down-list
;;; c-m-V           m-L         :V (with c-U arg)  scroll-other-window
;;; m-R             c-R         :R                 move-to-window-line
;;; c-m-R           c-m-R       :F              reposition-window-around-defun
;;; c-X t           c-X e       :X (with c-U arg)

(require 'ilisp)

(defun ild-debugger-command (string)
 (process-send-string (get-buffer-process (current-buffer))
		      (format "%s\n" string)))

(defun ild-prompt ()
 (and (eobp)
      (> (buffer-size) 3)
      (equal (char-to-string (char-after (- (point) 3))) "-")
      (equal (char-to-string (char-after (- (point) 2))) ">")
      (equal (char-to-string (char-after (- (point) 1))) " ")))

(defun ild-abort ()
 (interactive)
 (ild-debugger-command ":A"))

(defun ild-resume (&optional arg)
 (interactive "P")
 (if (ild-prompt)
     (ild-debugger-command ":C")
     (if arg
	 (capitalize-word arg)
	 (capitalize-word 1))))

(defun ild-next (&optional arg)
 (interactive "P")
 (if arg
     (ild-debugger-command (format ":N %s" arg))
     (ild-debugger-command ":N")))

(defun ild-previous (&optional arg)
 (interactive "P")
 (if arg
     (ild-debugger-command (format ":P %s" arg))
     (ild-debugger-command ":P")))

(defun ild-top (&optional arg)
 (interactive "P")
 (if arg
     (ild-debugger-command (format ":< %s" arg))
     (ild-debugger-command ":<")))

(defun ild-bottom (&optional arg)
 (interactive "P")
 (if arg
     (ild-debugger-command (format ":> %s" arg))
     (ild-debugger-command ":>")))

(defun ild-backtrace (&optional arg)
 (interactive "P")
 (if (ild-prompt)
     (if arg
	 (ild-debugger-command (format ":B %s" arg))
	 (ild-debugger-command ":B"))
     (if arg
	 (backward-word arg)
	 (backward-word 1))))

(defun ild-display ()
 (interactive)
 (ild-debugger-command ":D"))

(defun ild-verbose (&optional arg)
 (interactive "P")
 (if arg
     (ild-debugger-command (format ":V %s" arg))
     (ild-debugger-command ":V")))

(defun ild-return ()
 (interactive)
 (ild-debugger-command ":R"))

(defun ild-retry ()
 (interactive)
 (ild-debugger-command ":F"))

(defun ild-trap-on-exit (&optional arg)
 (interactive "P")
 (cond ((null arg) (ild-debugger-command ":X"))
       ((eq arg 0) (ild-debugger-command ":X NIL"))
       (t (ild-debugger-command ":X T"))))

;;; This fixes a bug in ILISP 4.1

(defun defkey-ilisp (key command &optional inferior-only)
 "Define KEY as COMMAND in ilisp-mode-map and lisp-mode-map unless
optional INFERIOR-ONLY is T.  If the maps do not exist they will be
created.  This should only be called after ilisp-prefix is set to the
desired prefix."
 (if (not ilisp-mode-map) (ilisp-bindings))
 (define-key ilisp-mode-map key command)
 (if (not inferior-only) (define-key lisp-mode-map key command)))

;;; This is a convenient command since c-Z c-W doesn't default to the whole
;;; buffer if there is no region

(defun compile-buffer ()
 "Compile the current buffer"
 (interactive)
 (compile-region-and-go-lisp (point-min) (point-max)))

(defkey-ilisp "\M-a"    'ild-abort t)
(defkey-ilisp "\M-c"    'ild-resume t)
(defkey-ilisp "\C-\M-n" 'ild-next t)
(defkey-ilisp "\C-\M-p" 'ild-previous t)
(defkey-ilisp "\C-c<"   'ild-top t)
(defkey-ilisp "\C-c>"   'ild-bottom t)
(defkey-ilisp "\M-b"    'ild-backtrace t)
(defkey-ilisp "\C-\M-d" 'ild-display t)
(defkey-ilisp "\C-\M-v" 'ild-verbose t)
(defkey-ilisp "\M-r"    'ild-return t)
(defkey-ilisp "\C-\M-r" 'ild-retry t)
(defkey-ilisp "\C-xt"   'ild-trap-on-exit t)
