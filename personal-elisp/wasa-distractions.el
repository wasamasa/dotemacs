;; load private data
(load (concat user-emacs-directory "private/private"))

;; typing of emacs
(setq toe-highscore-file (concat user-emacs-directory "etc/toe.score"))

;; tetris
(require 'tetris)
;(autoload 'tetris-mode-map "tetris" "Enable tetris keymap" nil 'keymap)
(define-key tetris-mode-map "z" 'tetris-rotate-next)
(define-key tetris-mode-map "x" 'tetris-rotate-prev)
(defun tetris-move-down ()
  (interactive)
  (unless tetris-paused
    (tetris-erase-shape)
    (setq tetris-pos-y (1+ tetris-pos-y))
    (if (tetris-test-shape)
        (setq tetris-pos-y (1- tetris-pos-y)))
    (tetris-draw-shape)))
(define-key tetris-mode-map [down] 'tetris-move-down)
(setq tetris-score-file (concat user-emacs-directory "etc/tetris.score"))
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
(setq circe-default-nick "webspid0r"
      circe-use-cycle-completion t
      circe-reduce-lurker-spam t
      circe-nickserv-ghost-style 'immediate
      circe-format-self-say "<{nick}> {body}"
      circe-highlight-nick-type 'message
      circe-network-options `(("Freenode"
                               :nickserv-password ,freenode-password)
                              ("Bitlbee" :port 6667
                               :lagmon-disabled t
                               :nickserv-password ,bitlbee-password)))
(enable-circe-color-nicks)
(setq circe-color-nicks-everywhere t)
(circe-lagmon-mode)
(setq lui-highlight-keywords '("webspid0r" "wubspider" "wasamasa" "wasa")
      lui-fill-column 69
      lui-max-buffer-size 100000)
(autoload 'lui-fool-toggle-display "lui" "Toggle fools" t)
(setq tracking-faces-priorities '(circe-highlight-nick-face))
(defun wasa-circe-nick-next (oldnick)
    (cond ((string= oldnick "webspid0r") "wubspider")
          ((string= oldnick "wubspider") "webspid0r")
          (t "wasamasa")))
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

(defun lui-highlight-keywords ()
  "Highlight the entries in the variable `lui-highlight-keywords'.

This is called automatically when new text is inserted."
  (let ((regex (lambda (entry)
                 (if (stringp entry)
                     entry
                   (car entry))))
        (submatch (lambda (entry)
                    (if (and (consp entry)
                             (numberp (cadr entry)))
                        (cadr entry)
                      0)))
        (properties (lambda (entry)
                      (let ((face (cond
                                   ;; REGEXP
                                   ((stringp entry)
                                    'lui-highlight-face)
                                   ;; (REGEXP SUBMATCH)
                                   ((and (numberp (cadr entry))
                                         (null (cddr entry)))
                                    'lui-highlight-face)
                                   ;; (REGEXP FACE)
                                   ((null (cddr entry))
                                    (cadr entry))
                                   ;; (REGEXP SUBMATCH FACE)
                                   (t
                                    (nth 2 entry)))))
                        (if (facep face)
                            `(face ,face)
                          face)))))
    (dolist (entry lui-highlight-keywords)
      (goto-char (point-min))
      (while (re-search-forward (funcall regex entry) nil t)
        (let* ((exp (funcall submatch entry))
               (beg (match-beginning exp))
               (end (match-end exp)))
          (when (not (text-property-any beg end 'lui-highlight-fontified-p t))
            ;; patch start
            (wasa-x-urgency-hint)
            ;; patch end
            (add-text-properties beg end
                                 (append (funcall properties entry)
                                         '(lui-highlight-fontified-p t)))))))))

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
