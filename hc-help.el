;;; Global key map
(global-set-key [?\C-^] 'describe-key-briefly)
(global-set-key [?\C-~] 'describe-key)
(global-set-key "\C-xf" 'describe-function)
(global-set-key "\C-xv" 'describe-variable)
(global-set-key [?\M-?] 'apropos-command)
(global-set-key [?\M-_] 'apropos)
(global-set-key [?\C-\M-^] 'apropos-command-sexp)
(global-set-key [?\C-\M-~] 'apropos-sexp)
(defadvice info
  (after hoge activate)
  (define-key Info-mode-map "\C-h" 'Info-last)
  (define-key Info-mode-map "B" 'Info-last)
  (define-key Info-mode-map "b" 'Info-last)
  (define-key Info-mode-map [S-iso-lefttab] 'Info-prev-reference)
  )
;;; Local key map
(add-hook 'help-mode-hook
	  '(lambda()
	     (local-set-key "\C-g" 'kill-bufwin)
	     ))
(add-hook 'apropos-mode-hook
	  '(lambda()
	     (local-set-key "\C-g" 'kill-bufwin)
	     ))
(define-key completion-list-mode-map "\C-g" 'kill-bufwin)

;Hints for the arguments of the function around which the cursor is.
(autoload 'turn-on-eldoc-mode "eldoc" nil t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;;; Functions
(defun apropos-region (start end)
  "apropos rigion."
  (interactive "r")
  (apropos (buffer-substring start end)))
(defun apropos-sexp ()
  "Call 'apropos' for the sexp which cursor is on,
unless the region is active, in which case it calls 'apropos-region'."
  (interactive)
  (if mark-active
      (command-execute 'apropos-region)
    (apropos (get-sexp))))
(defun apropos-command-sexp ()
  "Call 'apropos-command' for the sexp which cursor is on,
unless the region is active, in which case it calls 'apropos-region'."
  (interactive)
  (if mark-active
      (command-execute 'apropos-region)
    (apropos-command (get-sexp))))

(defadvice apropos
  (after hoge activate)
  (other-window 1))
(defadvice apropos-command
  (after hoge activate)
  (other-window 1))
(defadvice apropos-follow
  (after hoge activate)
  (other-window 1))
(defadvice describe-key
  (after hoge activate)
  (other-window 1))
(defadvice describe-mode
  (after hoge activate)
  (other-window 1))
(defadvice describe-function
  (after hoge activate)
  (other-window 1))
(defadvice describe-variable
  (after hoge activate)
  (other-window 1))

;;;;;;;;;;;;;;;;
;; Subroutine ;;
;;;;;;;;;;;;;;;;
(defun search-word (arg)
  "Search buffer for the word which cursor is on."
  (interactive "p")
  (let (str)
    (setq str (get-word arg))
    (isearch-resume str nil nil t str t)
;;     (search-forward str)
    ))
(defun search-sexp ()
  "Search buffer for the sexp which cursor is on."
  (interactive)
  (let (str)
    (setq str (get-sexp))
    (isearch-resume str nil nil t str t)
;;     (search-forward str)
    ))
(defun get-word (arg)
  "Return the word which cursor is on."
  (interactive "p")
  (save-excursion
    (let (start end str)
      (forward-char)
      (backward-word 1)
      (setq start (point))
      (forward-word arg)
      (setq end (point))
      (setq str (buffer-substring start end))
      (if (equal (substring str 0 1) "'")
	  (setq str (substring str 1)))
      (eval str)
      )))
(defun get-sexp ()
  "Return the sexp which cursor is on."
  (interactive)
  (save-excursion
    (let (start end str)
      (forward-char)
      (backward-sexp)
      (setq start (point))
      (forward-sexp)
      (setq end (point))
      (setq str (buffer-substring start end))
      (if (equal (substring str 0 1) "'")
	  (setq str (substring str 1)))
      (eval str)
      )))
(defun get-line ()
  "Return the line which cursor is on."
  (interactive)
  (save-excursion
    (let (start end str)
      (beginning-of-line)
      (setq start (point))
      (end-of-line)
      (setq end (point))
      (setq str (buffer-substring start end))
      (eval str)
      )))
(defun get-text (start end)
  "Return the text in the region."
  (interactive "r")
  (eval (buffer-substring start end)))
