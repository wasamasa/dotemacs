(defun comint-previous-input (arg)
  "Cycle backwards through input history, saving input."
  (interactive "*p")
  (unless (and (eq comint-input-ring-index nil)
               (< arg 0))
    (if (and (eq comint-input-ring-index 0)
             (< arg 0)
             comint-stored-incomplete-input)
        (comint-restore-input)
      (unless (and (eq comint-input-ring-index
                       (- (ring-length comint-input-ring) 1))
               (> arg 0))
        (comint-previous-matching-input "." arg)))))

(defun my-comint-preoutput-turn-buffer-read-only (text)
  (propertize text 'read-only t))
(add-hook 'comint-preoutput-filter-functions 'my-comint-preoutput-turn-buffer-read-only)

(defun my-comint-clear-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

;; TODO use this to implement CIDER-style buffer clearing
;; see https://github.com/clojure-emacs/cider/blob/cb3509eb54d3c3369681d73f3218a1493b977e99/cider-repl.el#L640-L655
(defun my-comint-goto-last-prompt ()
  (interactive)
  (comint-goto-process-mark)
  (goto-char (previous-char-property-change (point)))
  (while (not (looking-back comint-prompt-regexp))
    (goto-char (previous-char-property-change (point)))))

(my-define-keys comint-mode-map
                  [remap kill-word] 'my-kill-word
                  [remap backward-kill-word] 'my-backward-kill-word
                  (kbd "C-L") 'my-comint-clear-buffer)

(defun my-shell-turn-echo-off ()
  (setq comint-process-echoes t))
(add-hook 'shell-mode-hook 'my-shell-turn-echo-off)

(defun my-shell-kill-buffer-sentinel (process event)
  (when (memq (process-status process) '(exit signal))
    (kill-buffer)))

(defun my-kill-process-buffer-on-exit ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                        #'my-shell-kill-buffer-sentinel))

(add-hook 'ielm-mode-hook 'my-kill-process-buffer-on-exit)
(add-hook 'term-exec-hook 'my-kill-process-buffer-on-exit)
(add-hook 'comint-exec-hook 'my-kill-process-buffer-on-exit)

(provide 'setup-comint)
