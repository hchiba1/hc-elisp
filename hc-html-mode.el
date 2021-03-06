;html-mode-accel.el
;start by M-;
(add-hook 'html-mode-hook
	  '(lambda ()
	     (local-set-key [?\M-\;] 'html-mode-accel)
	     ))

(defun html-insert-tag (arg)
  "Insert a new line with string ARG in html source cord."
  (interactive "sStatement: ")
  (beginning-of-line)
  (open-line 1)
  (insert arg)
  (next-line 1)
  (back-to-indentation)
  )

(defun html-mode-accel ()
  "Insert html tags quickly by abbreviations."
  (interactive)
  (message "(a),(b)r,(h)r,(c)enter,(l)ist,(t)emplate,(f)orm,(i)nput,(p)hp")
  (let ((c (read-char)))
    (cond
     ((equal c ?a)
      (html-insert-tag "<a href=\"\"></a>")
      (previous-line 1)(beginning-of-line)(forward-char 9)
      )
     ((equal c ?b)
      (insert "<br>")
      (newline)
      )
     ((equal c ?h)
      (insert "<hr>")
      (newline)
      )
     ((equal c ?c)
      (html-insert-tag "<center>")
      (html-insert-tag "</center>")
      (previous-line 2)
      )
     ((equal c ?l)
      (html-insert-tag "<ul>")
      (html-insert-tag "<li>")
      (html-insert-tag "<li>")
      (html-insert-tag "</ul>")
      (previous-line 2)
      )
     ((equal c ?t)
      (html-insert-tag "<html>")
      (html-insert-tag "<head>")
      (html-insert-tag "<title></title>")
      (html-insert-tag "</head>")
      (html-insert-tag "<body>")
      (html-insert-tag "")
      (html-insert-tag "</body>")
      (html-insert-tag "</html>")
      (previous-line 3)
      )
     ((equal c ?f)
      (html-insert-tag "<form method=\"\" action=\"\">")
      (html-insert-tag "<input type=\"submit\" value=\"\">")
      (html-insert-tag "</form>")
      (previous-line 3)(beginning-of-line)(forward-char 14)
      (message "(g)et,(p)ost")
      (setq c (read-char))
      (cond
       ((equal c ?g)
	(insert "get")
	)
       ((equal c ?p)
	(insert "post")
	)
       )
      (forward-char 10)
      )
     ((equal c ?i)
      (html-insert-tag "<input type=\"\" name=\"\">")
      (previous-line 1)(beginning-of-line)(forward-char 13)
      )
     ((equal c ?p)
      (html-insert-tag "<?php")
      (html-insert-tag "")
      (html-insert-tag "?>")
      (previous-line 2)
      )

     )    
    )
  )
