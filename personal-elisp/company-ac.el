(require 'dash)

(defun company-ac-prefix (backend)
  (let ((prefix (cdr (assq 'prefix backend))))
    (if (stringp prefix)
        ;; TODO deal with this case
        (ignore)
      (buffer-substring (point) (funcall prefix)))))

(defun company-ac-candidates (backend prefix)
  ;; TODO doesn't work yet
    (funcall (cdr (assq 'candidates backend))))

(defun company-ac-doc-buffer (backend)
  (--when-let (cdr (assq 'document backend))
    (with-current-buffer (get-buffer-create "*bla*")
      (insert (funcall it))
      (current-buffer))))

(defun company-ac-init (backend)
  (--when-let (cdr (assq 'init backend))
    (funcall it)))

(defmacro company-ac-define-source (name backend)
  (let ((name name) (backend backend))
    `(defun ,name (command &optional arg &rest ignored)
       (interactive (list 'interactive))
       (case command
         (interactive (company-begin-backend ',name))
         (prefix (company-ac-prefix ,backend))
         (candidates (company-ac-candidates ,backend arg))
         (no-cache (unless (assq 'cache ,backend) t))
         (doc-buffer (company-ac-doc-buffer ,backend))
         (init (company-ac-init ,backend))))))

;; config + exemplary use

(require 'jedi)

(company-ac-define-source company-jedi ac-source-jedi-direct)
;; the above expands to:
;; (defun company-jedi (command &optional arg &rest ignored)
;;   (interactive (list 'interactive))
;;   (case command
;;     (interactive (company-begin-backend 'company-jedi))
;;     (prefix (company-ac-prefix ac-source-jedi-direct))
;;     (candidates (company-ac-candidates ac-source-jedi-direct arg))
;;     (no-cache (unless (assq 'cache ac-source-jedi-direct) t))
;;     (doc-buffer (company-ac-doc-buffer ac-source-jedi-direct))
;;     (init (company-ac-init ac-source-jedi-direct))))

(add-to-list 'company-backends 'company-jedi)

(provide 'company-ac)
