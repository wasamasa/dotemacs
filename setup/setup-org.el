(setq org-catch-invisible-edits 'error
      org-startup-indented t
      org-cycle-include-plain-lists 'integrate
      org-ellipsis " […]"
      org-return-follows-link t
      org-M-RET-may-split-line nil
      org-src-fontify-natively t
      org-enforce-todo-dependencies t
      org-enforce-todo-checkbox-dependencies t
      org-link-frame-setup '((file . find-file))
      org-directory "~/org/"
      org-agenda-files (list org-directory)
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
(autoload 'wc-mode "wc-mode" "Enable wc-mode" t)
(add-hook 'org-capture-mode-hook 'wc-mode)

(provide 'setup-org)
