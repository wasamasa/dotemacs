;; load private data
(load (concat user-emacs-directory "etc/private.el"))

;; typing of emacs
(setq toe-highscore-file (concat user-emacs-directory "etc/toe.score"))

;; tetris
(defun my-tetris-move-down ()
  (interactive)
  (unless tetris-paused
    (tetris-erase-shape)
    (setq tetris-pos-y (1+ tetris-pos-y))
    (if (tetris-test-shape)
        (setq tetris-pos-y (1- tetris-pos-y)))
    (tetris-draw-shape)))

(defun my-fix-tetris-mode ()
  (my-define-keys tetris-mode-map
                    (kbd "z") 'tetris-rotate-next
                    (kbd "x") 'tetris-rotate-prev
                    (kbd "<down>") 'my-tetris-move-down)
  (setq tetris-score-file (concat user-emacs-directory "etc/tetris.score")))

(add-hook 'tetris-mode-hook 'my-fix-tetris-mode)

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
      circe-prompt-string (propertize ">>> " 'face 'circe-prompt-face)
      circe-server-auto-join-default-type :after-nick
      circe-new-buffer-behavior-ignore-auto-joins t
      circe-track-faces-priorities '(my-circe-highlight-notification-face
                                     circe-my-message-face circe-server-face)
      circe-network-options `(("ZNC/Freenode" :host "127.0.0.1" :port 65432
                               :user "wasamasa/freenode" :pass ,znc-password)
                              ("ZNC/f0o" :host "127.0.0.1" :port 65432
                               :user "wasamasa/f0o" :pass ,znc-password)
                              ("Bitlbee" :port 6667
                               :nickserv-password ,bitlbee-password)))
(enable-circe-color-nicks)
(setq circe-color-nicks-everywhere t)
(setq lui-max-buffer-size 50000)
(add-hook 'circe-channel-mode-hook 'enable-lui-autopaste)

(defun my-window-C-l ()
  (interactive)
  (goto-char (point-max))
  (recenter-top-bottom -1))
(my-define-keys lui-mode-map
                  [remap kill-word] 'my-kill-word
                  [remap backward-kill-word] 'my-backward-kill-word
                  (kbd "C-l") 'my-window-C-l)

(setq lui-buttons-list
      `((,(concat
           "\\<\\(http\\|https\\|ftp\\)"
           ;; taken from thingatpt.el
           "[^]\t\n \"'<>[^`{}]*[^]\t\n \"'<>[^`{}.,;]+")
         0 browse-url 0)
        ("`\\([A-Za-z0-9+=*/-]+\\)'" 1 lui-button-elisp-symbol 1)
        ("RFC ?\\([0-9]+\\)" 0 lui-button-rfc 1)
        ("SRFI[- ]?\\([0-9]+\\)" 0 lui-button-srfi 1)))

(setq tracking-ignored-buffers '("*hl*"))

(defun my-circe-nick-next (oldnick)
    (cond ((string= oldnick "wasamasa") "wasa")
          ((string= oldnick "wasa") "wasamasa")
          (t "wubspider")))
(setq circe-nick-next-function 'my-circe-nick-next)

(defun circe-generate-nick-color ()
  "Patched version which only returns theme colors"
  (let ((solarized-colors '("#b58900" "#cb4b16" "#dc322f" "#d33682" "#6c71c4"
                            "#268bd2" "#2aa198" "#859900" "#7b6000" "#deb542"
                            "#f2804f" "#ff6e64" "#f771ac" "#9ea0e5" "#00629d"
                            "#69b7f0" "#00736f" "#69cabf" "#546e00" "#b4c342")))
    (nth (random (length solarized-colors)) solarized-colors)))

(defun my-x-urgency-hint (&optional frame arg source)
  (let* ((wm-hints (append (x-window-property
                            "WM_HINTS" frame "WM_HINTS" source nil t) nil))
         (flags (car wm-hints)))
    (setcar wm-hints (if arg
                         (logand flags #x1ffffeff)
                       (logior flags #x00000100)))
    (x-change-window-property "WM_HINTS" wm-hints frame "WM_HINTS" 32 t)))

(defface my-circe-highlight-notification-face '((t (:weight bold)))
  "Face for circe notifications")
(defun my-circe-message-option-highlight (nick user host command args)
  (let* ((highlight-regexps '("webspid0r" "wubspider" "wasamasa" "wasa\\>"))
         (irc-message (second args))
         (highlight-match (my-any-regex-in-string highlight-regexps irc-message)))
    (when irc-message
      (when (not (equal nick circe-default-nick))
        (when (and (not (equal major-mode 'circe-server-mode))
                   (or highlight-match (equal major-mode 'circe-query-mode)))
          (my-x-urgency-hint))
        (when highlight-match
          '((text-properties . (face my-circe-highlight-notification-face message t))))))))
(add-hook 'circe-message-option-functions 'my-circe-message-option-highlight)

(defun my-circe-disable-highlight-nick ()
  (remove-hook 'lui-pre-output-hook 'circe-highlight-nick t))
(add-hook 'circe-chat-mode-hook 'my-circe-disable-highlight-nick)

(defun my-irc ()
  "Connect to all my IRC servers"
  (interactive)
  (circe "Bitlbee")
  (circe "ZNC/Freenode")
  (circe "ZNC/f0o"))

;; mu4e
(autoload 'mu4e "mu4e" "Main function of mu4e" t)
(setq mu4e-maildir (concat user-directory ".mail")
      user-full-name "Vasilij Schneidermann"
      user-mail-address "v.schneidermann@gmail.com"
      mu4e-drafts-folder "/public/drafts"
      mu4e-sent-folder "/public/sent"
      mu4e-trash-folder "/public/trash"
      mu4e-refile-folder "/public/archive"
      mu4e-get-mail-command "checkmail"
      mu4e-view-show-images t
      mu4e-view-prefer-html t
      ;mu4e-html2text-command "lynx -hiddenlinks=merge -display_charset=utf-8 -dump -stdin"
      mu4e-html2text-command "lynx -display_charset=utf-8 -dump -stdin"
      mu4e-confirm-quit nil)
(defun my-mu4e-remap-search ()
  (my-define-keys 'mu4e-main-mode-map
                    (kbd "s") nil
                    (kbd "/") 'mu4e-headers-search))
(add-hook 'mu4e-main-mode-hook 'my-mu4e-remap-search)

(setq my-mu4e-account-alist
      '(("private"
         (user-full-name . "Hurrus Durrus")
         (user-mail-address . "hurrus.durrus@gmail.com")
         (mu4e-drafts-folder . "/private/drafts")
         (mu4e-sent-folder . "/private/sent")
         (mu4e-trash-folder . "/private/trash")
         (mu4e-refile-folder . "/private/archive"))
        ("public"
         (user-full-name . "Vasilij Schneidermann")
         (user-mail-address . "v.schneidermann@gmail.com")
         (mu4e-drafts-folder . "/public/drafts")
         (mu4e-sent-folder . "/public/sent")
         (mu4e-trash-folder . "/public/trash")
         (mu4e-refile-folder . "/public/archive"))))

(defun my-mu4e-set-account ()
       "Set the account for composing a message."
       (let* ((account
               (if mu4e-compose-parent-message
                   (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                     (string-match "/\\(.*?\\)/" maildir)
                     (match-string 1 maildir))
                 (completing-read (format "Compose with account: (%s) "
                                          (mapconcat #'(lambda (var) (car var)) my-mu4e-account-alist "/"))
                                  (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                                  nil t nil nil (caar my-mu4e-account-alist))))
              (account-vars (cdr (assoc account my-mu4e-account-alist))))
         (message "%s" account)
         (if account-vars
             (mapc #'(lambda (var)
                       (set (car var) (cdr var)))
                   account-vars)
           (error "No email account found"))))
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

(setq message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "msmtp")
(defun choose-msmtp-account ()
    (if (message-mail-p)
        (save-excursion
          (let* ((from (save-restriction
                         (message-narrow-to-headers)
                         (message-fetch-field "from")))
                 (account
                  (cond
                   ((string-match "hurrus.durrus@gmail.com" from) "private")
                   ((string-match "v.schneidermann@gmail.com" from) "public"))))
            (setq message-sendmail-extra-arguments (list '"-a" account))))))
(setq message-sendmail-envelope-from 'header)
(add-hook 'message-send-mail-hook 'choose-msmtp-account)

(eval-after-load "mu4e-main"
  '(defun mu4e~main-action-str (str &optional func-or-shortcut)
     "Highlight the first occurence of [.+] in STR.
If FUNC-OR-SHORTCUT is non-nil and if it is a function, call it
when STR is clicked (using RET or mouse-2); if FUNC-OR-SHORTCUT is
a string, execute the corresponding keyboard action when it is
clicked."
     (let ((newstr
            (replace-regexp-in-string
             "\\[\\(.+\\)\\]"
             (lambda(m)
               (format "[%s]"
                       (propertize (match-string 1 m) 'face 'mu4e-highlight-face)))
             str))
           (map (make-sparse-keymap))
           (func (if (functionp func-or-shortcut)
                     func-or-shortcut
                   (if (stringp func-or-shortcut)
                       (lexical-let ((macro func-or-shortcut))
                         (lambda()(interactive)
                           (execute-kbd-macro macro)))))))
       (define-key map [mouse-2] func)
       (define-key map (kbd "RET") func)
       (put-text-property 0 (length newstr) 'keymap map newstr)
       (put-text-property (string-match "\\[.+" newstr)
                          (- (length newstr) 1) 'mouse-face 'highlight newstr) newstr)))

(defun my-mu4e-main-view-fix ()
  (with-current-buffer (get-buffer mu4e~main-buffer-name)
    (save-excursion
      (let ((inhibit-read-only t))
        (goto-char (point-min))
        (when (search-forward "\t* enter a [s]earch query\n" (point-max) t)
          (set-text-properties (match-beginning 0) (match-end 0) nil)
          (replace-match "" t t)
          (insert (mu4e~main-action-str "\t* [?] enter a search query\n" 'mu4e-search)))))))
(add-hook 'mu4e-main-mode-hook 'my-mu4e-main-view-fix)

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

(provide 'setup-distractions)
