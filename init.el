;; see http://emacs.stackexchange.com/questions/539/how-do-i-measure-performance-of-elisp-code
(defmacro with-timer (&rest forms)
  "Run the given FORMS, counting and displaying the elapsed time."
  (declare (indent 1))
  (let ((nowvar (make-symbol "now"))
        (body   `(progn ,@forms)))
    `(let ((,nowvar (current-time)))
       (prog1 ,body
         (let ((elapsed (float-time (time-subtract (current-time) ,nowvar))))
           (message "spent (%.3fs)" elapsed))))))

;; see http://endlessparentheses.com/init-org-Without-org-mode.html
(with-temp-buffer
  (insert-file "~/.emacs.d/init.org")
  (goto-char (point-min))
  (search-forward "\n* Init")
  (while (not (eobp))
    (forward-line 1)
    (cond
     ;; Report Headers
     ((looking-at "\\*\\{2,3\\} +.*$")
      (message "%s" (match-string 0)))
     ;; Evaluate Code Blocks
     ((looking-at "^#\\+BEGIN_SRC +emacs-lisp.*$")
      (let ((l (match-end 0)))
        (search-forward "\n#+END_SRC")
        (with-timer (eval-region l (match-beginning 0)))))
     ;; Finish on the next level-1 header
     ((looking-at "^\\* ")
      (goto-char (point-max))))))
