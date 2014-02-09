(deftheme wasa-solarized "Fork of bbatsov's dark solarized theme")

(let* ((base03    "#002b36")
       (base02    "#073642")
       (base01    "#586e75")
       (base00    "#657b83")
       (base0     "#839496")
       (base1     "#93a1a1")
       (base2     "#eee8d5")
       (base3     "#fdf6e3")
       (yellow-d  "#7b6000")
       (yellow    "#b58900")
       (yellow-l  "#deb542")
       (orange-d  "#8b2c02")
       (orange    "#cb4b16")
       (orange-l  "#f2804f")
       (red-d     "#990a1b")
       (red       "#dc322f")
       (red-l     "#ff6e64")
       (magenta-d "#93115c")
       (magenta   "#d33682")
       (magenta-l "#f771ac")
       (violet-d  "#3f4d91")
       (violet    "#6c71c4")
       (violet-l  "#9ea0e5")
       (blue-d    "#00629d")
       (blue      "#268bd2")
       (blue-l    "#69b7f0")
       (cyan-d    "#00736f")
       (cyan      "#2aa198")
       (cyan-l    "#69cabf")
       (green-d   "#546e00")
       (green     "#859900")
       (green-l   "#b4c342")

       (solarized-fg base0)
       (solarized-bg base03)
       (solarized-hl base02)
       (solarized-emph base1)
       (solarized-comments base01)

       (s-fringe-bg solarized-hl)
       (s-mode-line-fg solarized-fg)
       (s-mode-line-bg solarized-hl)
       (s-mode-line-buffer-id-fg solarized-emph)
       (s-mode-line-inactive-fg solarized-comments)
       (s-mode-line-inactive-bg solarized-bg)
       (s-mode-line-inactive-bc solarized-hl))

  (custom-theme-set-faces
   'wasa-solarized

   `(comint-highlight-input ((t (:inherit default))))
   `(helm-fkey-key-face ((t (:foreground ,red :weight bold))))
   `(helm-fkey-bracket-face ((t (:weight bold))))
   `(makefile-space ((t (:background ,magenta))))
   `(wasa-circe-highlight-notification-face ((t (:foreground ,base2 :weight bold))))
   `(circe-originator-face ((t (:foreground ,base2))))

   ;; basic coloring
   `(default ((t (:foreground ,solarized-fg :background ,solarized-bg))))
   `(shadow ((t (:foreground ,solarized-comments))))
   `(match ((t (:background ,solarized-hl :foreground ,solarized-emph :weight bold))))
   `(cursor ((t (:background ,base2))))
   `(mouse ((t (:foreground ,solarized-bg :background ,solarized-fg :inverse-video t))))
   `(escape-glyph-face ((t (:foreground ,red))))
   `(fringe ((t (:foreground ,solarized-fg :background ,s-fringe-bg))))
   `(highlight ((t (:background ,solarized-hl ))))
   `(link ((t (:foreground ,yellow :underline t :weight bold))))
   `(link-visited ((t (:foreground ,yellow :underline t :weight normal))))
   `(success ((t (:foreground ,green ))))
   `(warning ((t (:foreground ,yellow ))))
   `(error ((t (:foreground ,orange))))
   `(lazy-highlight ((t (:foreground ,solarized-bg :background ,yellow
                                          :weight normal))))
   `(escape-glyph ((t (:foreground ,violet))))
   `(tooltip ((t (:foreground ,solarized-fg :background ,solarized-bg))))

   ;; compilation
   `(compilation-column-face ((t (:foreground ,cyan :underline nil))))
   `(compilation-column-number ((t (:inherit font-lock-doc-face :foreground ,cyan
                                                  :underline nil))))
   `(compilation-enter-directory-face ((t (:foreground ,green :underline nil))))
   `(compilation-error ((t (:inherit error :underline nil))))
   `(compilation-error-face ((t (:foreground ,red : :underline nil))))
   `(compilation-face ((t (:foreground ,solarized-fg :underline nil))))
   `(compilation-info ((t (:foreground ,solarized-comments :underline nil :bold nil))))
   `(compilation-info-face ((t (:foreground ,blue :underline nil))))
   `(compilation-leave-directory-face ((t (:foreground ,green :underline nil))))
   `(compilation-line-face ((t (:foreground ,green :underline nil))))
   `(compilation-line-number ((t (:foreground ,green :underline nil))))
   `(compilation-warning ((t (:inherit warning :underline nil))))
   `(compilation-warning-face ((t (:foreground ,yellow :weight normal :underline nil))))

   `(compilation-mode-line-exit
     ((t (:inherit compilation-info :foreground ,green :weight bold))))
   `(compilation-mode-line-fail
     ((t (:inherit compilation-error :foreground ,red :weight bold))))
   `(compilation-mode-line-run ((t (:foreground ,orange :weight bold))))

   ;; dired
   `(dired-directory ((t (:foreground ,blue :weight normal))))
   `(dired-flagged ((t (:foreground ,red))))
   `(dired-header ((t (:foreground ,solarized-bg :background ,blue))))
   `(dired-ignored ((t (:inherit shadow))))
   `(dired-mark ((t (:foreground ,yellow :weight bold))))
   `(dired-marked ((t (:foreground ,magenta :weight bold))))
   `(dired-perm-write ((t (:foreground ,solarized-fg :underline t))))
   `(dired-symlink ((t (:foreground ,cyan :weight normal :slant italic))))
   `(dired-warning ((t (:foreground ,orange :underline t))))

   ;; ecb
   `(ecb-default-highlight-face ((t (:background ,blue :foreground ,solarized-bg))))
   `(ecb-history-bucket-node-dir-soure-path-face
     ((t (:inherit ecb-history-bucket-node-face :foreground ,yellow))))
   `(ecb-source-in-directories-buffer-face ((t (:inherit ecb-directories-general-face
                                                              :foreground ,solarized-fg))))
   `(ecb-history-dead-buffer-face ((t (:inherit ecb-history-general-face
                                                     :foreground ,solarized-comments))))
   `(ecb-directory-not-accessible-face ((t (:inherit ecb-directories-general-face
                                                          :foreground ,solarized-comments))))
   `(ecb-bucket-node-face ((t (:inherit ecb-default-general-face :weight normal
                                             :foreground ,blue))))
   `(ecb-tag-header-face ((t (:background ,solarized-hl))))
   `(ecb-analyse-bucket-element-face ((t (:inherit ecb-analyse-general-face
                                                        :foreground ,green))))
   `(ecb-directories-general-face ((t (:inherit ecb-default-general-face :height 1.0))))
   `(ecb-method-non-semantic-face ((t (:inherit ecb-methods-general-face
                                                     :foreground ,cyan))))
   `(ecb-mode-line-prefix-face ((t (:foreground ,green))))
   `(ecb-tree-guide-line-face ((t (:inherit ecb-default-general-face
                                                 :foreground ,solarized-hl :height 1.0))))

   ;; grep
   `(grep-context-face ((t (:foreground ,solarized-fg))))
   `(grep-error-face ((t (:foreground ,red :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,blue))))
   `(grep-match-face ((t (:foreground ,orange :weight bold))))

   ;; faces used by isearch
   `(isearch ((t (:foreground ,solarized-bg :background ,magenta :weight normal))))
   `(isearch-fail ((t (:foreground ,red :background ,solarized-bg :weight bold))))

   ;; man
   `(Man-overstrike ((t (:foreground ,blue :weight bold))))
   `(Man-reverse ((t (:foreground ,orange))))
   `(Man-underline ((t (:foreground ,green :underline t))))

   ;; misc faces
   `(menu ((t (:foreground ,solarized-fg :background ,solarized-bg))))
   `(minibuffer-prompt ((t (:foreground ,solarized-fg))))
   `(mode-line
     ((t (:foreground ,s-mode-line-fg :background ,s-mode-line-bg
                      :box (:line-width 1 :color ,s-mode-line-bg)))))
   `(mode-line-buffer-id ((t (:foreground ,s-mode-line-buffer-id-fg :weight bold))))
   `(mode-line-highlight ((t (:box (:style border)))))
   `(mode-line-inactive
     ((t (:foreground ,s-mode-line-inactive-fg :background ,s-mode-line-inactive-bg
                      :box (:line-width 1 :color ,s-mode-line-inactive-bc)))))
   `(header-line
     ((t (:foreground ,solarized-emph :background ,solarized-hl
                      :box (:line-width 1 :color ,solarized-hl)))))
   `(region ((t (:foreground ,solarized-bg :background ,solarized-emph))))
   `(secondary-selection ((t (:background ,solarized-hl))))

   `(trailing-whitespace ((t (:background ,red))))
   `(vertical-border ((t (:foreground ,solarized-fg))))

   ;; font lock
   `(font-lock-builtin-face ((t (:foreground ,solarized-fg :weight bold))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,solarized-comments))))
   `(font-lock-comment-face ((t (:foreground ,solarized-comments))))
   `(font-lock-constant-face ((t (:foreground ,blue :weight bold))))
   `(font-lock-doc-face ((t (:foreground ,cyan))))
   `(font-lock-function-name-face ((t (:foreground ,blue))))
   `(font-lock-keyword-face ((t (:foreground ,green :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,yellow :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,blue))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,yellow :weight bold))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,green :weight bold))))
   `(font-lock-string-face ((t (:foreground ,cyan))))
   `(font-lock-type-face ((t (:foreground ,yellow))))
   `(font-lock-variable-name-face ((t (:foreground ,blue))))
   `(font-lock-warning-face ((t (:foreground ,orange :weight bold :underline t))))

   `(c-annotation-face ((t (:inherit font-lock-constant-face))))

;;; external

     ;; ace-jump-mode
     `(ace-jump-face-background
       ((t (:foreground ,solarized-comments :background ,solarized-bg
                             :inverse-video nil))))
     `(ace-jump-face-foreground
       ((t (:foreground ,red :background ,solarized-bg :inverse-video nil :weight bold))))

     ;; auctex
     `(font-latex-bold-face ((t (:inherit bold :foreground ,solarized-emph))))
     `(font-latex-doctex-documentation-face ((t (:background unspecified))))
     `(font-latex-doctex-preprocessor-face ((t
                                             (:inherit (font-latex-doctex-documentation-face
                                                        font-lock-builtin-face
                                                        font-lock-preprocessor-face)))))
     `(font-latex-italic-face ((t (:inherit italic :foreground ,solarized-emph))))
     `(font-latex-math-face ((t (:foreground ,violet))))
     `(font-latex-sectioning-0-face ((t (:inherit fixed-pitch :weight bold :foreground ,yellow))))
     `(font-latex-sectioning-1-face ((t (:inherit fixed-pitch :weight bold :foreground ,yellow))))
     `(font-latex-sectioning-2-face ((t (:inherit fixed-pitch :weight bold :foreground ,yellow))))
     `(font-latex-sectioning-3-face ((t (:inherit fixed-pitch :weight bold :foreground ,yellow))))
     `(font-latex-sectioning-4-face ((t (:inherit fixed-pitch :weight bold :foreground ,yellow))))
     `(font-latex-sectioning-5-face ((t (:inherit fixed-pitch :weight bold :foreground ,yellow))))
     `(font-latex-sedate-face ((t (:foreground ,solarized-emph))))
     `(font-latex-slide-title-face ((t (:inherit fixed-pitch :weight bold))))
     `(font-latex-string-face ((t (:foreground ,cyan))))
     `(font-latex-verbatim-face ((t (:inherit fixed-pitch :foreground ,solarized-fg
                                                   :slant italic))))
     `(font-latex-warning-face ((t (:inherit bold :foreground ,orange))))

     ;; auto-complete
     `(ac-candidate-face ((t (:background ,solarized-hl :foreground ,cyan))))
     `(ac-selection-face ((t (:background ,cyan-d :foreground ,cyan-l))))
     `(ac-candidate-mouse-face ((t (:background ,cyan-l :foreground ,cyan-d))))
     `(ac-completion-face ((t (:foreground ,solarized-emph :underline t))))
     `(ac-gtags-candidate-face ((t (:background ,solarized-hl :foreground ,blue))))
     `(ac-gtags-selection-face ((t (:background ,blue-d :foreground ,blue-l))))
     `(ac-yasnippet-candidate-face ((t (:background ,solarized-hl :foreground ,yellow))))
     `(ac-yasnippet-selection-face ((t (:background ,yellow-d :foreground ,yellow-l))))

     ;; calfw
     `(cfw:face-day-title ((t (:background ,solarized-hl))))
     `(cfw:face-annotation ((t (:inherit cfw:face-day-title :foreground ,yellow))))
     `(cfw:face-default-content ((t (:foreground ,green))))
     `(cfw:face-default-day ((t (:inherit cfw:face-day-title :weight bold))))
     `(cfw:face-disable ((t (:inherit cfw:face-day-title
                                           :foreground ,solarized-comments))))
     `(cfw:face-grid ((t (:foreground ,solarized-comments))))
     `(cfw:face-header ((t (:foreground ,blue-l :background ,blue-d :weight bold))))
     `(cfw:face-holiday ((t (:background nil :foreground ,red :weight bold))))
     `(cfw:face-periods ((t (:foreground ,magenta))))
     `(cfw:face-select ((t (:background ,magenta-d :foreground ,magenta-l))))
     `(cfw:face-saturday ((t (:foreground ,cyan-l :background ,cyan-d))))
     `(cfw:face-sunday ((t (:foreground ,red-l :background ,red-d :weight bold))))
     `(cfw:face-title ((t (:inherit fixed-pitch :foreground ,yellow :weight bold))))
     `(cfw:face-today ((t (:weight bold :background ,solarized-hl :foreground nil))))
     `(cfw:face-today-title ((t (:background ,yellow-d
                                                  :foreground ,yellow-l :weight bold))))
     `(cfw:face-toolbar ((t (:background ,solarized-hl :foreground ,solarized-fg))))
     `(cfw:face-toolbar-button-off ((t (:background ,yellow-d :foreground ,yellow-l
                                                         :weight bold))))
     `(cfw:face-toolbar-button-on ((t (:background ,yellow-l :foreground ,yellow-d
                                                        :weight bold))))

     ;; circe
     `(lui-irc-colors-bg-0-face ((t (:background ,base2))))
     `(lui-irc-colors-bg-1-face ((t (:background ,base02))))
     `(lui-irc-colors-bg-2-face ((t (:background ,blue-d))))
     `(lui-irc-colors-bg-3-face ((t (:background ,green-d))))
     `(lui-irc-colors-bg-4-face ((t (:background ,red-d))))
     `(lui-irc-colors-bg-5-face ((t (:background ,orange-d))))
     `(lui-irc-colors-bg-6-face ((t (:background ,violet-d))))
     `(lui-irc-colors-bg-7-face ((t (:background ,orange))))
     `(lui-irc-colors-bg-8-face ((t (:background ,yellow-d))))
     `(lui-irc-colors-bg-9-face ((t (:background ,green-l))))
     `(lui-irc-colors-bg-10-face ((t (:background ,cyan-d))))
     `(lui-irc-colors-bg-11-face ((t (:background ,cyan-l))))
     `(lui-irc-colors-bg-12-face ((t (:background ,blue-l))))
     `(lui-irc-colors-bg-13-face ((t (:background ,magenta))))
     `(lui-irc-colors-bg-14-face ((t (:background ,base01))))
     `(lui-irc-colors-bg-15-face ((t (:background ,base1))))

     `(lui-irc-colors-fg-0-face ((t (:foreground ,base2))))
     `(lui-irc-colors-fg-1-face ((t (:foreground ,base02))))
     `(lui-irc-colors-fg-2-face ((t (:foreground ,blue))))
     `(lui-irc-colors-fg-3-face ((t (:foreground ,green))))
     `(lui-irc-colors-fg-4-face ((t (:foreground ,red))))
     `(lui-irc-colors-fg-5-face ((t (:foreground ,orange-d))))
     `(lui-irc-colors-fg-6-face ((t (:foreground ,violet))))
     `(lui-irc-colors-fg-7-face ((t (:foreground ,orange))))
     `(lui-irc-colors-fg-8-face ((t (:foreground ,yellow))))
     `(lui-irc-colors-fg-9-face ((t (:foreground ,green-l))))
     `(lui-irc-colors-fg-10-face ((t (:foreground ,cyan))))
     `(lui-irc-colors-fg-11-face ((t (:foreground ,cyan-l))))
     `(lui-irc-colors-fg-12-face ((t (:foreground ,blue-l))))
     `(lui-irc-colors-fg-13-face ((t (:foreground ,magenta))))
     `(lui-irc-colors-fg-14-face ((t (:foreground ,base01))))
     `(lui-irc-colors-fg-15-face ((t (:foreground ,base1))))

     `(lui-button-face ((t (:foreground ,blue :underline t))))
     `(lui-highlight-face ((t (:foreground ,base2))))
     `(lui-time-stamp-face ((t (:foreground ,violet-d :weight bold))))

     `(circe-prompt-face ((t (:foreground ,blue :background ,solarized-bg))))
     `(circe-server-face ((t (:foreground ,blue))))
     `(circe-highlight-nick-face ((t (:foreground ,base2 :weight bold))))
     `(circe-topic-diff-new-face ((t (:background ,green-d))))
     `(circe-topic-diff-removed-face ((t (:background ,red-d))))
     `(circe-fool-face ((t (:foreground ,solarized-comments))))

     ;; clojure-test-mode
     `(clojure-test-failure-face ((t (:foreground ,orange :weight bold :underline t))))
     `(clojure-test-error-face ((t (:foreground ,red :weight bold :underline t))))
     `(clojure-test-success-face ((t (:foreground ,green :weight bold :underline t))))

     ;; company-mode
     `(company-tooltip ((t (:background ,solarized-hl :foreground ,cyan))))
     `(company-tooltip-selection ((t (:background ,cyan-d :foreground ,cyan-l))))
     `(company-tooltip-mouse ((t (:background ,cyan-l :foreground ,cyan-d))))
     `(company-tooltip-common ((t (:foreground ,cyan :background ,solarized-hl :weight bold))))
     `(company-tooltip-common-selection ((t (:foreground ,cyan-l :background ,cyan-d :weight bold))))
     `(company-preview ((t (:background ,solarized-hl :foreground ,cyan))))
     `(company-preview-common ((t (:foreground ,solarized-emph :underline t))))
     `(company-echo-common ((t (:foreground ,red))))
     `(company-preview-search ((t (:foreground ,solarized-fg :background ,blue-d))))
     `(company-scrollbar-bg ((t (:background ,cyan-l))))
     `(company-scrollbar-fg ((t (:background ,cyan-d))))

     ;; cscope
     `(cscope-file-face ((t (:foreground ,green :weight bold))))
     `(cscope-function-face ((t (:foreground ,blue))))
     `(cscope-line-number-face ((t (:foreground ,yellow))))
     `(cscope-line-face ((t (:foreground ,solarized-fg))))
     `(cscope-mouse-face ((t (:background ,blue :foreground ,solarized-fg))))

     ;; ctable
     `(ctbl:face-cell-select ((t (:background ,solarized-hl :foreground ,solarized-emph
                                                   :underline ,solarized-emph :weight bold))))
     `(ctbl:face-continue-bar ((t (:background ,solarized-hl :foreground ,yellow))))
     `(ctbl:face-row-select ((t (:background ,solarized-hl :foreground ,solarized-fg
                                                  :underline t))))

     ;; coffee
     `(coffee-mode-class-name ((t (:foreground ,yellow :weight bold))))
     `(coffee-mode-function-param ((t (:foreground ,violet :slant italic))))

     ;; custom
     `(custom-face-tag ((t (:inherit fixed-pitch :foreground ,violet :weight bold))))
     `(custom-variable-tag ((t (:inherit fixed-pitch :foreground ,cyan))))
     `(custom-comment-tag ((t (:foreground ,solarized-comments))))
     `(custom-group-tag ((t (:inherit fixed-pitch :foreground ,blue))))
     `(custom-group-tag-1 ((t (:inherit fixed-pitch :foreground ,red))))
     `(custom-state ((t (:foreground ,green))))

     ;; diff
     `(diff-added ((t (:foreground ,green :background ,solarized-bg))))
     `(diff-changed ((t (:foreground ,blue :background ,solarized-bg))))
     `(diff-removed ((t (:foreground ,red :background ,solarized-bg))))
     `(diff-header ((t (:background ,solarized-bg))))
     `(diff-file-header
       ((t (:background ,solarized-bg :foreground ,solarized-fg :weight bold))))
     `(diff-refine-added ((t :foreground ,solarized-bg :background ,green)))
     `(diff-refine-change ((t :foreground ,solarized-bg :background ,blue)))
     `(diff-refine-removed ((t (:foreground ,solarized-bg :background ,red))))

     ;; ediff
     `(ediff-fine-diff-A ((t (:background ,orange-d))))
     `(ediff-fine-diff-B ((t (:background ,green-d))))
     `(ediff-fine-diff-C ((t (:background ,yellow-d))))

     `(ediff-current-diff-C ((t (:background ,blue-d))))

     `(ediff-even-diff-A ((t (:background ,solarized-comments
                                               :foreground ,base3))))
     `(ediff-odd-diff-A ((t (:background ,solarized-comments
                                              :foreground ,base03))))
     `(ediff-even-diff-B ((t (:background ,solarized-comments
                                               :foreground ,base03))))
     `(ediff-odd-diff-B ((t (:background ,solarized-comments
                                              :foreground ,base3))))
     `(ediff-even-diff-C ((t (:background ,solarized-comments
                                               :foreground ,solarized-fg ))))
     `(ediff-odd-diff-C ((t (:background ,solarized-comments
                                              :foreground ,solarized-bg ))))

     ;; diff-hl
     `(diff-hl-change ((t (:background ,blue-d :foreground ,blue-l))))
     `(diff-hl-delete ((t (:background ,red-d :foreground ,red-l))))
     `(diff-hl-insert ((t (:background ,green-d :foreground ,green-l))))
     `(diff-hl-unknown ((t (:background ,cyan-d :foreground ,cyan-l))))

     ;; elfeed
     `(elfeed-search-date-face ((t (:foreground ,solarized-comments))))
     `(elfeed-search-feed-face ((t (:foreground ,solarized-comments))))
     `(elfeed-search-tag-face ((t (:foreground ,solarized-fg))))
     `(elfeed-search-title-face ((t (:foreground ,cyan))))

     ;; epc
     `(epc:face-title ((t (:foreground ,blue :background ,solarized-bg
                                            :weight normal :underline nil))))

     ;; eshell
     `(eshell-prompt ((t (:foreground ,yellow :weight bold))))
     `(eshell-ls-archive ((t (:foreground ,red :weight bold))))
     `(eshell-ls-backup ((t (:inherit font-lock-comment-face))))
     `(eshell-ls-clutter ((t (:inherit font-lock-comment-face))))
     `(eshell-ls-directory ((t (:foreground ,blue :weight bold))))
     `(eshell-ls-executable ((t (:foreground ,red :weight bold))))
     `(eshell-ls-unreadable ((t (:foreground ,solarized-fg))))
     `(eshell-ls-missing ((t (:inherit font-lock-warning-face))))
     `(eshell-ls-product ((t (:inherit font-lock-doc-face))))
     `(eshell-ls-special ((t (:foreground ,yellow :weight bold))))
     `(eshell-ls-symlink ((t (:foreground ,cyan :weight bold))))

     ;; fic
     `(fic-author-face ((t (:background ,solarized-bg :foreground ,orange
                                             :underline t :slant italic))))
     `(fic-face ((t (:background ,solarized-bg :foreground ,orange
                                      :weight normal :slant italic))))
     `(font-lock-fic-face ((t (:background ,solarized-bg :foreground ,orange
                                      :weight normal :slant italic))))

     ;; flx
     `(flx-highlight-face ((t (:foreground ,blue
                                                :weight normal :underline nil))))

     ;; flymake
     `(flymake-errline
       ((t :underline (:style wave :color ,red))))
     `(flymake-infoline
       ((t :underline (:style wave :color ,green))))
     `(flymake-warnline
       ((t :underline (:style wave :color ,yellow))))

     ;; flycheck
     `(flycheck-error
       ((t :underline (:style wave :color ,red))))
     `(flycheck-warning
       ((t :underline (:style wave :color ,yellow))))
     `(flycheck-info
       ((t :underline (:style wave :color ,blue))))
     `(flycheck-fringe-error
       ((t (:foreground ,red-l :weight bold))))
     `(flycheck-fringe-warning
       ((t (:foreground ,yellow-l :weight bold))))
     `(flycheck-fringe-info
       ((t (:foreground ,blue-l :weight bold))))

     ;; flyspell
     `(flyspell-duplicate ((t (:underline (:style wave :color ,yellow)))))
     `(flyspell-incorrect ((t (:underline (:style wave :color ,red)))))

     ;; git-gutter
     `(git-gutter:added ((t (:background ,green :foreground ,solarized-bg
                                              :weight bold))))
     `(git-gutter:deleted ((t (:background ,red :foreground ,solarized-bg
                                                :weight bold))))
     `(git-gutter:modified ((t (:background ,blue :foreground ,solarized-bg
                                                 :weight bold))))
     `(git-gutter:unchanged ((t (:background ,solarized-hl
                                                  :foreground ,solarized-bg
                                                  :weight bold))))

     ;; git-gutter-fr
     `(git-gutter-fr:added ((t (:foreground ,green  :weight bold))))
     `(git-gutter-fr:deleted ((t (:foreground ,red :weight bold))))
     `(git-gutter-fr:modified ((t (:foreground ,blue :weight bold))))

     ;; git-gutter+ and git-gutter+-fr
     `(git-gutter+-added ((t (:background ,green :foreground ,solarized-bg
                                               :weight bold))))
     `(git-gutter+-deleted ((t (:background ,red :foreground ,solarized-bg
                                                 :weight bold))))
     `(git-gutter+-modified ((t (:background ,blue :foreground ,solarized-bg
                                                  :weight bold))))
     `(git-gutter+-unchanged ((t (:background ,solarized-hl
                                                   :foreground ,solarized-bg
                                                   :weight bold))))
     `(git-gutter-fr+-added ((t (:foreground ,green  :weight bold))))
     `(git-gutter-fr+-deleted ((t (:foreground ,red :weight bold))))
     `(git-gutter-fr+-modified ((t (:foreground ,blue :weight bold))))

     ;; guide-key
     `(guide-key/highlight-command-face ((t (:foreground ,blue))))
     `(guide-key/key-face ((t (:foreground ,solarized-comments))))
     `(guide-key/prefix-command-face ((t (:foreground ,green))))

     ;; helm (these probably need tweaking)
     `(helm-apt-deinstalled ((t (:foreground ,solarized-comments))))
     `(helm-apt-installed ((t (:foreground ,green))))
     `(helm-bookmark-directory ((t (:inherit helm-ff-directory))))
     `(helm-bookmark-file ((t (:foreground ,solarized-fg))))
     `(helm-bookmark-gnus ((t (:foreground ,cyan))))
     `(helm-bookmark-info ((t (:foreground ,green))))
     `(helm-bookmark-man ((t (:foreground ,violet))))
     `(helm-bookmark-w3m ((t (:foreground ,yellow))))
     `(helm-bookmarks-su ((t (:foreground ,orange))))
     `(helm-buffer-not-saved ((t (:foreground ,orange))))
     `(helm-buffer-saved-out ((t (:foreground ,red :background ,solarized-bg
                                                   :inverse-video t))))
     `(helm-buffer-size ((t (:foreground ,solarized-comments))))
     `(helm-candidate-number ((t (:background ,solarized-hl :foreground ,solarized-emph
                                                   :bold t))))
     `(helm-ff-directory ((t (:background ,solarized-bg  :foreground ,blue))))
     `(helm-ff-executable ((t (:foreground ,green))))
     `(helm-ff-file ((t (:background ,solarized-bg :foreground ,solarized-fg))))
     `(helm-ff-invalid-symlink ((t (:background ,solarized-bg :foreground ,orange
                                                     :slant italic))))
     `(helm-ff-prefix ((t (:background ,yellow :foreground ,solarized-bg))))
     `(helm-ff-symlink ((t (:foreground ,cyan))))
     `(helm-grep-file ((t (:foreground ,cyan :underline t))))
     `(helm-grep-finish ((t (:foreground ,green))))
     `(helm-grep-lineno ((t (:foreground ,orange))))
     `(helm-grep-match ((t (:inherit match))))
     `(helm-grep-running ((t (:foreground ,red))))
     `(helm-header ((t (:inherit header-line))))
     `(helm-lisp-completion-info ((t (:foreground ,solarized-fg))))
     `(helm-lisp-show-completion ((t (:foreground ,yellow  :background ,solarized-hl
                                                       :bold t))))
     `(helm-M-x-key ((t (:foreground ,orange :underline t))))
     `(helm-moccur-buffer ((t (:foreground ,cyan :underline t))))
     `(helm-match ((t (:inherit match))))
     `(helm-selection ((t (:background ,solarized-hl :underline nil))))
     `(helm-selection-line ((t (:background ,solarized-hl :foreground ,solarized-emph
                                            :underline nil))))
     `(helm-separator ((t (:foreground ,red))))
     `(helm-source-header ((t (:family mono :weight bold :height 1.0
                                       :background ,blue-d :foreground ,solarized-bg))))
     `(helm-time-zone-current ((t (:foreground ,green))))
     `(helm-time-zone-home ((t (:foreground ,red))))
     `(helm-visible-mark ((t (:background ,solarized-bg :foreground ,magenta :bold t))))

     ;; hi-lock-mode
     `(hi-yellow ((t (:foreground ,yellow-d :background ,yellow-l))))
     `(hi-pink ((t (:foreground ,magenta-d :background ,magenta-l))))
     `(hi-green ((t (:foreground ,green-d :background ,green-l))))
     `(hi-blue ((t (:foreground ,blue-d :background ,blue-l))))
     `(hi-black-b ((t (:foreground ,solarized-emph :background ,solarized-bg
                                        :weight bold))))
     `(hi-blue-b ((t (:foreground ,blue-d :weight bold))))
     `(hi-green-b ((t (:foreground ,green-d :weight bold))))
     `(hi-red-b ((t (:foreground ,red :weight bold))))
     `(hi-black-hb ((t (:foreground ,solarized-emph :background ,solarized-bg
                                         :weight bold))))

     ;; highlight-changes
     `(highlight-changes ((t (:foreground ,orange))))
     `(highlight-changes-delete ((t (:foreground ,red :underline t))))

     ;; highlight-indentation
     `(highlight-indentation-face ((t (:background ,solarized-hl))))
     `(highlight-indentation-current-column-face((t (:background ,solarized-hl))))

     ;; hl-line-mode
     `(hl-line ((t (:background ,solarized-hl))))
     `(hl-line-face ((t (:background ,solarized-hl))))

     ;; ido-mode
     `(ido-first-match ((t (:foreground ,yellow :weight normal))))
     `(ido-only-match ((t (:foreground ,solarized-bg :background ,yellow :weight normal))))
     `(ido-subdir ((t (:foreground ,blue))))
     `(ido-incomplete-regexp ((t (:foreground ,red :weight bold ))))
     `(ido-indicator ((t (:background ,red :foreground ,solarized-bg :width condensed))))
     `(ido-virtual ((t (:foreground ,cyan))))

     ;; js2-mode colors
     `(js2-error ((t (:foreground ,red))))
     `(js2-external-variable ((t (:foreground ,orange))))
     `(js2-function-param ((t (:foreground ,green))))
     `(js2-instance-member ((t (:foreground ,magenta))))
     `(js2-jsdoc-html-tag-delimiter ((t (:foreground ,cyan))))
     `(js2-jsdoc-html-tag-name ((t (:foreground ,orange))))
     `(js2-jsdoc-tag ((t (:foreground ,cyan))))
     `(js2-jsdoc-type ((t (:foreground ,blue))))
     `(js2-jsdoc-value ((t (:foreground ,violet))))
     `(js2-magic-paren ((t (:underline t))))
     `(js2-private-function-call ((t (:foreground ,yellow))))
     `(js2-private-member ((t (:foreground ,blue))))
     `(js2-warning ((t (:underline ,orange))))

     ;; jedi
     `(jedi:highlight-function-argument ((t (:inherit bold))))

     ;; linum-mode
     `(linum ((t (:foreground ,solarized-comments :background ,s-fringe-bg))))

     ;; magit
     `(magit-section-title ((t (:foreground ,yellow :weight bold))))
     `(magit-branch ((t (:foreground ,orange :weight bold))))
     `(magit-item-highlight ((t (:background ,solarized-hl :weight unspecified))))
     `(magit-log-author ((t (:foreground ,cyan))))
     `(magit-log-graph ((t (:foreground ,solarized-comments))))
     `(magit-log-head-label-bisect-bad ((t (:background ,red-l :foreground ,red-d
                                                             :box 1))))
     `(magit-log-head-label-bisect-good ((t (:background ,green-l :foreground ,green-d
                                                              :box 1))))
     `(magit-log-head-label-default ((t (:background ,solarized-hl :box 1))))
     `(magit-log-head-label-local ((t (:background ,blue-d :foreground ,blue-l
                                                        :box 1))))
     `(magit-log-head-label-patches ((t (:background ,red-d :foreground ,red-l
                                                          :box 1))))
     `(magit-log-head-label-remote ((t (:background ,green-d :foreground ,green-l
                                                         :box 1))))
     `(magit-log-head-label-tags ((t (:background ,yellow-d :foreground ,yellow-l
                                                       :box 1))))
     `(magit-log-sha1 ((t (:foreground ,yellow))))

     ;; markdown-mode
     `(markdown-header-face ((t (:foreground ,green))))
     `(markdown-header-face-1 ((t (:inherit markdown-header-face))))
     `(markdown-header-face-2 ((t (:inherit markdown-header-face))))
     `(markdown-header-face-3 ((t (:inherit markdown-header-face))))
     `(markdown-header-face-4 ((t (:inherit markdown-header-face))))
     `(markdown-header-face-5 ((t (:inherit markdown-header-face))))
     `(markdown-header-face-6 ((t (:inherit markdown-header-face))))

     ;; message-mode
     `(message-cited-text ((t (:foreground ,solarized-comments))))
     `(message-header-name ((t (:foreground ,solarized-comments))))
     `(message-header-other ((t (:foreground ,solarized-fg :weight normal))))
     `(message-header-to ((t (:foreground ,solarized-fg :weight normal))))
     `(message-header-cc ((t (:foreground ,solarized-fg :weight normal))))
     `(message-header-newsgroups ((t (:foreground ,yellow :weight bold))))
     `(message-header-subject ((t (:foreground ,cyan :weight normal))))
     `(message-header-xheader ((t (:foreground ,cyan))))
     `(message-mml ((t (:foreground ,yellow :weight bold))))
     `(message-separator ((t (:foreground ,solarized-comments :slant italic))))

     ;; moccur
     `(moccur-current-line-face ((t (:underline t))))
     `(moccur-edit-done-face ((t
                               (:foreground ,solarized-comments
                                            :background ,solarized-bg
                                            :slant italic))))
     `(moccur-edit-face
       ((t (:background ,yellow :foreground ,solarized-bg))))
     `(moccur-edit-file-face ((t (:background ,solarized-hl))))
     `(moccur-edit-reject-face ((t (:foreground ,red))))
     `(moccur-face ((t (:background ,solarized-hl :foreground ,solarized-emph
                                         :weight bold))))
     `(search-buffers-face ((t (:background ,solarized-hl :foreground ,solarized-emph
                                                 :weight bold))))
     `(search-buffers-header-face ((t (:background ,solarized-hl :foreground ,yellow
                                                        :weight bold))))

     ;; mu4e
     `(mu4e-cited-1-face ((t (:foreground ,green :slant italic :weight normal))))
     `(mu4e-cited-2-face ((t (:foreground ,blue :slant italic :weight normal))))
     `(mu4e-cited-3-face ((t (:foreground ,orange :slant italic :weight normal))))
     `(mu4e-cited-4-face ((t (:foreground ,yellow :slant italic :weight normal))))
     `(mu4e-cited-5-face ((t (:foreground ,cyan :slant italic :weight normal))))
     `(mu4e-cited-6-face ((t (:foreground ,green :slant italic :weight normal))))
     `(mu4e-cited-7-face ((t (:foreground ,blue :slant italic :weight normal))))
     `(mu4e-flagged-face ((t (:foreground ,magenta :weight bold))))
     `(mu4e-view-url-number-face ((t (:foreground ,yellow :weight normal))))
     `(mu4e-warning-face ((t (:foreground ,red :slant normal :weight bold))))
     `(mu4e-header-highlight-face
       ((t (:inherit unspecified :foreground unspecified :background ,solarized-hl
                          ;:underline ,solarized-emph  :weight normal))))
                          :weight normal))))

     ;; `(mu4e-draft-face ((t (:inherit font-lock-string-face))))
     ;; `(mu4e-footer-face ((t (:inherit font-lock-comment-face))))
     ;; `(mu4e-forwarded-face ((t (:inherit font-lock-builtin-face :weight normal))))
     ;; `(mu4e-header-face ((t (:inherit default))))
     ;; `(mu4e-header-marks-face ((t (:inherit font-lock-preprocessor-face))))
     ;; `(mu4e-header-title-face ((t (:inherit font-lock-type-face))))
     ;; `(mu4e-highlight-face ((t (:inherit font-lock-pseudo-keyword-face :weight bold))))
     ;; `(mu4e-moved-face ((t (:inherit font-lock-comment-face :slant italic))))
     ;; `(mu4e-ok-face ((t (:inherit font-lock-comment-face :slant normal :weight bold))))
     ;; `(mu4e-replied-face ((t (:inherit font-lock-builtin-face :weight normal))))
     ;; `(mu4e-system-face ((t (:inherit font-lock-comment-face :slant italic))))
     ;; `(mu4e-title-face ((t (:inherit font-lock-type-face :weight bold))))
     ;; `(mu4e-trashed-face ((t (:inherit font-lock-comment-face :strike-through t))))
     ;; `(mu4e-unread-face ((t (:inherit font-lock-keyword-face :weight bold))))
     ;; `(mu4e-view-attach-number-face ((t (:inherit font-lock-variable-name-face :weight bold))))
     `(mu4e-view-contact-face ((t (:foreground ,solarized-fg  :weight normal))))
     `(mu4e-view-header-key-face ((t (:inherit message-header-name :weight normal))))
     `(mu4e-view-header-value-face ((t (:foreground ,cyan :weight normal :slant normal))))
     `(mu4e-view-link-face ((t (:inherit link))))
     `(mu4e-view-special-header-value-face ((t (:foreground ,blue :weight normal :underline nil
                                                                 ))))

     ;; nav
     `(nav-face-heading ((t (:foreground ,yellow))))
     `(nav-face-button-num ((t (:foreground ,cyan))))
     `(nav-face-dir ((t (:foreground ,green))))
     `(nav-face-hdir ((t (:foreground ,red))))
     `(nav-face-file ((t (:foreground ,solarized-fg))))
     `(nav-face-hfile ((t (:foreground ,red))))

     ;; org-mode
     `(org-agenda-structure
       ((t (:foreground ,solarized-emph :background ,solarized-hl
                             :weight bold :slant normal :inverse-video nil
                             :underline nil
                             :box (:line-width 2 :color ,solarized-bg)))))
     `(org-agenda-calendar-event ((t (:foreground ,solarized-emph))))
     `(org-agenda-calendar-sexp ((t (:foreground ,solarized-fg :slant italic))))
     `(org-agenda-date
       ((t (:foreground ,solarized-comments :background ,solarized-bg :weight normal
                             :inverse-video nil :overline nil :slant normal :height 1.0
                             :box (:line-width 2 :color ,solarized-bg)))) t)
     `(org-agenda-date-weekend
       ((t (:inherit org-agenda-date :inverse-video nil :background unspecified
                          :foreground ,solarized-comments :weight unspecified
                          :underline t :overline nil :box unspecified))) t)
     `(org-agenda-date-today
       ((t (:inherit org-agenda-date :inverse-video t :weight bold
                          :underline unspecified :overline nil :box unspecified
                          :foreground ,blue :background ,solarized-bg))) t)
     `(org-agenda-done ((t (:foreground ,solarized-comments :slant italic))) t)
     `(org-archived ((t (:foreground ,solarized-comments :weight normal))))
     `(org-block ((t (:foreground ,solarized-comments))))
     `(org-block-begin-line ((t (:foreground ,solarized-comments :slant italic))))
     `(org-checkbox ((t (:background ,solarized-bg :foreground ,solarized-fg ))))
     `(org-code ((t (:foreground ,solarized-comments))))
     `(org-date ((t (:foreground ,blue :underline t))))
     `(org-done ((t (:weight bold :foreground ,green))))
     `(org-ellipsis ((t (:foreground ,solarized-comments))))
     `(org-formula ((t (:foreground ,yellow))))
     `(org-headline-done ((t (:foreground ,green))))
     `(org-hide ((t (:foreground ,solarized-bg))))
     `(org-level-1 ((t (:inherit fixed-pitch :foreground ,orange))))
     `(org-level-2 ((t (:inherit fixed-pitch :foreground ,green))))
     `(org-level-3 ((t (:inherit fixed-pitch :foreground ,blue))))
     `(org-level-4 ((t (:inherit fixed-pitch :foreground ,yellow))))
     `(org-level-5 ((t (:inherit fixed-pitch :foreground ,cyan))))
     `(org-level-6 ((t (:inherit fixed-pitch :foreground ,green))))
     `(org-level-7 ((t (:inherit fixed-pitch :foreground ,red))))
     `(org-level-8 ((t (:inherit fixed-pitch :foreground ,blue))))
     `(org-link ((t (:foreground ,yellow :underline t))))
     `(org-sexp-date ((t (:foreground ,violet))))
     `(org-scheduled ((t (:foreground ,green))))
     `(org-scheduled-previously ((t (:foreground ,cyan))))
     `(org-scheduled-today ((t (:foreground ,blue :weight normal))))
     `(org-special-keyword ((t (:foreground ,solarized-comments :weight bold))))
     `(org-table ((t (:foreground ,green))))
     `(org-tag ((t (:weight bold))))
     `(org-time-grid ((t (:foreground ,solarized-comments))))
     `(org-todo ((t (:foreground ,red :weight bold))))
     `(org-upcoming-deadline ((t (:foreground ,yellow  :weight normal :underline nil))))
     `(org-warning ((t (:foreground ,orange :weight normal :underline nil))))
     ;; org-habit (clear=blue, ready=green, alert=yellow, overdue=red. future=lower contrast)
     `(org-habit-clear-face ((t (:background ,blue-d :foreground ,blue-l))))
     `(org-habit-clear-future-face ((t (:background ,blue-d))))
     `(org-habit-ready-face ((t (:background ,green-d :foreground ,green))))
     `(org-habit-ready-future-face ((t (:background ,green-d))))
     `(org-habit-alert-face ((t (:background ,yellow :foreground ,yellow-d))))
     `(org-habit-alert-future-face ((t (:background ,yellow-d))))
     `(org-habit-overdue-face ((t (:background ,red :foreground ,red-d))))
     `(org-habit-overdue-future-face ((t (:background ,red-d))))
     ;; latest additions
     `(org-agenda-dimmed-todo-face ((t (:foreground ,solarized-comments))))
     `(org-agenda-restriction-lock ((t (:background ,yellow))))
     `(org-clock-overlay ((t (:background ,yellow))))
     `(org-column ((t (:background ,solarized-hl :strike-through nil
                                        :underline nil :slant normal :weight normal :inherit default))))
     `(org-column-title ((t (:background ,solarized-hl :underline t :weight bold))))
     `(org-date-selected ((t (:foreground ,red :inverse-video t))))
     `(org-document-info ((t (:foreground ,solarized-fg))))
     `(org-document-title ((t (:foreground ,solarized-emph  :weight bold))))
     `(org-drawer ((t (:foreground ,cyan))))
     `(org-footnote ((t (:foreground ,magenta :underline t))))
     `(org-latex-and-export-specials ((t (:foreground ,orange))))
     `(org-mode-line-clock-overrun ((t (:inherit mode-line :background ,red))))

     ;; outline
     `(outline-1 ((t (:inherit org-level-1))))
     `(outline-2 ((t (:inherit org-level-2))))
     `(outline-3 ((t (:inherit org-level-3))))
     `(outline-4 ((t (:inherit org-level-4))))
     `(outline-5 ((t (:inherit org-level-5))))
     `(outline-6 ((t (:inherit org-level-6))))
     `(outline-7 ((t (:inherit org-level-7))))
     `(outline-8 ((t (:inherit org-level-8))))

     ;; popup
     `(popup-face ((t (:background ,solarized-hl :foreground ,solarized-fg))))
     `(popup-isearch-match ((t (:background ,yellow :foreground ,solarized-bg))))
     `(popup-menu-face ((t (:background ,solarized-hl :foreground ,solarized-fg))))
     `(popup-menu-mouse-face ((t (:background ,blue :foreground ,solarized-fg))))
     `(popup-menu-selection-face ((t (:background ,magenta :foreground ,solarized-bg))))
     `(popup-scroll-bar-background-face ((t (:background ,solarized-comments))))
     `(popup-scroll-bar-foreground-face ((t (:background ,solarized-emph))))
     `(popup-tip-face ((t (:background ,solarized-hl :foreground ,solarized-fg))))

     ;; rainbow-delimiters
     `(rainbow-delimiters-depth-1-face ((t (:foreground ,cyan))))
     `(rainbow-delimiters-depth-2-face ((t (:foreground ,yellow))))
     `(rainbow-delimiters-depth-3-face ((t (:foreground ,blue))))
     `(rainbow-delimiters-depth-4-face ((t (:foreground ,orange))))
     `(rainbow-delimiters-depth-5-face ((t (:foreground ,green))))
     `(rainbow-delimiters-depth-6-face ((t (:foreground ,yellow))))
     `(rainbow-delimiters-depth-7-face ((t (:foreground ,blue))))
     `(rainbow-delimiters-depth-8-face ((t (:foreground ,orange))))
     `(rainbow-delimiters-depth-9-face ((t (:foreground ,green))))
     `(rainbow-delimiters-depth-10-face ((t (:foreground ,yellow))))
     `(rainbow-delimiters-depth-11-face ((t (:foreground ,blue))))
     `(rainbow-delimiters-depth-12-face ((t (:foreground ,orange))))
     `(rainbow-delimiters-unmatched-face
       ((t (:foreground ,solarized-fg :background ,solarized-bg :inverse-video t))))

     ;; rst-mode
     `(rst-level-1-face ((t (:background ,yellow   :foreground ,solarized-bg))))
     `(rst-level-2-face ((t (:background ,cyan    :foreground ,solarized-bg))))
     `(rst-level-3-face ((t (:background ,blue    :foreground ,solarized-bg))))
     `(rst-level-4-face ((t (:background ,violet  :foreground ,solarized-bg))))
     `(rst-level-5-face ((t (:background ,magenta :foreground ,solarized-bg))))
     `(rst-level-6-face ((t (:background ,red     :foreground ,solarized-bg))))

     ;; sh-mode
     `(sh-quoted-exec ((t (:foreground ,violet :weight bold))))
     `(sh-escaped-newline ((t (:foreground ,yellow :weight bold))))
     `(sh-heredoc ((t (:foreground ,yellow :weight bold))))

     ;; smartparens
     `(sp-pair-overlay-face ((t (:background ,solarized-hl))))
     `(sp-wrap-overlay-face ((t (:background ,solarized-hl))))
     `(sp-wrap-tag-overlay-face ((t (:background ,solarized-hl))))
     `(sp-show-pair-enclosing ((t (:inherit highlight))))
     `(sp-show-pair-match-face
       ((t (:foreground ,violet :background ,solarized-bg
                             :weight normal :inverse-video t))))
     `(sp-show-pair-mismatch-face
       ((t (:foreground ,red :background ,solarized-bg
                             :weight normal :inverse-video t))))

     ;; show-paren
     `(show-paren-match
       ((t (:foreground ,cyan :background ,solarized-bg
                             :weight normal :inverse-video t))))
     `(show-paren-mismatch
       ((t (:foreground ,red :background ,solarized-bg
                             :weight normal :inverse-video t))))

     ;; mic-paren
     `(paren-face-match
       ((t (:foreground ,cyan :background ,solarized-bg
                             :weight normal :inverse-video t))))
     `(paren-face-mismatch
       ((t (:foreground ,red :background ,solarized-bg
                             :weight normal :inverse-video t))))
     `(paren-face-no-match
       ((t (:foreground ,red :background ,solarized-bg
                             :weight normal :inverse-video t))))

     ;; SLIME
     `(slime-repl-inputed-output-face ((t (:foreground ,red))))

     ;; speedbar
     `(speedbar-button-face ((t (:inherit fixed-pitch :foreground ,solarized-comments))))
     `(speedbar-directory-face ((t (:inherit fixed-pitch :foreground ,blue))))
     `(speedbar-file-face ((t (:inherit fixed-pitch :foreground ,solarized-fg))))
     `(speedbar-highlight-face ((t (:inherit fixed-pitch :background ,solarized-hl))))
     `(speedbar-selected-face ((t (:inherit fixed-pitch
                                                 :foreground ,yellow :underline t))))
     `(speedbar-separator-face ((t (:inherit fixed-pitch
                                                  :background ,blue :foreground ,solarized-bg
                                                  :overline ,cyan-d))))
     `(speedbar-tag-face ((t (:inherit fixed-pitch :foreground ,green))))

     ;; table
     `(table-cell ((t (:foreground ,solarized-fg :background ,solarized-hl))))

     ;; term
     `(term-color-black ((t (:foreground ,base03 :background ,base02))))
     `(term-color-red ((t (:foreground ,red :background ,red-d))))
     `(term-color-green ((t (:foreground ,green :background ,green-d))))
     `(term-color-yellow ((t (:foreground ,yellow :background ,yellow-d))))
     `(term-color-blue ((t (:foreground ,blue :background ,blue-d))))
     `(term-color-magenta ((t (:foreground ,magenta :background ,magenta-d))))
     `(term-color-cyan ((t (:foreground ,cyan :background ,cyan-d))))
     `(term-color-white ((t (:foreground ,base00 :background ,base0))))
     '(term-default-fg-color ((t (:inherit term-color-white))))
     '(term-default-bg-color ((t (:inherit term-color-black))))

     ;; tuareg
     `(tuareg-font-lock-governing-face ((t (:foreground ,magenta :weight bold))))
     `(tuareg-font-lock-multistage-face ((t (:foreground ,blue :background ,solarized-hl
                                                              :weight bold))))
     `(tuareg-font-lock-operator-face ((t (:foreground ,solarized-emph))))
     `(tuareg-font-lock-error-face ((t (:foreground ,yellow :background ,red
                                                         :weight bold))))
     `(tuareg-font-lock-interactive-output-face ((t (:foreground ,cyan))))
     `(tuareg-font-lock-interactive-error-face ((t (:foreground ,red))))

     ;; undo-tree
     `(undo-tree-visualizer-default-face
       ((t (:foreground ,solarized-comments :background ,solarized-bg))))
     `(undo-tree-visualizer-unmodified-face ((t (:foreground ,green))))
     `(undo-tree-visualizer-current-face ((t (:foreground ,blue :inverse-video t))))
     `(undo-tree-visualizer-active-branch-face
       ((t (:foreground ,solarized-emph :background ,solarized-bg :weight bold))))
     `(undo-tree-visualizer-register-face ((t (:foreground ,yellow))))

     ;; volatile highlights
     `(vhl/default-face ((t (:background ,green-d :foreground ,green-l))))

     ;; web-mode
     `(web-mode-builtin-face ((t (:foreground ,red))))
     `(web-mode-comment-face ((t (:foreground ,solarized-comments))))
     `(web-mode-constant-face ((t (:foreground ,blue :weight bold))))
     `(web-mode-current-element-highlight-face ((t
                                                 (:underline unspecified :weight unspecified
                                                             :background ,solarized-hl))))
     `(web-mode-css-at-rule-face ((t (:foreground ,violet :slant italic))))
     `(web-mode-css-pseudo-class-face ((t (:foreground ,green :slant italic))))
     `(web-mode-doctype-face ((t (:foreground ,solarized-comments
                                                   :slant italic :weight bold))))
     `(web-mode-folded-face ((t (:underline t))))
     `(web-mode-function-name-face ((t (:foreground ,blue))))
     `(web-mode-html-attr-name-face ((t (:foreground ,blue :slant normal))))
     `(web-mode-html-attr-value-face ((t (:foreground ,cyan :slant italic))))
     `(web-mode-html-tag-face ((t (:foreground ,green))))
     `(web-mode-keyword-face ((t (:foreground ,yellow :weight normal))))
     `(web-mode-preprocessor-face ((t (:foreground ,yellow :slant normal :weight unspecified))))
     `(web-mode-string-face ((t (:foreground ,cyan))))
     `(web-mode-type-face ((t (:foreground ,yellow))))
     `(web-mode-variable-name-face ((t (:foreground ,blue))))
     `(web-mode-warning-face ((t (:inherit font-lock-warning-face))))
     `(web-mode-block-attr-name-face ((t (:inherit web-mode-html-attr-name-face))))
     `(web-mode-block-attr-value-face ((t (:inherit web-mode-html-attr-value-face))))
     `(web-mode-block-comment-face ((t (:inherit web-mode-comment-face))))
     `(web-mode-block-control-face ((t (:inherit font-lock-preprocessor-face))))
     `(web-mode-block-face ((t (:background unspecified))))
     `(web-mode-block-string-face ((t (:inherit web-mode-string-face))))
     `(web-mode-comment-keyword-face ((t (:box 1 :weight bold))))
     `(web-mode-css-color-face ((t (:inherit font-lock-builtin-face))))
     `(web-mode-css-function-face ((t (:inherit font-lock-builtin-face))))
     `(web-mode-css-priority-face ((t (:inherit font-lock-builtin-face))))
     `(web-mode-css-property-name-face ((t (:inherit font-lock-variable-name-face))))
     `(web-mode-css-selector-face ((t (:inherit font-lock-keyword-face))))
     `(web-mode-css-string-face ((t (:inherit web-mode-string-face))))
     `(web-mode-javascript-string-face ((t (:inherit web-mode-string-face))))
     `(web-mode-json-context-face ((t (:foreground ,violet))))
     `(web-mode-json-key-face ((t (:foreground ,violet))))
     `(web-mode-json-string-face ((t (:inherit web-mode-string-face))))
     `(web-mode-param-name-face ((t (:foreground ,solarized-fg))))
     `(web-mode-part-comment-face ((t (:inherit web-mode-comment-face))))
     `(web-mode-part-face ((t (:inherit web-mode-block-face))))
     `(web-mode-part-string-face ((t (:inherit web-mode-string-face))))
     `(web-mode-symbol-face ((t (:foreground ,yellow))))
     `(web-mode-whitespace-face ((t (:background ,red))))

     ;; whitespace-mode
     `(whitespace-space ((t (:background unspecified :foreground ,solarized-comments
                                              :inverse-video unspecified :slant italic))))
     `(whitespace-hspace ((t (:background unspecified :foreground ,solarized-emph
                                               :inverse-video unspecified))))
     `(whitespace-tab ((t (:background unspecified :foreground ,red
                                            :inverse-video unspecified :weight bold))))
     `(whitespace-newline ((t(:background unspecified :foreground ,solarized-comments
                                               :inverse-video unspecified))))
     `(whitespace-trailing ((t (:background unspecified :foreground ,orange-d
                                                 :inverse-video t))))
     `(whitespace-line ((t (:background unspecified :foreground ,magenta
                                             :inverse-video unspecified))))
     `(whitespace-space-before-tab ((t (:background ,red-d :foreground unspecified
                                                         :inverse-video unspecified))))
     `(whitespace-indentation ((t (:background unspecified :foreground ,yellow
                                                    :inverse-video unspecified :weight bold))))
     `(whitespace-empty ((t (:background unspecified :foreground ,red-d
                                              :inverse-video t))))
     `(whitespace-space-after-tab ((t (:background unspecified :foreground ,orange
                                                        :inverse-video t :weight bold))))

     ;; which-func-mode
     `(which-func ((t (:foreground ,orange))))

     ;; window-number-mode
     `(window-number-face ((t (:foreground ,green))))

     ;; zencoding
     `(zencoding-preview-input ((t (:background ,solarized-hl :box ,solarized-emph)))))

    (custom-theme-set-variables
     'wasa-solarized
     `(ansi-color-names-vector [,solarized-bg ,red ,green ,yellow
                                              ,blue ,magenta ,cyan ,solarized-fg])

     ;; compilation
     `(compilation-message-face 'default)

     ;; fill-column-indicator
     `(fci-rule-color ,solarized-hl)

     ;; magit
     `(magit-diff-use-overlays nil)

     ;; highlight-changes
     `(highlight-changes-colors '(,magenta ,violet))

     ;; highlight-tail
     `(highlight-tail-colors
       '((,solarized-hl . 0)(,green-d . 20)(,cyan-d . 30)(,blue-d . 50)
         (,yellow-d . 60)(,orange-d . 70)(,magenta-d . 85)(,solarized-hl . 100)))

     ;; syslog-mode
     `(syslog-ip-face '((t :background unspecified :foreground ,yellow)))
     `(syslog-hour-face '((t :background unspecified :foreground ,green)))
     `(syslog-error-face '((t :background unspecified :foreground ,red :weight bold)))
     `(syslog-warn-face '((t :background unspecified :foreground ,orange :weight bold)))
     `(syslog-info-face '((t :background unspecified :foreground ,blue :weight bold)))
     `(syslog-debug-face '((t :background unspecified :foreground ,cyan :weight bold)))
     `(syslog-su-face '((t :background unspecified :foreground ,magenta)))

     ;; vc
     `(vc-annotate-color-map
       '((20 . ,red)
         (40 . "#CF4F1F")
         (60 . "#C26C0F")
         (80 . ,yellow)
         (100 . "#AB8C00")
         (120 . "#A18F00")
         (140 . "#989200")
         (160 . "#8E9500")
         (180 . ,green)
         (200 . "#729A1E")
         (220 . "#609C3C")
         (240 . "#4E9D5B")
         (260 . "#3C9F79")
         (280 . ,cyan)
         (300 . "#299BA6")
         (320 . "#2896B5")
         (340 . "#2790C3")
         (360 . ,blue)))
     `(vc-annotate-very-old-color nil)
     `(vc-annotate-background nil)
   ))

(provide-theme 'wasa-solarized)
