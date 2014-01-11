;;; Macros for .plan schedule files

(defvar plan-mode-map nil "Key map for plan mode.")

(defvar plan-in-israel nil "T if in Israel, NIL if not.")

(defun plan-full-copy-sparse-keymap (km)
  "Recursively copy the sparse keymap KM"
  (cond ((consp km)
	 (cons (plan-full-copy-sparse-keymap (car km))
	       (plan-full-copy-sparse-keymap (cdr km))))
	(t km)))

(setq plan-mode-map (plan-full-copy-sparse-keymap text-mode-map))

(defun plan-mode ()
 (setq major-mode 'plan-mode)
 (setq mode-name "PLAN")
 (use-local-map plan-mode-map))

(set-default 'auto-mode-alist (cons '("\\.plan" . plan-mode) auto-mode-alist))

(defun plan-beginning-of-entry ()
 (backward-char 1)
 (while (not (looking-at "|")) (backward-char 1))
 (forward-char 1))

(defun plan-up (n)
 (interactive "p")
 (plan-beginning-of-entry)
 (previous-line n))

(defun plan-down (n)
 (interactive "p")
 (plan-beginning-of-entry)
 (next-line n))

(defun plan-left (n)
 (interactive "p")
 (backward-char 1)
 (if (not (looking-at "|")) (forward-char 1))
 (let ((i n))
  (while (> i 0)
   (plan-beginning-of-entry)
   (backward-char 1)
   (setq i (- i 1)))
  (forward-char 1)))

(defun plan-right (n)
 (interactive "p")
 (let ((i n))
  (while (> i 0)
   (while (not (looking-at "|")) (forward-char 1))
   (forward-char 1)
   (setq i (- i 1)))))

(defun plan-out (n)
 (interactive "p")
 (plan-beginning-of-entry)
 (let ((i n))
  (while (> i 0)
   (delete-char 8)
   (insert "////////")
   (backward-char 8)
   (next-line 1)
   (setq i (- i 1)))))

(defun plan-in (n)
 (interactive "p")
 (plan-beginning-of-entry)
 (let ((i n))
  (while (> i 0)
   (delete-char 8)
   (insert "........")
   (backward-char 8)
   (next-line 1)
   (setq i (- i 1)))))

(defun plan-duplicate (n)
 (interactive "p")
 (plan-beginning-of-entry)
 (let ((i n))
  (while (> i 0)
   (previous-line 1)
   (let ((string (buffer-substring (point) (+ (point) 8))))
    (next-line 1)
    (delete-char 8)
    (insert string)
    (backward-char 8))
   (next-line 1)
   (setq i (- i 1)))))

(defun plan-entry (string)
 (interactive "sEntry: ")
 (plan-beginning-of-entry)
 (insert (substring (concat string "........") 0 8))
 (delete-char 8)
 (backward-char 8)
 (next-line 1))

(defun create-schedule ()
 (interactive)
 (insert
 (if plan-in-israel
"
         S        M        T        W        R        F
8:30.|........|........|........|........|........|........
9....|........|........|........|........|........|........
9:30.|........|........|........|........|........|........
10...|........|........|........|........|........|........
10:30|........|........|........|........|........|........
11...|........|........|........|........|........|........
11:30|........|........|........|........|........|........
12...|........|........|........|........|........|........
12:30|........|........|........|........|........|........
1....|........|........|........|........|........|........
1:30.|........|........|........|........|........|........
2....|........|........|........|........|........|........
2:30.|........|........|........|........|........|........
3....|........|........|........|........|........|........
3:30.|........|........|........|........|........|........
4....|........|........|........|........|........|........
4:30.|........|........|........|........|........|........
5....|........|........|........|........|........|........
5:30.|........|........|........|........|........|........
6....|........|........|........|........|........|........
6:30.|........|........|........|........|........|........
"
"
         M        T        W        R        F
8:30.|........|........|........|........|........
9....|........|........|........|........|........
9:30.|........|........|........|........|........
10...|........|........|........|........|........
10:30|........|........|........|........|........
11...|........|........|........|........|........
11:30|........|........|........|........|........
12...|........|........|........|........|........
12:30|........|........|........|........|........
1....|........|........|........|........|........
1:30.|........|........|........|........|........
2....|........|........|........|........|........
2:30.|........|........|........|........|........
3....|........|........|........|........|........
3:30.|........|........|........|........|........
4....|........|........|........|........|........
4:30.|........|........|........|........|........
5....|........|........|........|........|........
5:30.|........|........|........|........|........
6....|........|........|........|........|........
6:30.|........|........|........|........|........
")))

(defun find-time (who)
 (interactive "sWho: ")
 (let* ((plan (get-buffer-create "*plan*"))
        (schedule (get-buffer-create "*schedule*")))
  (set-buffer plan)
  (erase-buffer)
  (call-process "/usr/ucb/finger" nil t nil who)
  (goto-char (point-min))
  (while (< (point) (point-max))
   (if (looking-at "")
       (delete-char 1)
       (forward-char 1)))
  (set-buffer schedule)
  (if (= (point-min) (point-max)) (create-schedule))
  (goto-char (point-min))
  (while (not (looking-at "8:30\\.|")) (forward-char 1))
  (set-buffer plan)
  (goto-char (point-min))
  (catch 'exit
   (while (not (looking-at "8:30\\.|"))
    (if (= (point) (point-max)) (throw 'exit nil))
    (forward-char 1))
   (while t
    (set-buffer plan)
    (while (not (looking-at "|"))
     (if (= (point) (point-max)) (throw 'exit nil))
     (forward-char 1))
    (forward-char 1)
    (let ((free (looking-at "\\.\\.\\.\\.\\.\\.\\.\\.")))
     (set-buffer schedule)
     (while (not (looking-at "|"))
      (if (= (point) (point-max)) (throw 'exit nil))
      (forward-char 1))
     (forward-char 1)
     (cond ((not free)
	    (delete-char 8)
	    (insert "////////")
	    (backward-char 8))))))
  (kill-buffer plan)
  (switch-to-buffer schedule)
  (goto-char (point-min))))

(define-key plan-mode-map "\M-f" 'plan-right)
(define-key plan-mode-map "\M-b" 'plan-left)
(define-key plan-mode-map "\M-p" 'plan-up)
(define-key plan-mode-map "\M-n" 'plan-down)
(define-key plan-mode-map "\M-o" 'plan-out)
(define-key plan-mode-map "\M-i" 'plan-in)
(define-key plan-mode-map "\M-d" 'plan-duplicate)
(define-key plan-mode-map "\M-e" 'plan-entry)
