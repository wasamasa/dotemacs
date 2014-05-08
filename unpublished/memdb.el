(require 'dash)

(defvar memdb-allow-duplicates nil)

;; since mutating lists is a bad idea, a vector will be used instead,
;; its only element is queried and set to the result of the memdb
;; operation in question
(defun memdb-create ()
  (vector nil))

(defun memdb-set (database records)
  (aset database 0 records))
(put 'memdb-set 'lisp-indent-function 1)

(defun memdb-get (database)
  (aref database 0))
(put 'memdb-get 'lisp-indent-function 1)

(defun memdb-dump (database)
  (dolist (record (memdb-get database))
    (message "%s" record)))

(defun memdb-add-record (database record)
  (let ((records (memdb-get database)))
    (when (or memdb-allow-duplicates
              (not (member record records)))
      (memdb-set database
        (-snoc records record)))))

(defun memdb--where (clauses)
  (lambda (record)
    (-all?
     (lambda (key-value)
       (let ((key (car key-value))
             (value (cadr key-value)))
         (and (plist-member record key)
              (equal (plist-get record key) value))))
     (-partition 2 clauses))))

(defun memdb-select (database clauses)
  (-filter (memdb--where clauses)
           (memdb-get database)))

(defun memdb-delete (database clauses)
  (memdb-set database
    (-remove (memdb--where clauses)
             (memdb-get database))))

(defun memdb--update (updates)
  (lambda (record)
    (-reduce-from
     ;; TODO plist-put just adds not existing keys
     (lambda (acc key-value)
       (let ((key (car key-value))
             (value (cadr key-value)))
         (plist-put acc key value)))
     (-clone record)
     (-partition 2 updates))))

(defun memdb-update (database clauses &rest updates)
  (memdb-set database
    (-map-when
     (memdb--where clauses)
     (memdb--update updates)
     (memdb-get database))))

(setq my-memdb (memdb-create))

(memdb-add-record my-memdb '(:x 0 :y 0 :type background))
(memdb-add-record my-memdb '(:x 1 :y 0 :type background))
(memdb-add-record my-memdb '(:x 2 :y 0 :type background))
(memdb-add-record my-memdb '(:x 3 :y 0 :type background))

(memdb-select my-memdb '(:y 0))
(memdb-select my-memdb '(:x 1 :y 0))
(memdb-select my-memdb '(:x 1 :y 1))

(memdb-delete my-memdb '(:x 3))
(memdb-delete my-memdb '(:x 4))

(memdb-update my-memdb '(:y 0) :hurr nil)
