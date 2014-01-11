;;; To start up:
;;;  m-x load-library fi-site-init
;;;  m-x fi:common-lisp
;;;  load a .lisp file
;;;  m-x load-file lep-modifications.elc

;;; TTMTTD:
;;; need better m-r m-s
;;; need ILD
;;; c-c s and doing l inside scan-mode takes a long time
;;; c-c s and m-sh-A shouldn't prompt
;;; indentation

(defun fi:my-listener-keys (map)
  (define-key map "\M-p" 'fi:pop-input)
  (define-key map "\M-n" 'fi:push-input)
  (define-key map "\M-r" 'fi:re-search-backward-input)
  (define-key map "\M-s" 'fi:re-search-forward-input)
  (define-key map "\C-a" 'fi:subprocess-beginning-of-line))

(defun fi:my-editor-keys (map)
  (define-key map "\C-m" 'newline-and-indent-lisp)
  (define-key map "\C-j" 'newline-and-indent-lisp)
  (define-key map "\C-i" 'indent-line-ilisp)
  (define-key map "\M-\C-q" 'indent-sexp-ilisp))

(fi:my-listener-keys fi:inferior-common-lisp-mode-map)
;;;(fi:my-listener-keys fi:lisp-listener-mode-map)
(fi:my-editor-keys fi:common-lisp-mode-map)

(defun select-lisp ()
  "Select the lisp buffer in one window mode"
  (interactive)
  (fi:common-lisp)
  (delete-other-windows))
