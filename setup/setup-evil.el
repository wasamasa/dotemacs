(setq evil-default-cursor t)
(setq evil-want-C-w-in-emacs-state t)
(setq evil-symbol-word-search t)
(evil-mode t)
(global-surround-mode t)
(global-evil-matchit-mode)
(evil-set-initial-state 'dired-mode 'emacs)
(evil-set-initial-state 'package-menu-mode 'motion)
(evil-set-initial-state 'Custom-mode 'motion)
(evil-set-initial-state 'special-mode 'motion)
;; for some reason (evil-set-initial-state 'org-capture-mode 'insert) does not work
(add-hook 'org-capture-mode-hook 'evil-insert-state)
(evil-set-initial-state 'tumblesocks-compose-mode 'insert)
(evil-set-initial-state 'git-commit-mode 'insert)
(evil-set-initial-state 'nrepl-mode 'emacs)
(evil-set-initial-state 'circe-chat-mode 'emacs)
(evil-set-initial-state 'circe-channel-mode 'emacs)
(evil-set-initial-state 'circe-server-mode 'emacs)
(evil-set-initial-state 'circe-query-mode 'emacs)
(evil-set-initial-state 'circe-display-mode 'emacs)
(evil-set-initial-state 'Man-mode 'emacs)
(evil-set-initial-state 'woman-mode 'emacs)
(evil-set-initial-state 'tetris-mode 'emacs)
(evil-set-initial-state 'comint-mode 'emacs)
(evil-set-initial-state 'eshell-mode 'emacs)
(evil-set-initial-state 'shell-mode 'emacs)
(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'inferior-python-mode 'emacs)

(setq eyebrowse-switch-back-and-forth-p t
      eyebrowse-wrap-around-p t)
(eyebrowse-mode)
(eyebrowse-setup-opinionated-keys)

(define-key evil-motion-state-map (kbd "SPC") nil)
(define-key evil-visual-state-map (kbd "SPC") nil)
(define-key evil-motion-state-map (kbd "RET") nil)
(define-key evil-visual-state-map (kbd "RET") nil)
(define-key evil-motion-state-map (kbd "TAB") nil)
(define-key evil-visual-state-map (kbd "TAB") nil)
(define-key evil-motion-state-map ";" 'evil-ex) ; nnoremap ; :
(define-key evil-visual-state-map ";" 'evil-ex) ; vnoremap ; :
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist
      `((".*" . ,(concat user-emacs-directory "undo"))))
(global-evil-leader-mode t)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "," 'evil-buffer
  "." 'helm-mini
  "/" 'helm-find-files)

(evil-leader/set-key-for-mode 'tumblesocks-view-mode
  "q" 'quit-window
  "c" 'tumblesocks-view-compose-new-post
  "r" 'tumblesocks-view-refresh
  "t" 'tumblesocks-view-posts-tagged
  "v" 'tumblesocks-view-post-at-point
  "d" 'tumblesocks-view-delete-post-at-point
  "e" 'tumblesocks-view-edit-post-at-point)

(evil-define-key 'normal org-mode-map
  (kbd "RET") 'org-open-at-point)
(define-key evil-normal-state-map (kbd "C-.") nil)
(define-key evil-normal-state-map (kbd "M-.") nil)

(setq ace-jump-mode-move-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?\;))
(define-key evil-normal-state-map (kbd "SPC") 'evil-ace-jump-char-mode)
(define-key evil-normal-state-map (kbd "S-SPC") 'evil-ace-jump-word-mode)
(define-key evil-normal-state-map (kbd "C-SPC") 'evil-ace-jump-line-mode)
(define-key evil-operator-state-map (kbd "SPC") 'evil-ace-jump-char-mode)
(define-key evil-operator-state-map (kbd "S-SPC") 'evil-ace-jump-word-mode)
(define-key evil-operator-state-map (kbd "C-SPC") 'evil-ace-jump-line-mode)

(define-key evil-insert-state-map (kbd "RET") 'newline-and-indent)
(define-key evil-normal-state-map (kbd "-") 'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map (kbd "+") 'evil-numbers/inc-at-pt)
(define-key evil-window-map (kbd "u") 'winner-undo)
(define-key evil-window-map (kbd "b") 'helm-mini)

(defun my-evil-unimpaired-insert-newline-above (count)
  "Insert an empty line below point"
  (interactive "p")
  (save-excursion
    (dotimes (i count)
      (evil-insert-newline-above))))

(defun my-evil-unimpaired-insert-newline-below (count)
  "Insert an empty line below point"
  (interactive "p")
  (save-excursion
    (dotimes (i count)
      (evil-insert-newline-below))))

(define-key evil-normal-state-map (kbd "[ SPC")
  'my-evil-unimpaired-insert-newline-above)

(define-key evil-normal-state-map (kbd "] SPC")
  'my-evil-unimpaired-insert-newline-below)

(defun evil-paste-from-primary ()
  "Paste text from PRIMARY/Selection"
  (interactive)
  (evil-paste-from-register ?*))

(global-set-key (kbd "<S-insert>") 'evil-paste-from-primary)
(global-set-key (kbd "<mouse-2>") 'evil-paste-from-primary)

(provide 'setup-evil)
