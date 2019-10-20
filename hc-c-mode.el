;c-mode-accel.el
;start by M-;
;; (add-hook 'c-mode-hook
(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (c-set-style "cc-mode") ;Set CC-MODE for indentation style in C mode
	     ;; (c-toggle-auto-hungry-state) ;auto-newline hungry-delete-key ON
	     (c-toggle-hungry-state 1)
	     (local-set-key [?\M-\;] 'c-mode-accel)
	     (local-set-key "\C-m" 'reindent-then-newline-and-indent)
	     ))

(defun c-insert-statement (arg)
  "Insert a new line with string ARG."
  (interactive "sStatement: ")
  (beginning-of-line)
  (open-line 1)
  (indent-according-to-mode)
  (insert arg)
  (indent-according-to-mode)
  (next-line 1)
  (back-to-indentation)
  )

(defun c-prototype-declarations()
  "Generate prototype declarations of C function"
  (interactive)
  (let (start end temp (counter 0))
    (beginning-of-line)
    (setq start (point))
    ;; Search for prototype declarations
    (goto-char (point-max))
    (if (and (search-backward "/\* Prototype Declaration End \*/" nil t)
	     (search-backward "/\* Prototype Declaration \*/" nil t))
	(progn
	  (next-line 1)
	  (beginning-of-line)
	  (setq start (point))
	  )
      (goto-char start)
      (insert "/\* Prototype Declaration \*/\n")
      (setq start (point))
      (insert "/\* Prototype Declaration End \*/\n")
      )
    ;; Extract functions
    (goto-char (point-min))
    (while (search-forward-regexp "^{" nil t)
      (beginning-of-line)
      (setq temp (point))
      (previous-line 1)
      (if (> counter 0)
	  (append-next-kill))
      (when (not (looking-at "int main"))
	(kill-ring-save (point) temp)
	(setq counter (+ counter 1)))
      (next-line 2))
    ;; Generate prototype declarations
    (goto-char start)
    (yank)
    (goto-char start)
    (while (> counter 0)
      (end-of-line)
      (insert ";")
      (forward-char)
      (setq counter (- counter 1)))
    ;; Kill old prototype declarations 
    (setq temp (point))
    (search-forward "/\* Prototype Declaration End \*/" nil t)
    (beginning-of-line)
    (kill-region temp (point))
    (goto-char start)
    (message "%d" start)
    ))

(defun c-mode-accel ()
  "Insert C statements quickly by abbreviations."
  (interactive)
  (message "(I/i)f, (W/w)hile, (D/d)o while, (F/f)or, (p)rintf, (e)rr, (s)tdio, (m)ain, p(r)ototype declarations")
  (let ((c (read-char)))
    (cond
     ((equal c ?m)
      (c-insert-statement "#include <stdio.h>")
      (c-insert-statement "")
      (c-insert-statement "int main() {")
      (c-insert-statement "")
      (c-insert-statement "")
      (c-insert-statement "return 0;")
      (c-insert-statement "}")
      (previous-line 4)(backward-char 4)
      (message "(a)rgs")
      (let (arguments)
	(setq arguments (read-char))
	(cond
	 ((equal arguments ?a)
	  (insert "int argc, char *argv[]"))
	 (t
	  (insert "void")))
	(next-line))
      )
     ((equal c ?s)
      (c-insert-statement "scanf(\"%d\", &);")
      (previous-line 1)(end-of-line)(backward-char 2)
      (let (char)
	(setq char (read-char))
	(setq string (char-to-string char))
	(if (string-match "[a-z]" string)
	    (progn
	      (insert char)
	      (c-insert-statement (concat "int " string ";"))
	      (end-of-line)(backward-char 2)
	      )
	  )
	)
      )
     ((equal c ?t)
      (c-insert-statement "typedef struct  {")
      (c-insert-statement "} ;")
      (previous-line 2)(end-of-line)(backward-char 2)
      )
     ((equal c ?p)
      (c-insert-statement "printf(\"%\\n\");")
      (previous-line 1)(end-of-line)(backward-char 5)
      (let (char)
	(setq char (read-char))
	(setq string (char-to-string char))
	(if (string-match "[dsfpx]" string)
	    (progn
	      (cond
	       ((equal char "\n")
		(backward-char))
	       (t
		(insert char)))
	      (forward-char 3)(insert ", ")
	      )
	  (backward-char)(delete-char 1)
	  (if (string-match "[a-z]" string)
	      (insert char))
	  )
	)
      )
     ((equal c ?e)
      (open-line-and-insert "fprintf(stderr, \"\");")(backward-char 3)
      )
     ((char-equal c ?i)
      (let (branch startpos)
	(setq startpos (point))
	(cond
	 ((equal c ?i)
	  (open-line-and-insert "if () {")(forward-line)
	  (open-line-and-insert "")(forward-line)
	  (open-line-and-insert "}")
	  )
	 )
	(while (progn
		 (message "else (i)f, (e)lse  or  other key")
		 (setq branch (read-char))
		 (char-equal branch ?i))
	  (cond
	   ((equal branch ?i)
	    (insert " else if () {")(forward-line)
	    (open-line-and-insert "")(forward-line)
	    (open-line-and-insert "}")
	    )
	   )
	  )
	(cond
	 ((equal branch ?e)
	  (insert " else {")(forward-line)
	  (c-insert-statement "")
	  (c-insert-statement "}")
	  )
	 )
	(replace-string ";" "" nil startpos (point))
	(goto-char startpos)(back-to-indentation)(forward-char 4))
      )
     ((char-equal c ?w)
      (cond
       ((equal c ?w)
	(c-insert-statement "while () {")
	(c-insert-statement "")
	(c-insert-statement "}")
	(previous-line 3)(end-of-line)(backward-char 3)
	)
       )
      )
     ((char-equal c ?d)
      (cond
       ((equal c ?d)
	(c-insert-statement "do {")
	(c-insert-statement "")
	(c-insert-statement "} while ();")
	(previous-line 2)(c-indent-command)
	)
       )
      )
     ((char-equal c ?f)
      (cond
       ((equal c ?f)
	(c-insert-statement (concat "for (=\; \; ) {"))
	(c-insert-statement "")
	(c-insert-statement "}")
	(previous-line 3)(back-to-indentation)(forward-char 5)
	)
       )
      (let (i direc)
	(message "a, b, ... , z  or  other key")
	(setq i (char-to-string (read-char)))
	(when (string-match "[a-z]" i)
	  (insert i)(forward-char 3)(insert i)(forward-char 2)(insert i)
	  (beginning-of-line)(open-line 1)(indent-according-to-mode)(insert "int ")(insert i)(insert ";")
	  (next-line)(end-of-line)(backward-char 6)
	  (message "<, >  or  other key")
	  (setq direc (read-char))
	  (cond
	   ;; ((equal ?+ direc)
	    ;; (forward-char 3)(insert "<")(forward-char 3)(insert "++")(backward-char 9))
	    ;; (insert "++")(backward-char 8)(insert "0")(forward-char 3)(insert "<"))
	   ((equal ?< direc)
	    (insert "<")(backward-char 4)(insert "0")(forward-char 7)(insert "++")(backward-char 5))
	   ;; ((equal ?- direc)
	   ;;  (forward-char 3)(insert ">")(forward-char 3)(insert "--")(backward-char 9)))))
	   ((equal ?> direc)
	    (insert ">=0")(forward-char 3)(insert "--")(backward-char 11)))))
      )
     ((equal c ?r)
      (c-prototype-declarations)
      )
     )))