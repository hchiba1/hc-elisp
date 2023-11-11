;text-mode for default
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook
          '(lambda ()
	     (auto-fill-mode 0)
	     (local-set-key [?\C->] 'indent-region-by-one-char)
	     (local-set-key [?\M-\;] 'search-tag)
	     ))

;          '(lambda () (refill-mode 1))) ;refill(auto-fill in one input)
(setq-default fill-column 70)
(setq paragraph-start '"^\\([ 　・○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")

;abbrev mode for default
;; (setq-default abbrev-mode t)
;; (read-abbrev-file "~/.abbrev_defs")
;; (setq save-abbrevs t)

;; (quietly-read-abbrev-file)
;; (setq save-abbrevs t)
;; (setq abbrev-file-name "~/.abbrev_defs")
;; (define-key esc-map  " " 'expand-abbrev) ;; M-SPC



;Outline mode settings
;use "＜" for 1st class, and "・" for 2nd class
(setq outline-regexp "\\(<\\)\\|\\(^\\..\\)\\|\\(^\\*...\\)\\|\\(^＜\\)\\|\\(^・.\\)")

;Settings for Cangelog
;; (setq user-full-name "Hirokazu CHIBA")
;; (setq user-mail-address "hchiba@hgc.jp")


(global-set-key "\M-q" '(lambda() (interactive) (if mark-active (command-execute 'fill-region) (command-execute 'fill-paragraph))))


;;; Kill
;; (keyboard-translate ?\C-h ?\C-?)
;; (global-set-key "\C-h" nil)
(global-set-key "\C-h" 'backward-delete-char-untabify)

;C-k -> kill line including newline
(setq kill-whole-line t)
;delete spaces by backward-delete-char
(setq backward-delete-char-untabify-method 'hungry)
;delete region by Backspace
(defadvice backward-delete-char-untabify
  (around ys:backward-delete-region activate)
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))


(defun indent-region-by-one-char (start end)
  "indent region by one char"
  (interactive "r")
  (save-excursion
    (let (c)
      (setq c ?\C->)
      (while (or (equal c ?\C->)(equal c ?\C-<))
	(if (equal c ?\C->)
	    (indent-rigidly start end 1)
	  (indent-rigidly start end -1))
	(setq c (read-char)))
      )))

(global-set-key [?\C-=] 'count-chars-region)
(defun count-chars-region (start end)
  "Count number of characters in the region except newline."
  (interactive "r")
  (save-excursion
    (let ((count 0) startline endline)
      (goto-char start)
      (setq startline (what-line))
      (while (< (point) end)
	(forward-char 1)
	(setq count (+ 1 count)))
      (setq endline (what-line))
      (message "region contains %d chars." (- count (- endline startline)))
      )))

(global-set-key [?\C-+] 'toggle-input-method)
;; (global-set-key [?\C-<] 'backward-sexp)
;; (global-set-key [?\C->] 'forward-sexp)
;; (global-set-key [?\C-+] 'forward-mark-word)
;; (global-set-key [?\M-+] 'backward-mark-word)
;; (global-set-key "\C-xw" 'mark-whole-word)
;; (global-set-key "\C-xp" 'mark-paragraph)
;;; Mark ;;;
(global-set-key "\C-x\C-p" 'mark-paragraph)
(global-set-key "\C-x\C-h" 'mark-whole-buffer)
(global-set-key "\C-xc" 'mark-sexp)
(defun forward-mark-word ()
  "Mark the word which cursor is on, or the next word."
  (interactive)
  (if mark-active
      (forward-word 1)
    (forward-word 1)
    (backward-word 1)
    (set-mark (point))
    (forward-word 1))
  )
(defun backward-mark-word ()
  "Mark the word which cursor is on, or the next word."
  (interactive)
  (if mark-active
      (backward-word 1)
    (forward-char)
    (backward-word 1)
    (forward-word 1)
    (set-mark (point))
    (backward-word 1))
  )
(defun copy-word (arg)
  "Copy the word which cursor is on, or the next word."
  (interactive "p")
  (save-excursion
    (let (beg)
      (forward-word 1)
      (backward-word 1)
      (setq beg (point))
      (forward-word arg)
      (kill-ring-save beg (point))
      )))
