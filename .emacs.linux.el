(set-face-attribute 'variable-pitch nil :family "*")

(setq default-frame-alist
      (append (list
	       '(foreground-color . "#bbbec7")
	       '(background-color . "#25324c")
	       '(cursor-color . "cornflower blue")
	       ;; '(font . "fontset-standard")
	       '(line-spacing . 2)
	       ;; '(width . 125)
	       ;; '(height . 46)
	       ;; '(top . 0)
	       ;; '(height . 47)
	       ;; '(top . 2)
	       ;; '(left . 1)
;	       '(top . 25)
;	       '(left . 4)
	       '(height . 48)
	       '(width . 157)
	       )
	      default-frame-alist))

(fset 'ps 'a2ps-buffer)

;; a2ps
;; (load "a2ps-print")
;; (global-set-key 'f22 'a2ps-buffer)			;f22 is Print Screen
;; (global-set-key '(shift f22) 'a2ps-region-1)		;print selected text
;; (add-menu-button '("File") ["a2ps-print" a2ps-buffer "--"]) ;on file menu
;; 		Someday I'll get menu to show PrtScr instead of f22...

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
					   nil
					 'fullboth)))
(global-set-key [(meta return)] 'toggle-fullscreen)
