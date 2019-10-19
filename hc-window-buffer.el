;;; Window
(global-set-key "\C-o" '(lambda() (interactive) (other-window 1)))
(global-set-key "\C-x\C-o" '(lambda() (interactive) (other-window 1)))
(global-set-key "\C-\M-o" '(lambda() (interactive) (other-window -1)))
(global-set-key [?\C-`] 'kill-this-buffer)
(global-set-key [?\C-*] 'delete-window)
(global-set-key [?\C-.] 'delete-other-windows)
(global-set-key "\C-\M-g" 'kill-bufwin)
(global-set-key [?\C-\M-.] 'kill-other-bufwin)
;; (global-set-key [?\C-:] '(lambda() (interactive) (split-window-horizontally) (other-window 1) (bs-cycle-next)))
;; (global-set-key [?\C-\M-:] '(lambda() (interactive) (split-window-vertically) (other-window 1) (bs-cycle-next)))
(global-set-key [?\C-:] '(lambda() (interactive) (split-window-horizontally) (other-window 1) (pc-bufsw::walk 2)))
(global-set-key [?\C-\M-:] '(lambda() (interactive) (split-window-vertically) (other-window 1) (pc-bufsw::walk 2)))
(global-set-key [?\C-\|] '(lambda() (interactive) (split-window-horizontally) (other-window 1) (pc-bufsw::walk 2)))
(global-set-key [?\C-_] '(lambda() (interactive) (split-window-vertically) (other-window 1) (pc-bufsw::walk 2)))
(global-set-key [\C-up] '(lambda() (interactive) (shrink-window 2)))
(global-set-key [\C-down] '(lambda() (interactive) (enlarge-window 2)))
(global-set-key [\C-left] '(lambda() (interactive) (shrink-window-horizontally 5)))
(global-set-key [\C-right] '(lambda() (interactive) (enlarge-window-horizontally 5)))

(defun left-side-window (arg)
  "Make a window on the left side and shrink ARG width."
  (interactive "p")
  (delete-other-windows)
  (split-window-horizontally)
  (shrink-window-horizontally arg))
(defun right-side-window (arg)
  "Make a window on the right side and shrink ARG width."
  (interactive "p")
  (delete-other-windows)
  (split-window-horizontally)
  (other-window 1)
  (shrink-window-horizontally arg))
(defun kill-bufwin ()
  "Kill the current buffer and window."
  (interactive)
  (kill-this-buffer)
  (delete-window))
(defun kill-other-bufwin ()
  "Kill the other buffer and window."
  (interactive)
  (let (buf)
    (setq buf (buffer-file-name))
    (other-window 1)
    (if (equal buf (buffer-file-name))
	(message "Only one window. Can't kill the other buffer and window.")
      (kill-bufwin)
      (other-window -1))
    ))

;;; Switch buffer
;(iswitchb-default-keybindings) ;Use iswitchb-buffer instead of switch-to-buffer
(add-hook 'iswitchb-define-mode-map-hook
	  '(lambda()
	     (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
	     (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
	     ))
;; (defadvice iswitchb-exhibit
;;   (after iswitchb-exhibit-with-display-buffer activate)
;;   "Display the contents of the buffer selected in the mini buffer."
;;   (when (and
;;          (eq iswitchb-method iswitchb-default-method)
;;          iswitchb-matches)
;;     (select-window (get-buffer-window (cadr (buffer-list))))
;;     (iswitchb-visit-buffer (get-buffer (car iswitchb-matches)))
;;     (select-window (minibuffer-window))))

;Switch buffer like Windows
(require 'pc-bufsw)
(global-set-key [?\C-,]	'pc-bufsw::previous)
(global-set-key [?\C-\M-,]	'pc-bufsw::lru)
