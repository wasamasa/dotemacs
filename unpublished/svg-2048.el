(require 'esxml)
(require 'dash)
(require 'cl-lib)

(defvar svg-2048-padding 8)
(defvar svg-2048-box-size 64)
(defvar svg-2048-offset svg-2048-padding)
(defvar svg-2048-roundness svg-2048-padding)
(defvar svg-2048-board-color "#bbada0")
(defvar svg-2048-tile-color "#eee4da")

(defvar svg-2048-board
  (cl-loop for i from 0 to 3
           nconc
           (cl-loop for j from 0 to 3 collect
                    (cons (cons i j) nil))))

(defun svg-2048-create-svg ()
  (let* ((field-width (+ (* 5 svg-2048-padding) (* 4 svg-2048-box-size)))
         (field-height (+ (* 5 svg-2048-padding) (* 4 svg-2048-box-size)))
         (width (+ field-width (* 2 svg-2048-offset)))
         (height (+ field-width (* 2 svg-2048-offset))))
    (cl-flet ((n->s (n) (number-to-string n)))
      (sxml-to-xml
       `(svg (@ (xmlns "http://www.w3.org/2000/svg")
                (width ,(n->s width))
                (height ,(n->s height)))
             (rect (@ (width ,(n->s field-width))
                      (height ,(n->s field-height))
                      (rx ,(n->s svg-2048-roundness))
                      (x ,(n->s svg-2048-offset))
                      (y ,(n->s svg-2048-offset))
                      (fill ,svg-2048-board-color)))
             ,@(cl-loop for ((i . j) . value) in svg-2048-board collect
                        `(g (rect (@ (width ,(n->s svg-2048-box-size))
                                  (height ,(n->s svg-2048-box-size))
                                  (rx ,(n->s (/ svg-2048-roundness 2)))
                                  (fill ,svg-2048-tile-color)
                                  (x ,(n->s (+ (* (1+ j) svg-2048-padding)
                                               (* j svg-2048-box-size)
                                               svg-2048-offset)))
                                  (y ,(n->s (+ (* (1+ i) svg-2048-padding)
                                               (* i svg-2048-box-size)
                                               svg-2048-offset)))))
                               (text (@
                                        (text-anchor "middle")
                                        (font-family "sans-serif")
                                        (font-size "24")
                                        (fill "#776e65")
                                        (x ,(n->s (+
                                                   (* (1+ j) svg-2048-padding)
                                                   (/ (* (1- (* (1+ j) 2)) svg-2048-box-size) 2)
                                                   svg-2048-offset)))
                                        (y ,(n->s (+ 0
                                                   (* (+ i 2) svg-2048-padding)
                                                   (/ (* (1- (* (1+ i) 2)) svg-2048-box-size) 2)
                                                   svg-2048-offset))))
                                     ,(n->s value)))))))))

(defun svg-2048-get-board-value (x y)
  (cdr (assoc (cons x y) svg-2048-board)))

(defun svg-2048-set-board-value (x y value)
  (setq svg-2048-board
        (-replace-at (-elem-index (assoc (cons x y) svg-2048-board)
                                  svg-2048-board)
                     (cons (cons x y) value) svg-2048-board)))

(define-derived-mode svg-2048-mode special-mode "2048"
  "A SVG game"
  (with-current-buffer (get-buffer-create "*svg 2048*")
    (buffer-disable-undo)
    (read-only-mode -1)
    (erase-buffer)
    (insert-image (create-image (svg-2048-create-svg) 'svg t))))

(defun svg-2048 ()
  (interactive)
  (switch-to-buffer "*svg 2048*")
  (svg-2048-mode)
  (goto-char (point-min)))

(defun message-last-key ()
  (interactive)
  (message "%s" (string last-command-event)))

(define-key svg-2048-mode-map (kbd "w") 'message-last-key)
(define-key svg-2048-mode-map (kbd "a") 'message-last-key)
(define-key svg-2048-mode-map (kbd "s") 'message-last-key)
(define-key svg-2048-mode-map (kbd "d") 'message-last-key)

(provide 'svg-2048)
