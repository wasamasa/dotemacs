(setq company-idle-delay 0.1
      company-minimum-prefix-length 2
      company-selection-wrap-around t
      company-show-numbers t)
(setq company-backends
      '(company-elisp company-nxml company-css company-capf
                      (company-gtags company-etags
                                     company-dabbrev-code company-keywords)
                      company-files company-dabbrev))
(add-hook 'prog-mode-hook 'company-mode-on)
(define-key company-active-map (kbd "C-:") 'helm-company)

(provide 'wasa-company)
