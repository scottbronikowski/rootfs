(defun view-word-document ()
 (interactive)
 (let ((entity (get-text-property (point) 'mime-view-entity)))
  (cond (entity
         (mime-write-entity-content entity "/tmp/word-document.doc")
	 (call-process
	  "wvHtml"
	  nil
	  nil
	  nil
	  "--targetdir=/tmp"
	  "/tmp/word-document.doc"
	  "word-document.html")
	 (browse-url "file:///tmp/word-document.html")))))

(define-key global-map "\M-D"     'view-word-document)

(defun view-pdf-document ()
 (interactive)
 (let ((entity (get-text-property (point) 'mime-view-entity)))
  (cond (entity
         (mime-write-entity-content entity "/tmp/pdf-document.pdf")
	 (browse-url "file:///tmp/pdf-document.pdf")))))

(define-key global-map "\M-P"     'view-pdf-document)
