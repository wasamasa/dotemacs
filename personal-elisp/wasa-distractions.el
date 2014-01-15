;; load private data
(load (concat user-emacs-directory "private/private"))

;; typing of emacs
(setq toe-highscore-file (concat user-emacs-directory "etc/toe.score"))

;; tetris
(defun wasa-tetris-move-down ()
  (interactive)
  (unless tetris-paused
    (tetris-erase-shape)
    (setq tetris-pos-y (1+ tetris-pos-y))
    (if (tetris-test-shape)
        (setq tetris-pos-y (1- tetris-pos-y)))
    (tetris-draw-shape)))

(defun wasa-fix-tetris-mode ()
  (wasa-define-keys tetris-mode-map
                    (kbd "z") 'tetris-rotate-next
                    (kbd "x") 'tetris-rotate-prev
                    (kbd "<down>") 'wasa-tetris-move-down)
  (setq tetris-score-file (concat user-emacs-directory "etc/tetris.score")))

(add-hook 'tetris-mode-hook 'wasa-fix-tetris-mode)

(defadvice tetris-end-game (around zap-scores activate)
  (save-window-excursion ad-do-it)
  (kill-buffer))

(setq gamegrid-xpm "\
/* XPM */
static char *noname[] = {
/* width height ncolors chars_per_pixel */
\"16 16 3 1\",
/* colors */
\"+ s col1\",
\". s col2\",
\"- s col3\",
/* pixels */
\"--............++\",
\"--............++\",
\"..----........++\",
\"..----........++\",
\"..--..........++\",
\"..--..........++\",
\"..............++\",
\"..............++\",
\"..............++\",
\"..............++\",
\"..............++\",
\"..............++\",
\"..............++\",
\"..............++\",
\"++++++++++++++++\",
\"++++++++++++++++\"
};
")

;; tumblesocks
(setq oauth-nonce-function #'oauth-internal-make-nonce
      tumblesocks-blog "elitistfaggots.tumblr.com"
      tumblesocks-post-default-state "ask")

;; circe
(setq circe-default-nick "wasamasa"
      circe-default-user "wasamasa"
      circe-default-realname "wasamasa"
      circe-default-part-message "Bye"
      circe-default-quit-message "Bye"
      circe-use-cycle-completion t
      circe-reduce-lurker-spam t
      circe-nickserv-ghost-style 'after-auth
      circe-format-self-say "<{nick}> {body}"
      circe-format-server-topic "*** Topic Change by {origin}: {topic-diff}"
      circe-highlight-nick-type 'message
      circe-prompt-string (propertize ">>> " 'face 'circe-prompt-face)
      circe-server-auto-join-default-type :after-nick
      circe-new-buffer-behavior-ignore-auto-joins t
      circe-network-options `(("Freenode"
                               :channels ("#archlinux" "#archlinux.de" "#emacs")
                               :nickserv-password ,freenode-password)
                              ("Bitlbee" :port 6667
                               :lagmon-disabled t
                               :nickserv-password ,bitlbee-password)))
(enable-circe-color-nicks)
(setq circe-color-nicks-everywhere t)
(circe-lagmon-mode)
(setq lui-highlight-keywords '("webspid0r" "wubspider" "wasamasa" "wasa")
      lui-fill-column 69
      lui-max-buffer-size 50000)
(autoload 'lui-fool-toggle-display "lui" "Toggle fools" t)
(setq tracking-faces-priorities '(circe-highlight-nick-face))
(defun wasa-circe-nick-next (oldnick)
    (cond ((string= oldnick "wasamasa") "wasa")
          ((string= oldnick "wasa") "wasamasa")
          (t "wubspider")))
(setq circe-nick-next-function 'wasa-circe-nick-next)

(defun circe-generate-nick-color ()
  "Patched version which only returns theme colors"
  (let ((solarized-colors '("#b58900" "#cb4b16" "#dc322f" "#d33682" "#6c71c4"
                            "#268bd2" "#2aa198" "#859900" "#7b6000" "#deb542"
                            "#f2804f" "#ff6e64" "#f771ac" "#9ea0e5" "#00629d"
                            "#69b7f0" "#00736f" "#69cabf" "#546e00" "#b4c342")))
    (nth (random (length solarized-colors)) solarized-colors)))

(defun wasa-x-urgency-hint (&optional frame arg source)
  (let* ((wm-hints (append (x-window-property 
                            "WM_HINTS" frame "WM_HINTS" source nil t) nil))
         (flags (car wm-hints)))
    (setcar wm-hints (if arg
                         (logand flags #x1ffffeff)
                       (logior flags #x00000100)))
    (x-change-window-property "WM_HINTS" wm-hints frame "WM_HINTS" 32 t)))

(defun wasa-circe-message-option-highlight (nick user host command args)
  (let ((irc-message (second args)))
    (when (and irc-message
               (or (wasa-any-regex-in-string lui-highlight-keywords irc-message)
                   (eq major-mode 'circe-query-mode)))
      (wasa-x-urgency-hint)
      '((text-properties . (face default message t))))))
(add-hook 'circe-message-option-functions 'wasa-circe-message-option-highlight)

(defun wasa-irc ()
  "Connect to all my IRC servers"
  (interactive)
  (circe "Bitlbee")
  (circe "Freenode"))
;; elfeed
(setq elfeed-feeds '("http://iwdrm.tumblr.com/rss"
                     "http://fluxmachine.tumblr.com/rss"
                     "http://www.oglaf.com/feeds/rss/"
                     "http://www.johnnywander.com/feed"
                     "http://www.questionablecontent.net/QCRSS.xml"
                     "http://xkcd.com/atom.xml"
                     "http://natazilla.tumblr.com/rss"
                     "http://chibird.tumblr.com/rss"
                     "http://prequeladventure.com/feed/"
                     "http://hoxtranslations.blogspot.com/feeds/posts/default"
                     "http://feeds.feedburner.com/stevelosh?format=xml"
                     "http://lucumr.pocoo.org/feed.atom"
                     "http://me.veekun.com/atom.xml"
                     "http://www.archlinux.org/feeds/news/"
                     "http://feeds.feedburner.com/newsyc100?format=xml"
                     "http://blog.fefe.de/rss.xml?html"
                     "file:///home/wasa/rss/yahoo.atom"))

(provide 'wasa-distractions)
