;; -*- lexical-binding: t -*-
(require 'helm)

(defvar helm-fkey-keymap
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map helm-map)
    (define-key map [remap self-insert-command] 'exit-minibuffer)
    map))

(defun helm-fkey-call-function (data)
  "Calls the function associated to the last key pressed by
looking up DATA"
  (let ((command (nth 2 (assoc (string last-command-event) data))))
    (when command
      (command-execute command 'record))))

(defface helm-fkey-key-face '((t (:foreground "red" :weight bold)))
  "Face for the highlighted key")
(defface helm-fkey-bracket-face '((t (:weight bold)))
  "Face for the highlighted brackets")

(defun helm-fkey-propertize-candidate (str)
  "Propertizes a helm-fkey candidate, both brackets and the
enclosed glyph get a distinct face"
  (let* ((split-str (split-string str "\\(\\[\\|\\]\\)"))
         (beg (car split-str))
         (opening-bracket "[")
         (key (cadr split-str))
         (closing-bracket "]")
         (rest (nth 2 split-str)))
    (concat beg
            (propertize opening-bracket 'face 'helm-fkey-bracket-face)
            (propertize key 'face 'helm-fkey-key-face)
            (propertize closing-bracket 'face 'helm-fkey-bracket-face)
            rest)))

(defun helm-fkey-prettify (candidates)
  "Applies `helm-fkey-propertize-candidate' to CANDIDATES"
  (mapcar 'helm-fkey-propertize-candidate candidates))

(defmacro helm-fkey (label key bind data)
  "Creates and binds a helm-fkey function"
  (let ((func-name (intern (concat "helm-" key))))
    `(progn
       (defun ,func-name ()
         (interactive)
         (let* ((data ,data)
                (source '((name . ,label)
                          (candidates . (lambda () (mapcar 'cadr ,data)))
                          (candidate-transformer helm-fkey-prettify)
                          (action ("Execute" . (lambda (_) (helm-fkey-call-function ,data)))))))
           (helm :sources source :keymap helm-fkey-keymap :prompt "Key: " :buffer ,(concat "*helm-" key))))
       (global-set-key (kbd ,bind) ',func-name))))

(provide 'helm-fkeys)
