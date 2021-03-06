(global-set-key "\C-p" 'previous-window-line)
(global-set-key "\C-n" 'next-window-line)
(global-set-key "\C-\M-n" 'scroll-up-line)
(global-set-key "\C-\M-p" 'scroll-down-line)
;; (global-set-key "\C-xl" 'goto-line)
(global-set-key "\M-[" 'backward-paragraph)
(global-set-key "\M-]" 'forward-paragraph)
(global-set-key "\M-{" 'beginning-of-defun)
(global-set-key "\M-}" 'end-of-defun)
(global-set-key [?\C-{] 'beginning-of-defun)
(global-set-key [?\C-}] 'end-of-defun)
(global-set-key [?\C-\(] 'down-list)
(global-set-key [?\C-\)] 'up-list)

(defun previous-window-line (n)
  "Move cursor vertically up N lines, even if the sentence is long and folded in the window."
  (interactive "p")
  (let ((cur-col
	 (- (current-column)
	    (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion (- n))
    (move-to-column (+ (current-column) cur-col)))
  (run-hooks 'auto-line-hook)
  )
(defun next-window-line (n)
  "Move cursor vertically down N lines, even if the sentence is long and folded in the window."
  (interactive "p")
  (let ((cur-col
	 (- (current-column)
	    (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion n)
    (move-to-column (+ (current-column) cur-col)))
  (run-hooks 'auto-line-hook)
  )
(defun scroll-up-line (arg)
  "Scroll text of current window upward ARG lines."
  (interactive "p")
  (scroll-up arg)
  (next-line arg)
  )
(defun scroll-down-line (arg)
  "Scroll text of current window down ARG lines."
  (interactive "p")
  (scroll-down arg)
  (previous-line  arg)
  )

;Scroll only one line when the cursor go out of the window.
(setq scroll-conservatively 1)
(setq scroll-margin 5)
;; (setq next-screen-context-lines 1)
;; (setq next-screen-context-lines 10)
