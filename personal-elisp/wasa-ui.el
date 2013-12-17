;; annoyances
(setq inhibit-splash-screen t)
(setq wasa-fonts '("DejaVu Sans Mono-7" "DejaVu Sans" "Symbola"))
(create-fontset-from-fontset-spec standard-fontset-spec) ;to make --daemon work
(dolist (font (reverse wasa-fonts))
  (set-fontset-font "fontset-standard" 'unicode font nil 'prepend))
(add-to-list 'default-frame-alist '(font . "fontset-standard"))
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
(load-theme 'wasa-solarized t)

(provide 'wasa-ui)
