(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))
(defun wasa-eval-region-or-buffer ()
  (interactive)
  (if (region-active-p)
      (eval-region (region-beginning) (region-end))
    (eval-buffer)))
(wasa-define-keys emacs-lisp-mode-map
                  (kbd "C-c C-c") 'wasa-eval-region-or-buffer
                  (kbd "C-c C-k") 'eval-buffer
                  (kbd "C-c C-r") 'eval-region
                  (kbd "C-c C-z") 'ielm)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(cl-lib-highlight-initialize)
(cl-lib-highlight-warn-cl-initialize)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq show-paren-delay 0.05)
(setq eldoc-idle-delay 0.1)

(provide 'wasa-lisp)
