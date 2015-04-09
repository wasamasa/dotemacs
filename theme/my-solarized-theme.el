(deftheme my-solarized "Fork of bbatsov's solarized theme.")

(defun my-solarized-toggle ()
  (interactive)
  (if my-solarized-dark?
      (setq my-solarized-dark? nil)
    (setq my-solarized-dark? t))
  (load-theme 'my-solarized t))

(defvar my-solarized-dark? t
  "t for dark, nil for light.")

(defun my-solarized-color (color display)
  (if display
      (cond
       ((eq color 'bg-3) (if my-solarized-dark? "#002b36" "#fdf6e3"))
       ((eq color 'bg-2) (if my-solarized-dark? "#073642" "#eee8d5"))
       ((eq color 'bg-1) (if my-solarized-dark? "#586e75" "#93a1a1"))
       ((eq color 'bg-0) (if my-solarized-dark? "#657b83" "#839496"))
       ((eq color 'fg-0) (if my-solarized-dark? "#839496" "#657b83"))
       ((eq color 'fg-1) (if my-solarized-dark? "#93a1a1" "#586e75"))
       ((eq color 'fg-2) (if my-solarized-dark? "#eee8d5" "#073642"))
       ((eq color 'fg-3) (if my-solarized-dark? "#fdf6e3" "#002b36"))
       ((eq color 'yellow-d) (if my-solarized-dark? "#7b6000" "#deb542"))
       ((eq color 'yellow) "#b58900")
       ((eq color 'yellow-l) (if my-solarized-dark? "#deb542" "#7b6000"))
       ((eq color 'orange-d) (if my-solarized-dark? "#8b2c02" "#f2804f"))
       ((eq color 'orange) "#cb4b16")
       ((eq color 'orange-l) (if my-solarized-dark? "#f2804f" "#8b2c02"))
       ((eq color 'red-d) (if my-solarized-dark? "#990a1b" "#ff6e64"))
       ((eq color 'red) "#dc322f")
       ((eq color 'red-l) (if my-solarized-dark? "#ff6e64" "#990a1b"))
       ((eq color 'magenta-d) (if my-solarized-dark? "#93115c" "#f771ac"))
       ((eq color 'magenta) "#d33682")
       ((eq color 'magenta-l) (if my-solarized-dark? "#f771ac" "#93115c"))
       ((eq color 'violet-d) (if my-solarized-dark? "#3f4d91" "#9ea0e5"))
       ((eq color 'violet) "#6c71c4")
       ((eq color 'violet-l) (if my-solarized-dark? "#9ea0e5" "#3f4d91"))
       ((eq color 'blue-d) (if my-solarized-dark? "#00629d" "#69b7f0"))
       ((eq color 'blue) "#268bd2")
       ((eq color 'blue-l) (if my-solarized-dark? "#69b7f0" "#00629d"))
       ((eq color 'cyan-d) (if my-solarized-dark? "#00736f" "#69cabf"))
       ((eq color 'cyan) "#2aa198")
       ((eq color 'cyan-l) (if my-solarized-dark? "#69cabf" "#00736f"))
       ((eq color 'green-d) (if my-solarized-dark? "#546e00" "#b4c342"))
       ((eq color 'green) "#859900")
       ((eq color 'green-l) (if my-solarized-dark? "#b4c342" "#546e00")))
    (cond
     ((eq color 'bg-3) (if my-solarized-dark? "brightblack" "brightwhite"))
     ((eq color 'bg-2) (if my-solarized-dark? "black" "white"))
     ((eq color 'bg-1) (if my-solarized-dark? "brightgreen" "brightcyan"))
     ((eq color 'bg-0) (if my-solarized-dark? "brightyellow" "brightblue"))
     ((eq color 'fg-0) (if my-solarized-dark? "brightblue" "brightyellow"))
     ((eq color 'fg-1) (if my-solarized-dark? "brightcyan" "brightgreen"))
     ((eq color 'fg-2) (if my-solarized-dark? "white" "black"))
     ((eq color 'fg-3) (if my-solarized-dark? "brightwhite" "brightblack"))
     ((eq color 'yellow-d) (if my-solarized-dark? "yellow" "black"))
     ((eq color 'yellow) "yellow")
     ((eq color 'yellow-l) (if my-solarized-dark? "white" "yellow"))
     ((eq color 'orange-d) (if my-solarized-dark? "brightred" "black"))
     ((eq color 'orange) "brightred")
     ((eq color 'orange-l) (if my-solarized-dark? "white" "brightred"))
     ((eq color 'red-d) (if my-solarized-dark? "red" "black"))
     ((eq color 'red) "red")
     ((eq color 'red-l) (if my-solarized-dark? "white" "red"))
     ((eq color 'magenta-d) (if my-solarized-dark? "magenta" "black"))
     ((eq color 'magenta) "magenta")
     ((eq color 'magenta-l) (if my-solarized-dark? "white" "magenta"))
     ((eq color 'violet-d) (if my-solarized-dark? "brightmagenta" "black"))
     ((eq color 'violet) "brightmagenta")
     ((eq color 'violet-l) (if my-solarized-dark? "white" "brightmagenta"))
     ((eq color 'blue-d) (if my-solarized-dark? "blue" "black"))
     ((eq color 'blue) "blue")
     ((eq color 'blue-l) (if my-solarized-dark? "white" "blue"))
     ((eq color 'cyan-d) (if my-solarized-dark? "cyan" "black"))
     ((eq color 'cyan) "cyan")
     ((eq color 'cyan-l) (if my-solarized-dark? "white" "cyan"))
     ((eq color 'green-d) (if my-solarized-dark? "green" "black"))
     ((eq color 'green) "green")
     ((eq color 'green-l) (if my-solarized-dark? "white" "green")))))

(defun my-apply-faces (faces)
  "Helper function that sets the faces of the theme to a list of FACES.
See `my-transform-face' for the transformation, see
`my-transform-spec' for the rules."
  (apply #'custom-theme-set-faces 'my-solarized
         (mapcar #'my-transform-face faces)))

(defun my-transform-face (face)
  "Helper function that transforms a FACE to all variants.
FACE is a list where the first element is the name of the
affected face and the remaining elements specify the face
attributes which are transformed into face attributes for both
graphical and terminal displays. See `my-transform-spec' for the
rules that are applied to the face attributes."
  (let* ((name (car face))
         (spec (cdr face))
         (graphic-spec (my-transform-spec spec t))
         (tty-spec (my-transform-spec spec nil)))
    `(,name ((((type graphic)) ,@graphic-spec)
             (((type tty)) ,@tty-spec)))))

(defun my-transform-spec (spec display)
  "Helper function that transforms SPEC for DISPLAY.
DISPLAY is either t for graphic or nil for tty colors, SPEC is a
property list where the values are substituted with colors from
`my-solarized-colors' depending on DISPLAY for keys which are
either :foreground or :background. All other key-value
combinations remain unchanged."
  (let (output)
    (while spec
      (let* ((key (car spec))
             (value (cadr spec))
             (index (if display 1 2))
             (color (my-solarized-color value display)))
        (cond
         ((memq key '(:foreground :background :overline :color))
          (setq output (append output (list key color))))
         ((and (memq key '(:box :underline)) (listp value))
          (setq output (append output
                               (list key (my-transform-spec value display)))))
                               ;; (list key (my-transform-spec-box value display)))))
         (t (setq output (append output (list key value))))))
      (setq spec (cddr spec)))
    output))

(my-apply-faces
 '((my-circe-greentext-face :foreground green)
   (my-circe-highlight-notification-face :foreground fg-2 :weight bold)
   (comint-highlight-input :foreground unspecified)
   (comint-highlight-prompt :foreground unspecified)
   (eyebrowse-mode-line-active :foreground fg-2)
   (hl-todo :foreground red :weight bold)

   ;; basic coloring
   (default :foreground fg-0 :background bg-3)
   (shadow :foreground bg-1)
   (match :background bg-2 :foreground fg-1 :weight bold)
   (cursor :background fg-2)
   (mouse :foreground bg-3 :background fg-0 :inverse-video t)
   (escape-glyph-face :foreground red)
   (fringe :foreground fg-0 :background bg-2)
   (highlight :background bg-2 )
   (link :foreground yellow :underline t :weight bold)
   (link-visited :foreground yellow :underline t :weight normal)
   (success :foreground green )
   (warning :foreground yellow )
   (error :foreground orange)
   (lazy-highlight :foreground bg-3 :background yellow :weight normal)
   (escape-glyph :foreground violet)
   (tooltip :foreground fg-0 :background bg-3)

   ;; compilation
   (compilation-column-face :foreground cyan :underline nil)
   (compilation-column-number :inherit font-lock-doc-face :foreground cyan :underline nil)
   (compilation-enter-directory-face :foreground green :underline nil)
   (compilation-error :inherit error :underline nil)
   (compilation-error-face :foreground red : :underline nil)
   (compilation-face :foreground fg-0 :underline nil)
   (compilation-info :foreground bg-1 :underline nil :bold nil)
   (compilation-info-face :foreground blue :underline nil)
   (compilation-leave-directory-face :foreground green :underline nil)
   (compilation-line-face :foreground green :underline nil)
   (compilation-line-number :foreground green :underline nil)
   (compilation-warning :inherit warning :underline nil)
   (compilation-warning-face :foreground yellow :weight normal :underline nil)

   (compilation-mode-line-exit :inherit compilation-info :foreground green :weight bold)
   (compilation-mode-line-fail :inherit compilation-error :foreground red :weight bold)
   (compilation-mode-line-run :foreground orange :weight bold)

   ;; dired
   (dired-directory :foreground blue :weight normal)
   (dired-flagged :foreground red)
   (dired-header :foreground bg-3 :background blue)
   (dired-ignored :inherit shadow)
   (dired-mark :foreground yellow :weight bold)
   (dired-marked :foreground magenta :weight bold)
   (dired-perm-write :foreground fg-0 :underline t)
   (dired-symlink :foreground cyan :weight normal :slant italic)
   (dired-warning :foreground orange :underline t)

   ;; ecb
   (ecb-default-highlight-face :background blue :foreground bg-3)
   (ecb-history-bucket-node-dir-soure-path-face :inherit ecb-history-bucket-node-face :foreground yellow)
   (ecb-source-in-directories-buffer-face :inherit ecb-directories-general-face :foreground fg-0)
   (ecb-history-dead-buffer-face :inherit ecb-history-general-face :foreground bg-1)
   (ecb-directory-not-accessible-face :inherit ecb-directories-general-face :foreground bg-1)
   (ecb-bucket-node-face :inherit ecb-default-general-face :weight normal :foreground blue)
   (ecb-tag-header-face :background bg-2)
   (ecb-analyse-bucket-element-face :inherit ecb-analyse-general-face :foreground green)
   (ecb-directories-general-face :inherit ecb-default-general-face :height 1.0)
   (ecb-method-non-semantic-face :inherit ecb-methods-general-face :foreground cyan)
   (ecb-mode-line-prefix-face :foreground green)
   (ecb-tree-guide-line-face :inherit ecb-default-general-face :foreground bg-2 :height 1.0)

   ;; grep
   (grep-context-face :foreground fg-0)
   (grep-error-face :foreground red :weight bold :underline t)
   (grep-hit-face :foreground blue)
   (grep-match-face :foreground orange :weight bold)

   ;; faces used by isearch
   (isearch :foreground bg-3 :background magenta :weight normal)
   (isearch-fail :foreground red :background bg-3 :weight bold)

   ;; makefile
   (makefile-space :background magenta)

   ;; man
   (Man-overstrike :foreground blue :weight bold)
   (Man-reverse :foreground orange)
   (Man-underline :foreground green :underline t)

   ;; misc faces
   (menu :foreground fg-0 :background bg-3)
   (minibuffer-prompt :foreground fg-0)
   (mode-line :foreground fg-0 :background bg-2 :box (:line-width -1 :color bg-2))
   (mode-line-buffer-id :foreground fg-1 :weight bold)
   ;; TODO does that work?
   (mode-line-highlight :box (:line-width -1))
   (mode-line-inactive :foreground bg-1 :background bg-3 :box (:line-width -1 :color bg-2))
   (header-line :foreground fg-1 :background bg-2 :box (:line-width -1 :color bg-2))
   (region :foreground bg-3 :background fg-1)
   (secondary-selection :background bg-2)

   (trailing-whitespace :background red)
   (vertical-border :foreground fg-0)

   ;; font lock
   (font-lock-builtin-face :foreground fg-0 :weight bold)
   (font-lock-comment-delimiter-face :foreground bg-1)
   (font-lock-comment-face :foreground bg-1)
   (font-lock-constant-face :foreground blue :weight bold)
   (font-lock-doc-face :foreground cyan)
   (font-lock-function-name-face :foreground blue)
   (font-lock-keyword-face :foreground green :weight bold)
   (font-lock-negation-char-face :foreground yellow :weight bold)
   (font-lock-preprocessor-face :foreground blue)
   (font-lock-regexp-grouping-construct :foreground yellow :weight bold)
   (font-lock-regexp-grouping-backslash :foreground green :weight bold)
   (font-lock-string-face :foreground cyan)
   (font-lock-type-face :foreground yellow)
   (font-lock-variable-name-face :foreground blue)
   (font-lock-warning-face :foreground orange :weight bold :underline t)

   (c-annotation-face :inherit font-lock-constant-face)

   ;;; external

   ;; ace-jump-mode
   (ace-jump-face-background :foreground bg-1 :background bg-3 :inverse-video nil)
   (ace-jump-face-foreground :foreground red :background bg-3 :inverse-video nil :weight bold)

   ;; auctex
   (font-latex-bold-face :inherit bold :foreground fg-1)
   (font-latex-doctex-documentation-face :background unspecified)
   (font-latex-doctex-preprocessor-face :inherit (font-latex-doctex-documentation-face font-lock-builtin-face font-lock-preprocessor-face))
   (font-latex-italic-face :inherit italic :foreground fg-1)
   (font-latex-math-face :foreground violet)
   (font-latex-sectioning-0-face :inherit fixed-pitch :weight bold :foreground yellow)
   (font-latex-sectioning-1-face :inherit fixed-pitch :weight bold :foreground yellow)
   (font-latex-sectioning-2-face :inherit fixed-pitch :weight bold :foreground yellow)
   (font-latex-sectioning-3-face :inherit fixed-pitch :weight bold :foreground yellow)
   (font-latex-sectioning-4-face :inherit fixed-pitch :weight bold :foreground yellow)
   (font-latex-sectioning-5-face :inherit fixed-pitch :weight bold :foreground yellow)
   (font-latex-sedate-face :foreground fg-1)
   (font-latex-slide-title-face :inherit fixed-pitch :weight bold)
   (font-latex-string-face :foreground cyan)
   (font-latex-verbatim-face :inherit fixed-pitch :foreground fg-0 :slant italic)
   (font-latex-warning-face :inherit bold :foreground orange)

   ;; auto-complete
   (ac-candidate-face :background bg-2 :foreground cyan)
   (ac-selection-face :background cyan-d :foreground cyan-l)
   (ac-candidate-mouse-face :background cyan-l :foreground cyan-d)
   (ac-completion-face :foreground fg-1 :underline t)
   (ac-gtags-candidate-face :background bg-2 :foreground blue)
   (ac-gtags-selection-face :background blue-d :foreground blue-l)
   (ac-yasnippet-candidate-face :background bg-2 :foreground yellow)
   (ac-yasnippet-selection-face :background yellow-d :foreground yellow-l)

   ;; calfw
   (cfw:face-day-title :background bg-2)
   (cfw:face-annotation :inherit cfw:face-day-title :foreground yellow)
   (cfw:face-default-content :foreground green)
   (cfw:face-default-day :inherit cfw:face-day-title :weight bold)
   (cfw:face-disable :inherit cfw:face-day-title :foreground bg-1)
   (cfw:face-grid :foreground bg-1)
   (cfw:face-header :foreground blue-l :background blue-d :weight bold)
   (cfw:face-holiday :background unspecified :foreground red :weight bold)
   (cfw:face-periods :foreground magenta)
   (cfw:face-select :background magenta-d :foreground magenta-l)
   (cfw:face-saturday :foreground cyan-l :background cyan-d)
   (cfw:face-sunday :foreground red-l :background red-d :weight bold)
   (cfw:face-title :inherit fixed-pitch :foreground yellow :weight bold)
   (cfw:face-today :weight bold :background bg-2 :foreground unspecified)
   (cfw:face-today-title :background yellow-d :foreground yellow-l :weight bold)
   (cfw:face-toolbar :background bg-2 :foreground fg-0)
   (cfw:face-toolbar-button-off :background yellow-d :foreground yellow-l :weight bold)
   (cfw:face-toolbar-button-on :background yellow-l :foreground yellow-d :weight bold)

   ;; circe
   (lui-irc-colors-bg-0-face :background fg-2)
   (lui-irc-colors-bg-1-face :background bg-2)
   (lui-irc-colors-bg-2-face :background blue-d)
   (lui-irc-colors-bg-3-face :background green-d)
   (lui-irc-colors-bg-4-face :background red-d)
   (lui-irc-colors-bg-5-face :background orange-d)
   (lui-irc-colors-bg-6-face :background violet-d)
   (lui-irc-colors-bg-7-face :background orange)
   (lui-irc-colors-bg-8-face :background yellow-d)
   (lui-irc-colors-bg-9-face :background green-l)
   (lui-irc-colors-bg-10-face :background cyan-d)
   (lui-irc-colors-bg-11-face :background cyan-l)
   (lui-irc-colors-bg-12-face :background blue-l)
   (lui-irc-colors-bg-13-face :background magenta)
   (lui-irc-colors-bg-14-face :background bg-1)
   (lui-irc-colors-bg-15-face :background fg-1)

   (lui-irc-colors-fg-0-face :foreground fg-2)
   (lui-irc-colors-fg-1-face :foreground bg-2)
   (lui-irc-colors-fg-2-face :foreground blue)
   (lui-irc-colors-fg-3-face :foreground green)
   (lui-irc-colors-fg-4-face :foreground red)
   (lui-irc-colors-fg-5-face :foreground orange-d)
   (lui-irc-colors-fg-6-face :foreground violet)
   (lui-irc-colors-fg-7-face :foreground orange)
   (lui-irc-colors-fg-8-face :foreground yellow)
   (lui-irc-colors-fg-9-face :foreground green-l)
   (lui-irc-colors-fg-10-face :foreground cyan)
   (lui-irc-colors-fg-11-face :foreground cyan-l)
   (lui-irc-colors-fg-12-face :foreground blue-l)
   (lui-irc-colors-fg-13-face :foreground magenta)
   (lui-irc-colors-fg-14-face :foreground bg-1)
   (lui-irc-colors-fg-15-face :foreground fg-1)

   (lui-button-face :foreground blue :underline t)
   (lui-highlight-face :foreground fg-2)
   (lui-time-stamp-face :foreground violet-d :weight bold)

   (circe-originator-face :foreground fg-2)
   (circe-prompt-face :foreground blue :background bg-3)
   (circe-server-face :foreground blue)
   (circe-highlight-nick-face :foreground fg-2 :weight bold)
   (circe-topic-diff-new-face :background green-d)
   (circe-topic-diff-removed-face :background red-d)
   (circe-fool-face :foreground bg-1)

   ;; clojure-test-mode
   (clojure-test-failure-face :foreground orange :weight bold :underline t)
   (clojure-test-error-face :foreground red :weight bold :underline t)
   (clojure-test-success-face :foreground green :weight bold :underline t)

   ;; company-mode
   (company-tooltip :background bg-2 :foreground cyan)
   (company-tooltip-annotation :background bg-2 :foreground cyan-l)
   (company-tooltip-selection :background cyan-d :foreground cyan-l)
   (company-tooltip-mouse :background cyan-l :foreground cyan-d)
   (company-tooltip-common :foreground cyan :background bg-2 :weight bold)
   (company-tooltip-common-selection :foreground cyan-l :background cyan-d :weight bold)
   (company-preview :background bg-2 :foreground cyan)
   (company-preview-common :foreground fg-1 :underline t)
   (company-echo-common :foreground red)
   (company-preview-search :foreground fg-0 :background blue-d)
   (company-scrollbar-bg :background cyan-l)
   (company-scrollbar-fg :background cyan-d)

   ;; cscope
   (cscope-file-face :foreground green :weight bold)
   (cscope-function-face :foreground blue)
   (cscope-line-number-face :foreground yellow)
   (cscope-line-face :foreground fg-0)
   (cscope-mouse-face :background blue :foreground fg-0)

   ;; ctable
   (ctbl:face-cell-select :background bg-2 :foreground fg-1 :underline fg-1 :weight bold)
   (ctbl:face-continue-bar :background bg-2 :foreground yellow)
   (ctbl:face-row-select :background bg-2 :foreground fg-0 :underline t)

   ;; coffee
   (coffee-mode-class-name :foreground yellow :weight bold)
   (coffee-mode-function-param :foreground violet :slant italic)

   ;; custom
   (custom-face-tag :inherit fixed-pitch :foreground violet :weight bold)
   (custom-variable-tag :inherit fixed-pitch :foreground cyan)
   (custom-comment-tag :foreground bg-1)
   (custom-group-tag :inherit fixed-pitch :foreground blue)
   (custom-group-tag-1 :inherit fixed-pitch :foreground red)
   (custom-state :foreground green)

   ;; diff
   (diff-added :foreground green :background bg-3)
   (diff-changed :foreground blue :background bg-3)
   (diff-removed :foreground red :background bg-3)
   (diff-header :background bg-3)
   (diff-file-header :background bg-3 :foreground fg-0 :weight bold)
   (diff-refine-added :foreground bg-3 :background green)
   (diff-refine-change :foreground bg-3 :background blue)
   (diff-refine-removed :foreground bg-3 :background red)

   ;; ediff
   (ediff-fine-diff-A :background orange-d)
   (ediff-fine-diff-B :background green-d)
   (ediff-fine-diff-C :background yellow-d)

   (ediff-current-diff-A :background orange-d)
   (ediff-current-diff-B :background green-d)
   (ediff-current-diff-C :background blue-d)

   (ediff-even-diff-A :background bg-1 :foreground fg-3)
   (ediff-odd-diff-A :background bg-1 :foreground bg-3)
   (ediff-even-diff-B :background bg-1 :foreground bg-3)
   (ediff-odd-diff-B :background bg-1 :foreground fg-3)
   (ediff-even-diff-C :background bg-1 :foreground fg-0 )
   (ediff-odd-diff-C :background bg-1 :foreground bg-3 )

   ;; enh-ruby-mode
   (enh-ruby-heredoc-delimiter-face :foreground cyan-l :weight bold)
   (enh-ruby-op-face :foreground violet)
   (enh-ruby-regexp-face :foreground cyan)
   (enh-ruby-regexp-delimiter-face :foreground cyan-l :weight bold)
   (enh-ruby-string-delimiter-face :foreground cyan)
   (erm-syn-errline :foreground red)
   (erm-syn-warnline :foreground orange)

   ;; diff-hl
   (diff-hl-change :background blue-d :foreground blue-l)
   (diff-hl-delete :background red-d :foreground red-l)
   (diff-hl-insert :background green-d :foreground green-l)
   (diff-hl-unknown :background cyan-d :foreground cyan-l)

   ;; elfeed
   (elfeed-search-date-face :foreground bg-1)
   (elfeed-search-feed-face :foreground bg-1)
   (elfeed-search-tag-face :foreground fg-0)
   (elfeed-search-title-face :foreground cyan)

   ;; epc
   (epc:face-title :foreground blue :background bg-3 :weight normal :underline nil)

   ;; eshell
   (eshell-prompt :foreground yellow :weight bold)
   (eshell-ls-archive :foreground red :weight bold)
   (eshell-ls-backup :inherit font-lock-comment-face)
   (eshell-ls-clutter :inherit font-lock-comment-face)
   (eshell-ls-directory :foreground blue :weight bold)
   (eshell-ls-executable :foreground red :weight bold)
   (eshell-ls-unreadable :foreground fg-0)
   (eshell-ls-missing :inherit font-lock-warning-face)
   (eshell-ls-product :inherit font-lock-doc-face)
   (eshell-ls-special :foreground yellow :weight bold)
   (eshell-ls-symlink :foreground cyan :weight bold)

   ;; fic
   (fic-author-face :background bg-3 :foreground orange :underline t :slant italic)
   (fic-face :background bg-3 :foreground orange :weight normal :slant italic)
   (font-lock-fic-face :background bg-3 :foreground orange :weight normal :slant italic)

   ;; flx
   (flx-highlight-face :foreground blue :weight normal :underline nil)

   ;; flymake
   (flymake-errline :underline (:style wave :color red))
   (flymake-infoline :underline (:style wave :color green))
   (flymake-warnline :underline (:style wave :color yellow))

   ;; flycheck
   (flycheck-error :underline (:style wave :color red))
   (flycheck-warning :underline (:style wave :color yellow))
   (flycheck-info :underline (:style wave :color blue))
   (flycheck-fringe-error :foreground red-l :weight bold)
   (flycheck-fringe-warning :foreground yellow-l :weight bold)
   (flycheck-fringe-info :foreground blue-l :weight bold)

   ;; flyspell
   (flyspell-duplicate :underline (:style wave :color yellow))
   (flyspell-incorrect :underline (:style wave :color red))

   ;; git-gutter
   (git-gutter:added :background green :foreground bg-3 :weight bold)
   (git-gutter:deleted :background red :foreground bg-3 :weight bold)
   (git-gutter:modified :background blue :foreground bg-3 :weight bold)
   (git-gutter:unchanged :background bg-2 :foreground bg-3 :weight bold)

   ;; git-gutter-fr
   (git-gutter-fr:added :foreground green  :weight bold)
   (git-gutter-fr:deleted :foreground red :weight bold)
   (git-gutter-fr:modified :foreground blue :weight bold)

   ;; git-gutter+ and git-gutter+-fr
   (git-gutter+-added :background green :foreground bg-3 :weight bold)
   (git-gutter+-deleted :background red :foreground bg-3 :weight bold)
   (git-gutter+-modified :background blue :foreground bg-3 :weight bold)
   (git-gutter+-unchanged :background bg-2 :foreground bg-3 :weight bold)
   (git-gutter-fr+-added :foreground green :weight bold)
   (git-gutter-fr+-deleted :foreground red :weight bold)
   (git-gutter-fr+-modified :foreground blue :weight bold)

   ;; guide-key
   (guide-key/highlight-command-face :foreground blue)
   (guide-key/key-face :foreground bg-1)
   (guide-key/prefix-command-face :foreground green)

   ;; helm (these probably need tweaking)
   (helm-apt-deinstalled :foreground bg-1)
   (helm-apt-installed :foreground green)
   (helm-bookmark-directory :inherit helm-ff-directory)
   (helm-bookmark-file :foreground fg-0)
   (helm-bookmark-gnus :foreground cyan)
   (helm-bookmark-info :foreground green)
   (helm-bookmark-man :foreground violet)
   (helm-bookmark-w3m :foreground yellow)
   (helm-bookmarks-su :foreground orange)
   (helm-buffer-not-saved :foreground orange)
   (helm-buffer-saved-out :foreground red :background bg-3 :inverse-video t)
   (helm-buffer-size :foreground bg-1)
   (helm-candidate-number :background bg-2 :foreground fg-1 :bold t)
   (helm-ff-directory :background bg-3 :foreground blue)
   (helm-ff-executable :foreground green)
   (helm-ff-file :background bg-3 :foreground fg-0)
   (helm-ff-invalid-symlink :background bg-3 :foreground orange :slant italic)
   (helm-ff-prefix :background yellow :foreground bg-3)
   (helm-ff-symlink :foreground cyan)
   (helm-grep-file :foreground cyan :underline t)
   (helm-grep-finish :foreground green)
   (helm-grep-lineno :foreground orange)
   (helm-grep-match :inherit match)
   (helm-grep-running :foreground red)
   (helm-header :inherit header-line)
   (helm-lisp-completion-info :foreground fg-0)
   (helm-lisp-show-completion :foreground yellow  :background bg-2 :bold t)
   (helm-M-x-key :foreground orange :underline t)
   (helm-moccur-buffer :foreground cyan :underline t)
   (helm-match :inherit match)
   (match :background bg-2 :foreground fg-1 :weight bold)
   (helm-selection :background bg-2 :underline nil)
   (helm-selection-line :background bg-2 :foreground fg-1 :underline nil)
   (helm-separator :foreground red)
   (helm-source-header :family mono :weight bold :height 1.0 :background blue-d :foreground bg-3)
   (helm-time-zone-current :foreground green)
   (helm-time-zone-home :foreground red)
   (helm-visible-mark :background bg-3 :foreground magenta :bold t)

   ;; hi-lock-mode
   (hi-yellow :foreground yellow-d :background yellow-l)
   (hi-pink :foreground magenta-d :background magenta-l)
   (hi-green :foreground green-d :background green-l)
   (hi-blue :foreground blue-d :background blue-l)
   (hi-black-b :foreground fg-1 :background bg-3 :weight bold)
   (hi-blue-b :foreground blue-d :weight bold)
   (hi-green-b :foreground green-d :weight bold)
   (hi-red-b :foreground red :weight bold)
   (hi-black-hb :foreground fg-1 :background bg-3 :weight bold)

   ;; highlight-changes
   (highlight-changes :foreground orange)
   (highlight-changes-delete :foreground red :underline t)

   ;; highlight-indentation
   (highlight-indentation-face :background bg-2)
   (highlight-indentation-current-column-face:background bg-2)

   ;; hl-line-mode
   (hl-line :background bg-2)
   (hl-line-face :background bg-2)

   ;; hydra
   (hydra-face-red :foreground red :weight bold)
   (hydra-face-blue :foreground blue :weight bold)

   ;; ido-mode
   (ido-first-match :foreground yellow :weight normal)
   (ido-only-match :foreground bg-3 :background yellow :weight normal)
   (ido-subdir :foreground blue)
   (ido-incomplete-regexp :foreground red :weight bold )
   (ido-indicator :background red :foreground bg-3 :width condensed)
   (ido-virtual :foreground cyan)

   ;; js2-mode colors
   (js2-error :foreground red)
   (js2-external-variable :foreground orange)
   (js2-function-param :foreground green)
   (js2-instance-member :foreground magenta)
   (js2-jsdoc-html-tag-delimiter :foreground cyan)
   (js2-jsdoc-html-tag-name :foreground orange)
   (js2-jsdoc-tag :foreground cyan)
   (js2-jsdoc-type :foreground blue)
   (js2-jsdoc-value :foreground violet)
   (js2-magic-paren :underline t)
   (js2-private-function-call :foreground yellow)
   (js2-private-member :foreground blue)
   (js2-warning :underline (:color orange))

   ;; jedi
   (jedi:highlight-function-argument :inherit bold)

   ;; linum-mode
   (linum :foreground bg-1 :background bg-2)

   ;; magit
   (magit-section-title :foreground yellow :weight bold)
   (magit-branch :foreground orange :weight bold)
   (magit-diff-add :background unspecified :foreground green)
   (magit-diff-del :background unspecified :foreground red)
   (magit-item-highlight :background bg-2 :weight unspecified)
   (magit-log-author :foreground cyan)
   (magit-log-graph :foreground bg-1)
   (magit-log-head-label-bisect-bad :background red-l :foreground red-d :box (:line-width -1))
   (magit-log-head-label-bisect-good :background green-l :foreground green-d :box (:line-width -1))
   (magit-log-head-label-default :background bg-2 :box (:line-width -1))
   (magit-log-head-label-local :background blue-d :foreground blue-l :box (:line-width -1))
   (magit-log-head-label-patches :background red-d :foreground red-l :box (:line-width -1))
   (magit-log-head-label-remote :background green-d :foreground green-l :box (:line-width -1))
   (magit-log-head-label-tags :background yellow-d :foreground yellow-l :box (:line-width -1))
   (magit-log-sha1 :foreground yellow)

   ;; markdown-mode
   (markdown-header-face :foreground green)
   (markdown-header-face-1 :inherit markdown-header-face)
   (markdown-header-face-2 :inherit markdown-header-face)
   (markdown-header-face-3 :inherit markdown-header-face)
   (markdown-header-face-4 :inherit markdown-header-face)
   (markdown-header-face-5 :inherit markdown-header-face)
   (markdown-header-face-6 :inherit markdown-header-face)

   ;; message-mode
   (message-cited-text :foreground bg-1)
   (message-header-name :foreground bg-1)
   (message-header-other :foreground fg-0 :weight normal)
   (message-header-to :foreground fg-0 :weight normal)
   (message-header-cc :foreground fg-0 :weight normal)
   (message-header-newsgroups :foreground yellow :weight bold)
   (message-header-subject :foreground cyan :weight normal)
   (message-header-xheader :foreground cyan)
   (message-mml :foreground yellow :weight bold)
   (message-separator :foreground bg-1 :slant italic)

   ;; moccur
   (moccur-current-line-face :underline t)
   (moccur-edit-done-face :foreground bg-1 :background bg-3 :slant italic)
   (moccur-edit-face :background yellow :foreground bg-3)
   (moccur-edit-file-face :background bg-2)
   (moccur-edit-reject-face :foreground red)
   (moccur-face :background bg-2 :foreground fg-1 :weight bold)
   (search-buffers-face :background bg-2 :foreground fg-1 :weight bold)
   (search-buffers-header-face :background bg-2 :foreground yellow :weight bold)

   ;; mu4e
   (mu4e-cited-1-face :foreground green :slant italic :weight normal)
   (mu4e-cited-2-face :foreground blue :slant italic :weight normal)
   (mu4e-cited-3-face :foreground orange :slant italic :weight normal)
   (mu4e-cited-4-face :foreground yellow :slant italic :weight normal)
   (mu4e-cited-5-face :foreground cyan :slant italic :weight normal)
   (mu4e-cited-6-face :foreground green :slant italic :weight normal)
   (mu4e-cited-7-face :foreground blue :slant italic :weight normal)
   (mu4e-flagged-face :foreground magenta :weight bold)
   (mu4e-view-url-number-face :foreground yellow :weight normal)
   (mu4e-warning-face :foreground red :slant normal :weight bold)
   (mu4e-header-highlight-face :foreground unspecified :background bg-2 :weight normal)

   (mu4e-draft-face :inherit font-lock-string-face)
   (mu4e-footer-face :inherit font-lock-comment-face)
   (mu4e-forwarded-face :inherit font-lock-builtin-face :weight normal)
   (mu4e-header-face :inherit default)
   (mu4e-header-marks-face :inherit font-lock-preprocessor-face)
   (mu4e-header-title-face :inherit font-lock-type-face)
   (mu4e-highlight-face :inherit font-lock-pseudo-keyword-face :weight bold)
   (mu4e-moved-face :inherit font-lock-comment-face :slant italic)
   (mu4e-ok-face :inherit font-lock-comment-face :slant normal :weight bold)
   (mu4e-replied-face :inherit font-lock-builtin-face :weight normal)
   (mu4e-system-face :inherit font-lock-comment-face :slant italic)
   (mu4e-title-face :inherit font-lock-type-face :weight bold)
   (mu4e-trashed-face :inherit font-lock-comment-face :strike-through t)
   (mu4e-unread-face :inherit font-lock-keyword-face :weight bold)
   (mu4e-view-attach-number-face :inherit font-lock-variable-name-face :weight bold)
   (mu4e-view-contact-face :foreground fg-0  :weight normal)
   (mu4e-view-header-key-face :inherit message-header-name :weight normal)
   (mu4e-view-header-value-face :foreground cyan :weight normal :slant normal)
   (mu4e-view-link-face :inherit link)
   (mu4e-view-special-header-value-face :foreground blue :weight normal :underline nil)

   ;; nav
   (nav-face-heading :foreground yellow)
   (nav-face-button-num :foreground cyan)
   (nav-face-dir :foreground green)
   (nav-face-hdir :foreground red)
   (nav-face-file :foreground fg-0)
   (nav-face-hfile :foreground red)

   ;; org-mode
   (org-agenda-structure :foreground fg-1 :background bg-2 :weight bold :slant normal :inverse-video nil :underline nil :box (:line-width -1 :color bg-3))
   (org-agenda-calendar-event :foreground fg-1)
   (org-agenda-calendar-sexp :foreground fg-0 :slant italic)
   (org-agenda-date :foreground bg-1 :background bg-3 :weight normal :inverse-video nil :overline nil :slant normal :height 1.0 :box (:line-width -1 :color bg-3) t)
   (org-agenda-date-weekend :inherit org-agenda-date :inverse-video nil :background unspecified :foreground bg-1 :weight unspecified :underline t :overline nil :box unspecified t)
   (org-agenda-date-today :inherit org-agenda-date :inverse-video t :weight bold :underline unspecified :overline nil :box unspecified :foreground blue :background bg-3 t)
   (org-agenda-done :foreground bg-1 :slant italic t)
   (org-archived :foreground bg-1 :weight normal)
   (org-block :foreground bg-1)
   (org-block-begin-line :foreground bg-1 :slant italic)
   (org-checkbox :background bg-3 :foreground fg-0 )
   (org-code :foreground bg-1)
   (org-date :foreground blue :underline t)
   (org-done :weight bold :foreground green)
   (org-ellipsis :foreground bg-1)
   (org-formula :foreground yellow)
   (org-headline-done :foreground green)
   (org-hide :foreground bg-3)
   (org-level-1 :inherit fixed-pitch :foreground orange)
   (org-level-2 :inherit fixed-pitch :foreground green)
   (org-level-3 :inherit fixed-pitch :foreground blue)
   (org-level-4 :inherit fixed-pitch :foreground yellow)
   (org-level-5 :inherit fixed-pitch :foreground cyan)
   (org-level-6 :inherit fixed-pitch :foreground green)
   (org-level-7 :inherit fixed-pitch :foreground red)
   (org-level-8 :inherit fixed-pitch :foreground blue)
   (org-link :foreground yellow :underline t)
   (org-sexp-date :foreground violet)
   (org-scheduled :foreground green)
   (org-scheduled-previously :foreground cyan)
   (org-scheduled-today :foreground blue :weight normal)
   (org-special-keyword :foreground bg-1 :weight bold)
   (org-table :foreground green)
   (org-tag :weight bold)
   (org-time-grid :foreground bg-1)
   (org-todo :foreground red :weight bold)
   (org-upcoming-deadline :foreground yellow  :weight normal :underline nil)
   (org-warning :foreground orange :weight normal :underline nil)
   ;; org-habit (clear=blue ready=green alert=yellow overdue=red. future=lower contrast)
   (org-habit-clear-face :background blue-d :foreground blue-l)
   (org-habit-clear-future-face :background blue-d)
   (org-habit-ready-face :background green-d :foreground green)
   (org-habit-ready-future-face :background green-d)
   (org-habit-alert-face :background yellow :foreground yellow-d)
   (org-habit-alert-future-face :background yellow-d)
   (org-habit-overdue-face :background red :foreground red-d)
   (org-habit-overdue-future-face :background red-d)
   ;; latest additions
   (org-agenda-dimmed-todo-face :foreground bg-1)
   (org-agenda-restriction-lock :background yellow)
   (org-clock-overlay :background yellow)
   (org-column :background bg-2 :strike-through nil :underline nil :slant normal :weight normal :inherit default)
   (org-column-title :background bg-2 :underline t :weight bold)
   (org-date-selected :foreground red :inverse-video t)
   (org-document-info :foreground fg-0)
   (org-document-title :foreground fg-1  :weight bold)
   (org-drawer :foreground cyan)
   (org-footnote :foreground magenta :underline t)
   (org-latex-and-export-specials :foreground orange)
   (org-mode-line-clock-overrun :inherit mode-line :background red)

   ;; outline
   (outline-1 :inherit org-level-1)
   (outline-2 :inherit org-level-2)
   (outline-3 :inherit org-level-3)
   (outline-4 :inherit org-level-4)
   (outline-5 :inherit org-level-5)
   (outline-6 :inherit org-level-6)
   (outline-7 :inherit org-level-7)
   (outline-8 :inherit org-level-8)

   ;; popup
   (popup-face :background bg-2 :foreground fg-0)
   (popup-isearch-match :background yellow :foreground bg-3)
   (popup-menu-face :background bg-2 :foreground fg-0)
   (popup-menu-mouse-face :background blue :foreground fg-0)
   (popup-menu-selection-face :background magenta :foreground bg-3)
   (popup-scroll-bar-background-face :background bg-1)
   (popup-scroll-bar-foreground-face :background fg-1)
   (popup-tip-face :background bg-2 :foreground fg-0)

   ;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground cyan)
   (rainbow-delimiters-depth-2-face :foreground yellow)
   (rainbow-delimiters-depth-3-face :foreground blue)
   (rainbow-delimiters-depth-4-face :foreground orange)
   (rainbow-delimiters-depth-5-face :foreground green)
   (rainbow-delimiters-depth-6-face :foreground yellow)
   (rainbow-delimiters-depth-7-face :foreground blue)
   (rainbow-delimiters-depth-8-face :foreground orange)
   (rainbow-delimiters-depth-9-face :foreground green)
   (rainbow-delimiters-depth-10-face :foreground yellow)
   (rainbow-delimiters-depth-11-face :foreground blue)
   (rainbow-delimiters-depth-12-face :foreground orange)
   (rainbow-delimiters-unmatched-face
     :foreground fg-0 :background bg-3 :inverse-video t)

   ;; rst-mode
   (rst-level-1 :background bg-2 :foreground fg-0)
   (rst-level-2 :background bg-2 :foreground fg-0)
   (rst-level-3 :background bg-2 :foreground fg-0)
   (rst-level-4 :background bg-2 :foreground fg-0)
   (rst-level-5 :background bg-2 :foreground fg-0)
   (rst-level-6 :background bg-2 :foreground fg-0)

   ;; sh-mode
   (sh-quoted-exec :foreground violet :weight bold)
   (sh-escaped-newline :foreground yellow :weight bold)
   (sh-heredoc :foreground yellow :weight bold)

   ;; smart-mode-line
   (sml/global :foreground fg-0)
   (sml/modes :foreground fg-2 :weight bold)
   (sml/filename :foreground green :weight bold)
   (sml/prefix :foreground yellow :weight bold)
   (sml/read-only :foreground cyan)
   (sml/outside-modified :foreground fg-2 :background red)
   (sml/modified :foreground red :weight bold)
   (sml/charging :foreground green-d)
   (sml/discharging :foreground red-d)

   ;; smartparens
   (sp-pair-overlay-face :background bg-2)
   (sp-wrap-overlay-face :background bg-2)
   (sp-wrap-tag-overlay-face :background bg-2)
   (sp-show-pair-enclosing :inherit highlight)
   (sp-show-pair-match-face :foreground violet :background bg-3 :weight normal :inverse-video t)
   (sp-show-pair-mismatch-face :foreground red :background bg-3 :weight normal :inverse-video t)

   ;; show-paren
   (show-paren-match :foreground cyan :background bg-3 :weight normal :inverse-video t)
   (show-paren-mismatch :foreground red :background bg-3 :weight normal :inverse-video t)

   ;; mic-paren
   (paren-face-match :foreground cyan :background bg-3 :weight normal :inverse-video t)
   (paren-face-mismatch :foreground red :background bg-3 :weight normal :inverse-video t)
   (paren-face-no-match :foreground red :background bg-3 :weight normal :inverse-video t)

   ;; SLIME
   (slime-repl-inputed-output-face :foreground red)

   ;; speedbar
   (speedbar-button-face :inherit fixed-pitch :foreground bg-1)
   (speedbar-directory-face :inherit fixed-pitch :foreground blue)
   (speedbar-file-face :inherit fixed-pitch :foreground fg-0)
   (speedbar-highlight-face :inherit fixed-pitch :background bg-2)
   (speedbar-selected-face :inherit fixed-pitch :foreground yellow :underline t)
   (speedbar-separator-face :inherit fixed-pitch :background blue :foreground bg-3 :overline cyan-d)
   (speedbar-tag-face :inherit fixed-pitch :foreground green)

   ;; table
   (table-cell :foreground fg-0 :background bg-2)

   ;; term
   (term-color-black :foreground bg-3 :background bg-2)
   (term-color-red :foreground red :background red-d)
   (term-color-green :foreground green :background green-d)
   (term-color-yellow :foreground yellow :background yellow-d)
   (term-color-blue :foreground blue :background blue-d)
   (term-color-magenta :foreground magenta :background magenta-d)
   (term-color-cyan :foreground cyan :background cyan-d)
   (term-color-white :foreground bg-0 :background fg-0)
   (term-default-fg-color :inherit term-color-white)
   (term-default-bg-color :inherit term-color-black)

   ;; tuareg
   (tuareg-font-lock-governing-face :foreground magenta :weight bold)
   (tuareg-font-lock-multistage-face :foreground blue :background bg-2 :weight bold)
   (tuareg-font-lock-operator-face :foreground fg-1)
   (tuareg-font-lock-error-face :foreground yellow :background red :weight bold)
   (tuareg-font-lock-interactive-output-face :foreground cyan)
   (tuareg-font-lock-interactive-error-face :foreground red)

   ;; undo-tree
   (undo-tree-visualizer-default-face :foreground bg-1 :background bg-3)
   (undo-tree-visualizer-unmodified-face :foreground green)
   (undo-tree-visualizer-current-face :foreground blue :inverse-video t)
   (undo-tree-visualizer-active-branch-face :foreground fg-1 :background bg-3 :weight bold)
   (undo-tree-visualizer-register-face :foreground yellow)

   ;; volatile highlights
   (vhl/default-face :background green-d :foreground green-l)

   ;; web-mode
   (web-mode-builtin-face :foreground red)
   (web-mode-comment-face :foreground bg-1)
   (web-mode-constant-face :foreground blue :weight bold)
   (web-mode-current-element-highlight-face :underline unspecified :weight unspecified :background bg-2)
   (web-mode-css-at-rule-face :foreground violet :slant italic)
   (web-mode-css-pseudo-class-face :foreground green :slant italic)
   (web-mode-doctype-face :foreground bg-1 :slant italic :weight bold)
   (web-mode-folded-face :underline t)
   (web-mode-function-name-face :foreground blue)
   (web-mode-html-attr-name-face :foreground blue :slant normal)
   (web-mode-html-attr-value-face :foreground cyan :slant italic)
   (web-mode-html-tag-face :foreground green)
   (web-mode-keyword-face :foreground yellow :weight normal)
   (web-mode-preprocessor-face :foreground yellow :slant normal :weight unspecified)
   (web-mode-string-face :foreground cyan)
   (web-mode-type-face :foreground yellow)
   (web-mode-variable-name-face :foreground blue)
   (web-mode-warning-face :inherit font-lock-warning-face)
   (web-mode-block-attr-name-face :inherit web-mode-html-attr-name-face)
   (web-mode-block-attr-value-face :inherit web-mode-html-attr-value-face)
   (web-mode-block-comment-face :inherit web-mode-comment-face)
   (web-mode-block-control-face :inherit font-lock-preprocessor-face)
   (web-mode-block-face :background unspecified)
   (web-mode-block-string-face :inherit web-mode-string-face)
   (web-mode-comment-keyword-face :box (:line-width -1) :weight bold)
   (web-mode-css-color-face :inherit font-lock-builtin-face)
   (web-mode-css-function-face :inherit font-lock-builtin-face)
   (web-mode-css-priority-face :inherit font-lock-builtin-face)
   (web-mode-css-property-name-face :inherit font-lock-variable-name-face)
   (web-mode-css-selector-face :inherit font-lock-keyword-face)
   (web-mode-css-string-face :inherit web-mode-string-face)
   (web-mode-javascript-string-face :inherit web-mode-string-face)
   (web-mode-json-context-face :foreground violet)
   (web-mode-json-key-face :foreground violet)
   (web-mode-json-string-face :inherit web-mode-string-face)
   (web-mode-param-name-face :foreground fg-0)
   (web-mode-part-comment-face :inherit web-mode-comment-face)
   (web-mode-part-face :inherit web-mode-block-face)
   (web-mode-part-string-face :inherit web-mode-string-face)
   (web-mode-symbol-face :foreground yellow)
   (web-mode-whitespace-face :background red)

   ;; whitespace-mode
   (whitespace-space :background unspecified :foreground bg-1 :inverse-video unspecified :slant italic)
   (whitespace-hspace :background unspecified :foreground fg-1 :inverse-video unspecified)
   (whitespace-tab :background unspecified :foreground red :inverse-video unspecified :weight bold)
   (whitespace-newline :background unspecified :foreground bg-1 :inverse-video unspecified)
   (whitespace-trailing :background unspecified :foreground orange-d :inverse-video t)
   (whitespace-line :background unspecified :foreground magenta :inverse-video unspecified)
   (whitespace-space-before-tab :background red-d :foreground unspecified :inverse-video unspecified)
   (whitespace-indentation :background unspecified :foreground yellow :inverse-video unspecified :weight bold)
   (whitespace-empty :background unspecified :foreground red-d :inverse-video t)
   (whitespace-space-after-tab :background unspecified :foreground orange :inverse-video t :weight bold)

   ;; which-func-mode
   (which-func :foreground orange)

   ;; window-number-mode
   (window-number-face :foreground green)))

(custom-theme-set-variables
 'my-solarized
 ;; ansi-term
 `(ansi-color-names-vector [,(my-solarized-color 'bg-3 (display-graphic-p))
                            ,(my-solarized-color 'red (display-graphic-p))
                            ,(my-solarized-color 'green (display-graphic-p))
                            ,(my-solarized-color 'yellow (display-graphic-p))
                            ,(my-solarized-color 'blue (display-graphic-p))
                            ,(my-solarized-color 'magenta (display-graphic-p))
                            ,(my-solarized-color 'cyan (display-graphic-p))
                            ,(my-solarized-color 'fg-0 (display-graphic-p))])

 ;; compilation
 '(compilation-message-face 'default)

 ;; magit
 '(magit-use-overlays nil)

 ;; highlight-tail
 `(highlight-tail-colors '((,(my-solarized-color 'bg-2 (display-graphic-p)) . 0)
                           (,(my-solarized-color 'green-d (display-graphic-p)) . 20)
                           (,(my-solarized-color 'cyan-d (display-graphic-p)) . 30)
                           (,(my-solarized-color 'blue-d (display-graphic-p)) . 50)
                           (,(my-solarized-color 'yellow-d (display-graphic-p)) . 60)
                           (,(my-solarized-color 'orange-d (display-graphic-p)) . 70)
                           (,(my-solarized-color 'magenta-d (display-graphic-p)) . 85)
                           (,(my-solarized-color 'bg-2 (display-graphic-p)) . 100)))

 ;; org-mode
 `(org-todo-keyword-faces '(("DEAD" . (:foreground ,(my-solarized-color 'violet (display-graphic-p)) :weight bold)))))

(when (fboundp 'sml/set-face-color)
  (sml/set-face-color 'sml/active-foreground-color (my-solarized-color 'fg-0 (display-graphic-p)))
  (sml/set-face-color 'sml/active-background-color (my-solarized-color 'bg-2 (display-graphic-p)))
  (sml/set-face-color 'sml/inactive-foreground-color (my-solarized-color 'bg-1 (display-graphic-p)))
  (sml/set-face-color 'sml/inactive-background-color (my-solarized-color 'bg-3 (display-graphic-p))))

(provide-theme 'my-solarized)

;; Local Variables:
;; eval: (show-smartparens-mode -1)
;; eval: (rainbow-mode)
;; End:
