(setq org-modules '(org-habit)
      org-indent-mode t
      org-catch-invisible-edits 'error
      org-startup-indented t
      org-cycle-include-plain-lists 'integrate
      org-ellipsis " […]"
      org-return-follows-link t
      org-log-done t
      org-M-RET-may-split-line nil
      org-enforce-todo-dependencies t
      org-enforce-todo-checkbox-dependencies t
      org-agenda-files '("~/org/")
      org-directory "~/org/"
      org-default-notes-file (concat org-directory "inbox.org")
      org-capture-templates
            '(("n" "Note" entry (file+headline org-default-notes-file "Inbox")
                        "* TODO %<%Y-%m-%d %H:%M:%S>\n\n%?" :empty-lines 1)))
;(global-set-key (kbd "<f12>") 'org-agenda)
(setq which-func-modes '(org-mode))
(which-function-mode)
;(global-set-key (kbd "<f11>") 'org-capture)
(global-set-key (kbd "<f11>") (lambda () (interactive) (org-capture nil "n")))

;; org-present
(add-hook 'org-present-mode-hook
          (lambda ()
            (org-display-inline-images)))

(add-hook 'org-present-mode-quit-hook
          (lambda ()
            (org-remove-inline-images)))

(provide 'wasa-org)
