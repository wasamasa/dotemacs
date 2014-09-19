;; lexical-binding: t

;; Sound basics
;; play/pacat/aplay/... allow you to send raw audio
;; for the 8bit sound we'll use a sample rate of 22,050 Hz and u8 as bit depth
;; the former means 22,050 values make up a second of sound
;; the latter that the values are between 0 and 255
;; if you'd plot the resulting graph, you'd see wave forms
;; so, if you send the right ascii characters, you'll get sawtooths and such
;; timbre is affected by the general wave form
;; loudness by the amplitude of the wave form
;; multiple sounds need to be mixed to a final wave form
;; modification of existing wave forms is done by filtering

(defvar blip-player-process nil)
(defvar blip-audio-buffer (get-buffer-create "*blip audio buffer*"))
(defvar blip-samplerate 22050)
(defvar blip-bitdepth 256)

(defun blip-create-player-process ()
  (let ((process-connection-type nil))
    ;; TODO make it customizable
    (if (executable-find "pacat")
        (setq blip-player-process
              (start-process "pacat" "*pacat*" "pacat" "--format=u8" "--rate=22050"))
      (setq blip-player-process
            (start-process "aplay" "*aplay*" "aplay" "--format=U8" "--rate=22050")))))

(defun blip-ensure-process ()
  (unless (and blip-player-process (process-live-p blip-player-process))
    (blip-create-player-process)))

(defun blip-send-int-to-player (int)
  (process-send-string blip-player-process (string int)))

;; TODO make it controllable (closures?)
;; (boop (lambda (i) (mod i 256)))
;; => plays sawtooth
;; (boop (lambda (i) (mod (* 2 i) 256)))
;; => makes it play a higher-pitched sawtooth
;; (boop)
;; stops playback

;; ignore this below

(let ((thunk (lambda (n) (1+ n))))
  (defun blip (new-thunk)
    (setq thunk new-thunk))

  (defun create-blip ()
    (let ((counter 0))
      (lambda ()
        (setq counter (1+ counter))
        (funcall thunk counter)))))

;; and that above, too

;; TODO this shouldn't block emacs
;; TODO after that's solved, control playback
(defun blip-send-ints-to-player (thunk)
  (let ((i 0))
    (while t
      (blip-send-int-to-player (funcall thunk i))
      (setq i (1+ i)))))

(defun blip-player-int-function (i)
  ;; infix: (t>>9&t>>8)*(t>>3)
  (* (logand (lsh i -9) (lsh i -8)) (lsh -i 3)))

(defun blip-play-loop ()
  (interactive)
  (blip-ensure-process)
  (blip-send-ints-to-player 'blip-player-int-function))

;; TODO do a function that renders to file, ideally with loop detection
;; TODO graph resulting waveform to ascii
