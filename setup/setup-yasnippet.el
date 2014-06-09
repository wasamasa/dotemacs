(my-eval-after yasnippet
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-reload-all))
(add-hook 'text-mode-hook 'yas-minor-mode)
(add-hook 'prog-mode-hook 'yas-minor-mode)

(provide 'setup-yasnippet)
