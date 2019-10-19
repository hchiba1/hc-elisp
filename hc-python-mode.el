(add-hook 'python-mode-hook
	  '(lambda()
	     (local-set-key [?\M-\;] 'python-mode-shortcuts)
	     ))
	     
