(global-set-key [?\M-,] '(lambda(arg) (interactive "p") (if mark-active (command-execute 'lookup-region) (lookup-word (get-word arg)))))
(global-set-key [?\M-.] 'lookup-pattern)

;; (require 'lookup)
(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)
(autoload 'lookup-word "lookup" nil t)
(setq lookup-search-agents
      '(
	(ndeb "~/dict/kenkyusha")
	(ndeb "~/dict/srd-fpw")
	(ndeb "~/dict/reader")
	(ndeb "~/dict/biology")
	(ndeb "~/dict/rikagaku")
	(ndeb "~/dict/kojien~")
;; 	(ndeb "/mnt/cdrom")
;; 	(ndtp "dserver")
	(ndspell)
	))
(add-hook 'lookup-load-hook
	  '(lambda()
	     (lookup-set-dictionary-option "ndeb+~/dict/srd-fpw:srd-fpw" ':stemmer 'stem-english)
	     (lookup-set-dictionary-option "ndeb+~/dict/reader:plus" ':stemmer 'stem-english)
	     (lookup-set-dictionary-option "ndeb+~/dict/biology:honmon" ':stemmer 'stem-english)
	     (lookup-set-dictionary-option "ndeb+~/dict/rikagaku:rikagaku" ':stemmer 'stem-english)
	     (lookup-set-dictionary-option "ndeb+~/dict/kojien~:kojien" ':stemmer 'stem-english)
	     (lookup-set-dictionary-option "ndeb+~/dict/kenkyusha:chujiten" ':stemmer 'stem-english)
	     (lookup-set-dictionary-option "ndeb+~/dict/kenkyusha:kanjigen" ':stemmer 'stem-english)
;; 	     (setq lookup-use-bitmap t)
	     (setq lookup-window-height 15)
	     ))
(add-hook 'lookup-select-mode-hook
	  '(lambda()
	     (local-set-key "\C-g" 'lookup-suspend)
	     ))
(add-hook 'lookup-entry-mode-hook
	  '(lambda()
	     (local-set-key "\C-g" 'lookup-suspend)
	     (local-set-key "\C-i" '(lambda() (interactive) (other-window 1)))
	     (local-set-key "N" 'lookup-history-next)
	     (local-set-key "B" 'lookup-history-previous)
	     (local-set-key "\C-h" 'lookup-history-previous)
	     (local-set-key "b" 'lookup-entry-previous-page)
	     (local-set-key "\C-\M-n" 'lookup-entry-scroll-up-content)
	     (local-set-key "\C-\M-p" 'lookup-entry-scroll-down-content)
	     (local-set-key "n" '(lambda() (interactive) (next-window-line 1)(lookup-entry-display-content)(recenter)))
	     (local-set-key "p" '(lambda() (interactive) (previous-window-line 1)(lookup-entry-display-content)(recenter)))
	     ))
(add-hook 'lookup-content-mode-hook
	  '(lambda()
	     (local-set-key "\C-g" 'lookup-suspend)
	     (local-set-key [S-iso-lefttab] 'lookup-content-previous-tab-stop)
	     (local-set-key "n" '(lambda() (interactive) (other-window -1)(lookup-entry-next-entry)(other-window 1)))
	     (local-set-key "p" '(lambda() (interactive) (other-window -1)(lookup-entry-previous-entry)(other-window 1)))
	     (local-set-key "N" '(lambda() (interactive) (other-window -1)(lookup-history-next)(other-window 1)))
	     (local-set-key "B" '(lambda() (interactive) (other-window -1)(lookup-history-previous)(other-window 1)))
	     (local-set-key "\C-h" '(lambda() (interactive) (other-window -1)(lookup-history-previous)(other-window 1)))
	     ))
;; (defadvice lookup-entry-next-entry
;;   (after hoge activate)
;;   (recenter)
;;   )
;; (defadvice lookup-entry-previous-entry
;;   (after hoge activate)
;;   (recenter)
;;   )
;; (defadvice lookup-entry-open
;;   (after hoge activate)
;;   (balance-windows))
;; (defadvice lookup-pattern
;;   (after hoge activate)
;;   (other-window 1)
;;   )
;; (defadvice lookup
;;   (after hoge activate)
;;   (other-window 1)
;;   )
