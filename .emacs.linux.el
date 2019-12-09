(set-face-attribute 'variable-pitch nil :family "*")

(setq default-frame-alist
      (append (list
	       '(foreground-color . "#bbbec7")
	       '(background-color . "#25324c")
	       '(cursor-color . "cornflower blue")
	       ;; '(font . "fontset-standard")
	       ;; '(font . "Monospace")
	       ;; '(font . "Noto mono")
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

(if (equal system-type 'darwin)
    ;; nil
    (let* ((font-family "Menlo")
           (font-size 17)
           (font-height (* font-size 10))
           (jp-font-family "ヒラギノ角ゴ ProN"))
      (set-face-attribute 'default nil :family font-family :height font-height)
      (let ((name (frame-parameter nil 'font))
            (jp-font-spec (font-spec :family jp-font-family))
            (jp-characters '(katakana-jisx0201
                             cp932-2-byte
                             japanese-jisx0212
                             japanese-jisx0213-2
                             japanese-jisx0213.2004-1))
            (font-spec (font-spec :family font-family))
            (characters '((?\u00A0 . ?\u00FF)    ; Latin-1
                          (?\u0100 . ?\u017F)    ; Latin Extended-A
                          (?\u0180 . ?\u024F)    ; Latin Extended-B
                          (?\u0250 . ?\u02AF)    ; IPA Extensions
                          (?\u0370 . ?\u03FF)))) ; Greek and Coptic
        (dolist (jp-character jp-characters)
          (set-fontset-font name jp-character jp-font-spec))
        (dolist (character characters)
          (set-fontset-font name character font-spec))
        (add-to-list 'face-font-rescale-alist (cons jp-font-family 1.2))))
  (setq default-frame-alist
        (append (list
                 '(font . "Monospace")
                 )
                default-frame-alist))
  )

(fset 'ps 'a2ps-buffer)

;; a2ps
;; (load "a2ps-print")
;; (global-set-key 'f22 'a2ps-buffer)			;f22 is Print Screen
;; (global-set-key '(shift f22) 'a2ps-region-1)		;print selected text
;; (add-menu-button '("File") ["a2ps-print" a2ps-buffer "--"]) ;on file menu
;; 		Someday I'll get menu to show PrtScr instead of f22...

;; (defun toggle-fullscreen ()
;;   (interactive)
;;   (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
;; 					   nil
;; 					 'fullboth)))
;; (global-set-key [(meta return)] 'toggle-fullscreen)
