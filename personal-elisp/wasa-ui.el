;; annoyances
(setq inhibit-splash-screen t)
(setq default-frame-alist '((font . "DejaVu Sans Mono-7")))
(set-fontset-font "fontset-default" '(#x10000 . #x1ffff) "Symbola")
(add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font "fontset-default" '(#x10000 . #x1ffff) "Symbola" frame)))
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(setq echo-keystrokes 0.5)

;; theme and faces
(setq custom-file (concat user-emacs-directory "custom/custom"))
(load custom-file)
(setq x-gtk-use-system-tooltips nil)
(add-to-list 'custom-theme-load-path
	     (concat user-emacs-directory "personal-elisp/"))

(setq sml/theme 'respectful
      sml/mode-width 'full
      sml/replacer-regexp-list
      '(("^~/org/" ":O:")
        ("^~/\\.emacs\\.d/" ":ED:")))
(sml/setup)

(load-theme 'wasa-solarized t)

(provide 'wasa-ui)
