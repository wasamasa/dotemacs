;; global keybinds
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "<insert>") nil)
(defun wasa-quit-emacs ()
  (interactive)
  (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
  (remove-hook 'kill-emacs-query-functions 'server-kill-emacs-query-function)
  (save-buffers-kill-emacs))
(global-set-key (kbd "M-<f4>") (lambda () (interactive) (wasa-quit-emacs)))

(provide 'wasa-keybinds)
