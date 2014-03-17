;; global keybinds
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "<insert>") nil)
(defun wasa-quit-emacs ()
  (interactive)
  (save-some-buffers nil t)
  (kill-emacs))
(global-set-key (kbd "M-<f4>") 'wasa-quit-emacs)

(provide 'setup-keybinds)
