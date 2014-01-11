;;; tex-math-preview-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (tex-math-preview tex-math-preview) "tex-math-preview"
;;;;;;  "tex-math-preview.el" (18591 22908))
;;; Generated autoloads from tex-math-preview.el

(let ((loads (get 'tex-math-preview 'custom-loads))) (if (member '"tex-math-preview" loads) nil (put 'tex-math-preview 'custom-loads (cons '"tex-math-preview" loads))))

(autoload 'tex-math-preview "tex-math-preview" "\
Preview a TeX maths expression at (or surrounding) point.
The `tex-math-preview-function' variable controls the viewing
method.  The math expressions recognised are

    $...$ or $$...$$              TeX
    \\(...\\) or \\=\\[...\\]            LaTeX
    \\begin{math}...\\end{math}     LaTeX
    \\begin{displaymath}...        LaTeX
    @math{...}                    Texinfo
    <math>...</math>              Wikipedia
    <alt role=\"tex\">...</alt>     DBTexMath

DBTexMath is processed with plain TeX by default, or if it
contains \\(...\\) or \\=\\[...\\] then with LaTeX.

\"$\" is both the start and end for plain TeX, making it slightly
ambiguous.  tex-math-preview assumes point is inside the
expression, so when just after a \"$\" then that's the start, or
when just before then that's the end.  If point is in between two
\"$$\" then that's considered a start.

For more on the respective formats see

    URL `http://www.latex-project.org/'
    Info node `(texinfo)math'
    URL `http://meta.wikimedia.org/wiki/Help:Displaying_a_formula'
    URL `http://ricardo.ecn.wfu.edu/~cottrell/dbtexmath/'

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("tex-math-preview-pkg.el") (18591 22908
;;;;;;  68543))

;;;***

(provide 'tex-math-preview-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; tex-math-preview-autoloads.el ends here
