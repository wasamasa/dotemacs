(my-eval-after ibuf-ext
  (add-to-list 'ibuffer-never-show-predicates "^\\*"))

(defun my-setup-ibuffer-vc ()
  (ibuffer-vc-set-filter-groups-by-vc-root)
  (unless (eq ibuffer-sorting-mode 'alphabetic)
    (ibuffer-do-sort-by-alphabetic)))
(add-hook 'ibuffer-hook 'my-setup-ibuffer-vc)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(provide 'setup-ibuffer)
