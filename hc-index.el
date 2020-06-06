;; (load "~/etc/lisp/initchart.el")
;; (initchart-record-execution-time-of load file)
;; (initchart-record-execution-time-of require feature)

;; (set-language-environment "Japanese")

(setq load-path
      (append load-path
	      (list
	       "~/etc/hc-elisp"
	       "~/etc/lisp"
	       "~/etc/lisp/lookup"
	       "~/etc/lisp/ess-5.2.2/lisp"
	       )))
(setq Info-directory-list
      '(
	"~/etc/lisp/info"
	"/usr/share/info"
	))

;; Basic settings
(load "hc-faces" )
(load "hc-aliases")
(load "hc-window-buffer")
(load "hc-moving-cursor")
(load "hc-programming")
(load "hc-text-editing")

;; Settings for various modes
(load "hc-c-mode")
(load "hc-lisp-mode")
(load "hc-perl-mode")
(load "hc-ruby-mode")
(load "hc-go-mode")
(load "hc-nim-mode")
(load "hc-js-mode")
(load "hc-ess-mode")
(load "hc-html-mode")
(load "hc-yatex-mode")
(load "hc-help")
(load "hc-ibuffer")
(load "hc-lookup")
(load "hc-w3m")
(load "my-dired-mode")

;; Other settings
(load "hc-other-settings")
(load "hc-test-functions")
(load ".emacs.linux.el")
