;; see http://endlessparentheses.com/init-org-Without-org-mode.html
(with-temp-buffer
  (insert-file "~/.emacs.d/init.org")
  (goto-char (point-min))
  (search-forward "\n* Init")
  (while (not (eobp))
    (forward-line 1)
    (cond
     ;; Report Headers
     ((looking-at (format "\\*\\{2,3\\} +.*$" my-init-headline-message-depth))
      (message "%s" (match-string 0)))
     ;; Evaluate Code Blocks
     ((looking-at "^#\\+BEGIN_SRC +emacs-lisp.*$")
      (let ((l (match-end 0)))
        (search-forward "\n#+END_SRC")
        (eval-region l (match-beginning 0))))
     ;; Finish on the next level-1 header
     ((looking-at "^\\* ")
      (goto-char (point-max))))))
