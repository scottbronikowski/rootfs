;;;  -*- Mode: Emacs-Lisp -*-

;;; ilisp.emacs --

;;; This file is part of ILISP.
;;; Version: 5.7
;;;
;;; Copyright (C) 1990, 1991, 1992, 1993 Chris McConnell
;;;               1993, 1994 Ivan Vasquez
;;;               1994, 1995 Marco Antoniotti and Rick Busdiecker
;;;
;;; Send mail to 'ilisp-request@lehman.com' to be included in the
;;; ILISP mailing list.

;;; This file shows examples of some of the things you might want to
;;; do to install or customize ILISP.  You may not want to include all
;;; of them in your .emacs.  For example, the default key binding
;;; prefix for ILISP is C-z and this file changes the default prefix to
;;; C-c.  For more information on things that can be changed, see the
;;; file ilisp.el. 


;;; If ilisp lives in some non-standard directory, you must tell emacs
;;; where to get it. This may or may not be necessary.

(setq load-path (cons (expand-file-name "~jones/emacs/ilisp/") load-path))


;;; If you always want partial minibuffer completion

(require 'completer)

;;; If want TMC completion then you will have to Ftp it yourself from think.com
;;; It's become to flaky for me to deal with. -- Ivan
;;;(load "completion")
;;;(initialize-completions)

;;; If you want to redefine typeout-window keys:
;;;(add-hook 'ilisp-load-hook
;;;      '(lambda ()
;;;	(define-key global-map "\C-c1" 'ilisp-bury-output)
;;;	(define-key global-map "\C-cv" 'ilisp-scroll-output)
;;;	(define-key global-map "\C-cg" 'ilisp-grow-output)))


;;; Autoload based on your LISP.  You only really need the one you use.
;;; If called with a prefix, you will be prompted for a buffer and
;;; program.
;;; 
;;; [Back to the old way now -- Ivan Mon Jun 28 23:30:51 1993]
;;;

(autoload 'run-ilisp "ilisp" "Select a new inferior LISP." t)

(autoload 'clisp     "ilisp" "Inferior generic Common LISP." t)

;;; Franz
;(autoload 'allegro   "ilisp" "Inferior Allegro Common LISP." t)

;;; Lucid
;(autoload 'lucid     "ilisp" "Inferior Lucid Common LISP." t)

;;; Harlequin
;(autoload lispworks  "ilisp" "Inferior Harlequin Common LISP (LispWorks)." t)
;(autoload harlequin  "ilisp" "Inferior Harlequin Common LISP (LispWorks)." t)
;(autoload pulcinella "ilisp" "Inferior Harlequin Common LISP (LispWorks)." t)
;;; Italian "Commedia dell'Arte" twist.

;;; CMULISP
(autoload 'cmulisp   "ilisp" "Inferior CMU Common LISP." t)

;;; CLISP (Bruno Haible and XX stoll)
;(autoload 'clisp-hs   "ilisp" "Inferior Haible/Stoll CLISP Common LISP." t)

;;; KCL's
;(autoload 'kcl "ilisp" "Inferior Kyoto Common LISP." t)
(autoload 'akcl "ilisp" "Inferior Austin Kyoto Common LISP." t)
;(autoload 'ibcl "ilisp" "Ibuki Common LISP." t)
(autoload 'gcl "ilisp" "Inferior GNU Common LISP." t)
(autoload 'ecl "ilisp" "Inferior EcoLisp." t)

;;; Scheme's
;(autoload 'scheme    "ilisp" "Inferior generic Scheme." t)
;(autoload 'oaklisp   "ilisp" "Inferior Oaklisp Scheme." t)


;;; Define where LISP programs are found.  (This may already be done
;;; at your site.)
;(setq allegro-program "/usr/misc/.allegro/bin/cl")
;(setq lucid-program "/usr/misc/.lucid/bin/lisp")
;(setq cmulisp-program "/usr/misc/.cmucl/bin/lisp")
;(setq clisp-hs-program "clisp")
;(setq lispworks-program "/somewhere/in/the/directory/tree/lispworks")
(setq cmulisp-program "/usr/robotics/shared/lang/cmu-cl/17e/bin/lisp")
(setq akcl-program "kcl")
;(setq gcl-program "gcl")
;(setq ecl-program "ecl")

;;; If you run cmu-cl then set this to where your source files are.
(setq cmulisp-local-source-directory "/usr/robotics/shared/cmu-cl/17e/")


;;; This makes reading a lisp file load in ilisp.
(set-default 'auto-mode-alist
	     (append '(("\\.lisp$" . lisp-mode)) auto-mode-alist))
(setq lisp-mode-hook '(lambda () (require 'ilisp)))

;;; Sample load hook
(add-hook 'ilisp-load-hook 
	  (function
	   (lambda ()
	     ;; Change default key prefix to C-c
	     (setq ilisp-prefix "\C-c")

	     ;; Make sure that you don't keep popping up the 'inferior
	     ;; lisp' buffer window when this is already visible in
	     ;; another frame. Actually this variable has more impact
	     ;; than that. Watch out.
	     ;(setq pop-up-frames t)

	     (message "Running ilisp-load-hook")
	     ;; Define LispMachine-like key bindings, too.
	     ;; (ilisp-lispm-bindings) Sample initialization hook.

	     ;; Set the inferior LISP directory to the directory of
	     ;; the buffer that spawned it on the first prompt.
	     (add-hook 'ilisp-init-hook
		       (function
			(lambda ()
			  (default-directory-lisp ilisp-last-buffer))))
	     )))

(add-hook 'ilisp-site-hook
	  (function
	   (lambda ()
	     (setq ilisp-init-binary-extension "sparcf")
	     (setq ilisp-init-binary-command "(progn \"sparcf\")")
	     ;; (setq ilisp-binary-extension "sparcf")
	     )))


;;; end of file -- ilisp.emacs --
