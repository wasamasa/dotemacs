;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)
;; load foreign stuff
(add-to-list 'load-path (concat user-emacs-directory "foreign-elisp"))
(require 'ac-company)
(require 'gimme-cat)
(require 'highlight-tail)
;; load own elisp
(add-to-list 'load-path (concat user-emacs-directory "personal-elisp"))
(setq wasa-packages
      '(wasa-ui
        wasa-hooks
        wasa-annoyances
        wasa-pretty-symbols
        wasa-autocomplete
        wasa-company
        wasa-popwin
        wasa-calendar
        wasa-org
        wasa-ibuffer
        wasa-helm
        helm-smex
        helm-fkeys
        wasa-cc
        wasa-lisp
        wasa-web
        wasa-smartparens
        wasa-auctex
        wasa-defuns
        wasa-keybinds
        wasa-evil
        wasa-distractions))
(dolist (package-name wasa-packages)
  (require package-name))
