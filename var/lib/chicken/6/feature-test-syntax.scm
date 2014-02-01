;; We can't always use ##sys#values, because old chicken does not understand
;; it and we are overwriting #+ .  If we did not overwrite #+ then we could
;; always return values.  However if API were different this approach is
;; not even possible.

(use setup-api) ;; version>=?

(let ((omit (if (version>=? (chicken-version) "4.6.7")
                '(##sys#values)
                ''(##core#undefined))))
  (set-sharp-read-syntax!
   #\+ (lambda (p) (let ((ft (read p))
                    (body (read p)))
                (eval
                 `(cond-expand (,ft ',body)
                               (else ,omit)))
                )))
  (set-sharp-read-syntax!
   #\- (lambda (p) (let ((ft (read p))
                    (body (read p)))
                (eval
                 `(cond-expand (,ft ,omit)
                               (else ',body))))))
  (set-sharp-read-syntax!
   #\? (lambda (p) (let* ((test (read p))
                     (ft (car test))
                     (con (cadr test))
                     (alt (cddr test)))
                (eval
                 `(cond-expand (,ft ',con)
                               (else
                                ,(if (null? alt)
                                     omit
                                     (list 'quote (car alt))))))))))
