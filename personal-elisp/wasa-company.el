(wasa-eval-after company
  (defun company-mode-on ()
    (when (and (not (or noninteractive (eq (aref (buffer-name) 0) ?\s)))
               (cond ((eq company-global-modes t)
                      t)
                     ((eq (car-safe company-global-modes) 'not)
                      (not (memq major-mode (cdr company-global-modes))))
                     (t (or (not (null (derived-mode-p 'prog-mode)))
                            (memq major-mode company-global-modes)))))
      (company-mode 1))))

(global-company-mode t)
(define-key company-active-map (kbd "C-:") 'helm-company)

(setq company-idle-delay 0.1
      company-minimum-prefix-length 2
      company-selection-wrap-around t
      company-show-numbers t
      company-global-modes '(nxml-mode sgml-mode css-mode
                             inferior-emacs-lisp-mode)
      company-backends '(company-jedi company-elisp company-nxml company-css
                         company-capf (company-gtags company-etags
                                       company-dabbrev-code company-keywords)
                         company-files company-dabbrev))
(setq company-jedi-python-bin "python")

(provide 'wasa-company)
