(add-hook 'nim-mode-hook
          (lambda()
            (local-set-key [?\M-\;] 'nim-mode-shortcuts)
            (local-set-key [\C-\return] '(lambda() (interactive) (insert ":")(forward-line)(open-line-and-insert "")))
            (if (= 0 (buffer-size)) (insert-nim-template))
            ))

;; (add-hook 'nim-mode-hook 'nimsuggest-mode)
;; (setq nimsuggest-path "/usr/bin/nimsuggest")
;; (add-hook 'nimsuggest-mode-hook 'company-mode)  ; auto complete package
;; (add-hook 'nimsuggest-mode-hook 'flycheck-mode) ; auto linter package

(defun insert-nim-template ()
  "Insert Nim template."
  (interactive)
  ;; (open-line-and-insert "import macros, tables, sets, lists, queues, intsets, critbits, future, unicode") (forward-line)
  (open-line-and-insert "import strutils, sequtils, math, algorithm") (forward-line)
  (open-line-and-insert "") (forward-line)
  )

(defun nim-mode-shortcuts ()
  "Insert Nim statemnts quickly by abbreviations."
  (interactive)
  (message "(r)ead i(n)t or i(N)ts")
  (let ((c (read-char)))
    (cond
     ;; readI(n)t
     ((equal c ?n)
      (open-line-and-insert "var n = readLine(stdin).parseInt")
      ;; (beginning-of-line)(forward-char 5)
      (forward-line)
      )
     ;; (a)rray
     ((equal c ?a)
      (open-line-and-insert "var a = readLine(stdin).split.map(parseInt)")
      ;; (beginning-of-line)(forward-char 8)
      (forward-line)
      )
     ;; (m)apIt
     ((equal c ?m)
      (insert "(0..<n).mapIt(") (end-of-line) (insert ")")
      )
     ;; (r)eadLine
     ((equal c ?r)
      (open-line-and-insert "var  = readLine(stdin)")
      (let ((s (read-char)))
	(cond
	 ((equal s ?s) ;; split
	  (insert ".split")
	  (let ((m (read-char)))
	    (cond
	     ((equal m ?i) ;; init
	      (insert ".map(parseInt)")(beginning-of-line)(forward-char 4)
	      )
	     (t
	      (beginning-of-line) (forward-char 4)
	      )
	     )
	    )
	  )
	 ((equal s ?i) ;; init
	  (insert ".parseInt")(beginning-of-line)(forward-char 4)
	  )
	 ((equal s ?I) ;; 
	  (insert ".split.map(parseInt)")(beginning-of-line)(forward-char 4)
	  )
	 (t
	  (beginning-of-line) (forward-char 4)
	  )
	 )
	)
      )
     ;; (p)roc
     ((equal c ?p)
      (open-line-and-insert "proc (:): =") (backward-char 6)
      )
     ;; (f)or
     ((equal c ?f)
      (open-line-and-insert "for  in :") (backward-char 5)
      (let (i direc)
	(setq i (char-to-string (read-char)))
	(when (string-match "[a-z]" i)
	  (insert i) (forward-char 4)
	  (message "<, >  or  other key")
	  (setq direc (read-char))
	  (cond
	   ((equal ?< direc)
	    (insert "0..<"))
	   ((equal ?0 direc)
	    (insert "0..<"))
	   ((equal direc ?>)
	    (insert "countdown(, )")(backward-char 3))
	   (t
	    (insert direc))
	  ))
	)
      )
     ;; (e)lse
     ((equal c ?e)
      (open-line-and-insert "else:") (forward-line)
      (open-line-and-insert "")
      )
     ;; (E)lse
     ((equal c ?E)
      (open-line-and-insert "elif :") (backward-char 1)
      )
     ;; (v)ar
     ((equal c ?v)
      (open-line-and-insert "var")(forward-line)
      (open-line-and-insert ":")(backward-char)
      )
     ;; (i)nc
     ((equal c ?i)
      (back-to-indentation)(insert "inc(")(end-of-line)(insert ")")
      )

     )))
