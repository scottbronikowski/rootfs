;;;; inline-type-checks.scm
;;;; Kon Lovett, Apr '09

;; Issues
;;
;; - Needs "chicken-primitive-object-inlines.scm"
;;
;; - This source is to be included only!

; maybe a problem with expansion environment namespace pollution
(define-for-syntax (symbolize . elts)
  (string->symbol (apply conc (map strip-syntax elts))) )

;just in case older inlines
(define-inline (%natural? n) (%<= 0 n))
(define-inline (%fxnatural? fx) (%fx<= 0 fx))

(cond-expand

  (unsafe
 
    (define-syntax define-inline-check-type
      (er-macro-transformer
        (lambda (frm rnm cmp)
          (let ((_define-inline (rnm 'define-inline)))
            (let* ((typ (cadr frm))
                   (typstr (symbol->string typ))
                   (nam (string->symbol (string-append "%check-" typstr))) )
              `(,_define-inline (,nam loc obj . _) obj) ) ) ) ) )

    (define-inline (%check-positive-fixnum . _) (begin))
    (define-inline (%check-natural-fixnum . _) (begin))
    (define-inline (%check-positive-integer . _) (begin))
    (define-inline (%check-natural-integer . _) (begin))
    (define-inline (%check-positive-number . _) (begin))
    (define-inline (%check-natural-number . _) (begin))
    (define-inline (%check-structure . _) (begin))
    (define-inline (%check-minimum-argument-count . _) (begin))
    (define-inline (%check-argument-count . _) (begin)) )

  (else

    (define-inline (%alist? obj)
      (or (%null? obj)
          (and (%pair? obj) (%list-every/1 (lambda (x) (%pair? x)) obj))) )

    ;;

    (define-syntax define-inline-check-type
      (er-macro-transformer
        (lambda (frm rnm cmp)
          (let ((_define-inline (rnm 'define-inline))
                (_unless (rnm 'unless))
                (_optional (rnm 'optional)) )
            (let* ((typ (cadr frm))
                   (typstr (symbol->string typ))
                   (pred (if (not (null? (cddr frm))) (caddr frm)
                           (string->symbol (string-append "%" typstr "?"))))
                   (nam (string->symbol (string-append "%check-" typstr)))
                   (errnam (string->symbol (string-append "error-" typstr))) )
              `(,_define-inline (,nam loc obj . args)
                 (,_unless (,pred obj)
                   (,errnam loc obj (,_optional args)))
                 obj ) ) ) ) ) )

    ;;

    (define-inline (%check-positive-fixnum loc obj . args)
      (unless (and (%fixnum? obj) (%fxpositive? obj))
        (error-positive-fixnum loc obj (optional args)))
      obj )

    (define-inline (%check-natural-fixnum loc obj . args)
      (unless (and (%fixnum? obj) (%fxnatural? obj))
        (error-natural-fixnum loc obj (optional args)))
      obj )

    ;;

    (define-inline (%check-positive-integer loc obj . args)
      (unless (and (%integer? obj) (%positive? obj))
        (error-positive-integer loc obj (optional args)))
      obj )

    (define-inline (%check-natural-integer loc obj . args)
      (unless (and (%integer? obj) (%natural? obj))
        (error-natural-integer loc obj (optional args)))
      obj )

    ;;

    (define-inline (%check-positive-number loc obj . args)
      (unless (and (%number? obj) (%positive? obj))
        (error-positive-number loc obj (optional args)))
      obj )

    (define-inline (%check-natural-number loc obj . args)
      (unless (and (%number? obj) (%natural? obj))
        (error-natural-number loc obj (optional args)))
      obj )

    ;;

    (define-inline (%check-structure loc obj tag . args)
      (unless (%structure-instance? obj tag)
        (error-structure loc obj tag (optional args)))
      obj )

    ;;

    (define-inline (%check-minimum-argument-count loc argc minargc)
      (unless (%fx<= minargc argc)
        (error-minimum-argument-count loc argc minargc))
      argc )

    (define-inline (%check-argument-count loc argc maxargc)
      (unless (%fx<= argc maxargc)
        (error-argument-count loc argc maxargc))
      argc ) ) )

;;

(define-inline-check-type fixnum)
(define-inline-check-type flonum)
(define-inline-check-type integer)
(define-inline-check-type number)
(define-inline-check-type symbol)
(define-inline-check-type keyword)
(define-inline-check-type string)
(define-inline-check-type char)
(define-inline-check-type boolean)
(define-inline-check-type procedure)
(define-inline-check-type closure)
(define-inline-check-type input-port)
(define-inline-check-type output-port)
(define-inline-check-type list)
(define-inline-check-type pair)
(define-inline-check-type blob)
(define-inline-check-type vector)
(define-inline-check-type alist)

(define-inline (%check-cardinal-fixnum loc obj . args)
  (%check-natural-fixnum loc obj (optional args)))
(define-inline (%check-cardinal-integer loc obj . args)
  (%check-natural-integer loc obj (optional args)))
(define-inline (%check-cardinal-number loc obj . args)
  (%check-natural-number loc obj (optional args)))
