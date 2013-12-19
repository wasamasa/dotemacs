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
(setq helm-mp-highlight-delay 0.3)

(setq helm-cmd-t-default-repo (concat user-directory "code/dotfiles"))

;; helm ack-grep hacks
(setq helm-ack-grep-executable "ack")
(setq helm-grep-default-command
      (concat helm-ack-grep-executable " -nH --nogroup --nocolor --nopager --smart-case %p %f")
      helm-grep-default-recurse-command
      (concat helm-ack-grep-executable " -H --nogroup --nocolor --nopager --smart-case %p %f"))

;; helm grep hacks
(when helm-ff-ido-style-backspace
  (define-key helm-read-file-map (kbd "<backspace>")
    'helm-find-files-down-one-level))

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

(provide 'wasa-helm)
