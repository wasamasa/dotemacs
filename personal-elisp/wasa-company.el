(setq company-idle-delay 0.1
      company-minimum-prefix-length 2
      company-selection-wrap-around t
      company-show-numbers t)
(setq company-backends
      '(company-jedi company-elisp company-nxml company-css
                     company-capf
                     (company-gtags company-etags company-dabbrev-code company-keywords)
                     company-files company-dabbrev))
(setq company-jedi-python-bin "python")
(eval-after-load "company" '(define-key company-active-map (kbd "C-:") 'helm-company))

(provide 'wasa-company)
