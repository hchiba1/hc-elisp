;lisp-mode-accel.el
;start by M-;
(add-hook 'emacs-lisp-mode-hook
	  '(lambda ()
	     (local-set-key [?\M-\;] 'lisp-mode-accel)
	     (local-set-key "\C-x\C-p" 'mark-defun)
	     (local-set-key [?\C--] 'describe-function-sexp)
	     ))

(fset 'describe-function-sexp
      [f1 ?f return ?\C-o])

(defun insert-statement (arg)
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

(defun lisp-mode-accel ()
  "Insert Lisp forms quickly by abbreviations."
  (interactive)
  (message "(i)f, (l)et, (c)ond, de(f)un, def(a)dvice")
  (let ((c (read-char)) op)
    (cond
     ((equal c ?i)
      (insert-statement "(if ()")
      (insert-statement "")
      (insert-statement ")")
      (previous-line 3)(end-of-line)(backward-char 1)
      )
     ((equal c ?l)
      (insert-statement "(let ()")
      (insert-statement "")
      (insert-statement ")")
      (previous-line 3)(end-of-line)(backward-char 1)
      )
     ((equal c ?c)
      (insert-statement "(cond")
      (insert-statement "(()")
      (insert-statement "")
      (insert-statement ")")
      (insert-statement ")")
      (previous-line 4)(end-of-line)(backward-char 1)
      )
     ((equal c ?f)
      (insert-statement "(defun  ()")
      (insert-statement "\"\"")
      (insert-statement "(interactive)")
      (insert-statement "")
      (insert-statement ")")
      (previous-line 5)(end-of-line)(backward-char 3)
      )
     ((equal c ?a)
      (insert-statement "(defadvice ")
      (insert-statement "")
      (insert-statement ")")
      (previous-line 3)(end-of-line)
      (message "(b)efore, (a)fter")
      (setq op (read-char))
      (cond
       ((equal op ?b)
	(next-line 1)
	(insert-statement "(before hoge activate)")
	(previous-line 2)(end-of-line))
       ((equal op ?a)
	(next-line 1)
	(insert-statement "(after hoge activate)")
	(previous-line 2)(end-of-line)))
      )
     )))
