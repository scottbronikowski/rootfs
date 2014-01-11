;;; ILD: A common Common Lisp debugger user interface for ILisp.
;;;   ---Jeffrey Mark Siskind

;;; Keystroke c-u? What it does
;;; ---------------------------------------------------------
;;; m-a            Abort
;;; m-c            Continue
;;; c-m-n     *    Next stack frame
;;; c-m-p     *    Previous stack frame
;;; c-c <          Top stack frame
;;; c-c >          Bottom stack frame
;;; m-b            Backtrace
;;; c-m-d          Display all locals
;;; c-m-l     *    Display particular local
;;; c-c r          Return
;;; c-m-r          Retry
;;; c-x t          Trap on exit

(require 'ilisp)

(deflocal ild-abort-string nil)
(deflocal ild-continue-string nil)
(deflocal ild-next-string nil)
(deflocal ild-next-string-arg nil)
(deflocal ild-previous-string nil)
(deflocal ild-previous-string-arg nil)
(deflocal ild-top-string nil)
(deflocal ild-bottom-string nil)
(deflocal ild-backtrace-string nil)
(deflocal ild-locals-string nil)
(deflocal ild-local-string-arg nil)
(deflocal ild-return-string nil)
(deflocal ild-retry-string nil)
(deflocal ild-trap-on-exit-string nil)

(defun ild-debugger-command (string)
 (process-send-string (get-buffer-process (current-buffer))
		      (format "%s\n" string)))

(defun ild-prompt ()
 (save-excursion
  (beginning-of-line)
  (comint-skip-prompt)
  (eobp)))

(defun ild-abort ()
 (interactive)
 (if ild-abort-string
     (ild-debugger-command ild-abort-string)
     (beep)))

(defun ild-continue (&optional arg)
 (interactive "P")
 (if (ild-prompt)
     (if ild-continue-string
	 (ild-debugger-command ild-continue-string)
	 (beep))
     (if arg (capitalize-word arg) (capitalize-word 1))))

(defun ild-next (&optional arg)
 (interactive "P")
 (if arg
     (if ild-next-string-arg
	 (ild-debugger-command (format ild-next-string-arg arg))
	 (beep))
     (if ild-next-string
	 (ild-debugger-command ild-next-string)
	 (beep))))

(defun ild-previous (&optional arg)
 (interactive "P")
 (if arg
     (if ild-previous-string-arg
	 (ild-debugger-command (format ild-previous-string-arg arg))
	 (beep))
     (if ild-previous-string
	 (ild-debugger-command ild-previous-string)
	 (beep))))

(defun ild-top (&optional arg)
 (interactive "P")
 (if ild-top-string
     (ild-debugger-command ild-top-string)
     (beep)))

(defun ild-bottom (&optional arg)
 (interactive "P")
 (if ild-bottom-string
     (ild-debugger-command ild-bottom-string)
     (beep)))

(defun ild-backtrace (&optional arg)
 (interactive "P")
 (if (ild-prompt)
     (if ild-backtrace-string
	 (ild-debugger-command ild-backtrace-string)
	 (beep))
     (if arg (backward-word arg) (backward-word 1))))

(defun ild-locals (&optional arg)
 (interactive "P")
 (if ild-locals-string
     (ild-debugger-command ild-locals-string)
     (beep)))

(defun ild-local (&optional arg)
 (interactive "P")
 (if arg
     (if ild-local-string-arg
	 (ild-debugger-command (format ild-local-string-arg arg))
	 (beep))
     (if ild-locals-string
	 (ild-debugger-command ild-locals-string)
	 (beep))))

(defun ild-return ()
 (interactive)
 (if ild-return-string
     (ild-debugger-command ild-return-string)
     (beep)))

(defun ild-retry ()
 (interactive)
 (if ild-retry-string
     (ild-debugger-command ild-retry-string)
     (beep)))

(defun ild-trap-on-exit (&optional arg)
 (interactive "P")
 (if ild-trap-on-exit-string
     (ild-debugger-command ild-trap-on-exit-string)
     (beep)))

(defun stack-limit-lisp (limit)
 "Set the stack limit for the next inferior lisp process to be created."
 (interactive "nLimit: ")
 (setq clim-program (format "/bin/csh ~qobi/bin/limit-lisp %d" limit)))

(defun fast-lisp ()
 "Use the production compiler."
 (interactive)
 (ilisp-send "(progn (proclaim '(optimize (speed 3) (safety 0) (space 0) (compilation-speed 0) (debug 0))) #+akcl (use-fast-links t))"))

(defun slow-lisp ()
 "Use the development compiler."
 (interactive)
 (ilisp-send "(progn (proclaim '(optimize (speed 0) (safety 3) (space 3) (compilation-speed 3) (debug 3))) #+akcl (use-fast-links nil))"))

(defun select-lisp ()
 "Select the lisp buffer in one window mode"
 (interactive)
 (cond ((and (lisp-mem ilisp-buffer
		       (buffer-list)
		       (function (lambda (x y) (equal x (buffer-name y)))))
	     (get-buffer-process (get-buffer ilisp-buffer)))
	(delete-other-windows)
	(switch-to-buffer ilisp-buffer))
       (t (ee473)
	  (delete-other-windows))))

(defun select-ilisp (arg)
 "Select the current ILISP buffer."
 (interactive "P")
 (if (and (not arg)
          (lisp-mem
	   (buffer-name (current-buffer))
	   ilisp-buffers
	   (function (lambda (x y) (equal x (format "*%s*" (car y)))))))
     (setq ilisp-buffer (buffer-name (current-buffer)))
     (let ((new (completing-read
		 (if ilisp-buffer
		     (format "Buffer [%s]: "
			     (substring ilisp-buffer 1
					(1- (length ilisp-buffer))))
		     "Buffer: ")
		 ilisp-buffers nil t)))
      (if (not (zerop (length new)))
	  (setq ilisp-buffer (format "*%s*" new))))))

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
(defkey-ilisp "\M-c"    'ild-continue t)
(defkey-ilisp "\C-\M-n" 'ild-next t)
(defkey-ilisp "\C-\M-p" 'ild-previous t)
(defkey-ilisp "\C-c<"   'ild-top t)
(defkey-ilisp "\C-c>"   'ild-bottom t)
(defkey-ilisp "\M-b"    'ild-backtrace t)
(defkey-ilisp "\C-\M-d" 'ild-locals t)
(defkey-ilisp "\C-\M-l" 'ild-local t)
(defkey-ilisp "\C-cr"   'ild-return t)
(defkey-ilisp "\C-\M-r" 'ild-retry t)
(defkey-ilisp "\C-xt"   'ild-trap-on-exit t)
(define-key   global-map     "\C-cL" 'select-lisp)
(ilisp-defkey lisp-mode-map  "\C-f"  'fast-lisp)
(ilisp-defkey ilisp-mode-map "\C-f"  'fast-lisp)
(ilisp-defkey lisp-mode-map  "\C-s"  'slow-lisp)
(ilisp-defkey ilisp-mode-map "\C-s"  'slow-lisp)
;; because the ILisp 5.5 version is broken
(defkey-ilisp "\C-\M-e"  'end-of-defun)

(defdialect clisp "Common LISP" ilisp
 (setq ilisp-load-or-send-command
       "(or (and (load \"%s\" :if-does-not-exist nil) t)
             (and (load \"%s\" :if-does-not-exist nil) t))")
 (cond ((or (equal (system-name) "qobi.ai")
            (equal (system-name) "dvp.cs")
            (equal (system-name) "qew.cs"))
	(ilisp-load-init 'clisp "~qobi/emacs/clisp"))
       (t (ilisp-load-init 'clisp "clisp")))
 (setq ilisp-package-regexp "^[ \t]*(in-package[ \t\n]*"
       ilisp-package-command "(let ((*package* *package*)) %s (package-name *package*))"
       ilisp-package-name-command "(package-name *package*)"
       ilisp-in-package-command "(in-package \"%s\")"
       ilisp-last-command "*"
       ilisp-save-command "(progn (ILISP:ilisp-save) %s\n)"
       ilisp-restore-command "(ILISP:ilisp-restore)"
       ilisp-block-command "(progn %s\n)"
       ilisp-eval-command "(ILISP:ilisp-eval \"%s\" \"%s\" \"%s\")"
       ilisp-defvar-regexp "(defvar[ \t\n]")
 (setq ilisp-defvar-command
       "(ILISP:ilisp-eval \"(let ((form '%s)) (progn (makunbound (second form)) (eval form)))\" \"%s\" \"%s\")")
 (setq ilisp-compile-command "(ILISP:ilisp-compile \"%s\" \"%s\" \"%s\")"
       ilisp-describe-command "(ILISP:ilisp-describe \"%s\" \"%s\")"
       ilisp-inspect-command "(ILISP:ilisp-inspect \"%s\" \"%s\")"
       ilisp-arglist-command "(ILISP:ilisp-arglist \"%s\" \"%s\")")
 (setq ilisp-documentation-types
       '(("function") ("variable")
	 ("structure") ("type")
	 ("setf") ("class")
	 ("(qualifiers* (class ...))")))
 (setq ilisp-documentation-command
       "(ILISP:ilisp-documentation \"%s\" \"%s\" \"%s\")")
 (setq ilisp-macroexpand-1-command
       "(ILISP:ilisp-macroexpand-1 \"%s\" \"%s\")")
 (setq ilisp-macroexpand-command "(ILISP:ilisp-macroexpand \"%s\" \"%s\")")
 (setq ilisp-complete-command
       "(ILISP:ilisp-matching-symbols \"%s\" \"%s\" %s %s %s)")
 (setq ilisp-locator 'lisp-locate-clisp)
 (setq ilisp-source-types
       '(("function") ("macro") ("variable")
	 ("structure") ("type")
	 ("setf") ("class")
	 ("(qualifiers* (class ...))")))
 (setq ilisp-callers-command "(ILISP:ilisp-callers \"%s\" \"%s\")"
       ilisp-trace-command "(ILISP:ilisp-trace \"%s\" \"%s\" \"%s\")"
       ilisp-untrace-command "(ILISP:ilisp-untrace \"%s\" \"%s\")")
 (setq ilisp-directory-command "(namestring *default-pathname-defaults*)"
       ilisp-set-directory-command
       "(setq *default-pathname-defaults* (parse-namestring \"%s\"))")
 (setq ilisp-load-command "(load \"%s\")")
 (setq ilisp-compile-file-command
       "(ILISP:ilisp-compile-file \"%s\" \"%s\")"))

(defdialect lucid "Lucid Common LISP" clisp
 (cond ((or (equal (system-name) "qobi.ai")
            (equal (system-name) "dvp.cs")
            (equal (system-name) "qew.cs"))
	(ilisp-load-init 'lucid "~qobi/emacs/lucid"))
       (t (ilisp-load-init 'lucid "lucid")))
 (setq comint-prompt-regexp "^\\(->\\)+ \\|^[^> ]*> "
       comint-fix-error ":a"
       ilisp-reset ":a :t"
       comint-continue ":c"
       comint-interrupt-regexp ">>Break: Keyboard interrupt"
       comint-prompt-status
       (function (lambda (old line)
		  (comint-prompt-status old line 'lucid-check-prompt))))
 (setq ilisp-error-regexp "ILISP:[^\"]*\\|>>[^\n]*")
 (setq ilisp-source-types (append ilisp-source-types '(("any"))))
 (setq ilisp-find-source-command
       "(ILISP:ilisp-source-files \"%s\" \"%s\" \"%s\")")
 (setq ilisp-binary-command
       "(first (last lucid::*load-binary-pathname-types*))")
 (setq ild-abort-string ":A"
       ild-continue-string ":C"
       ild-next-string ":N"
       ild-next-string-arg ":N %s"
       ild-previous-string ":P"
       ild-previous-string-arg ":P %s"
       ild-top-string ":<"
       ild-bottom-string ":>"
       ild-backtrace-string ":B"
       ild-locals-string ":V"
       ild-local-string-arg ":L %s"
       ild-return-string ":R"
       ild-retry-string ":F"
       ild-trap-on-exit-string ":X T"))
(setq lucid-program "lisp-clos")

(defdialect clim "Lucid CLIM" lucid)
(setq clim-program "lisp-clim")

(defdialect qsim "Lucid QSIM" lucid)
(setq qsim-program "lisp-qsim")

(defdialect allegro "Allegro Common LISP" clisp
 (cond ((or (equal (system-name) "qobi.ai")
            (equal (system-name) "dvp.cs")
            (equal (system-name) "qew.cs"))
	(ilisp-load-init 'allegro "~qobi/emacs/allegro"))
       (t (ilisp-load-init 'allegro "allegro")))
 (setq comint-fix-error ":pop"
       ilisp-reset ":reset"
       comint-continue ":cont"
       comint-interrupt-regexp  "Error: [^\n]* interrupt\)")
 (setq comint-prompt-status
       (function (lambda (old line)
		  (comint-prompt-status old line 'allegro-check-prompt))))
 ;; <cl> or package> at top-level
 ;; [0-9c] <cl> or package> in error
 ;; (setq comint-prompt-regexp "^\\(\\[[0-9]*c*\\] \\|\\)\\(<\\|\\)[^>]*> ")
 (setq comint-prompt-regexp "^\\(\\[[0-9]+i?c?\\] \\|\\[step\\] \\)?\\(<?[-A-Za-z]* ?[0-9]*?>\\|[-A-Za-z0-9]+([0-9]+):\\) ")
 (setq ilisp-error-regexp
       "\\(ILISP:[^\"]*\\)\\|\\(Error:[^\n]*\\)\\|\\(Break:[^\n]*\\)")

 (setq ilisp-binary-command "excl:*fasl-default-type*")
 (setq ilisp-source-types (append ilisp-source-types '(("any"))))
 (setq ilisp-find-source-command
       "(ILISP:ilisp-source-files \"%s\" \"%s\" \"%s\")")
 (setq ilisp-init-binary-command
       "(let ((ext (or #+m68k \"68fasl\"
		        #+sparc \"sfasl\"
		        #+iris4d \"ifasl\"
                        #+dec3100 \"pfasl\"
                        excl:*fasl-default-type*)))
           #+allegro-v4.0 (setq ext (concatenate 'string ext \"4\"))
           ext)")
 (setq ild-abort-string ":pop"
       ild-continue-string ":cont"
       ild-next-string ":dn"
       ild-next-string-arg ":dn %s"
       ild-previous-string ":up"
       ild-previous-string-arg ":up %s"
       ild-top-string ":to"
       ild-bottom-string ":bo"
       ild-backtrace-string ":bt"
       ild-locals-string ":local"
       ild-local-string-arg ":local %s"
       ild-return-string nil		;needs work
       ild-retry-string ":rest"
       ild-trap-on-exit-string ":boe"))
(setq allegro-program "cl")

(defdialect akcl "Austin Kyoto Common LISP" kcl
 (setq comint-prompt-regexp "^[-A-Z]*>+")
 (setq ild-abort-string ":q"
       ild-continue-string ":r"
       ild-next-string ":up"
       ild-next-string-arg ":up %s"
       ild-previous-string ":down"
       ild-previous-string-arg ":down %s"
       ild-top-string ":down 1000000"
       ild-bottom-string ":up 1000000"
       ild-backtrace-string ":bt"
       ild-locals-string ":fr"
       ild-local-string-arg ":loc %s"
       ild-return-string ":r"
       ild-retry-string nil		;needs work
       ild-trap-on-exit-string nil))	;needs work
(setq akcl-program "akcl")

(defdialect pcl "Austin Kyoto Common LISP with PCL" akcl)
(setq pcl-program "pcl")

(defdialect cmulisp "CMU Common LISP" clisp
 (ilisp-load-init 'cmu "cmulisp")
 (if cmulisp-local-source-directory
     (setq ilisp-source-directory-fixup-alist
	   (list
	    (cons cmulisp-source-directory-regexp
		  cmulisp-local-source-directory)))
     (message "cmulisp-local-source-directory not set."))
 (setq comint-prompt-regexp "^\\([0-9]+\\]+\\|\\*\\) "
       ilisp-trace-command "(ILISP:cmulisp-trace \"%s\" \"%s\" \"%s\")"
       comint-prompt-status
       (function (lambda (old line)
		  (comint-prompt-status old line 'cmulisp-check-prompt)))
       ilisp-error-regexp "ILISP:[^\"]*\\|Error [^\n]*"
       ilisp-arglist-command "(ILISP:arglist \"%s\" \"%s\")"
       ilisp-find-source-command "(ILISP:source-file \"%s\" \"%s\" \"%s\")"
       comint-fix-error ":pop"
       comint-continue ":go"
       ilisp-reset ":q"
       comint-interrupt-regexp "Interrupted at"
       ilisp-binary-extension "sparcf")
 (setq ild-abort-string ":abort"
       ild-continue-string ":go"
       ild-next-string ":down"
       ild-next-string-arg nil		;needs work
       ild-previous-string ":up"
       ild-previous-string-arg nil	;needs work
       ild-top-string ":bottom"
       ild-bottom-string ":top"
       ild-backtrace-string ":backtrace"
       ild-locals-string ":l"
       ild-local-string-arg "(debug:arg %s)"
       ild-return-string nil		;needs work (debug:debug-return x)
       ild-retry-string nil		;needs work
       ild-trap-on-exit-string nil))	;needs work
(setq cmulisp-program "cmucl")

(defdialect qsci "Qobi Scheme->C" scheme
 (setq comint-fix-error ":X"
       ilisp-reset ":A"
       comint-continue ":C"
       comint-interrupt-regexp ">>Interrupt:"
       ilisp-eval-command
       "(begin (eval (read (open-input-string \"%s\"))) \"%s\" \"%s\")"
       ilisp-package-command "%s"	;needs work
       ilisp-block-command "(begin %s)"
       ilisp-load-command "(ld \"%s\")"
       ilisp-load-or-send-command "(begin \"%s\" (ld \"%s\"))"
       ild-abort-string ":A"
       ild-continue-string ":C"
       ild-next-string ":N"
       ild-previous-string ":P"
       ild-top-string ":<"
       ild-bottom-string ":>"
       ild-backtrace-string ":B")
 (ilisp-load-init 'qsci "~qobi/emacs/qsci"))
(setq qsci-program "qsci")

(defdialect csc484 "CSC484 Qobi Scheme->C" qsci)
(setq csc484-program "csc484")

(defdialect hsci "Howard Qobi Scheme->C" qsci)
(setq hsci-program "hsci")
