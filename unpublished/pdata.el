(require 'dash)

(defvar pdata-allow-duplicates nil)

;; since mutating lists is a bad idea, a vector will be used instead,
;; its only element is queried and set to the result of the pdata
;; operation in question
(defun pdata-create ()
  (vector nil))
(defalias 'pdata 'pdata-create)

(defun pdata-set (database records)
  (aset database 0 records))
(put 'pdata-set 'lisp-indent-function 1)

(defun pdata-get (database)
  (aref database 0))
(put 'pdata-get 'lisp-indent-function 1)

(defun pdata-dump (database)
  (dolist (record (pdata-get database))
    (message "%s" record)))

(defun pdata-add-record (database record)
  ;; adds record at end of database
  (let ((records (pdata-get database)))
    (when (or pdata-allow-duplicates
              (not (member record records)))
      (pdata-set database
        (-snoc records record)))))
(put 'pdata-add-record 'lisp-indent-function 1)

(defun pdata-add-records (database &rest records)
  (-each records (lambda (record) (pdata-add-record database record))))
(put 'pdata-add-records 'lisp-indent-function 1)

(defun pdata--where (clauses)
  (lambda (record)
    (-all?
     (lambda (key-value)
       (let ((key (car key-value))
             (value (cadr key-value)))
         (and (plist-member record key)
              (equal (plist-get record key) value))))
     (-partition 2 clauses))))

(defun pdata-select (database clauses &optional column)
  (let ((results (-filter (pdata--where clauses)
                          (pdata-get database))))
    (cond
     ((keywordp column)
      (-map (lambda (record) (plist-get record column)) results))
     ;; TODO allow selecting multiple columns, error handling
     (t results))))

;; convenience method stolen from activerecord
(defun pdata-select-at (database clauses &optional column)
  (car (pdata-select database clauses column)))

(defun pdata-delete (database clauses)
  (pdata-set database
    (-remove (pdata--where clauses)
             (pdata-get database))))

(defun pdata--update (updates)
  (lambda (record)
    (-reduce-from
     (lambda (acc key-value)
       (let ((key (car key-value))
             (value (cadr key-value)))
         (if (plist-member acc key)
           (plist-put acc key value)
           acc)))
     (-clone record)
     (-partition 2 updates))))

(defun pdata-update (database clauses &rest updates)
  (pdata-set database
    (-map-when
     (pdata--where clauses)
     (pdata--update updates)
     (pdata-get database))))
(put 'pdata-update 'lisp-indent-function 2)

(setq my-db (pdata-create))

(pdata-add-record my-db '(:x 0 :y 0 :type background))
(pdata-add-record my-db '(:x 1 :y 0 :type background))
(pdata-add-record my-db '(:x 2 :y 0 :type background))
(pdata-add-record my-db '(:x 3 :y 0 :type background))

(pdata-select my-db '(:y 0))
(pdata-select my-db '(:x 1 :y 0))
(pdata-select my-db '(:x 1 :y 1))

(pdata-delete my-db '(:x 3))
(pdata-delete my-db '(:x 4))

(pdata-update my-db '(:y 0) :hurr nil)
(pdata-update my-db '(:y 0) :y 1)

(pdata-get my-db)
