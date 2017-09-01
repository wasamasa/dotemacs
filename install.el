;; bootstrap
(package-initialize)
(if (require 'quelpa nil t)
    (quelpa-self-upgrade)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

(defun my-package-install (package)
  (when (not (package-installed-p package))
    (package-install package)))

;; GNU ELPA stuff
(package-refresh-contents)
(my-package-install 'auctex)
(my-package-install 'bug-hunter)
(my-package-install 'csv-mode)
(my-package-install 'rainbow-mode)

;; elisp dev helpers
(quelpa 'buttercup)
(quelpa 'cl-lib-highlight)
(quelpa 'form-feed)
(quelpa 'macrostep)
(quelpa 'esxml)
(quelpa 'marmalade-client)

;; productivity
(quelpa 'ace-jump-mode)
(quelpa 'calfw)
(quelpa 'column-enforce-mode)
(quelpa 'company)
(quelpa 'eyebrowse)
(quelpa 'firestarter)
(quelpa 'flx)
(quelpa 'flycheck)
(quelpa 'helm)
(quelpa 'helm-cmd-t)
(quelpa 'helm-company)
(quelpa 'hl-todo)
(quelpa 'hydra)
(quelpa 'magit)
(quelpa 'magit-rockstar)
(quelpa 'rainbow-delimiters)
(quelpa 'shackle)
(quelpa 'smart-mode-line)
(quelpa 'smartparens)
(quelpa 'smex)
(quelpa 'visual-fill-column)
(quelpa 'yasnippet)

;; markup
(quelpa 'latex-extra)
(quelpa 'markdown-mode)
(quelpa 'textile-mode)
(quelpa 'toc-org)
(quelpa 'yaml-mode)

;; evil
(quelpa 'evil)
(quelpa 'evil-numbers)
(quelpa 'evil-surround)
(quelpa 'vimrc-mode)

;; languages
(quelpa 'clojure-mode)
(quelpa 'cider :stable t)
(quelpa 'csharp-mode)
(quelpa 'enh-ruby-mode)

;; web
(quelpa 'company-tern)
(quelpa 'json-mode)
(quelpa 'tern)
(quelpa 'web-mode)

;; fun
(quelpa 'highlight-tail)
(quelpa 'nyan-mode)
(quelpa 'nyan-prompt)
(quelpa '(zone-matrix :fetcher git :url "https://github.com/ober/zone-matrix"))
