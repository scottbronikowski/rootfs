(setq PC-meta-flag t)
(setq pop-up-windows t)
(setq make-backup-files t)
(setq version-control t)
(setq kept-old-versions 0)
(setq kept-new-versions 3)
(setq trim-versions-without-asking t)
(setq delete-auto-save-files t)
(setq ask-about-buffer-names t)
(setq default-major-mode 'text-mode)
(setq default-fill-column 78)
(setq lpr-switches '("-Pee339c1"))

;;; So shell mode won't have those annoying ^M's
;;; tcsh looses big in a buffer
(setq explicit-shell-file-name "/bin/tcsh")

;;; Put this into text-mode-hook
(setq indent-tabs-mode nil)
(setq inhibit-startup-message t)

;;; so meta works from lisp machines
(setq meta-flag t)
(setq tab-stop-list '(4 8 12 16 24 32 40 48 56 64 72 80))

;;; C indenting style - my own preference
(setq c-indent-level 1)
(setq c-continued-statement-offset 0)
(setq c-brace-offset 0)
(setq c-argdecl-indent 0)
(setq c-label-offset 0)

;;; RMAIL-MODE-HOOK can't do this, because by the time the hook runs,
;;; RMAIL-FILE-NAME's already been looked at.
(setq rmail-file-name "~/mail/rmail")
(setq mail-host-address "purdue.edu")
(setq mail-self-blind t)
(setq mail-default-reply-to "brownfis@purdue.edu")
(setq mail-signature t)
;(setq rmail-babyl-compatibility " ")

;;; This variable controls what mode GNU goes into when editing various
;;; kinds of files.  This list is somewhat different than its default
;;; value, and corresponds to the kinds of files I usually edit.
(set-default 'auto-mode-alist
	     (append
	      '(("\\.txt$"          . text-mode)
		("\\.text$"         . text-mode)
		("\\.doc$"          . text-mode)
                ("\\.rmail$"        . rmail-mode)
                ("\\.babyl$"        . rmail-mode)
		("\\.c$"            . c-mode)
		("\\.h$"            . c-mode)
		("\\.l$"            . lisp-mode)
		("\\.lsp$"          . lisp-mode)
		("\\.lisp$"         . lisp-mode)
		("\\.cl$"           . lisp-mode)
		("\\.ml$"           . lisp-mode)
		("\\.sc$"           . scheme-mode)
		("\\.tex$"          . latex-mode)
		("\\.sty$"          . latex-mode)
		("\\.bbl$"          . latex-mode)
		("\\.bib$"          . bibtex-mode)
		("\\.texinfo$"      . texinfo-mode)
		("\\.texi$"         . texinfo-mode)
		("\\.el$"           . emacs-lisp-mode)
		("[]>:/]\\..*emacs" . emacs-lisp-mode))
	      auto-mode-alist))

;;; Mode Hooks
(setq text-mode-hook '(lambda () (auto-fill-mode 1)))
(setq tex-mode-hook
      '(lambda ()
         (reftex-mode)
         ;; don't look at backslash
	 (setq paragraph-start "^[ \t]*$\\|^[\f%]"
	       paragraph-separate paragraph-start)))
(add-hook
 'mail-setup-hook
 (lambda ()
  (define-key mail-mode-map "\C-c["
   (lambda ()
    (interactive)
    (require 'reftex)
    (let ((reftex-cite-format
           '((102 . "%100a\n%t\n%b\n%100e\n%j\nvolume: %v, number: %n, chapter: %c, edition: %d, pages: %p\nmonth: %m, year: %y\n%u %f\n%i\n%o\n%s\n%h\n")
	     (108 . "(%2a %y, %j %v, %P, %e: %b, %u, %s %<)")))
	  (reftex-cite-punctuation '(", " " & " " et al.")))
     (reftex-citation))))))

;;; Ed Reingold's calendar stuff

(setq european-calendar-style t)
(setq mark-holidays-in-calendar t)
(setq all-hebrew-calendar-holidays t)
(setq nongregorian-diary-listing-hook 'list-hebrew-diary-entries)
(setq nongregorian-diary-marking-hook 'mark-hebrew-diary-entries)
(setq diary-display-hook 'fancy-diary-display)
(setq diary-list-include-blanks t)
(setq list-diary-entries-hook
      '(include-other-diary-files
        (lambda nil
          (setq diary-entries-list
                (sort diary-entries-list 'diary-entry-compare)))))
(setq mark-diary-entries-hook 'mark-included-diary-files)
(setq view-diary-entries-initially t)
(setq number-of-diary-entries [2 2 2 2 2 4 3])
;;;(setq calendar-latitude 43.666666667)	;Toronto
;;;(setq calendar-longitude -79.4)		;Toronto
(setq calendar-latitude 40.36096667)	;NECI
(setq calendar-longitude -74.59555)	;NECI

;;; LaTeX mode
(setq tex-directory "/tmp")
(setq tex-dvi-print-command "dvips")
(setq tex-alt-dvi-print-command "dvip")
(cond ((equal (system-name) "ingqondo.ecn.purdue.edu")
       (setq tex-dvi-view-command "xdvi -geometry 843x750-0-0 -expert"))
      (t (setq tex-dvi-view-command "xdvi -geometry 829x1172-0-0 -expert")))
(setq tex-default-mode 'latex-mode)
(setq latex-run-command "latex")
(setq reftex-default-bibliography
      (list (expand-file-name "~/tex/inputs/QobiTeX.bib")))

;;; Manual Path
(setq Man-switches "-M /home/qobi/pkg/entropic/5.3.1/esps531.linux/man:/home/qobi/man:/opt/SUNWits/Graphics-sw/xil/man:/opt/SUNWits/Graphics-sw/xgl-3.0/man:/local/X11R6/man:/usr/openwin/man:/local/man:/usr/man:/usr/X11/man:/usr/local/man:/usr/local/5.3/share/man:/usr/local/5.3/share/explorer/unsupported/man:/usr/local/Irix5/man:/usr/local/cad.new/man:/usr/local/imtools/imtools/man:/usr/local/imtools/libim/man:/usr/local/lib/crisp/help/man:/usr/local/man:/usr/local/tex/man:/usr/local/tools/pisces9009/icl/man:/opt/man:/usr/share/catman:/usr/share/man/usr/catman/usr/man:")
