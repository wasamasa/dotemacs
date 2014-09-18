(add-to-list 'auto-mode-alist '("Gemfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . enh-ruby-mode))

(setq enh-ruby-bounce-deep-indent t)

(setq inf-ruby-default-implementation "pry")

(provide 'setup-ruby)
