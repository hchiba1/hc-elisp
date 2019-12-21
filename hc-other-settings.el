;redo
(when (require 'redo nil t)
  (define-key ctl-x-map (if window-system "U" "r") 'redo)
  (define-key global-map [?\C-.] 'redo))

;reduce freqency garbage colection
(setq gc-cons-threshold 5242880)

;to access recently used files
(recentf-mode)
;don't use tab for indentation
;; (setq-default indent-tabs-mode nil)


;;; Mini Buffer ;;;;;;

;i-search for mini-buffer history
(require 'minibuf-isearch nil t)

;mini buffer や kill-ring 等の履歴を次回起動時に持ち越したい
;; (when (require 'session nil t)
;;   (setq session-initialize '(de-saveplace session keys menus)
;;         session-globals-include '((kill-ring 50)
;;                                   (session-file-alist 100 t)
;;                                   (file-name-history 100)))
;;   (add-hook 'after-init-hook 'session-initialize))

;yes/no -> y(SP)/n
(fset 'yes-or-no-p 'y-or-n-p)

;yank-pop-summary
(autoload 'yank-pop-forward "yank-pop-summary" nil t)
(autoload 'yank-pop-backward "yank-pop-summary" nil t)
(global-set-key "\M-y" 'yank-pop-forward)
;; (global-set-key "\C-\M-y" 'yank-pop-backward)


;;Complete the file name in the minibuffer automatically.
;; (when (< emacs-major-version 23)
;;     (setq hc-ctrl-x-c-is-completion t)
;;     (require 'highlight-completion)
;;     (highlight-completion-mode 1)
;;     (global-set-key "\C-\\" 'toggle-input-method)
;; )

(require 'dabbrev-highlight)
;; (require 'dabbrev-ja nil t)

;; (setq visible-bell t)
(setq ring-bell-function 'ignore)

;; PukiWiki
(setq pukiwiki-auto-insert t)
(autoload 'pukiwiki-edit "pukiwiki-mode" "pukwiki-mode." t)
(autoload 'pukiwiki-index "pukiwiki-mode" "pukwiki-mode." t)
(autoload 'pukiwiki-edit-url "pukiwiki-mode" "pukwiki-mode." t)
(setq pukiwiki-site-list
 '(
   ("hiro"
    "http://hiro.hgc.jp/pukiwiki/index.php"
    nil euc-jp-dos)
   ("Meadow"
    "http://www.bookshelf.jp/pukiwiki/pukiwiki.php"
    nil euc-jp-dos)
;;    ("macemacs"
;;     "http://macemacsjp.sourceforge.jp/index.php"
;;     nil euc-jp-dos)
;;    ("Xyzzy"
;;     "http://xyzzy.s53.xrea.com/wiki/wiki.php"
;;     nil euc-jp-dos)
;;    ("Pukiwiki"
;;     "http://pukiwiki.org/index.php" nil utf-8-dos)
   ))
(fset 'wi
   [C-return ?p ?u ?k ?i ?w ?i ?k ?i ?- ?i ?n ?d ?e ?x return return])

;; woman
(setq woman-cache-filename "~/.wmncach.el")
(setq woman-manpath '(
                      "e:/cygwin/usr/man"
                      "e:/cygwin/local/man"
                      "e:/cygwin/usr/autotool/devel/man"
                      "e:/cygwin/usr/local/man"
                      "e:/cygwin/usr/local/man/ja"
                      "e:/cygwin/usr/ssl/man"
                      "e:/cygwin/usr/X11R6/man"
                      "e:/cygwin/usr/man/ja"
                      "e:/namazu/man"
                      "e:/unix/local/kakasi/doc"
                      ))


;Bookmark
(global-set-key [?\C-@] 'bookmark-bmenu-list-side)
(global-set-key [?\M-@] 'bookmark-jump)
(add-hook 'bookmark-bmenu-mode-hook
	  '(lambda()
	     (local-set-key "n" '(lambda()(interactive) (next-line 1)(bookmark-bmenu-switch-other-window)))
	     (local-set-key "p" '(lambda()(interactive) (previous-line 1)(bookmark-bmenu-switch-other-window)))
	     (local-set-key "\C-m" 'bookmark-bmenu-1-window)
	     (local-set-key "\C-@" 'kill-bufwin)
	     (local-set-key "\C-g" 'kill-bufwin)
	     (local-set-key "\C-\M-g" 'kill-bufwin)
	     ))
(defun bookmark-bmenu-list-side()
  (interactive)
  ;; (right-side-window 40)
  (right-side-window 30)
  (command-execute 'bookmark-bmenu-list)
  (isearch-resume "^\\s-+\\s-+" t nil t "^  " t)
;;   (isearch-resume "^\\s-+\\s-+[^\t]*" t nil t "^  [^\t]*" t)
  )
(setq bookmark-save-flag 1)
;; 超整理法
;; (progn
;;   (setq bookmark-sort-flag nil)
;;   (defun bookmark-arrange-latest-top ()
;;     (let ((latest ( bookmark-get-bookmark bookmark)))
;;       (setq bookmark-alist (cons latest (delq latest bookmark-aliset))))
;;     (bookmark-save))
;;   (add-hook 'bookmark-after-jump-hook 'bookmark-arrange-latest-top))

;Dired mode
(add-hook 'dired-mode-hook
	  '(lambda()
	     (local-set-key "\C-\M-n" nil)
	     (local-set-key "\C-\M-p" nil)
	     (local-set-key "\C-o" nil)

	     (local-set-key "n" '(lambda()(interactive) (dired-next-line 1)(dired-display-file)))
	     (local-set-key "p" '(lambda()(interactive) (dired-previous-line 1)(dired-display-file)))

;; 	     (local-set-key "\C-v" 'dired-display-file)
	     (local-set-key "v" 'dired-display-file)
	     (local-set-key "\C-h" 'dired-up-directory)
	     (local-set-key "b" 'dired-up-directory)
	     ))
;; (require 'master)
;; (load "my-dired-master")
;; (define-key dired-mode-map " " 'dired-view-file-scroll) ;view and scroll up
;; (define-key dired-mode-map "b" 'dired-view-file-scroll-down) ;scroll down
;; (define-key dired-mode-map "<" 'dired-view-file-beginning-of-buffer) ;beginning of buffer
;; (define-key dired-mode-map ">" 'dired-view-file-end-of-buffer) ;end of buffer
;; (define-key dired-mode-map "/" 'dired-isearch-file)
;; 					;q -> quit
(defadvice dired-display-file
  (before hoge activate)
  (delete-other-windows)
  (split-window-horizontally)
  (shrink-window-horizontally 35))

;Occur
(define-key occur-mode-map "n" '(lambda()(interactive) (next-line 1)(occur-mode-goto-occurrence)(recenter)(other-window 1)))
(define-key occur-mode-map "p" '(lambda()(interactive) (previous-line 1)(occur-mode-goto-occurrence)(recenter)(other-window 1)))
(define-key occur-mode-map "\C-n" '(lambda()(interactive) (next-line 1)(occur-mode-goto-occurrence)(recenter)(other-window 1)))
(define-key occur-mode-map "\C-p" '(lambda()(interactive) (previous-line 1)(occur-mode-goto-occurrence)(recenter)(other-window 1)))

;Grep mode (compilation-mode)
(add-hook 'compilation-mode-hook
	  '(lambda()
	     (local-set-key "n" '(lambda()(interactive) (next-line 1)(compile-goto-error)(other-window 1)))
	     (local-set-key "p" '(lambda()(interactive) (previous-line 1)(compile-goto-error)(other-window 1)))
	     ))

;; Mew
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(setq mew-icon-directory "/usr/share/emacs/etc/Mew")

(require 'expand)


;Repeat
(global-set-key "\C-\M-u" 'universal-argument)
(global-set-key [?\M-\"] 'repeat)
(global-set-key "\M-p" 'repeat-complex-command)


;;Why isn't it work???
;;when IME is ON, space" " does't seems to be recognized.
;;So, cannot toggle the state. Just one way from OFF to ON.
;; (global-set-key [?\S- ] 'mw32-ime-toggle)
;; (global-set-key [?\S- ] 'toggle-input-method)

;browse-url
(global-set-key [S-mouse-2] 'browse-url-at-mouse)

;auto-save-buffers
(require 'auto-save-buffers)
(run-with-idle-timer 0.5 t 'auto-save-buffers) 

(define-key global-map [165] [92]) ; yen to backskash
