(add-hook 'go-mode-hook
      (lambda()
	(local-set-key [?\M-\;] 'go-mode-shortcuts)
	(local-set-key [?\C-\M-\\] 'gofmt)
	;; (local-set-key [\C-\return] 'initialize-go-variable)
	(local-set-key [?\C--] 'initialize-go-variable)
	(local-set-key [?\C-\M-\;] 'initialize-go-variable)
	(local-set-key "\C-xi" '(lambda() (interactive) (go-goto-imports) (beginning-of-line)))
	(local-set-key "\C-x\C-h" 'mark-defun)
	(setq tab-width 4)
	(if (= 0 (buffer-size)) (insert-go-template))
	))

(add-to-list 'exec-path (expand-file-name "/usr/local/go/bin/"))
(add-to-list 'exec-path (expand-file-name "/home/chiba/go/bin/"))

;; company-modeと連携してコード補完する
;; (require 'company-go)
(add-hook 'go-mode-hook (lambda()
      (company-mode)
      (setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
      (setq company-idle-delay 0) ; 遅延なしにすぐ表示
      (setq company-minimum-prefix-length 3) ; デフォルトは4
      (setq company-selection-wrap-around t) ; 候補の最後の次は先頭に戻る
      (setq completion-ignore-case t)
      (setq company-dabbrev-downcase nil)
      (global-set-key (kbd "C-M-i") 'company-complete)
      ;; C-n, C-pで補完候補を次/前の候補を選択
      (define-key company-active-map (kbd "C-n") 'company-select-next)
      (define-key company-active-map (kbd "C-p") 'company-select-previous)
      (define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
      (define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
      (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
      ))

;; flycheck-modeを有効化してシンタックスエラーを検知
;; (add-hook 'go-mode-hook 'flycheck-mode)
;; (add-hook 'go-mode-hook (lambda()
;;        (add-hook 'before-save-hook' 'gofmt-before-save)
;;        (local-set-key (kbd "M-.") 'godef-jump)
;;        (set (make-local-variable 'company-backends) '(company-go))
;;        (setq indent-tabs-mode nil)    ; タブを利用
;;        (setq c-basic-offset 4)    ; tabサイズを4にする
;;        (setq tab-width 4)))

(defun initialize-go-variable ()
  "Initialize Go variable."
  (interactive)
  (unless (equal (buffer-substring (- (point) 1) (point)) " ")
    (insert " "))
  (insert ":= ")
  )

(defun insert-go-template ()
  "Insert Go template."
  (interactive)
  (open-line-and-insert "package main") (forward-line)
  (open-line-and-insert "") (forward-line)
  (open-line-and-insert "import (") (forward-line)
  (open-line-and-insert "\"fmt\"") (forward-line)
  (open-line-and-insert ")") (forward-line)
  (open-line-and-insert "") (forward-line)
  (open-line-and-insert "func main() {") (forward-line)
  (open-line-and-insert "") (forward-line)
  (open-line-and-insert "}") (forward-line -1) (back-to-indentation)
  )

(defun go-mode-shortcuts ()
  "Insert go statemnts quickly by abbreviations."
  (interactive)
  (message "(m)ain, (p)rintln, (P)rintf, (f)or, (i)f, (e)lse, (c)ase, (E)rr, (1)exit, (M)ake, (a)rgs, (r)eturn, (v)ar, (d)float64")
  (let ((c (read-char)))
    (cond
     ;; (m)ain
     ((equal c ?m)
      (insert-go-template)
      )
     ;; (v)ar
     ((equal c ?v)
      (open-line-and-insert "var ")
      )
     ;; (p)rintln
     ((equal c ?p)
      (open-line-and-insert "fmt.Println()")(backward-char)
      )
     ;; (P)rintf
     ((equal c ?P)
      (open-line-and-insert "fmt.Printf(\"\\n\")")(backward-char 4)
      )
     ;; (s)can
     ((equal c ?s)
      (open-line-and-insert "fmt.Scan(&)")(backward-char)
      )
     ;; (M)ake
     ((equal c ?M)
      (open-line-and-insert "a := make([]int, n)")(backward-char 7)
      )
     ;; (a)rgs
     ((equal c ?a)
      (open-line-and-insert "if len(os.Args) !=  {")(forward-line)
      (open-line-and-insert "os.Exit(1)")(forward-line)
      (open-line-and-insert "}")(forward-line -1)(backward-char 3)
      )
     ;; (r)eturn
     ((equal c ?r)
      (open-line-and-insert "return ")
      )
     ;; (f)or
     ((equal c ?f)
      (open-line-and-insert "for {")(forward-line)
      (open-line-and-insert "")(forward-line)
      (open-line-and-insert "}")(forward-line -2)
      (back-to-indentation)(forward-char 4)
      (let (i direc)
	(message "a, b, ... , z  or  other key")
	(setq i (char-to-string (read-char)))
	(when (string-match "[a-z]" i)
	  (insert i)(insert " :=  ")(backward-char)
	  (message "<, >, (  or  other key")
	  (setq direc (read-char))
	  (cond
	   ((equal ?< direc)
	    (insert "0; ")(insert i)(insert " < ; ")(insert i)(insert "++")(backward-char 5))
	   ((equal ?> direc)
	    (insert "; ")(insert i)(insert " >= 0; ")(insert i)(insert "--")(backward-char 13))
	   ((equal ?\( direc)
	    (backward-char 4)(insert ", _")(forward-char 4)(insert "range "))
	   (t
	    (insert direc))
	   )
	  ))
      )
     ;; (i)f
     ((equal c ?i)
      (open-line-and-insert "if  {")(forward-line)
      (open-line-and-insert "")(forward-line)
      (open-line-and-insert "}")(forward-line -2)
      (end-of-line)(backward-char 2)
      )
     ;; (e)lse
     ((equal c ?e)
      (unless (equal (buffer-substring (- (point) 1) (point)) " ")
	  (insert " "))
      (insert "else {")(forward-line)
      (open-line-and-insert "")(forward-line)
      (open-line-and-insert "}")(forward-line -1)
      (back-to-indentation)
      )
     ;; (E)rr
     ((equal c ?E)
      (open-line-and-insert "if err != nil {")(forward-line)
      (open-line-and-insert "fmt.Fprintln(os.Stderr, err)")(forward-line)
      (open-line-and-insert "os.Exit(1)")(forward-line)
      (open-line-and-insert "}")(forward-line -1)
      (back-to-indentation)
      )
     ;; exit(1)
     ((equal c ?1)
      (open-line-and-insert "os.Exit(1)")
      )
     ;; (c)ase
     ((equal c ?c)
      (open-line-and-insert "switch  {")(forward-line)
      (open-line-and-insert "case:")(forward-line)
      (open-line-and-insert "")(forward-line)
      (open-line-and-insert "default:")(forward-line)
      (open-line-and-insert "}")(forward-line -4)
      (end-of-line)(backward-char 2)
      )
     ;; (d)ouble i.e., float64
     ((equal c ?d)
      (insert "float64")
      (unless (eq (point) (point-at-eol))
	(progn
	  (insert "(")(forward-sexp)(insert ")")
	  )
	)
      )
     
     )
    ))
