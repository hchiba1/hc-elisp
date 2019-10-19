;;; Count lines, words, chars
(defun count-lines-buffer ()
  "Count number of lines in the current buffer."
  (interactive)
  (save-excursion
    (let ((count 0) (flg 0))
      (goto-char (point-min))
      (end-of-line)
      (if (=  (point) (point-max))
	  (setq flg 1))
      (while (=  flg 0)
	(next-line 1)
	(beginning-of-line)
	(setq count (+ 1 count))
	(if (=  (point) (point-max))
	    (setq flg 1)
	  (end-of-line)
	  (if (=  (point) (point-max))
	      (setq flg 1)))
      )
      (message "buffer contains %d lines." count))))
(defun count-chars-buffer ()
  "Count number of characters in the current buffer."
  (interactive)
  (save-excursion
    (let ((count 0))
      (goto-char (point-min))
      (while (< (point) (point-max))
	(forward-char 1)
	(setq count (1+ count)))
      (message "buffer contains %d chars." count))))
(defun count-words-region (start end)
  (interactive "r")
  (save-excursion
    (let ((count 0))
      (goto-char start)
      (while (< (point) end)
	(forward-word 1)
	(setq count (+ 1 count)))
      (setq count (- count 1))
      (message "region contains %d words." count))))
(defun count-words-buffer ()
  "Count number of words in the current buffer."
  (interactive)
  (save-excursion
    (let ((count 0))
      (goto-char (point-min))
      (while (< (point) (point-max))
	(forward-word 1)
	(setq count (1+ count)))
      (message "buffer contains %d words." count))))

(defun capitalize-sentences-region (start end)
  ""
  (interactive "r")
  (save-excursion
    (goto-char start)
    (while (search-forward ". " end t)
      (capitalize-word 1))
    ))


(defun goto-percent (p)
  (interactive "nGoto percent: ")
  (goto-char (/ (* (point-max) p) 100)))

(defun what-line()
  (interactive)
  (save-excursion
    (let* ((count 1) (end (point)) )
      (goto-char (point-min))
      (while (< (point) end)
	(next-line 1)
	(setq count (+ 1 count)))
      (message "You are in %d-th line." count)
      (eval count))))

;; calculate power
;; (let ((n 5)(c 1)(i 0))
;;   (while (< i n)
;;     (setq i (+ 1 i))
;;     (setq c (* 2 c)))
;;   (message "c=%d" c))
      
(defun entropy (x)
  "Calculate entropy."
  (+ (- (* x (log x 2))) (- (* (- 1 x) (log (- 1 x) 2))))
  )

(defun me ()
  "View memo about Emacs."
  (interactive)
  (split-window)
  (other-window 1)
  (find-file "~/Memo/emacs")
  (view-mode)
  (local-set-key "\C-g" 'kill-bufwin)
  )

(defun occur-date()
  "Extract date-line(ex. 5/10 ...) using occur."
  (interactive)
  (left-side-window 20)
  (other-window 1)
  (find-file "~/docs/diary")
  (occur "^[1-9][0-9]?/[1-9][0-9]?[^\n]")
  (other-window 1))

(defun fill-buffer ()
  "Fill the current buffer."
  (interactive)
  (let* (current-pos)
    (setq current-pos (point))
    (fill-region (point-min) (point-max))
    (goto-char current-pos)
  ))



(defun search-tag ()
  "Search tags in my diary file."
  (interactive)
  (message "Scr), Res)")
  (let ((c (read-char)))
    (cond
     ((equal c ?s)
      (isearch-resume "^Scr)" t nil t "^" t)
      )
     ((equal c ?r)
      (isearch-resume "^Res)" t nil t "^" t)
      )
     )
    ))


;; (defun scrap-region ()
;;   "Scrap region"
;;   (interactive)
;;   (if mark-active
      
;;       )
  
;;   )
