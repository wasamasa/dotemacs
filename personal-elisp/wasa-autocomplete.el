(global-auto-complete-mode t)
(setq ac-auto-show-menu 0.1
      ac-quick-help-delay 0.3
      ac-comphist-file (concat user-emacs-directory "etc/ac-comphist"))
(ac-company-define-source ac-source-company-elisp company-elisp)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)

(provide 'wasa-autocomplete)
