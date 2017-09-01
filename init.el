;; -*- lexical-binding: t; -*-
(defun my-memoize (f)
  (let ((cache (make-hash-table :test 'equal))
        (not-found (make-symbol "not-found")))
    (lambda (&rest args)
      (let ((hit (gethash args cache not-found)))
        (if (eq hit not-found)
            (let ((result (apply f args)))
              (puthash args result cache)
              result)
          hit)))))

;; so very silly
(setq package--init-file-ensured t)

(defvar my-init-time 0)

;; see http://emacs.stackexchange.com/questions/539/how-do-i-measure-performance-of-elisp-code
(defmacro with-timer (&rest forms)
  "Run the given FORMS, counting and displaying the elapsed time."
  (declare (indent 0))
  (let ((nowvar (make-symbol "now"))
        (body `(progn ,@forms)))
    `(let ((,nowvar (current-time)))
       (prog1 ,body
         (let ((elapsed (float-time (time-subtract (current-time) ,nowvar))))
           (setq my-init-time (+ my-init-time elapsed))
           (when (> elapsed 0.001)
             (message "spent (%.3fs)" elapsed)))))))

;; see http://endlessparentheses.com/init-org-Without-org-mode.html
(let (errors)
  (with-temp-buffer
    (insert-file "~/.emacs.d/init.org")
    (goto-char (point-min))
    (search-forward "\n* Init")
    (while (not (eobp))
      (forward-line 1)
      (cond
       ;; skip headers marked as TODO
       ((looking-at "^\\(\\*+\\) TODO +.*$")
        (when (ignore-errors (search-forward (format "\n%s " (match-string 1))
                                             nil t))
          (forward-line -1))) ; avoid (forward-line 1) messing this up
       ;; report headers
       ((looking-at "\\*\\{2,3\\} +.*$")
        (message "%s" (match-string 0)))
       ;; evaluate code blocks
       ((looking-at "^#\\+BEGIN_SRC +emacs-lisp.*$")
        (let (src-beg src-end)
          (condition-case error
              (progn
                (setq src-beg (match-end 0))
                (search-forward "\n#+END_SRC")
                (setq src-end (match-beginning 0))
                (with-timer (eval-region src-beg src-end)))
            (error
             (push (format "%s for:\n%s\n\n---\n"
                           (error-message-string error)
                           (buffer-substring src-beg src-end))
                   errors)))))
       ;; finish on the next level-1 header
       ((looking-at "^\\* ")
        (goto-char (point-max))))))
  (message "pre-init: (%.3fs)" my-init-time)
  (when errors
    (with-current-buffer (get-buffer-create "*init errors*")
      (insert (format "%i error(s) found\n\n" (length errors)))
      (dolist (error (nreverse errors))
        (insert error "\n"))
      (goto-char (point-min))
      (special-mode))
    (setq initial-buffer-choice (lambda () (get-buffer "*init errors*")))))
