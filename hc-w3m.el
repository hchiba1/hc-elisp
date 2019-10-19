(add-hook 'w3m-mode-hook
	  '(lambda()
	     (local-set-key "\C-h" 'w3m-view-previous-page)
	     (local-set-key "p" 'extract-and-print-abstract)
	     (local-set-key "f" 'show-full-text)
	     ))
(autoload 'w3m "w3m" "Visit the WWW page using w3m" t)
(autoload 'w3m-find-file "w3m" "Find a local file using emacs-w3m." t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
(autoload 'w3m-weather "w3m-weather" "Display a weather report." t)
(autoload 'w3m-antenna "w3m-antenna" "Report changes of web sites." t)
(autoload 'w3m-namazu "w3m-namazu" "Search files with Namazu." t)


(global-set-key [?\C-x?\C-,] 'search-cell-this-word)
(global-set-key [?\C-x?\C-.] 'search-cell)
(global-set-key "\C-xw" 'w3m-this-line)
(defun search-cell-this-word (arg)
  "Search for the word arg from the Molecular Biology of the Cell."
  (interactive "p")
  (w3m-browse-url (concat
		 "http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=Books&cmd=search&doptcmdl=DocSum&term="
		 (get-word arg)
		 "+AND+mboc4%5Bbook%5D"))
  (delete-other-windows))
(defun search-cell (arg)
  "Search for the word arg from the Molecular Biology of the Cell."
  (interactive "sSearch Cell for: ")
  (w3m-browse-url (concat
		 "http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=Books&cmd=search&doptcmdl=DocSum&term="
		 arg
		 "+AND+mboc4%5Bbook%5D"))
  (delete-other-windows))
(defun ej (arg)
  "Search for e-journal"
  (interactive "sjournal: ")
  (w3m-browse-url (concat
		   "http://ejournal.dl.itc.u-tokyo.ac.jp/cgi-bin/ejsrch.cgi?title=" arg
		   ))
  (delete-other-windows))

(fset 'extract-and-print-abstract
   [?\M-< ?\C-7 ?\M-x ?f ?o ?r ?w tab ?p ?a ?r return ?\C-  ?\M-x ?f ?o ?r ?w tab ?p ?a ?r return ?\M-w ?\C-, ?\C-n ?\C-y])

(fset 'show-full-text
   [?U ?h ?t ?t ?p ?: ?/ ?/ ?1 ?3 ?3 ?. ?1 ?1 ?. ?1 ?9 ?9 ?. ?1 ?1 ?: ?8 ?0 ?8 ?0 ?/ ?- ?_ ?- ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-h ?f ?u ?l ?l return])
;; (fset 'w3m-this-line
;;    [?\C-a ?\C-s ?h ?t ?t ?p ?: ?/ ?/ ?\C-m C-return ?w ?3 ?m return return])
(defun w3m-this-line ()
  "Goto url by w3m near the cursor."
  (interactive)
  (beginning-of-line)
  (search-forward-regexp "http\\|file")
  (backward-word 1)
  (command-execute 'w)
  )

;; Add "http://133.11.199.11:8080" before the http://...
(fset 'H
   "\C-shttp\C-m\342http://133.11.199.11:8080/-_-")
;; Add "http://133.11.199.11:8080" before the http://...
;; and replace "abstract" with "full"
(fset 'h
   "\C-shttp\C-m\342http://133.11.199.11:8080/-_-\346\346\346\346\346\346\346\350full")
