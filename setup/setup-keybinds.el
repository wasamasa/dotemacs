;; global keybinds
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "<insert>") nil)
(defun my-quit-emacs ()
  (interactive)
  (save-some-buffers nil t)
  (kill-emacs))
(global-set-key (kbd "M-<f4>") 'my-quit-emacs)

(provide 'setup-keybinds)
