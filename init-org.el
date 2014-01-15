;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)
;; load foreign stuff
(add-to-list 'load-path (concat user-emacs-directory "foreign-elisp"))
(require 'ac-company)
(require 'wc-mode)
;; load own elisp
(add-to-list 'load-path (concat user-emacs-directory "personal-elisp"))
(setq user-directory (concat "/home/" user-login-name "/"))
(setq initial-buffer-choice (concat user-directory "org/org.org"))
(setq wasa-packages
      '(wasa-ui
        wasa-hooks
        wasa-annoyances
        wasa-defuns
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
        wasa-python
        wasa-auctex
        wasa-smartparens
        wasa-keybinds
        wasa-evil
        ;;wasa-distractions
        ))
(dolist (package-name wasa-packages)
  (require package-name))
