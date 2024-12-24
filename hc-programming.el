;;; Global key map
(global-set-key "\C-j" 'reindent-then-newline-and-indent)
(global-set-key [?\C-\M-j] 'open-line-for-input)
(global-set-key [\C-\return] 'open-parenthesis)
(global-set-key [\M-\return] 'shell-command)
(global-set-key [\C-\M-\return] 'open-block)
(global-set-key [?\C-\M-y] 'duplicate-current-line)
(global-set-key [?\C-\M-m] 'indent-and-next)
(global-set-key [?\C-\M-\;] 'lisp-complete-symbol)
(global-set-key [?\C-\;] 'comment-dwim)
(global-set-key [?\C-\M-+] 'search-word)
(global-set-key [?\C-\\] 'search-sexp)
(global-set-key [?\C-\M-\\] 'indent-buffer-or-region)
(global-set-key "\C-x\C-h" 'mark-defun)
;;; kill
(global-set-key "\C-\M-d" 'kill-sexp)
;; (global-set-key [?\C-\M-k] '(lambda() (interactive) (beginning-of-line) (kill-line) ) )
;; (global-set-key [?\C-\M-k] '(lambda() (interactive) (beginning-of-line) (kill-line) (backward-char)) )
;; (global-set-key [?\C-\M-k] '(lambda() (interactive) (beginning-of-line) (kill-line) (back-to-indentation)) )
(global-set-key "\C-\M-k" 'kill-this-paragraph)
(global-set-key "\C-\M-h" 'backward-kill-sexp)
(global-set-key "\M-d" 'delete-word)
(global-set-key "\M-h" 'backward-delete-word)
;; (global-set-key "\M-h" 'backward-kill-word)

(show-paren-mode t)

;; (electric-pair-mode t) ; automatically close parenthesis, after Emacs 24. compete with smartparens.
;; (defadvice electric-pair-post-self-insert-function
;;     (around electric-pair-post-self-insert-function-around activate)
;;   "Don't insert the closing pair in comments or strings"
;;   (unless (nth 8 (save-excursion (syntax-ppss (1- (point)))))
;;     ad-do-it))

;; (require 'backalittle)

;; (require 'smartparens-config)
;; (smartparens-global-mode t)

(defun open-line-for-input ()
  "Open line for input."
  (interactive)
  (beginning-of-line)(open-line 1)
  (indent-according-to-mode)
  )

(defun open-line-and-insert (arg)
  "Open line and insert string ARG."
  (interactive "sStatement: ")
  (beginning-of-line)(open-line 1)
  (insert arg)(indent-according-to-mode)
  )

(defun open-block ()
  "Open block."
  (interactive)
  (unless (equal (buffer-substring (- (point) 1) (point)) " ")
    (insert " "))
  (end-of-line)
  (unless (equal (buffer-substring (- (point) 1) (point)) " ")
    (insert " "))
  (insert "{") (forward-line)
  (open-line-and-insert "") (forward-line)
  (open-line-and-insert "}") (forward-line -1)
  (back-to-indentation)
  )

(defun open-parenthesis ()
  "Open parenthesis."
  (interactive)
  (insert "()") (backward-char)
  )

(defun indent-and-next ()
  "Indent and next line."
  (interactive)
  (indent-according-to-mode)
  (forward-line)(back-to-indentation)
  )

(defun copy-current-line ()
  "Copy current line and comment out."
  (interactive)
  ;; (copy-region-as-kill (point-at-bol) (point-at-bol 2))
  (kill-ring-save (point-at-bol) (point-at-bol 2))
  (comment-line 1)
  (beginning-of-line)(yank)(forward-line -1)(back-to-indentation)
  )

(defun duplicate-current-line ()
  "Duplicate current line."
  (interactive)
  (kill-ring-save (point-at-bol) (point-at-bol 2))
  (beginning-of-line)(yank)
  ;; (forward-line -1)
  ;; (back-to-indentation)
  )

;; web-mode
(autoload 'web-mode "web-mode" "Major mode for editing web templates")
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(defun web-mode-hook ()
  ;; (setq web-mode-markup-indent-offset 2)
  ;; (setq web-mode-css-indent-offset 2)
  ;; (setq web-mode-code-indent-offset 2)
  (setq web-mode-engines-alist
        '(("php"    . "\\.ctp\\'"))
        )
  )
(add-hook 'web-mode-hook  'web-mode-hook)
(custom-set-faces
 '(web-mode-doctype-face
   ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face
   ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-html-attr-name-face
   ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face
   ((t (:foreground "#82AE46"))))
 '(web-mode-comment-face
   ((t (:foreground "#D9333F"))))
 '(web-mode-server-comment-face
   ((t (:foreground "#D9333F"))))
 '(web-mode-css-rule-face
   ((t (:foreground "#A0D8EF"))))
 '(web-mode-css-pseudo-class-face
   ((t (:foreground "#FF7F00"))))
 '(web-mode-css-at-rule-face
   ((t (:foreground "#FF7F00"))))
)

;; Julia
(autoload 'julia-mode "julia-mode" "Major mode for editing Julia source code")

;; R-mode (ESS)
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)
(autoload 'R "ess-site" "start R" t)
(add-to-list 'auto-mode-alist '("\\.[rR]$" . R-mode))

;; shell-mode
(add-hook 'shell-mode-hook
	  (lambda ()
	    (set-buffer-process-coding-system 'undecided-dos 'sjis-unix)
	    (local-set-key "\C-j" 'comint-send-input)
	    (local-set-key [?\C-$] 'shell-mode-map-history)
	    (local-set-key [?\C-#] 'shell-mode-map-edit)
	    ))
(defun shell-mode-map-history ()
  (interactive)
  (local-set-key "\C-p" 'comint-previous-input)
  (local-set-key "\C-n" 'comint-next-input)
  )
(defun shell-mode-map-edit ()
  (interactive)
  (local-set-key "\C-p" 'previous-window-line)
  (local-set-key "\C-n" 'next-window-line)
  )

;; Shell script
(add-hook 'sh-mode-hook
	  (lambda ()
	    (local-set-key "\C-m" 'reindent-then-newline-and-indent)
	    (local-set-key [?\C-\M-\;] '(lambda() (interactive) (horizontal-bar "#" 62)))
	    ))

;; Ruby
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files")
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "set local key defs for inf-ruby in ruby-mode")
(setq auto-mode-alist
      (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (append
       '(("ruby" . ruby-mode))
       interpreter-mode-alist))
(setq ruby-indent-level 4)

(autoload 'ruby "rubydb2x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(let ((rel (assq 'ruby-electric-mode minor-mode-map-alist)))
  (setq minor-mode-map-alist (append (delete rel minor-mode-map-alist) (list rel))))
(setq ruby-electric-expand-delimiters-list nil)

(require 'ruby-block)
(defun ruby-mode-hook-ruby-block()
  (ruby-block-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-block)
(setq ruby-block-highlight-toggle t)

;; Scheme
(setq scheme-program-name "/usr/local/bin/gosh -i")
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process. " t)

;; gsql-mode
(autoload 'gsql-mode "gsql-mode" "Major mode for GSQL" t)
(add-to-list 'auto-mode-alist '("\\.gsql$" . gsql-mode))
(add-hook 'gsql-mode-hook
          '(lambda ()
             (make-local-variable 'sh-basic-offset)
             (make-local-variable 'sh-indentation)
             (setq sh-basic-offset 2)
             (setq sh-indentation 2)
             (local-set-key [?\C->] 'indent-region-by-one-char)
           ))

;; for SPARQL source code
(autoload 'sparql-mode "sparql-mode" "Mode for editing SPARQL files" t)
(autoload 'sparqling-mode "sparqling-mode" "Major mode for SPARQL" t)
(add-to-list 'auto-mode-alist '("\\.rq$" . sparqling-mode))
(add-to-list 'auto-mode-alist '("\\.spl$" . prolog-mode))
(setq auto-mode-alist
      (cons (cons "\\.isql$" 'shell-script-mode) auto-mode-alist))
(add-hook 'sparqling-mode-hook
          '(lambda ()
             (make-local-variable 'sh-basic-offset)
             (make-local-variable 'sh-indentation)
             (setq sh-basic-offset 2)
             (setq sh-indentation 2)
             (local-set-key [?\C->] 'indent-region-by-one-char)
             (if (= 0 (buffer-size)) (insert-sparqling-template))
           ))
;; js2-mode
(add-to-list 'auto-mode-alist '("\\.pegjs$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsonld$" . js-mode))
(autoload 'js2-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.pegjs$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
            (setq js2-basic-offset 2)
            (setq js-switch-indent-offset 2)
           ))
;; (require 'typescript-mode)
;; (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
;; n3-mode
(autoload 'n3-mode "n3-mode" "Major mode for OWL or N3 files" t)
(setq auto-mode-alist
      (append
       (list
        '("\\.ttl$" . n3-mode)
        '("\\.n3$" . n3-mode)
        '("\\.owl$" . n3-mode)
        '("\\.sparqling$" . n3-mode)
	)
       auto-mode-alist))

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;yatex-mode
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(setq dvi2-command' "dvi")

(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
;; (setq auto-mode-alist
;;       (cons (cons "\\.html$" 'yahtml-mode) auto-mode-alist))
(setq yahtml-www-browser "netscape") ;お気に入りのブラウザを書いて下さい。netscapeが便利です。
(setq yahtml-path-url-alist
      '(("/home/yuuji/public_html" . "http://www.mynet/~yuuji")
	("/home/staff/yuuji/html" . "http://www.othernet/~yuuji")))
         ;UNIXの絶対パスと対応するURLのリストを書いて下さい。
(add-hook 'yatex-mode-hook
	  '(lambda()
	     (local-set-key "\C-\M-x"  'execute-platex)
	     (local-set-key "\M-q" '(lambda() (interactive) (if mark-active (command-execute 'fill-region) (command-execute 'fill-paragraph))))
	     ))
(fset 'execute-platex "\C-ctj")


; Make executable the file associated with the current buffer, when it is a script file.
(add-hook 'after-save-hook 'make-file-executable)
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
        (let ((name (buffer-file-name)))
          (or (equal ?. (string-to-char (file-name-nondirectory name)))
              (let ((mode (file-modes name)))
                (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                (message (concat "Wrote " name " (+x)"))))))))


;Jump to the corresponding parenthesis
(global-set-key [?\C-'] 'paren-match)
(progn
  (defvar com-point nil
    "Remember com point as a marker. \(buffer specific\)")
  (set-default 'com-point (make-marker))
  (defun getcom (arg)
    "Get com part of prefix-argument ARG."
    (cond ((null arg) nil)
	  ((consp arg) (cdr arg))
	  (t nil)))
  (defun paren-match (arg)
    "Go to the matching parenthesis."
    (interactive "P")
    (let ((com (getcom arg)))
      (if (numberp arg)
	  (if (or (> arg 99) (< arg 1))
	      (error "Prefix must be between 1 and 99.")
	    (goto-char
	     (if (> (point-max) 80000)
		 (* (/ (point-max) 100) arg)
	       (/ (* (point-max) arg) 100)))
	    (back-to-indentation))
	(cond ((looking-at "[\(\[{]")
	       (if com (move-marker com-point (point)))
	       (forward-sexp 1)
	       (if com
		   (paren-match nil com)
		 (backward-char)))
	      ((looking-at "[])}]")
	       (forward-char)
	       (if com (move-marker com-point (point)))
	       (backward-sexp 1)
	       (if com (paren-match nil com)))
	      (t (error "")))))))


;; (defun relief (ch n)
;;   "Relief the words in the line by ch."
;;   (interactive)
;;   (let (beg end len i str)
;;     ;; Get the length of the line.
;;     (beginning-of-line)
;;     (setq beg (point))
;;     (end-of-line)
;;     (setq len (- (point) beg))
;;     ;; Write a line of ch.
;;     (beginning-of-line)
;;     (open-line 1)
;;     (setq i 0)
;;     (while (< i (+ len (* n 2) 2))
;;       (insert ch)
;;       (setq i (+ i 1))
;;       )
;;     ;; Enclose the line by ch.
;;     (next-line 1)
;;     (beginning-of-line)
;;     (setq i 0)
;;     (while (< i (+ n))
;;       (insert ch)
;;       (setq i (+ i 1))
;;       )
;;     (insert " ")
;;     (end-of-line)
;;     (insert " ")
;;     (setq i 0)
;;     (while (< i (+ n))
;;       (insert ch)
;;       (setq i (+ i 1))
;;       )
;;     ;; Write a line of ch.
;;     (next-line 1)
;;     (beginning-of-line)
;;     (open-line 1)
;;     (setq i 0)
;;     (while (< i (+ len (* n 2) 2))
;;       (insert ch)
;;       (setq i (+ i 1))
;;       )
;;     (beginning-of-line)
;;     ))

(defun horizontal-bar (ch n)
  "Relief the words in the line by ch."
  (interactive)
  (let (beg indent pos len i)
    ;; Get the length of the line.
    (beginning-of-line)
    (setq beg (point))
    (back-to-indentation)
    (setq indent (point))
    (end-of-line)
    (setq pos (- (point) beg))
    (setq len (- (point) indent))
    ;; Enclose the line by ch.
    (if (> len 0)
	(progn
	  (insert " ")
	  (setq pos (+ pos 1)))
      )
    (while (< pos n)
      (insert ch)
      (setq pos (+ pos 1))
      )
    ))

(defun kill-this-paragraph (arg)
  (interactive "p")
  (kill-region
   (progn (forward-paragraph arg) (point))
   (progn (backward-paragraph arg) (point))
   ))

(defun indent-buffer-or-region ()
  "Indent buffer or region."
  (interactive)
  (if (region-active-p)
      (indent-region (region-beginning) (region-end))
    (indent-region (point-min) (point-max))
    ))

;; M-w -> copy the current line, if region is not active.
(defadvice kill-ring-save
    (around kill-ring-save-or-copy-line-as-kill (beg end) activate)
  (interactive (list (point) (mark)))
  (if (and (called-interactively-p 'any) (not mark-active))
      (copy-region-as-kill (point-at-bol 1) (point-at-bol 2))
    ad-do-it))

(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

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

;; (setq markdown-fontify-code-blocks-natively t)

;; GitHub Copilot
(when (>= emacs-major-version 27)
  (require 'copilot)
  (add-hook 'prog-mode-hook 'copilot-mode)
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion))

(require 'nginx-mode)
