(defvar boop-player-process nil)

(defun boop-create-player-process ()
  (let ((process-connection-type nil))
    ;; TODO test whether pacat is available, if not use aplay
    ;; TODO make it customizable
    ;; TODO set correct sample rate (should be 8000?)
    (setq boop-player-process (start-process "pacat" "*pacat*" "pacat"))))

(defun boop-send-int-to-player (int)
  ;; TODO make sure mod 65535 is the right choice
  (process-send-string boop-player-process (string (mod int 65535))))

;; TODO turn this into a closure, then generator
(defun boop-send-ints-to-player (computation)
  (let ((i 0))
    (while t
      (boop-send-int-to-player (funcall computation i))
      (setq i (1+ i)))))

;; TODO use something simpler
;; TODO make a c->elisp macro?
(defun boop-player-int-function (i)
  ;; infix notation: (t>>9&t>>8)*(t>>3)
  (* (logand (lsh i -9) (lsh i -8)) (lsh i -3)))

;; TODO add functions for stopping, resetting, replacing
(defun boop-play-some-music ()
  (interactive)
  (unless (and boop-player-process (process-live-p boop-player-process))
    (boop-create-player-process))
  (boop-send-ints-to-player 'boop-player-int-function))

;; TODO do a function that renders to file, ideally with loop detection
