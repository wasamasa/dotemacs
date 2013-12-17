(defun wasa-turn-on-fill-mode ()
  (auto-fill-mode 1))
(defun wasa-turn-on-indicate-empty-lines ()
  (setq indicate-empty-lines t))
(defun wasa-turn-on-indicate-buffer-boundaries ()
  (setq indicate-buffer-boundaries
        '((top . left) (bottom . left))))
(rainbow-delimiters-mode-enable)

(add-hook 'text-mode-hook 'wasa-turn-on-indicate-buffer-boundaries)
(add-hook 'text-mode-hook 'wasa-turn-on-indicate-empty-lines)
(add-hook 'text-mode-hook 'wasa-turn-on-fill-mode)
(add-hook 'prog-mode-hook 'wasa-turn-on-indicate-buffer-boundaries)
(add-hook 'prog-mode-hook 'wasa-turn-on-indicate-empty-lines)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode-enable)

(provide 'wasa-hooks)
