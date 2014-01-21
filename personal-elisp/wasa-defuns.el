;; -*- lexical-binding: t -*-
(require 'cl-lib)
(require 's)
(require 'dash)

(defun wasa-define-keys (keymap &rest binds)
  (cl-dolist (pair (-partition 2 binds))
    (let ((key (first pair))
          (func (second pair)))
      (define-key keymap key func))))

(defun wasa-global-set-keys (&rest binds)
  (cl-dolist (pair (-partition 2 binds))
    (let ((key (first pair))
          (func (second pair)))
      (define-key key func))))

(defun wasa-replace-in-region-or-buffer (search-replace-list)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max)))
        (case-fold-search nil))
    (save-excursion
      (cl-dolist (sr search-replace-list)
        (goto-char beg)
        (while (re-search-forward (car sr) end t)
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

(defun wasa-any-regex-in-string (regexes string)
  "Tests whether any of the given regular expressions is present in the given string."
  (cl-dolist (regex regexes)
    (when (s-contains? regex string)
      (cl-return t))))

(defun wasa-kill-word (arg)
  "Kill characters forward until encountering the end of a word.
With argument ARG, do this that many times.  Do not move."
  (interactive "p")
  (kill-region (point) (save-excursion (forward-word arg) (point))))

(defun wasa-backward-kill-word (arg)
  "Kill characters backward until encountering the end of a word.
With argument ARG, do this that many times.  Do not move."
  (interactive "p")
  (wasa-kill-word (- arg)))

(provide 'wasa-defuns)
