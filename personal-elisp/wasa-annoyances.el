(require 's)

(setq gc-cons-threshold 50000000)
(setq safe-local-variable-values '((org-confirm-elisp-link-function . nil)))
(setq find-function-C-source-directory (concat user-emacs-directory "emacs-24.3/src"))
(setq delete-old-versions t)
(setq browse-url-browser-function 'browse-url-xdg-open)
(fset 'yes-or-no-p 'y-or-n-p)
(setq split-height-threshold 0
      split-width-threshold 0)
(line-number-mode t)
(column-number-mode t)
(setq-default indent-tabs-mode nil)
(setq uniquify-buffer-name-style 'forward)
(setq apropos-do-all t)
(setq async-shell-command-buffer 'new-buffer)
(setq server-use-tcp t)
(setq mouse-yank-at-point t)
(setq comint-prompt-read-only t)
(setq scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
(setq frame-title-format '("" invocation-name ": " (:eval (s-trim (buffer-name)))))
(setq user-directory (concat "/home/" user-login-name "/"))
(setq initial-buffer-choice (concat user-emacs-directory "init.el"))
(setq blink-matching-paren nil)
;; primitive vcs and uncluttering
(setq backup-directory-alist
      `((".*" . ,(concat user-emacs-directory "backup"))))
(setq auto-save-list-file-prefix (concat user-emacs-directory "autosave/"))
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "autosave/\\1") t)))
(setq version-control t)
(winner-mode t)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "etc/saved-places"))
(setq python-check-command "flake8")
(unicode-whitespace-setup)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq bookmark-default-file (concat user-emacs-directory "etc/bookmarks"))

(provide 'wasa-annoyances)
