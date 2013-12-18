(setq recentf-save-file (concat user-emacs-directory "etc/recentf")
      recentf-max-menu-items 25
      recentf-max-saved-items 50)
(recentf-mode t)
(helm-mode t)
(setq helm-ff-ido-style-backspace 'always
      helm-ff-auto-update-initial-value t
      helm-ff-newfile-prompt-p nil
      helm-ff-skip-boring-files t)
(setq helm-adaptive-history-file (concat user-emacs-directory "etc/helm-adaptive")
      helm-adaptive-history-length 100)
(helm-adaptative-mode t)

(setq helm-cmd-t-default-repo (concat user-directory "code/dotfiles"))
(setq helm-grep-default-command "ack-grep -nH --no-group --no-color --smart-case %p %f"
      helm-grep-default-recurse-command "ack-grep -H --no-group --no-color --smart-case %p %f")

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

(provide 'wasa-helm)
