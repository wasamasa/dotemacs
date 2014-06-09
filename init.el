;; setup package autoloads
(package-initialize)
;; enable GNU/ELPA and Org repository only
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; make package setup files loadable
(add-to-list 'load-path (concat user-emacs-directory "setup"))
;; make unpublished packages loadable
(add-to-list 'load-path (concat user-emacs-directory "unpublished"))

;; load safe setup files
(require 'setup-defuns)
(require 'setup-ui)
(require 'setup-hooks)
(require 'setup-annoyances)
(require 'setup-keybinds)

;; load unpublished packages
(require 'helm-smex)
(require 'helm-fkeys)

;; load remaining setup files
(require 'setup-tramp)
(require 'setup-pretty-symbols)
(require 'setup-company)
(require 'setup-popwin)
(require 'setup-calendar)
(require 'setup-org)
(require 'setup-ibuffer)
(require 'setup-helm)
(require 'setup-comint)
(require 'setup-flycheck)
(require 'setup-helm-fkeys)
(require 'setup-cc-mode)
(require 'setup-lisp)
(require 'setup-web)
(require 'setup-python)
(require 'setup-auctex)
(require 'setup-smartparens)
(require 'setup-evil)
(require 'setup-yasnippet)
(require 'setup-distractions)
