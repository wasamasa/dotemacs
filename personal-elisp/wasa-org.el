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
      org-journal-file (concat org-directory "journal.org")
      org-capture-templates
            '(("n" "Note" entry (file+headline org-default-notes-file "Inbox")
               "* TODO %<%Y-%m-%d %H:%M:%S>\n\n%?" :empty-lines 1)
              ("j" "Journal" entry (file+datetree org-journal-file)
               "* %<%H:%M>\n\n%?" :empty-lines 1)))
(setq which-func-modes '(org-mode))
(which-function-mode)
(global-set-key (kbd "<f11>") 'org-capture)

(provide 'wasa-org)
