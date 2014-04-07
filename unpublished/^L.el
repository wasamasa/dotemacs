(defgroup ^L nil
  "Turn ^L glyphs into horizontal lines."
  :prefix "^L-"
  :group 'faces)

(defface ^L-line
  '((t :inherit font-lock-comment-face :strike-through t))
  "Face for ^L-mode lines."
  :group '^L)

(defcustom ^L-kick-cursor t
  "When t, entering a line moves the cursor away from it."
  :type 'boolean
  :group '^L)

(defun ^L-kick-cursor (old new)
  (cond ((and (< old new) (/= (point-max) (point)))
         (forward-char 1))
        ((and (>= old new) (/= (point-min) (point)))
         (forward-char -1))))

(defun ^L-adjust-display-table ()
  (let ((display-table (or (purecopy (window-display-table))
                           (make-display-table))))
    (aset display-table ?\^L [? ])
    (set-window-display-table nil display-table)))

(defun ^L-adjust-font-lock ()
  (font-lock-add-keywords
   nil
   `((,page-delimiter
      0
      (if ^L-kick-cursor
          '(face ^L-line display (space . (:width text))
             point-entered ^L-kick-cursor)
        '(face ^L-line display (space . (:width text))))
      t)))
  (font-lock-fontify-buffer))

(define-minor-mode ^L-mode
  "Toggle ^L-mode.
^L glyphs are displayed as horizontal lines."
  :lighter " ^L"
  (progn
    (^L-adjust-display-table)
    (^L-adjust-font-lock)))

(provide '^L)
