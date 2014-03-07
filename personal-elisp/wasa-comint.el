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

(defun wasa-comint-preoutput-turn-buffer-read-only (text)
  (propertize text 'read-only t))

(add-hook 'comint-preoutput-filter-functions 'wasa-comint-preoutput-turn-buffer-read-only)
(define-key comint-mode-map [remap kill-word] 'wasa-kill-word)
(define-key comint-mode-map [remap backward-kill-word] 'wasa-backward-kill-word)

(defun wasa-shell-turn-echo-off ()
  (setq comint-process-echoes t))
(add-hook 'shell-mode-hook 'wasa-shell-turn-echo-off)

(defun my-shell-kill-buffer-sentinel (process event)
  (when (memq (process-status process) '(exit signal))
    (kill-buffer)))

(defun my-kill-process-buffer-on-exit ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                        #'my-shell-kill-buffer-sentinel))

(add-hook 'ielm-mode-hook 'my-kill-process-buffer-on-exit)
(add-hook 'term-exec-hook 'my-kill-process-buffer-on-exit)
(add-hook 'comint-exec-hook 'my-kill-process-buffer-on-exit)

(provide 'wasa-comint)
