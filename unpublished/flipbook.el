(defvar flipbook-format-string nil)
(defvar flipbook-frame 1)
(defvar flipbook-last-frame 7780)
(defvar flipbook-interval (/ 1.0 30))
(defvar flipbook-playing nil)
(defvar flipbook-timer nil)

(defun flipbook-init ()
  (setq flipbook-frame 1))

(defun flipbook-reset ()
  (interactive)
  (flipbook-init)
  (flipbook-redraw))

(defun flipbook-redraw ()
  (with-current-buffer (get-buffer "*flipbook*")
    (setq buffer-read-only nil)
    (erase-buffer)
    (insert-image (create-image (format flipbook-format-string flipbook-frame)))
    (insert "\n")
    (setq buffer-read-only t)))

(defun flipbook-advance-frames (frames)
  (when (<= flipbook-frame flipbook-last-frame)
    (flipbook-redraw)
    (setq flipbook-frame (+ flipbook-frame frames))))

(defun flipbook-next-frame ()
  (interactive)
  (flipbook-advance-frames 1))

(defun flipbook-forward-frame ()
  (interactive)
  (unless flipbook-playing
    (flipbook-advance-frames 1)))

(defun flipbook-forward-second ()
  (interactive)
  (flipbook-advance-frames (ceiling (/ 1.0 flipbook-interval))))

(defun flipbook-backward-frame ()
  (interactive)
  (unless flipbook-playing
    (flipbook-advance-frames -1)))

(defun flipbook-backward-second ()
  (interactive)
  (flipbook-advance-frames (- (ceiling (/ 1.0 flipbook-interval)))))

(defun flipbook-play-or-pause ()
  (interactive)
  (if flipbook-playing
      (flipbook-pause)
    (flipbook-play)))

(defun flipbook-play ()
  (interactive)
  (unless flipbook-playing
    (setq flipbook-timer
          (run-at-time nil flipbook-interval
                       'flipbook-next-frame))
    (setq flipbook-playing t)))

(defun flipbook-pause ()
  (interactive)
  (when flipbook-playing
    (cancel-timer flipbook-timer)
    (setq flipbook-playing nil)))

(defun flipbook-stop ()
  (interactive)
  (flipbook-pause)
  (flipbook-reset))

(define-derived-mode flipbook-mode special-mode "Flipbook"
  "Flips through image frames."
  (with-current-buffer (get-buffer "*flipbook*")
    (auto-save-mode -1)
    (buffer-disable-undo)
    (setq mode-line-format nil)
    (flipbook-init)
    (flipbook-redraw)))

(defun flipbook (format-string fps &optional last-frame)
  "Start the player"
  ;; format-string fps &optional last-frame
  (interactive "sHurr: \nsDurr: ")
  (setq flipbook-format-string "~/tmp/v-rage/frames/img%05d.png")
  (switch-to-buffer "*flipbook*")
  (flipbook-mode)
  (goto-char (point-max)))

(define-key flipbook-mode-map (kbd "g") 'flipbook-redraw)
(define-key flipbook-mode-map (kbd "r") 'flipbook-reset)
(define-key flipbook-mode-map (kbd "p") 'flipbook-play-or-pause)
(define-key flipbook-mode-map (kbd "SPC") 'flipbook-play-or-pause)
(define-key flipbook-mode-map (kbd "s") 'flipbook-stop)
(define-key flipbook-mode-map (kbd ",") 'flipbook-backward-frame)
(define-key flipbook-mode-map (kbd "<") 'flipbook-backward-frame)
(define-key flipbook-mode-map (kbd "<left>") 'flipbook-backward-second)
(define-key flipbook-mode-map (kbd ".") 'flipbook-forward-frame)
(define-key flipbook-mode-map (kbd ">") 'flipbook-forward-frame)
(define-key flipbook-mode-map (kbd "<right>") 'flipbook-forward-second)
