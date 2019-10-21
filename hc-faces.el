(setq inhibit-startup-message t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (message (emacs-init-time))
            ;;; Hide bars ;;;
            (menu-bar-mode 0) ;; 1 or 0 (same as -1)
            (tool-bar-mode 0) ;; 1 or 0 (same as -1)
            (scroll-bar-mode -1)
            ;; (set-scroll-bar-mode nil) ;; 'right or 'left or 'nil ; it takes almost 0.5 sec! (why?)
            ))

;;; Dinamic coloring ;;;
(global-font-lock-mode t)

;;; hilighten region ;;;
(setq-default transient-mark-mode t)

;;; Cursor ;;;
(blink-cursor-mode 0) ; Don't blink cursor

;;; Show line numbers ;;;
(global-linum-mode t)
(setq linum-format "%3d")
(set-face-attribute 'linum nil
                    :foreground "#777")
;; (custom-set-faces
;;  '(fringe ((t (:background "#333")))))

(setq-default truncate-lines t)
;; (setq-default truncate-partial-width-windows t)

;;; Mode line ;;;
(set-face-foreground 'mode-line "#bbbed7") ; mode-line for emacs24
(set-face-background 'mode-line "#294163") ; mode-line for emacs24
;;; filename<dirname> in case of overlapped name
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")
(setq uniquify-min-dir-content 1)
;; (display-time) ;show
;; (which-function-mode t)
;; (column-number-mode t) ;show
(setq-default mode-line-format
              (list "%e"
                    'mode-line-front-space
                    'mode-line-mule-info
                    'mode-line-client
                    'mode-line-modified ; */% indicators if the file has been modified
                    'mode-line-remote
                    'mode-line-frame-identification
                    'mode-line-buffer-identification ;; filename
                    ;; 'mode-line-position ;; pos% (line,column)
                    "  "
                    'mode-line-modes ; major and minor modes in effect
                    `(vc-mode vc-mode) ; if vc-mode is in effect, display version control info here
                    "  %l:%c"
                    "  "
                    '(:eval (format "%d" (count-lines (point-max) (point-min)))) ;; TOTAL LINES
                    " lines"
                    "  %P"
                    ;; '(which-func-mode ("" which-func-format "--")) ; if which-func-mode is in effect, display which function we are currently in.
                    ;; 'mode-line-misc-info
                    ;; 'system-name ;; hostname
                    ;; "-%-" ; dashes sufficient to fill rest of modeline.
                    mode-line-end-spaces
                    ))
;; (setq-default mode-line-buffer-identification
;; 	      '(buffer-file-name ("%f") ("%b")) ;; file path or buffer name
;; 	      )
(setq-default header-line-format
              '(
                "%f"                                    ;; FILE PATH
                " %* "                                 ;; file status (e.g. read-only)
                ""(:eval system-name)""                   ;; HOST NAME
                ;; " %* "                                 ;; file status (e.g. read-only)
                ;; ": %f"                                    ;; FILE PATH
                ;; "%b %f"
                ;; (:eval (if (buffer-file-name) " (%f)")) ; file path
                ;; (:eval (if (buffer-file-name) "%f" "%b")) ; file path or buffer name
                ))

;; hide "Encoded-kbd" in the mode line
(let ((elem (assq 'encoded-kbd-mode minor-mode-alist)))
  (when elem
    (setcar (cdr elem) "")))

;; hide "Isearch" in the mode line
(add-hook 'isearch-mode-hook
          '(lambda ()
             (setcar (cdr (assq 'isearch-mode minor-mode-alist)) "")
             ))



;;; minibuffer ;;;
                                        ;resize minibuffer to appropreate size
                                        ;(resize-minibuffer-mode 1)
                                        ;turn off keybind hints
(setq suggest-key-bindings nil)
                                        ;open window such as *HELP* in appropreate size
(temp-buffer-resize-mode 1)


(setq-default tab-width 4)
(setq-default indent-tabs-mode nil) ; use spaces insted of tab



;; ;; trim Texinfo
;; (add-hook 'texinfo-mode-hook
;;           '(lambda ()
;;              (setq mode-name "Texi")))
;; ;; trmi Lisp Interaction
;; (add-hook 'lisp-interaction-mode-hook
;;           '(lambda ()
;;              (setq mode-name "Lisp-Int")))
;; trim Emacs-Lisp
;; (add-hook 'emacs-lisp-mode-hook
;;           '(lambda ()
;;              (setq mode-name "Elisp")))

;;; tab and end-of-line space is colord
;;; Ref.:http://www.bookshelf.jp/soft/meadow.html
;; (defface my-face-b-1 '((t (:background "gray80"))) nil)
;; (defface my-face-u-1 '((t (:foreground "SpringGreen" :underline t))) nil)
;; (defvar my-face-b-1 'my-face-b-1)
;; (defvar my-face-u-1 'my-face-u-1)
;; (defadvice font-lock-mode (before my-font-lock-mode ())
;;   (font-lock-add-keywords
;;    major-mode
;;    '(("\t" 0 my-face-b-1 append)
;;      ("[ \t]+$" 0 my-face-u-1 append)
;;      )))
;; (ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;; (ad-activate 'font-lock-mode)

                                        ;high-lighten yanked strings
;; (when (or window-system (eq emacs-major-version '21))
;;   (defadvice yank (after ys:highlight-string activate)
;;     (let ((ol (make-overlay (mark t) (point))))
;;       (overlay-put ol 'face 'highlight)
;;       (sit-for 0.5)
;;       (delete-overlay ol)))
;;   (defadvice yank-pop (after ys:highlight-string activate)
;;     (when (eq last-command 'yank)
;;       (let ((ol (make-overlay (mark t) (point))))
;;         (overlay-put ol 'face 'highlight)
;;         (sit-for 0.5)
;;         (delete-overlay ol)))))
