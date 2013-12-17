;; buffer grouping
(setq ibuffer-saved-filter-groups
            (quote (("default"
                     ("Org" (mode . org-mode))
                     ("Emacs" (or (name . "^\\*scratch\\*$") (name . "^\\*Messages\\*$")))
                     ("Python" (mode . python-mode))
                     ("Elisp" (mode . emacs-lisp-mode))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))
(setq ibuffer-auto-mode 1)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(provide 'wasa-ibuffer)
