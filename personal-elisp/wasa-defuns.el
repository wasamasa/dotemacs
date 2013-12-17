(defun wasa-replace-in-region-or-buffer (search-replace-list)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max)))
        (case-fold-search nil))
    (save-excursion
      (dolist (sr search-replace-list)
        (goto-char beg)
        (while (search-forward (car sr) end t)
          (replace-match (cadr sr) t t))))))

(defun wasa-replace-paragraphs ()
  (interactive)
  (wasa-replace-in-region-or-buffer '(("\n\n" "\n"))))

(defun wasa-replace-tex-umlauts ()
  (interactive)
  (wasa-replace-in-region-or-buffer
   '(("Ä" "\"A")
     ("Ö" "\"O")
     ("Ü" "\"U")
     ("ä" "\"a")
     ("ö" "\"o")
     ("ü" "\"u")
     ("ß" "\"s"))))

(defun wasa-region-test (beg end)
  (interactive "r")
  (unless (region-active-p)
    (setq beg 0)(setq end 0))
  (message "Region: %d %d" beg end))

(provide 'wasa-defuns)
