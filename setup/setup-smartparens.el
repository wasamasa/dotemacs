(require 'smartparens)
; hook functions
(defun wasa-turn-on-sp-mode ()
  (smartparens-mode t))
(defun wasa-turn-on-show-sp-mode ()
  (show-smartparens-mode t))

;; hooks
(add-hook 'text-mode-hook 'wasa-turn-on-sp-mode)
(add-hook 'text-mode-hook 'wasa-turn-on-show-sp-mode)
(add-hook 'prog-mode-hook 'wasa-turn-on-sp-mode)
(add-hook 'prog-mode-hook 'wasa-turn-on-show-sp-mode)
(add-hook 'minibuffer-setup-hook 'wasa-turn-on-sp-mode)
(add-hook 'minibuffer-setup-hook 'wasa-turn-on-show-sp-mode)

;; we're using evil, thus we can't move the cursor beyond the end of
;; the line and have to show the matching paren with this setting
(setq sp-show-pair-from-inside t)

;; no single quotes for elisp
(sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
(sp-local-pair 'minibuffer-inactive-mode "`" nil :actions nil)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
(sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)
(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)
(sp-local-pair 'lisp-interaction-mode "`" nil :actions nil)

;; tex and latex use their own quote delimiters
(sp-local-pair 'LaTeX-mode "\"" nil :actions nil)
(sp-local-pair 'LaTeX-mode "'" nil :actions nil)
(sp-local-pair 'LaTeX-mode "`" nil :actions nil)
(sp-local-pair 'latex-mode "\"" nil :actions nil)
(sp-local-pair 'latex-mode "'" nil :actions nil)
(sp-local-pair 'latex-mode "`" nil :actions nil)
(sp-local-pair 'TeX-mode "\"" nil :actions nil)
(sp-local-pair 'TeX-mode "'" nil :actions nil)
(sp-local-pair 'TeX-mode "`" nil :actions nil)
(sp-local-pair 'tex-mode "\"" nil :actions nil)
(sp-local-pair 'tex-mode "'" nil :actions nil)
(sp-local-pair 'tex-mode "`" nil :actions nil)

;; lots of autopairing solutions from other editors insert an extra
;; newline with correct indentation after pressing enter after an
;; opening key, this adds a generic function for that

(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

;; list of modes and pairs to apply this to
(sp-local-pair 'c-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))

(provide 'setup-smartparens)
