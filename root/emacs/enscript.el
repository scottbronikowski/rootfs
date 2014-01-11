;; Enscript Emacs buffer on line printer.
;; Copyright (C) 1985, 1988 Free Software Foundation, Inc.

;; This file is part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 1, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

(defvar *enscript* "nenscript")

(defvar *enscript-printer* "ee339c1")

(defun enscript-buffer ()
  "Print buffer contents as with Unix command `enscript'."
  (interactive)
  (enscript-region-1 (point-min) (point-max)))

(defun enscript-region (start end)
  "Print region contents as with Unix command `enscript'."
  (interactive "r")
  (enscript-region-1 start end))

(defun enscript-region-1 (start end)
  (let ((name (concat "\"" (buffer-name) " Emacs buffer\""))
	(width tab-width))
    (save-excursion
     (message "Spooling...")
     (if (/= tab-width 8)
	 (let ((oldbuf (current-buffer)))
	  (set-buffer (get-buffer-create " *spool temp*"))
	  (widen)
          (erase-buffer)
	  (insert-buffer-substring oldbuf start end)
	  (setq tab-width width)
	  (untabify (point-min) (point-max))
	  (setq start (point-min) end (point-max))))
     (call-process-region
      start end *enscript* nil nil nil
      (concat "-P" *enscript-printer*) "-2r" "-b" name)
     (message "Spooling...done"))))
