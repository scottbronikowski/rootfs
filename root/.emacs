;;  -*- mode: lisp; -*-

(setq gc-cons-threshold 100000000)
(setq garbage-collection-messages t)

(setq ring-bell-function 'ignore)

;; Autocompile the .emacs buffer
(require 'bytecomp)
(defun autocompile nil
  ;;  (interactive)
  (if (string= (buffer-file-name)
	       (expand-file-name (concat default-directory ".emacs")))
      (if (byte-compile-file (buffer-file-name))
	  (run-at-time 1 nil
		       (lambda () (delete-windows-on "*Compile-Log*"))))))
(add-hook 'after-save-hook 'autocompile)

(defvar school nil)
(defvar dark-paren t)
(defvar fancy-paren t)

;;(load-file user-init-file)
;;(load-file custom-file)

;(when (load "/usr/share/emacs/site-lisp/site-gentoo"))
(setq load-path (append load-path '("~/emacs")))
;; (load-file (expand-file-name "~/emacs/.."))

(autoload 'sourcepair-load "sourcepair" "" t)


;; Breadcrumbs

(autoload 'bc-set               "breadcrumb" "Set bookmark in current point."   t)
(autoload 'bc-previous          "breadcrumb" "Go to previous bookmark."         t)
(autoload 'bc-next              "breadcrumb" "Go to next bookmark."             t)
(autoload 'bc-local-previous    "breadcrumb" "Go to previous local bookmark."   t)
(autoload 'bc-local-next        "breadcrumb" "Go to next local bookmark."       t)
(autoload 'bc-goto-current      "breadcrumb" "Go to the current bookmark."      t)
(autoload 'bc-list              "breadcrumb" "List all bookmarks in menu mode." t)
(autoload 'bc-clear             "breadcrumb" "Clear all bookmarks."             t)

(global-set-key (kbd "s-SPC") 'bc-set)
(global-set-key (kbd "s-<left>") 'bc-previous)
(global-set-key (kbd "s-<right>") 'bc-next)
(global-set-key (kbd "s-<down>") 'bc-local-previous)
(global-set-key (kbd "s-<up>") 'bc-local-next)
(global-set-key (kbd "s-<return>") 'bc-goto-current)
(global-set-key (kbd "s-l")   'bc-list)
(global-set-key (kbd "s-c")   'bc-clear)


;;; Doc view, for pdfs and co

;(autoload 'doc-view "doc-view")
(load-file (expand-file-name "~/emacs/doc-view.el"))

;;; One day bongo might be good enough..
;(require 'bongo)
;(load-file (expand-file-name "~/emacs/bongo-mplayer.el"))



;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/emacs/elpa/package.el"))
  (package-initialize))


(require 'compile)
(require 'flymake)
;;(add-to-list 'load-path (expand-file-name "~/.elisp/undo_browse.el"))
;;(require 'undo-browse)
					;(require 'hen)
					;(require 'cmuscheme)
					;(require 'quack)

(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)


(unless school (defun c-ident-command nil '()))

(auto-compression-mode 1)

;; Visual stuff

(auto-image-file-mode 1)
(setq inhibit-startup-message t)
					;(setq debug-on-error t)

(if (load "mwheel" t)
    (mwheel-install))

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;(set-default-font "Bitstream Vera Sans Mono-8")
;;(set-default-font "Andale Mono-8")
(set-default-font "DejaVu Sans Mono-12")

(setq scroll-step 10)

(global-font-lock-mode t)
(blink-cursor-mode nil)
(set-scroll-bar-mode 'right)
(setq transient-mark-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq display-time-day-and-date t)
(display-time)

					;(setq browse-url-browser-function 'browse-url-firefox)
					;(global-set-key "\C-xo" 'browse-url-at-point)

(setq frame-title-format (list "emacs@" system-name " - " '(buffer-file-name "%f" "%b")))
(setq icon-title-format frame-title-format)

(defadvice query-replace-read-args
    (before barf-if-buffer-read-only activate)
  "Signal a `buffer-read-only' error if the current buffer is read-only."
  (barf-if-buffer-read-only))

(setq truncate-partial-width-windows nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(display-time)
(setq line-number-mode t)
(setq column-number-mode t)

(when window-system
  (global-unset-key "\C-z")

  ;; wee parentheses

  (show-paren-mode 1)
  (when fancy-paren
    (add-hook 'lisp-mode-hook 'highlight-parentheses-mode)
    (add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
    (add-hook 'haskell-mode-hook 'highlight-parentheses-mode)
    (add-hook 'scheme-mode-hook 'highlight-parentheses-mode)

    (add-hook 'inferior-scheme-mode-hook 'highlight-parentheses-mode))

  ;; Finally, large by default - almost works, border at the bottom where this fails
  ;;(require 'maxframe)

  (defun max-frame ()
    (interactive)
    (set-frame-position (selected-frame) 0 0)
    (set-frame-size (selected-frame) 205 55))

  (add-hook 'window-setup-hook 'max-frame t)

  (defun fullscreen ()
    (interactive)
    (set-frame-parameter nil 'fullscreen
			 (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
  (global-set-key [f11] 'fullscreen))

(add-hook 'comint-output-filter-functions
	  'comint-watch-for-password-prompt)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(autoload 'ansi-color-apply "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; TODO
;(require 'dictionary)
;(setq dictionary-server "dict.org")

;; copy/paste

(setq backup-by-copying-when-mismatch t)
(setq backup-by-copying-when-linked t)
(global-font-lock-mode t)
(setq x-select-enable-clipboard t)

;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
(setq desktop-save 'if-exists)
(desktop-save-mode 1)

;; save a bunch of variables to the desktop file
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
		(file-name-history        . 100)
		(grep-history             . 30)
		(compile-history          . 30)
		(minibuffer-history       . 50)
		(query-replace-history    . 60)
		(read-expression-history  . 60)
		(regexp-history           . 60)
		(regexp-search-ring       . 20)
		(search-ring              . 20)
		(shell-command-history    . 50)
		tags-file-name
		register-alist)))

(setq ibuffer-shrink-to-minimum-size t)
(setq ibuffer-always-show-last-buffer nil)
(setq ibuffer-sorting-mode 'recency)
(setq ibuffer-use-header-line t)
(global-set-key [(f12)] 'ibuffer)


;; Make *scratch* unkillable

(save-excursion
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer))

(defun kill-scratch-buffer ()
  ;; Kill the current (*scratch*) buffer
  (remove-hook 'kill-buffer-query-functions 'kill-scratch-buffer)
  (kill-buffer (current-buffer))

  ;; Make a brand new *scratch* buffer
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer)

  ;; Since we killed it, don't let caller do that.
  nil)



;; backups, so we don't litter

(defconst use-backup-dir t)
(setq backup-directory-alist (quote ((".*" . "~/backup/temp/")))
      version-control t		     ; Use version numbers for backups
      kept-new-versions 16	   ; Number of newest versions to keep
      kept-old-versions 2	   ; Number of oldest versions to keep
      delete-old-versions t    ; Ask to delete excess backup versions?
      backup-by-copying-when-linked t) ; Copy linked files, don't rename.

;; completions

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(ido-everywhere t)
(defun ido-execute ()
  (interactive)
  (call-interactively
   (intern
    (ido-completing-read
     "M-x "
     (let (cmd-list)
       (mapatoms (lambda (S)
		   (when (commandp S)
		     (setq cmd-list (cons (format "%S" S) cmd-list)))))
       (sort (sort cmd-list 'string-lessp)
	     (lambda (x y) (< (length x) (length y)))))))))

(global-set-key "\M-x" 'ido-execute)

;; FIXME: Andrei: Do I still want this?

(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol
	try-expand-whole-kill))


;; prolog mode setup

(autoload 'prolog-mode "prolog" nil t)

(setq prolog-program-name "pl") ;; to use SWI-Prolog

(fset 'use-swipl "\C-[xset-variable\C-mprolog-program-name\C-m\"pl\"\C-m")

(setq prolog-program-name "/usr/bin/pl")

(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)

(add-hook 'prolog-mode-hook 'turn-on-font-lock)


;; c mode setup

(if school
    (defun c-indent-buffer ()
      "Indent entire buffer of C source code."
      (interactive)
      (save-excursion
	(goto-char (point-min))
	(while (< (point) (point-max))
	  (c-indent-command)
	  (end-of-line)
	  (forward-char 1))))
    (defun indent-buffer ()
      (interactive)
      (save-excursion
	(indent-region 0 (buffer-size)))))

(when school
  (defun flymake-compile()
    "kill all flymake syntax checks, start compilation"
    (interactive)
    (flymake-stop-all-syntax-checks)
    (call-interactively 'compile)))

;; Helper for compilation. Close the compilation window if
;; there was no error at all.
(unless school
					;  (defun compilation-exit-autoclose (status code msg)
					;    (when (and (eq status 'exit) (zerop code))
					;      (bury-buffer)
					;      (delete-window (get-buffer-window (get-buffer "*compilation*"))))
					;    (cons msg code))
					;  (setq compilation-exit-message-function 'compilation-exit-autoclose)

  (setq mode-compile-expert-p 't)
  (setq mode-compile-never-edit-command-p 't)
  (setq mode-compile-prefered-default-makerule 'all)
  (setq mode-compile-always-save-buffer-p 't)
  (setq mode-compile-default-make-options "-k -j3")
  (setq mode-compile-make-options (eval mode-compile-default-make-options)))

;; setup mode hooks

(if school
    (defun my-c-mode-hook ()
      (c-set-offset 'substatement-open 0))
    (defun my-c-mode-hook ()
      (unless school (define-key c-mode-map (kbd "C-.") 'c-indent-buffer))
      (c-set-offset 'substatement-open 0)))

(setq auto-mode-alist
      (append '(("\\.c$" . c-mode )
		("\\.cpp$" . c++-mode )
		("\\.cc$" . c++-mode )
		("\\.h$" . c++-mode )
		("\\.m$" . octave-mode)
		("\\.sc$" . scheme-mode)
		("\\.pl$" . prolog-or-perl-mode)

		("\\.pdf$" . open-in-doc-view)
		("\\.dvi$" . open-in-doc-view)
		("\\.ps$" . open-in-doc-view)

		("\\.avi$" . gnome-open)
		("\\.mpg$" . gnome-open)
		("\\.mp4$" . gnome-open)
		("\\.mp3$" . gnome-open)
		("\\.mpeg$" . gnome-open)

		;; Aleph files use these suffixes
		("\\.b$" . prolog-mode)
		("\\.n$" . prolog-mode)
		("\\.f$" . prolog-mode)

		("\\.chs$" . haskell-mode)
		("\\.hs$" . haskell-mode)
		("\\.pro$" . prolog-mode)
		("\\.scm$" . hen-mode)
		("\\.sch$" . scheme-mode)
		("\\.tex$" . latex-mode)
		("\\.htm$" . html-mode)
		("\\.bib$" . bibtex-mode)
		("\\.html$" . html-mode)
		("\\.emacs$" . lisp-mode)
		("\\.el$" . lisp-mode)
		("\\.s$" . asm-mode))
	      auto-mode-alist))

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

;; both prolog and perl files are often called .pl;
;; this tries to do the right thing.
(defun prolog-or-perl-mode () (interactive)
       (if
	(or (string-match "/perl\\b" (buffer-string)) ; file with perl header
	    (= 1 (point-max)))			    ; new file
	(progn
	  (cperl-mode)
	  (message "Ambiguous suffix .pl resolved to perl mode."))
	(progn
	  (prolog-mode)
	  (message "Ambiguous suffix .pl resolved to prolog mode.")))
       (sit-for 1))

(defun toggle-selective-display ()
  (interactive)
  (set-selective-display (if selective-display nil 1)))

;; FIXME: Andrei: I'm still not used to this after ages using it
'; perhaps it's just a bad idea whose time to die has come?
					;(setq skeleton-pair t)
					;(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
					;(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
					;(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
					;(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)

;; recent files

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 60)

(defun ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (let ((home (expand-file-name (getenv "HOME"))))
    (find-file
     (ido-completing-read "Recentf open: "
			  (mapcar (lambda (path)
				    (replace-regexp-in-string home "~" path))
				  recentf-list)
			  nil t))))

(global-set-key (kbd "C-x f") 'ido-choose-from-recentf)

;; keyboard bindings

(unless school
  (global-set-key (kbd "C-.") 'indent-buffer))

;; Shift + arrows for moving windows

(windmove-default-keybindings)

(defun kill-syntax-forward ()
  "Kill characters with syntax at point."
  (interactive)
  (kill-region (point)
	       (progn
		 (skip-syntax-forward
		  (string (char-syntax (char-after))))
		 (point))))

(defun kill-syntax-backward ()
  "Kill characters with syntax at point."
  (interactive)
  (kill-region (point)
	       (progn
		 (skip-syntax-backward
		  (string (char-syntax (char-before))))
		 (point))))

;; Update this when moving
(setq calendar-latitude 40.5)
(setq calendar-longitude -86.9)
(setq calendar-location-name "West Lafayette, IN")

(unless school
  (setq scroll-preserve-screen-position t))

(defun move-line (&optional n)
  "Move current line N (1) lines up/down leaving point in place."
  (interactive "p")
  (when (null n)
    (setq n 1))
  (let ((col (current-column)))
    (interactive)
    (beginning-of-line)
    (next-line 1)
    (transpose-lines n)
    (previous-line 1)
    (forward-char col)))

(defun move-line-up (n)
  "Moves current line N (1) lines up leaving point in place."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Moves current line N (1) lines down leaving point in place."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t '())))

;; Window resizing

(global-set-key (kbd "H-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "H-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "H-<down>") 'shrink-window)
(global-set-key (kbd "H-<up>") 'enlarge-window)

(global-set-key (kbd "M-<down>") 'move-line-down)
(global-set-key (kbd "M-<up>") 'move-line-up)

(require 'layout-restore)
(global-set-key (kbd "H-s") 'layout-save-current)
(global-set-key (kbd "H-l") 'layout-restore)
(global-set-key (kbd "H-d") 'layout-delete-current)

(global-set-key (kbd "H-g") 'goto-line)
(global-set-key (kbd "H-e") 'redo)
(global-set-key (kbd "H-u") 'undo)
(global-set-key (kbd "H-p") 'woman)
(global-set-key (kbd "H-z") 'sourcepair-load)


(global-set-key (kbd "C-c d") 'dictionary-search)
					;(global-set-key (kbd "H-s") 'dictionary-search)
					;(global-set-key (kbd "H-m") 'dictionary-match-words)
(global-set-key (kbd "C-;") 'comment-region)
(global-set-key (kbd "C-:") 'uncomment-region)

(setq elscreen-prefix-key (kbd "H-C"))

;; Compiling
(global-set-key (kbd "H-c") 'mode-compile)
(global-set-key (kbd "H-a") 'mode-compile-kill)
(global-set-key (kbd "H-x") 'next-error)
(global-set-key (kbd "H-X") 'previous-error)
(global-set-key (kbd "H-'") 'next-error)
(global-set-key (kbd "H-;") 'previous-error)
(global-set-key (kbd "H-r") 'recompile)

(global-set-key (kbd "H-f") 'toggle-selective-display)

(global-set-key (kbd "H-[") 'kill-syntax-backward)
(global-set-key (kbd "H-]") 'kill-syntax-forward)

(global-set-key (kbd "C-'") 'hippie-expand)
(global-set-key [(control return)] 'set-mark-command)

(global-set-key (kbd "H-`") 'match-paren)

;; While searching with C-s this will run occur
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
		 (regexp-quote isearch-string))))))

(defalias 'qr 'query-replace)
(defalias 'qrr 'query-replace-regexp)

;; For some reason despite qr making more sense qq comes more naturally
(defalias 'qq 'query-replace)
(defalias 'qqr 'query-replace-regexp)


;; (global-set-key (kbd "s-<up>") 'up-list)
;; (global-set-key (kbd "s-<down>") 'down-list)
;; (global-set-key (kbd "s-<right>") 'forward-sexp)
;; (global-set-key (kbd "s-m") 'mark-sexp)
;; (global-set-key (kbd "s-<home>") 'beginning-of-defun)
;; (global-set-key (kbd "s-<left>") 'backward-sexp)
;; (global-set-key (kbd "s-<end>") 'end-of-defun)
;; (global-set-key (kbd "s-t") 'transpose-sexps)
;; (global-set-key (kbd "s-h") 'mark-defun)
;; (global-set-key (kbd "s-i") 'indent-sexp)
;; (global-set-key (kbd "s-k") 'kill-sexp)
;; (global-set-key (kbd "s-l") 'backward-kill-sexp)

(global-set-key (kbd "s-<tab>") 'complete-symbol)


					;(define-key scheme-mode-map (kbd "s-s") 'quack-view-srfi)
					;(define-key scheme-mode-map (kbd "C-)") 'hen-close-parens-at-point)

(defun fc-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
	     (current-buffer))
    (error (message "Invalid expression")
	   (insert (current-kill 0)))))

(global-set-key (kbd "C-c e") 'fc-eval-and-replace)
(global-set-key (kbd "C-c C-e") 'eval-last-sexp)

(global-set-key (kbd "C-<tab>") 'semantic-complete-analyze-inline)
					;(global-set-key (kbd "H-l") 'semantic-complete-jump)

;; (global-set-key (kbd "C-c t")
;;     (lambda () (interactive)
;;         (progn
;;             (save-buffer)
;;             (move-beginning-of-line nil)
;;             (call-process-region
;;                 (line-beginning-position)
;;                 (line-end-position)
;;                 "typeof"
;;                 nil
;;                 t
;;                 nil
;;                 (buffer-file-name)))))

;; keyboard macros
(global-set-key [f4]  'start-kbd-macro)
(global-set-key [f5]  'end-kbd-macro)
(global-set-key [f6]  'call-last-kbd-macro)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(chess-default-engine (quote (chess-gnuchess chess-crafty chess-phalanx)))
 '(chess-images-directory "/usr/share/pixmaps/chess/xboard")
 '(chess-sound-directory "/usr/share/sounds/chess")
 '(erc-modules (quote (autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly ring stamp spelling track)))
 '(eshell-directory-change-hook (quote (eshell-dir-buffer-name)))
 '(eshell-modules-list (quote (eshell-alias eshell-basic eshell-cmpl eshell-dirs eshell-glob eshell-hist eshell-ls eshell-pred eshell-prompt eshell-script eshell-term eshell-unix)))
 '(eshell-show-lisp-completions t)
 '(icicle-command-abbrev-alist nil)
 '(icicle-reminder-prompt-flag 6)
 '(ispell-silently-savep t)
 '(muse-project-alist (quote (("WikiPlans" ("~/Plans" :default "TaskPool" :major-mode planner-mode :visit-link planner-visit-link)))))
 '(org-deadline-warning-days 0)
 '(org-default-priority 66)
 '(org-insert-mode-line-in-empty-file t)
 '(org-lowest-priority 67)
 '(safe-local-variable-values (quote ((default-tab-width . 3))))
 '(xref-class-tree-splits-window-horizontally nil)
 '(xref-completion-case-sensitive t)
 '(xref-completion-overload-wizard-deep 3))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


(put 'downcase-region 'disabled nil)

;; ;; Haskell

;; (load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file.el")
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
;; (global-set-key (kbd "H-i") 'haskell-ghci-load-file)

;; (defun insert-scc-at-point ()
;;   "Insert an SCC annotation at point."
;;   (interactive)
;;   (if (or (looking-at "\b\|[ t]\|$") (and (not (bolp))
;; 					  (save-excursion
;; 					    (forward-char -1)
;; 					    (looking-at "\b\|[ t]"))))
;;       (let ((space-at-point (looking-at "[ t]")))
;; 	(unless (and (not (bolp)) (save-excursion
;; 				    (forward-char -1)
;; 				    (looking-at "[ t]")))
;; 	  (insert " "))
;; 	(insert "{-# SCC \"\" #-}")
;; 	(unless space-at-point
;; 	  (insert " "))
;; 	(forward-char (if space-at-point -5 -6)))
;;       (error "Not over an area of whitespace")))


;; (defun kill-scc-at-point ()
;;   "Kill the SCC annotation at point."
;;   (interactive)
;;   (save-excursion
;;     (let ((old-point (point))
;; 	  (scc "\({-#[ t]*SCC \"[^\"]*\"[ t]*#-}\)[ t]*"))
;;       (while (not (or (looking-at scc) (bolp)))
;; 	(forward-char -1))
;;       (if (and (looking-at scc)
;; 	       (<= (match-beginning 1) old-point)
;; 	       (> (match-end 1) old-point))
;; 	  (kill-region (match-beginning 0) (match-end 0))
;; 	  (error "No SCC at point")))))


;; (global-set-key (kbd "H-o") 'insert-scc-at-point)
;; (global-set-key (kbd "H-O") 'kill-scc-at-point)



;; erc

(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
				"324" "329" "332" "333" "353" "477"))

(setq erc-track-exclude-server-buffer t)

(defvar erc-channels-to-visit nil
  "Channels that have not yet been visited by erc-next-channel-buffer")
(defun erc-next-channel-buffer ()
  "Switch to the next unvisited channel. See erc-channels-to-visit"
  (interactive)
  (when (null erc-channels-to-visit)
    (setq erc-channels-to-visit
	  (remove (current-buffer) (erc-channel-list nil))))
  (let ((target (pop erc-channels-to-visit)))
    (if target
	(switch-to-buffer target))))


(global-set-key (kbd "C-=") 'erc-next-channel-buffer)

(require 'erc-match)
(setq erc-keywords '("andrei" "abarbu" "teval" "andrei_away" "andrei_" "barbu"))

(setq erc-autojoin-channels-alist
      '(("irc.freenode.net" "#csc" "#hurd" "##hurd" "#c++" "#scheme"
	 "#math" "#c" "#haskell" "#prolog")))




(defun display-as-hex ()
  (interactive)
  (message (format "#x%x" (read (read-no-blanks-input "Number: ")))))
(global-set-key (kbd "H-h") 'display-as-hex)
(defun display-as-dec ()
  (interactive)
  (message (format "%d" (read (concat "#x"(read-no-blanks-input "Number: "))))))
(global-set-key (kbd "H-n") 'display-as-dec)

(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (ido-completing-read "Project file: "
			 (tags-table-files)
			 nil t)))

(defun csc ()
  (interactive)
  (shell "csc"))

(defun mohio ()
  (interactive)
  (shell "mohio"))

(setq woman-use-own-frame nil)
(setq tramp-default-method "ssh")

(display-battery-mode)
(global-set-key (kbd "H-b") 'battery)

(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

(require 'uniquify)

(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")


(add-hook 'message-mode-hook 'turn-on-flyspell)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
					;(add-hook 'lisp-mode-hook 'flyspell-prog-mode)
(add-hook 'scheme-mode-hook 'flyspell-prog-mode)
(add-hook 'haskell-mode-hook 'flyspell-prog-mode)



;; hideshow for programming
(load-library "hideshow")
(load-file (expand-file-name "~/emacs/hideshowvis.el"))
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'haskell-mode-hook 'hs-minor-mode)
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'lisp-mode-hook 'hs-minor-mode)
(add-hook 'elisp-mode-hook 'hs-minor-mode)
(add-hook 'scheme-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)


(global-set-key (kbd "C-c s") 'hs-show-block)
(global-set-key (kbd "C-c S") 'hs-show-all)
(global-set-key (kbd "C-c h") 'hs-hide-block)
(global-set-key (kbd "C-c H") 'hs-hide-all)


(define-fringe-bitmap 'hs-marker [0 24 24 126 126 24 24 0])

(defcustom hs-fringe-face 'hs-fringe-face
  "*Specify face used to highlight the fringe on hidden regions."
  :type 'face
  :group 'hideshow)

(defface hs-fringe-face
    '((t (:foreground "#888" :box (:line-width 2 :color "grey75" :style released-button))))
  "Face used to highlight the fringe on folded regions"
  :group 'hideshow)

(defcustom hs-face 'hs-face
  "*Specify the face to to use for the hidden region indicator"
  :type 'face
  :group 'hideshow)

(defface hs-face
    '((t (:background "dark slate gray" :box t)))
  "Face to hightlight the ... area of hidden regions"
  :group 'hideshow)

(defun display-code-line-counts (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (let* ((marker-string "*fringe-dummy*")
	   (marker-length (length marker-string))
	   (display-string (format "(%d)..." (count-lines (overlay-start ov) (overlay-end ov)))))
      (overlay-put ov 'help-echo "Hidden text. C-c,= to show")
      (put-text-property 0 marker-length 'display (list 'left-fringe 'hs-marker 'hs-fringe-face) marker-string)
      (overlay-put ov 'before-string marker-string)
      (put-text-property 0 (length display-string) 'face 'hs-face display-string)
      (overlay-put ov 'display display-string))))

(setq hs-set-up-overlay 'display-code-line-counts)



(defun google-region (&optional flags)
  "Google the selected region"
  (interactive)
  (let ((query (buffer-substring (region-beginning) (region-end))))
    (browse-url (concat
		 "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" query))))
(global-set-key (kbd "C-c g") 'google-region)

(add-hook 'text-mode-hook 'flyspell-mode)


(defun open-in-doc-view ()
  (interactive)
  (doc-view
   (buffer-file-name (current-buffer))
   (buffer-file-name (current-buffer))))

(global-set-key (kbd "H-<return>") 'org-meta-return)


(require 'scheme)

(setq scheme-program-name "run-dsci")
(setq c-indent-level 1)
(setq c-continued-statement-offset 0)
(setq c-brace-offset 0)
(setq c-argdecl-indent 0)
(setq c-label-offset 0)

(setq lisp-body-indent 1)

(put 'when 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)
(put 'syntax-rules 'scheme-indent-function 1)
(put 'eval-when 'scheme-indent-function 1)
(put 'with-font 'scheme-indent-function 1)
(put 'call-with-postscript-file 'scheme-indent-function 1)
(put 'parallel-do 'scheme-indent-function 2)

(setq
 scheme-font-lock-keywords
 (append
  scheme-font-lock-keywords-2
  (eval-when-compile
   (list
    (list (concat "(\\(define\\*?\\("
		  "\\(-structure\\|-application\\)\\|"
		  "\\)\\)\\>"
		  ;; Any whitespace and declared object.
		  "[ \t]*(?"
		  "\\(\\sw+\\)?")
	  '(1 font-lock-keyword-face)
	  '(6 (cond ((match-beginning 3) font-lock-function-name-face)
		    ((match-beginning 5) font-lock-variable-name-face)
		   (t font-lock-type-face))
	      nil t))
    (cons
     (concat
      "(" (regexp-opt
	   '("set!" "define-button" "define-key" "define-region" "unless") t)
      "\\>") 1)))))

(setq org-agenda-files (list "~/replicated/notes/notes"))
(global-set-key (kbd "C-c C-x d") 'org-agenda)
(global-set-key (kbd "C-c a") 'org-agenda)


(setq eshell-save-history-on-exit t)
(setq eshell-history-size 1024)
(setq eshell-hist-ignoredups t)
(setq eshell-cmpl-cycle-completions nil)

(defun eshell-maybe-bol ()
  (interactive)
  (let ((p (point)))
    (eshell-bol)
    (if (= p (point))
	(beginning-of-line))))


(add-hook 'eshell-preoutput-filter-functions
	  'ansi-color-apply)
(add-hook 'eshell-output-filter-functions
	  'eshell-truncate-buffer)
(add-hook 'eshell-mode-hook
	  '(lambda ()
	    (define-key eshell-mode-map [up] 'previous-line)
	    (define-key eshell-mode-map [down] 'next-line)
	    (define-key eshell-mode-map "\C-a" 'eshell-maybe-bol)
	    (define-key eshell-mode-map [home] 'eshell-maybe-bol)
	    (setq shell-num (+ shell-num 1))
	    (rename-buffer (concat "*eshell*<" (number-to-string shell-num) ">"))
	    (eshell-dir-buffer-name)))
(add-hook 'eshell-pre-command-hook
	  '(lambda ()
	    (eshell-rename-buffer (eshell-get-old-input))))
(add-hook 'eshell-post-command-hook 'eshell-dir-buffer-name)

;; Seems women are better than men afterall..
(defun eshell/man (subject) (woman subject))
(defalias 'man 'woman)


;;; shell-toggle
;; http://www-verimag.imag.fr/~moy/emacs/shell-toggle-patched.el
(autoload 'shell-toggle "shell-toggle" t)
(autoload 'shell-toggle-cd "shell-toggle" t)

(setq shell-toggle-launch-shell 'shell-toggle-eshell)

(global-set-key (kbd "C-c O") 'shell-toggle-cd)
(global-set-key (kbd "C-c o") 'shell-toggle)

;(eshell)
(load-file (expand-file-name "~/emacs/multi-eshell.el"))

(defvar shell-num 0)

(defun eshell-rename-buffer (x)
  (rename-buffer
   (concat (car (split-string (buffer-name) "|")) "|" x)
   t))

(defun eshell-dir-buffer-name () (eshell-rename-buffer default-directory))


;; Change the default eshell prompt
(setq eshell-prompt-function
      (lambda ()
	(concat (getenv "USER") "@" system-name " "
		(eshell/pwd) (if (= (user-uid) 0) " # " " $ "))))

(setq comint-completion-addsuffix t)

(require 'color-theme)
(color-theme-initialize)
(load-file (expand-file-name "~/emacs/color-theme-colorful-obsolescence.el"))
;; (color-theme-dark-laptop)
;; (color-theme-midnight)
;; (color-theme-charcoal-black)
;; (color-theme-tty-dark)
(color-theme-colorful-obsolescence)

(defun run-isci ()
    (interactive)
    (run-scheme (expand-file-name "~/bin/run-isci")))

(defun run-dsci ()
    (interactive)
    (run-scheme (expand-file-name "~/bin/run-dsci")))

(setq haskell-program-name "ghci")

(defun xlock ()
  (interactive)
  (shell-command "xlock"))

(global-set-key (kbd "M-L") 'xlock)

(setq prolog-program-name "~/bin/pl")
(setq diff-switches "-u")

(defun uniquify-region-lines (beg end)
 "Remove duplicate adjacent lines in region."
 (interactive "*r")
 (save-excursion
  (goto-char beg)
  (while (re-search-forward "^\\(.*\n\\)\\1+" end t)
   (replace-match "\\1"))))
  
(defun uniquify-buffer-lines ()
 "Remove duplicate adjacent lines in the current buffer."
 (interactive)
 (uniquify-region-lines (point-min) (point-max)))
(put 'narrow-to-region 'disabled nil)
