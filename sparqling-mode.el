;; - syntax highlighting of SPARQL keywords (customizable)
;; - 'Ctrl-Return' to submit SPARQL query using 'sparqling' command
;; - 'Meta-;' to support input
;; - syntax highlighting of search result (JSON, Turtle, XML, HTML)

;; - dependent on
;;    'sparqling' command (when submitting SPARQL query)
;;     js2-mode.el (when visualizing JSON) - if not installed, java-mode is used
;;     n3-mode.el (when visualizing Turtle)
;;    'column' command (when visualizing tab delimited JSON)

;; - add .emacs
;; (autoload 'sparqling-mode "sparqling-mode" "Major mode for SPARQL" t)
;; (add-to-list 'auto-mode-alist '("\\.rq$" . sparqling-mode))

(defvar sparqling-command-default  (concat (getenv "HOME") "/bin/sparqling"))
(defvar sparqling-result-format-default "xml")
(defvar sparqling-use-column-command t)	;; Use UNIX system 'column' command, to tabulate search results (in the case of tab delimited JSON)

(defun sparqling-current-buffer ()
  "Submit current buffer to SPARQL endpoint."
  (interactive)
  (let (sparqling-command format command-line org beg end)
    (setq sparqling-command sparqling-command-default)
    (setq format sparqling-result-format-default)

    ;; Analyze shebang line
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
	(progn
	  (setq org (point))
	  (goto-char (point-min))
	  (forward-char 2)
	  ;; Extract sparqling-command
	  (setq beg (point))
	  (end-of-line)
	  (setq end (point))
	  (setq sparqling-command (buffer-substring-no-properties beg end))
	  ;; Extract sparqling-result-format
	  (backward-sexp)
	  (setq format (buffer-substring-no-properties (point) end))
	  ;; Recover cursor position
	  (goto-char org)
	  ))

    ;; Prepare output window
    (delete-other-windows)
    (split-window-vertically)
    (other-window 1)
    (switch-to-buffer "*Shell Command Output*")
    (other-window 1)

    ;; Execute system command
    (setq command-line (concat sparqling-command " " (buffer-file-name)))
    (if (and sparqling-use-column-command
	     (string= format "json"))
	(setq command-line (concat sparqling-command " " (buffer-file-name) " | column -t -s '	' ")))
    (if (buffer-modified-p)
	(save-buffer))
    (message (concat "SPARQLing: (shell-command \"" command-line "\")"))
    (shell-command command-line)
    (message (concat "Executed : (shell-command \"" command-line "\")"))

    ;; Set mode for output window
    (other-window 1)
    (fundamental-mode)
    (if (or (string= "json" format) 
	    (string= "rdf/json" format)
	    (string= "js" format))
	(if (fboundp 'js2-mode)
	    (js2-mode)
	  (java-mode)))
    (if (or (string= "turtle" format)
	    (string= "null" format))
	(if (fboundp 'n3-mode)
	    (n3-mode)))
    (if (or (string= "xml" format)
	    (string= "rdf/xml" format))
	(xml-mode))
    (if (string= "html" format)
	(html-mode))
    (setq truncate-lines t)
    (other-window 1)

  ))

(defun sparqling-boost ()
  "Insert SPQRQL statemnts quickly."
  (interactive)
  (message "she(b)ang, (s)elect, (c)onstruct")
  (let ((c (read-char)))
    (cond
     ;; she(b)ang line
     ((equal c ?b)
      (insert-statement (concat "#!" sparqling-command-default " -f " sparqling-result-format-default))
      (insert-statement "")
      )
     ;; (p)refix
     ((equal c ?p)
      (insert-statement "PREFIX :")
      (previous-line 1)(end-of-line)(backward-char 1)
      )
     ;; (s)elect
     ((equal c ?s)
      (insert-statement "SELECT *")
      (insert-statement "WHERE {")
      (insert-statement "?s ?p ?o .")
      (insert-statement "}")
      (previous-line 4)(end-of-line)(backward-char 1)
      )
     ;; (c)onstruct
     ((equal c ?c)
      (insert-statement "CONSTRUCT {")
      (insert-statement "?s ?p ?o .")
      (insert-statement "}")
      (insert-statement "WHERE {")
      (insert-statement "?s ?p ?o .")
      (insert-statement "}")
      (previous-line 5)(back-to-indentation)
      )
     ;; (f)ilter
     ((equal c ?f)
      (insert-statement "FILTER ()")
      (previous-line 1)(end-of-line)(backward-char 1)
      )
     ;; (r)egex
     ((equal c ?r)
      (insert-statement "FILTER (regex(, \"\"))")
      (previous-line 1)(end-of-line)(backward-char 6)
      )
     ;; (v)alues
     ((equal c ?v)
      (insert-statement "VALUES () {  }")
      (previous-line 1)(end-of-line)(backward-char 6)
      )
     ;; (d)efine input:inference
     ((equal c ?i)
      (insert-statement "define input:inference ''")
      (previous-line 1)(end-of-line)(backward-char 1)
      )
     ;; (l)imit
     ((equal c ?l)
      (insert-statement "LIMIT ")
      (previous-line 1)(end-of-line)
      )
     ;; (o)rder
     ((equal c ?o)
      (insert-statement "ORDER BY ")
      (previous-line 1)(end-of-line)
      )
     ;; (h)ttp://
     ((equal c ?h)
      (insert "<http://>")
      (backward-char 1)
      )
     )))

(define-derived-mode sparqling-mode shell-script-mode "SPARQL"
  (define-key sparqling-mode-map [\C-\return] 'sparqling-current-buffer)
  (define-key sparqling-mode-map [?\M-\;] 'sparqling-boost)
  )

(font-lock-add-keywords
 'sparqling-mode
 '(
   ("\\?\\(\\w+\\)" . (1 font-lock-variable-name-face nil t))
   ("\\$\\([1-9][0-9]*\\)" . (1 font-lock-function-name-face nil t))
   ("\\$\\(STDIN\\)" . (1 font-lock-function-name-face nil t))
   ("\\$\\(ARGS\\)" . (1 font-lock-function-name-face nil t))
   ("\\$\\(\\w+\\)" . (1 font-lock-variable-name-face nil t))
   ("SELECT" . font-lock-keyword-face)
   ("select" . font-lock-keyword-face)
   ("CONSTRUCT" . font-lock-keyword-face)
   ("construct" . font-lock-keyword-face)
   ("DESCRIBE" . font-lock-keyword-face)
   ("describe" . font-lock-keyword-face)
   ("ASK" . font-lock-keyword-face)
   ("ask" . font-lock-keyword-face)
   ("WHERE" . font-lock-keyword-face)
   ("where" . font-lock-keyword-face)
   ("SERVICE" . font-lock-keyword-face)
   ("service" . font-lock-keyword-face)
 ))
