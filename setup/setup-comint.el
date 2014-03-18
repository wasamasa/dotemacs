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
(my-define-keys comint-mode-map
                  [remap kill-word] 'my-kill-word
                  [remap backward-kill-word] 'my-backward-kill-word)

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
