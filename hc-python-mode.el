(add-hook 'python-mode-hook
	  '(lambda()
	     (local-set-key [?\M-\;] 'python-mode-shortcuts)
	     (local-set-key [?\C->] 'indent-region-forward)
	     (local-set-key [?\C-<] 'indent-region-backward)
             (if (= 0 (buffer-size)) (insert-python-template))
	     ))

(defun python-mode-shortcuts ()
  "Insert Python statemnts quickly by abbreviations."
  (interactive)
  (message "(s)hebang, (a)rgs, (l)oop for filter program, (i)f, (w)hile, (f)or, (p)ototype declarations, (e)xport functions, (o)ccur sub")
  (let ((c (read-char)))
    (cond
     ;; (s)hebang
     ((equal c ?s)
      (insert-python-template)
      )
     ;; (p)rint
     ((equal c ?p)
      (open-line-and-insert "print()") (backward-char 1)
      )
     )))

(defun insert-python-template ()
  "Insert Python template."
  (interactive)
  (open-line-and-insert "#!/usr/bin/env python3") (forward-line)
  (open-line-and-insert "import argparse") (forward-line)
  (open-line-and-insert "") (forward-line)
  (open-line-and-insert "parser = argparse.ArgumentParser(description='')") (forward-line)
  (open-line-and-insert "parser.add_argument('-n', '--cores', type=int, default=1, help='')") (forward-line)
  (open-line-and-insert "parser.add_argument('-v', '--verbose', action='store_true', help='')") (forward-line)
  (open-line-and-insert "args = parser.parse_args()") (forward-line)
  (open-line-and-insert "") (forward-line)
  (open-line-and-insert "if __name__ == '__main__':") (forward-line)
  (open-line-and-insert "main()") (forward-line)
  )

(defun indent-region-forward (start end)
  "indent region by one char"
  (interactive "r")
  (save-excursion
    (let (c)
      (setq c ?\C->)
      (while (or (equal c ?\C->)(equal c ?\C-<))
        (if (equal c ?\C->)
            (indent-rigidly start end 4)
          (indent-rigidly start end -4))
        (setq c (read-char)))
      )))

(defun indent-region-backward (start end)
  "indent region by one char"
  (interactive "r")
  (save-excursion
    (let (c)
      (setq c ?\C-<)
      (while (or (equal c ?\C->)(equal c ?\C-<))
        (if (equal c ?\C->)
            (indent-rigidly start end 4)
          (indent-rigidly start end -4))
        (setq c (read-char)))
      )))
