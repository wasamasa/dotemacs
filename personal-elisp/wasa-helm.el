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
(setq helm-ack-binary "ack")
(setq helm-grep-default-command
      (concat helm-ack-binary " -nH --nogroup --nocolor --nopager --smart-case %p %f")
      helm-grep-default-recurse-command
      (concat helm-ack-binary " -H --nogroup --nocolor --nopager --smart-case %p %f"))

(cl-defun helm-grep-use-ack-p (&key where)
  (cl-case where
    (default (string= (helm-grep-command) helm-ack-binary))
    (recursive (string= (helm-grep-command t) helm-ack-binary))
    (strict (and (string= (helm-grep-command t) helm-ack-binary)
                 (string= (helm-grep-command) helm-ack-binary)))
    (t (and (not (string= (helm-grep-command) "git-grep"))
            (or (string= (helm-grep-command) helm-ack-binary)
                (string= (helm-grep-command t) helm-ack-binary))))))

(defun helm-grep-hack-types ()
  "Return a list of known ack-grep types."
  (with-temp-buffer
    (call-process helm-ack-binary nil t nil
                  "--help" "types")
    (goto-char (point-min))
    (cl-loop while (re-search-forward
                    "^ *--\\(\\[no\\]\\)\\([^. ]+\\) *\\(.*\\)" nil t)
             collect (cons (concat (match-string 2)
                                   " [" (match-string 3) "]")
                           (match-string 2))
             collect (cons (concat "no" (match-string 2)
                                   " [" (match-string 3) "]")
                           (concat "no" (match-string 2))))))

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

(provide 'wasa-helm)
