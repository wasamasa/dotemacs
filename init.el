;; so very silly
(setq package--init-file-ensured t)

;; see http://emacs.stackexchange.com/questions/539/how-do-i-measure-performance-of-elisp-code

(defmacro with-timer (&rest forms)
  "Run the given FORMS, counting and displaying the elapsed time."
  (declare (indent 0))
  (let ((nowvar (make-symbol "now"))
        (body `(progn ,@forms)))
    `(let ((,nowvar (current-time)))
       (prog1 ,body
         (let ((elapsed (float-time (time-subtract (current-time) ,nowvar))))
           (when (> elapsed 0.001)
             (message "spent (%.3fs)" elapsed)))))))

;; see http://endlessparentheses.com/init-org-Without-org-mode.html
(with-temp-buffer
  (insert-file "~/.emacs.d/init.org")
  (goto-char (point-min))
  (search-forward "\n* Init")
  (while (not (eobp))
    (forward-line 1)
    (cond
     ;; skip headers marked as TODO
     ((looking-at "^\\(\\*+\\) TODO +.*$")
      (search-forward (format "\n%s " (match-string 1))))
     ;; report headers
     ((looking-at "\\*\\{2,3\\} +.*$")
      (message "%s" (match-string 0)))
     ;; evaluate code blocks
     ((looking-at "^#\\+BEGIN_SRC +emacs-lisp.*$")
      (let ((l (match-end 0)))
        (search-forward "\n#+END_SRC")
        (with-timer (eval-region l (match-beginning 0)))))
     ;; finish on the next level-1 header
     ((looking-at "^\\* ")
      (goto-char (point-max))))))
