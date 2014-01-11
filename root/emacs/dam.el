;;; make control-meta-rubout work (backward kill sexp)
(global-unset-key [C-M-delete])
(global-set-key [C-M-delete] 'backward-kill-sexp)

;;; so I can do this through Kermit
(global-unset-key "\M-&")
(global-set-key "\M-&" 'backward-kill-sexp)

(defvar semi-colon 59 "the numeric representation of the character ;")

(defun comment-region ()
 (interactive)
 (let* ((beg (if (< (point) (mark)) (point) (mark)))
	(end (if (< (point) (mark)) (mark) (point)))
	(reg-size (count-lines beg end)))
  (goto-char beg)
  (beginning-of-line)
  (comment-loop 0 reg-size)))

(defun comment-loop (k reg-size)
 (cond ((< k reg-size)
	(insert semi-colon)
	(beginning-of-line)
	(forward-line)
	(comment-loop (+ k 1) reg-size))))

(global-unset-key "\C-x;")
(global-set-key "\C-x;" 'comment-region)

(defun uncomment-region ()
 (interactive)
 (let* ((beg (if (< (point) (mark)) (point) (mark)))
	(end (if (< (point) (mark)) (mark) (point)))
	(reg-size (count-lines beg end)))
  (goto-char beg)
  (beginning-of-line)
  (uncomment-loop 0 reg-size)))

(defun uncomment-loop (k reg-size)
 (cond ((< k reg-size)
	(if (eq (char-after (point)) semi-colon)
	    (delete-char 1))
	(beginning-of-line)
	(forward-line)
	(uncomment-loop (+ k 1) reg-size))))

(global-unset-key "\C-x:")
(global-set-key "\C-x:" 'uncomment-region)

(defun copy-sexp-as-kill (arg)
 "Save sexp as if killed, but don't kill it."
 (interactive "p")
 (let ((beg (point)))
  (forward-sexp arg)
  (copy-region-as-kill beg (point))))

(global-set-key "\e\^W" 'copy-sexp-as-kill)

(defconst no-key "\e[ ")
(defconst l1-key "\e[192z")
(defconst l2-key "\e[193z")
(defconst l3-key "\e[194z")
(defconst l4-key "\e[195z")
(defconst l5-key "\e[196z")
(defconst l6-key "\e[197z")
(defconst l7-key "\e[198z")
(defconst l8-key "\e[199z")
(defconst l9-key "\e[200z")
(defconst l10-key "\e[201z")
(defconst help-key "\e[-1z")

(defconst r1-key "\e[208z")
(defconst r2-key "\e[209z")
(defconst r3-key "\e[210z")
(defconst r4-key "\e[211z")
(defconst r5-key "\e[212z")
(defconst r6-key "\e[213z")
(defconst r7-key "\e[214z")
(defconst r9-key "\e[216z")
(defconst r11-key "\e[218z")
(defconst r13-key "\e[220z")
(defconst r15-key "\e[222z")
(defconst alt-key "\e[223z")

(defconst f1-key "\e[224z")
(defconst f2-key "\e[225z")
(defconst f3-key "\e[226z")
(defconst f4-key "\e[227z")
(defconst f5-key "\e[228z")
(defconst f6-key "\e[229z")
(defconst f7-key "\e[230z")
(defconst f8-key "\e[231z")
(defconst f9-key "\e[232z")

(defun define-keypad-key (map key def)
 "In MAP, cause the string KEY to be bound to DEF.  Creates 
any needed intermediate keymaps"
 (let ((look (lookup-key map key)))
  (if (numberp look)
      (let ((len (1- (length key)))
	    (submap (lookup-key map (substring key 0 (1- look)))))
       (while (<= look len)
	(let ((new (make-sparse-keymap)))
	 (define-key submap (char-to-string (aref key (1- look))) new)
	 (setq submap new)
	 (setq look (1+ look))))))
  (define-key map key def)))

(defun ignore-key () "Do nothing interactively" (interactive))

(mapcar
 (function
  (lambda (key)
  (define-keypad-key global-map key 'ignore-key)))
 (list l1-key l2-key l3-key l4-key l5-key l6-key l7-key l8-key l9-key l10-key
       help-key r1-key r2-key r3-key r4-key r5-key r6-key r7-key r9-key
       r11-key r13-key r15-key alt-key f1-key f2-key f3-key f4-key f5-key
       f6-key f7-key f8-key f9-key))
