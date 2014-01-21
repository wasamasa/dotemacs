(defun comint-previous-input (arg)
  "Cycle backwards through input history, saving input."
  (interactive "*p")
  (if (and (eq comint-input-ring-index nil)
           (< arg 0))
      (ignore)
    (if (and (eq comint-input-ring-index 0)
             (< arg 0)
             comint-stored-incomplete-input)
        (comint-restore-input)
      (if (and (eq comint-input-ring-index (- (ring-length comint-input-ring) 1))
               (> arg 0))
          (ignore)
        (comint-previous-matching-input "." arg)))))

(defun wasa-comint-preoutput-turn-buffer-read-only (text)
  (propertize text 'read-only t))

(add-hook 'comint-preoutput-filter-functions 'wasa-comint-preoutput-turn-buffer-read-only)
(define-key comint-mode-map [remap kill-word] 'wasa-kill-word)
(define-key comint-mode-map [remap backward-kill-word] 'wasa-backward-kill-word)

(provide 'wasa-comint)
