;;; php-boris-minor-mode.el --- a minor mode to evaluate PHP code in the Boris PHP repl"

;; Copyright (C) 2013 steckerhalter

;; Author: steckerhalter
;; URL: https://github.com/steckerhalter/php-boris-minor-mode
;; Package-Requires: ((php-boris "0.0.1") (highlight))
;; Keywords: php repl eval

;;; Commentary:

;; Adds a few keyboard shortcuts to `php-mode' (e.g. C-c C-c) to send
;; code from a PHP buffer to the Boris PHP repl and evaluate it there.

;;; Code:

(require 'php-boris)
(require 'highlight)

(defun php-boris-eval-region (start end)
  "Evaluate the region.
The two arguments START and END are character positions;
they can be in either order."
  (interactive "r")
  (php-boris-interactive-eval start end (buffer-substring-no-properties start end)))

(defun php-boris-eval-buffer ()
  "Evaluate the current buffer."
  (interactive)
  (php-boris-eval-region (point-min) (point-max)))

(defun php-boris-eval-defun ()
  "Evaluate the current function."
  (interactive)
  (let ((start (save-excursion (php-beginning-of-defun) (point)))
        (end (save-excursion (php-end-of-defun) (point))))
    (php-boris-eval-region start end)))

(defun php-boris-region-for-expression-at-point ()
  "Return the start and end position of statement at point."
  (save-excursion
    (save-match-data
      (when (equal (char-before) ?\;) (backward-char))
      (c-end-of-statement)
      (let ((end (point)))
        (c-beginning-of-statement-1)
        (list (point) end)))))

(defun php-boris-eval-dwim ()
  "Print and evaluate the current statement in Boris PHP REPL.
With active region print and evaluate the text in the region."
  (interactive)
  (let ((region (if (region-active-p)
                    (list (region-beginning) (region-end))
                  (php-boris-region-for-expression-at-point))))
    (apply #'php-boris-eval-region region)))

(defun php-boris-interactive-eval (start end form)
  "Evaluate the given FORM in the PHP REPL."
  (let* ((buffer (current-buffer))
         (repl-buffer (php-boris-get-repl t)))
    (comint-send-string repl-buffer (php-boris-clean-php-code form))
    (comint-send-string repl-buffer "\n")
    (unless (= php-boris-eval-flash-duration 0)
      (php-boris-eval-flash start end))))

(defun php-boris-get-repl (&optional show focus)
  "Get the existing repl or create new one and return the repl buffer.
If SHOW is t make the repl visible. If FOCUS is t show and focus
the repl."
  (interactive)
  (let ((process (get-process php-boris-process-name)))
    (if process (php-boris-get-repl-with-process process show focus)
      (php-boris-get-repl-create show focus)
      )))

(defun php-boris-get-repl-create (&optional show focus)
  "Create a new Boris repl.
If SHOW is t make the repl visible. If FOCUS is t show and focus
the repl. Return the repl buffer."
  (let ((buffer (current-buffer)))
    (cond
     (show (let ((repl-buffer (progn (php-boris) (current-buffer))))
             (sit-for 0.1 t)
             (pop-to-buffer buffer)
             repl-buffer))
     (focus (progn (php-boris)
                   (current-buffer)))
     (t (save-window-excursion
          (php-boris)
          (current-buffer))))
    ))

(defun php-boris-get-repl-with-process (process &optional show focus)
  "Get the Boris repl from the process.
 If SHOW is t make the repl visible. If FOCUS is t show and focus
the repl. Return the repl buffer."
  (let ((repl-buffer (process-buffer process)))
    (cond
     (show (set-window-point
            (display-buffer repl-buffer)
            (1+ (buffer-size repl-buffer))))
     (focus (php-boris))
     )
    repl-buffer)
  )

(defun php-boris-clean-php-code (code)
  "Remove the php tag if it prefixes CODE."
  (if (string-prefix-p "<?php" code t)
      (substring code 5)
    code))

(defun php-boris-goto-source ()
  "Go the source code definition of the object at point."
  (interactive)
  (let* (output
         (repl-buffer (php-boris-get-repl))
         (word (current-word))
         (code (format
                "
if (is_object(%s)) {
    $r = new ReflectionObject(%s);
    $json = json_encode(
        array(
            'filename' => $r->getFileName(),
            'line' => $r->getStartLine()
        )
    );
    print \"{{{$json}}}\";
}
" word word)))
    (setq output
          (with-temp-buffer
            (comint-redirect-send-command-to-process code (current-buffer) repl-buffer nil t)
            (sit-for 0.2 t)
            (goto-char (point-max))
            (re-search-backward "{{\\({.*?}\\)}}" nil t)
            (match-string 1)))
    (if (or (null output) (string= "{$json}" output))
        (message "No source file found for `%s'" word)
      (let* ((json-object-type 'hash-table)
             (hash (json-read-from-string output))
             (filename (gethash "filename" hash))
             (line (gethash "line" hash)))
        (if (null filename)
            (message "No source file found for `%s'" word)
          (find-file-existing filename)
          (goto-line line)
          (message "Found definition for `%s' in file `%s' on line %s" word filename line)
          )))))

(defcustom php-boris-eval-flash-duration 0.4
  "*Duration the evaluated expession should be highlighted.
When set to 0 the flashing will be disabled."
  :type 'number
  :group 'php-boris)

(defcustom php-boris-eval-flash-face 'region
  "*Face to use for showing the region during the evaluation."
  :type 'face
  :group 'php-boris)

(defun php-boris-eval-flash (start end &optional face duration)
  "Flash the given region form START to END.
If FACE and DURATION are given use these, otherwise the defaults."
  (let ((face (if face face php-boris-eval-flash-face))
        (duration (if duration duration php-boris-eval-flash-duration)))
    (hlt-highlight-region start end face)
    (run-at-time duration nil #'hlt-unhighlight-region start end face)))

(defun php-boris-switch-to-repl ()
  "Switch to the repl making it visible if it is hidden."
  (interactive)
  (php-boris-get-repl nil t)
  )

;;;###autoload
(define-minor-mode php-boris-minor-mode
  "PHP boris minor mode.
Interactively with no argument, this command toggles the mode.  A
positive prefix argument enables the mode, any other prefix
argument disables it.  From Lisp, argument omitted or nil enables
the mode, `toggle' toggles the state.

When the minor mode is enabled, it adds several commands to
interact with the Boris PHP REPL.

The keys largely correspond to what nrepl uses, see
`https://github.com/clojure-emacs/nrepl.el'"
  :group 'php-boris
  :lighter " brs"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c C-c") 'php-boris-eval-dwim)
            (define-key map (kbd "C-c C-k") 'php-boris-eval-buffer)
            (define-key map (kbd "C-c C-r") 'php-boris-eval-region)
            (define-key map (kbd "C-c C-z") 'php-boris-switch-to-repl)
            (define-key map (kbd "C-c C-s") 'php-boris-goto-source)
            (define-key map (kbd "C-M-x") 'php-boris-eval-defun)
            map)
  )

;;;###autoload
(add-hook 'php-mode-hook 'php-boris-minor-mode)

(provide 'php-boris-minor-mode)
;;; php-boris-minor-mode.el ends here
