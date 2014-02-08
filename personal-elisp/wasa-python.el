(add-to-list 'interpreter-mode-alist '("python2" . python-mode))
(add-to-list 'interpreter-mode-alist '("python3" . python-mode))

(add-hook 'python-mode-hook 'company-jedi-start)

(provide 'wasa-python)
