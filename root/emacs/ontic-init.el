;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; - NFS Share File - ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Site dependant defaults:                                                ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *ontic-directory* "/h/g/patrick/Ontic/ontic")
(defvar *default-ontic-release* "11.5")
(defvar ontic-lucid-program "/u/qobi/lucid/lisp-clos")
(defvar *ontic-dialect* 'ontic-lucid)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Site independant defaults:                                              ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *interface-directory* (concat *ontic-directory* "/interface"))
(defvar *ontic-ilisp* (concat *interface-directory* "/ontic-ilisp"))
(defvar *ontic-dialect-string* (format "%s" *ontic-dialect*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Set up Ontic:                                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Put the interface on the load path (required by ilisp)
(setq load-path (cons *interface-directory* load-path))

;; The following automaticaly loads emacs-eval when ilisp is loaded.
(autoload 'ontic *ontic-ilisp* "Ontic running in Common LISP." t)

;; share
(if (not (memq 'share features))
    (load "share" nil t))

;; Require ontic-mode.
(if (not (memq 'ontic-mode features))
    (load "ontic-mode" nil t))
