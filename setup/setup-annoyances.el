(require 's)

(setq gc-cons-threshold 50000000)
(setq gnutls-min-prime-bits 1024)
(setq initial-scratch-message "")
(setq safe-local-variable-values '((org-confirm-elisp-link-function . nil)))
(setq find-function-C-source-directory (concat user-emacs-directory "emacs-24.3/src"))
(setq delete-old-versions t)
(setq browse-url-browser-function 'browse-url-xdg-open)
(fset 'yes-or-no-p 'y-or-n-p)
(setq split-height-threshold 0
      split-width-threshold 0)
(line-number-mode t)
(column-number-mode t)
(setq-default indent-tabs-mode nil)
(setq uniquify-buffer-name-style 'forward)
(require 'uniquify)
(setq apropos-do-all t)
(setq recentf-save-file (concat user-emacs-directory "etc/recentf")
      recentf-max-menu-items 25
      recentf-max-saved-items 50)
(recentf-mode t)
(setq savehist-file (concat user-emacs-directory "etc/savehist")
      history-length 150)
(savehist-mode t)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "etc/saveplace"))
(require 'saveplace)
(setq async-shell-command-buffer 'new-buffer)
(setq server-use-tcp t)
(setq mouse-yank-at-point t)
(setq comint-prompt-read-only t)
(setq scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
(setq frame-title-format '("" invocation-name ": " (:eval (s-trim (buffer-name)))))
(setq user-directory (concat "/home/" user-login-name "/"))
(setq blink-matching-paren nil)
;; primitive vcs and uncluttering
(setq backup-directory-alist
      `((".*" . ,(concat user-emacs-directory "backup"))))
(setq tramp-backup-directory-alist backup-directory-alist)
(setq auto-save-list-file-prefix (concat user-emacs-directory "autosave/"))
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "autosave/\\1") t)))
(setq version-control t)
(winner-mode t)
(setq windmove-wrap-around t)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "etc/saved-places"))
(setq python-check-command "flake8")
(unicode-whitespace-setup)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq bookmark-default-file (concat user-emacs-directory "etc/bookmarks"))
(setq tumblesocks-token-file (concat user-emacs-directory "etc/tumblr-oauth-token"))
(setq ediff-window-setup-function 'ediff-setup-windows-plain
      ediff-split-window-function 'split-window-horizontally)
(mapatoms (lambda (s) (when (get s 'disabled) (put s 'disabled nil))))
(setq quelpa-upgrade-p t)

;; great candidate for a patch that enables a more convenient option
(my-eval-after debug
  (defun debugger-setup-buffer (debugger-args)
    "Initialize the `*Backtrace*' buffer for entry to the debugger.
That buffer should be current already."
    (setq buffer-read-only nil)
    (erase-buffer)
    (set-buffer-multibyte t)		;Why was it nil ?  -stef
    (setq buffer-undo-list t)
    (let ((standard-output (current-buffer))
          (print-escape-newlines t)
          (print-level 8)
          (print-length 50))
      (backtrace))
    (goto-char (point-min))
    (delete-region (point)
                   (progn
                     (search-forward "\n  debug(")
                     (forward-line (if (eq (car debugger-args) 'debug)
                                       2	; Remove implement-debug-on-entry frame.
                                     1))
                     (point)))
    (insert "Debugger entered")
    ;; lambda is for debug-on-call when a function call is next.
    ;; debug is for debug-on-entry function called.
    (pcase (car debugger-args)
      ((or `lambda `debug)
       (insert "--entering a function:\n"))
      ;; Exiting a function.
      (`exit
       (insert "--returning value: ")
       (setq debugger-value (nth 1 debugger-args))
       (prin1 debugger-value (current-buffer))
       (insert ?\n)
       (delete-char 1)
       (insert ? )
       (beginning-of-line))
      ;; Debugger entered for an error.
      (`error
       (insert "--Lisp error: ")
       (prin1 (nth 1 debugger-args) (current-buffer))
       (insert ?\n))
      ;; debug-on-call, when the next thing is an eval.
      (`t
       (insert "--beginning evaluation of function call form:\n"))
      ;; User calls debug directly.
      (_
       (insert ": ")
       (prin1 (if (eq (car debugger-args) 'nil)
                  (cdr debugger-args) debugger-args)
              (current-buffer))
       (insert ?\n)))
    ;; After any frame that uses eval-buffer,
    ;; insert a line that states the buffer position it's reading at.
    (save-excursion
      (let ((tem eval-buffer-list))
        (while (and tem
                    (re-search-forward "^  eval-\\(buffer\\|region\\)(" nil t))
          (beginning-of-line)
          (insert (format "Error at line %d in %s: "
                          (with-current-buffer (car tem)
                            (line-number-at-pos (point)))
                          (with-current-buffer (car tem)
                            (buffer-name))))
          (pop tem))))
    (debugger-make-xrefs)))

(setq csv-separators '(";" "	" ",")
      csv-separator-chars '(?\; ?	 ?,)
      csv--skip-regexp "^
;	,"
      csv-separator-regexp "[;	,]"
      csv-font-lock-keywords '(("[;	,]" (0 'csv-separator-face))))

(defun my-startup-greeter ()
  (message "Let the hacking begin!"))
(defalias 'display-startup-echo-area-message 'my-startup-greeter)

(add-hook 'eshell-load-hook 'nyan-prompt-enable)

(provide 'setup-annoyances)
