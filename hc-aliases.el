;;; For mode change
(fset 'c 'c-mode)
(fset 'pl 'perl-mode)
(fset 'cpl 'cperl-mode)
(fset 'pro 'prolog-mode)
(defun pd ()
  "perldb"
  (interactive)
  (perldb (concat "perl " (buffer-file-name))))
(fset 'rb 'ruby-mode)
(fset 'el 'emacs-lisp-mode)
(fset 'ol 'outline-mode)
(fset 'sh 'shell-script-mode)
;; (fset 'b 'shell)
(fset 'i 'info)
(fset 'n 'linum-mode)
(fset 'u 'untabify)

;;; For w3m
(fset 'w [C-return ?w ?3 ?m return])
;; (defun l ()
;;   "w3m location in the line which cursor is on."
;;   (interactive)
;;   (if mark-active
;;       (w3m (command-execute 'get-text))
;;     (w3m (get-line)))
;;   )
(fset 's 'w3m-search)
(fset 'f 'w3m-find-file)

;;; For lookup
(fset 'l 'lookup-entry-select-dictionary)
(fset 'd 'lookup)
(fset 'res 'lookup-restart)


;;; Other aliases
(defun new() (interactive)(switch-to-buffer "new"))
(fset 'p 'print-buffer)
(fset 'g 'grep)
(defun cx ()
  "Execute \"chmod -x buffer-file-name\""
  (interactive)
  (shell-command (concat "cx " (buffer-file-name)))
  )
(fset 'bin 'hexl-find-file)
(fset 'kill 'kill-some-buffers)
(defun bak ()
  "Backup the last version of the file edited in the current buffer."
  (interactive)
  (let ((filename (buffer-file-name)))
    (rename-file filename (concat filename "~" ) 1)
    (copy-file (concat filename "~" ) filename 1)
    (find-alternate-file filename)
    ))
(setq make-backup-files nil)

(defun b() "Save as bookmark" (interactive) (bookmark-set))

(defun t() "Toggle truncate lines" (interactive) (toggle-truncate-lines))
