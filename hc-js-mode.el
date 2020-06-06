(add-hook 'js-mode-hook
          (lambda()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)
            (setq js-switch-indent-offset 2)
            (local-set-key [?\M-\;] 'js-mode-shortcuts)
            ))

(defun js-mode-shortcuts ()
  "Insert JavaScript statemnts quickly by abbreviations."
  (interactive)
  (message "(p)rint")
  (let ((c (read-char)))
    (cond
     ;; (s)hebang
     ((equal c ?s)
      (insert-js-template)
      )
     ;; (p)rint
     ((equal c ?p)
      (open-line-and-insert "console.log();") (backward-char 2)
      )
     )))


(defun insert-js-template ()
  "Insert Node.js template."
  (interactive)
  (open-line-and-insert "#!/usr/bin/env node") (forward-line)
  (open-line-and-insert "const program = require('commander');") (forward-line)
  (open-line-and-insert "") (forward-line)
  (open-line-and-insert "program") (forward-line)
  (open-line-and-insert "  .arguments('<ARG>')") (forward-line)
  (open-line-and-insert "  .parse(process.argv);") (forward-line)
  (open-line-and-insert "") (forward-line)
)
