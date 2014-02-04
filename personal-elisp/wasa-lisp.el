;; lisp settings
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-company-elisp)))
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))
(cl-lib-highlight-initialize)
(cl-lib-highlight-warn-cl-initialize)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq show-paren-delay 0.05)
(setq eldoc-idle-delay 0.1)
(add-hook 'emacs-lisp-mode-hook 'el-spice-mode)
(add-hook 'ielm-mode-hook 'el-spice-mode)
(add-hook 'lisp-interaction-mode 'el-spice-mode)

(provide 'wasa-lisp)
