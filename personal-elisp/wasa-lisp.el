;; lisp settings
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-company-elisp)))
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))
(defun wasa-eval-region-or-buffer ()
  (interactive)
  (if (region-active-p)
      (eval-region (region-beginning) (region-end))
    (eval-buffer)))
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'wasa-eval-region-or-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-k") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-r") 'eval-region)
(define-key emacs-lisp-mode-map (kbd "C-c C-z") 'ielm)

(cl-lib-highlight-initialize)
(cl-lib-highlight-warn-cl-initialize)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq show-paren-delay 0.05)
(setq eldoc-idle-delay 0.1)

(provide 'wasa-lisp)
