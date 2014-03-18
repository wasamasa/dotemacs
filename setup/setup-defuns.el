;; -*- lexical-binding: t -*-
(require 'cl-lib)
(require 's)
(require 'dash)

(defmacro my-eval-after (feature &rest body)
  (cl-declare (indent 1))
  `(eval-after-load ',feature '(progn ,@body)))

(defun my-define-keys (keymap &rest binds)
  (cl-dolist (pair (-partition 2 binds))
    (let ((key (car pair))
          (func (cadr pair)))
      (define-key keymap key func))))

(defun my-global-set-keys (&rest binds)
  (cl-dolist (pair (-partition 2 binds))
    (let ((key (car pair))
          (func (cadr pair)))
      (define-key key func))))

(defun my-replace-in-region-or-buffer (search-replace-list)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max)))
        (case-fold-search nil))
    (save-excursion
      (cl-dolist (sr search-replace-list)
        (goto-char beg)
        (while (re-search-forward (car sr) end t)
          (replace-match (cadr sr) t t))))))

(defun my-replace-paragraphs ()
  (interactive)
  (my-replace-in-region-or-buffer '(("\n\n" "\n"))))

(defun my-any-regex-in-string (regexes string)
  "Tests whether any of the given regular expressions is present
in the given string."
  (when string
    (cl-dolist (regex regexes)
      (when (s-contains? regex string)
        (cl-return t)))))

(defun my-kill-word (arg)
  "Kill characters forward until encountering the end of a word.
With argument ARG, do this that many times.  Do not move."
  (interactive "p")
  (kill-region (point) (save-excursion (forward-word arg) (point))))

(defun my-backward-kill-word (arg)
  "Kill characters backward until encountering the end of a word.
With argument ARG, do this that many times.  Do not move."
  (interactive "p")
  (my-kill-word (- arg)))

(defun my-log (str)
  (save-current-buffer
    (set-buffer (get-buffer-create "*log*"))
    (goto-char (point-max))
    (insert (format "%s\n" str))))

(provide 'setup-defuns)
