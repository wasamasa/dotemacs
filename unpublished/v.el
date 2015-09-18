(defalias 'v 'vector)

(defalias 'v-length 'length)
(defalias 'v-size 'length)

(defalias 'v-vector? 'vectorp)

(defalias 'v-fill 'fillarray)

(defalias 'v-line 'make-vector)

(defun v-grid (width height init)
  (let ((grid (make-vector height nil)))
    (dotimes (i height)
      (aset grid i (v-line width init)))
    grid))

(defalias 'v-ref 'aref)
(defalias 'v-set 'aset)

(let ((vector [0 1]))
  (v-set vector 0 -1)
  (v-ref vector 0))

(let ((grid (v-grid 2 2 nil)))
  (-> grid
      (v-ref 1)
      (v-set 1 t))
  (-> grid
      (v-ref 1)
      (v-ref 1)))

(defmacro v-ref-in (vector spec)
  (cond
   ((and (listp spec) (= (length spec) 1))
    `(v-ref ,vector ,(car spec)))
   ((listp spec)
    `(v-ref (v-ref-in ,vector ,(cdr spec))
            ,(car spec)))
   (t (error "Wrong spec"))))

(defmacro v-set-in (vector spec value)
  `(v-set (v-ref-in ,vector ,(cdr spec))
          ,(car spec) ,value))

(let ((grid (v-grid 2 2 nil)))
  (v-set-in grid (1 1) t)
  (v-ref-in grid (1 1)))

(defalias 'v->vector 'vconcat)

(defun v->list (&rest sequences)
  (append (apply 'vconcat sequences) nil))

(defalias 'v->string 'concat)

(defalias 'v-copy 'copy-sequence)

(defun v-deep-copy (vector)
  (copy-tree vector t))

(defun v--range (start stop step)
  (when (not (integerp start))
    (error "START must be an integer"))
  (when (not (integerp stop))
    (error "STOP must be an integer"))
  (when (not (integerp step))
    (error "STEP must be an integer"))
  (when (zerop step)
    (error "STEP must be non-zero"))
  (let ((size (if (zerop (- stop start))
                  0
                (/ (- stop start) step))))
    (if (<= size 0)
        []
      (let ((vector (make-vector size nil))
            (i 0)
            (item start)
            (comparator (if (> step 0) '< '>)))
        (while (funcall comparator item stop)
          (aset vector i item)
          (setq item (+ item step))
          (setq i (1+ i)))
        vector))))

(defun v-range (&rest spec)
  (cond
   ((= (length spec) 1)
    (v--range 0 (car spec) 1))
   ((= (length spec) 2)
    (v--range (car spec) (cadr spec) 1))
   ((= (length spec) 3)
    (v--range (car spec) (cadr spec) (nth 2 spec)))
   (t (error "Wrong spec"))))

(v-range 5)
(v-range 0 5)
(v-range 0 10 2)

(defun v-each (vector fn)
  (let ((size (length vector))
        (i 0))
    (while (< i size)
      (funcall fn (aref vector i))
      (setq i (1+ i)))))
(put 'v-each 'lisp-indent-function 1)

;; this is sort of ugly...
(v-each [1 2 3]
  (lambda (x)
    (v-each [1 2 3]
      (lambda (y)
        (message "%s x %s is %s"
                 x y (* x y))))))

(defun v-map (fn vector)
  (let* ((size (length vector))
         (i 0)
         (results (make-vector size nil)))
    (while (< i size)
      (aset results i (funcall fn (aref vector i)))
      (setq i (1+ i)))
    results))

(v-map '1+ [0 1 2])

;; TODO figure out more uses in spec other than binding the variable
;; and specifying the vector, like python- (either stop argument or
;; start and stop and optional step argument) or CL- (keywords!) or
;; elisp-style (fixed ordering and optional) beginning and end
;; positions
(defmacro v-do (spec &rest body)
  (declare (indent 1))
  (let ((size (make-symbol "s"))
        (i (make-symbol "i")))
    `(let ((,size (length ,(cadr spec)))
           (,i 0)
           ,(car spec))
       (while (< ,i ,size)
         (setq ,(car spec) (aref ,(cadr spec) ,i))
         ,@body
         (setq ,i (1+ ,i))))))

;; much better!
(v-do (x [1 2 3])
  (v-do (y [1 2 3])
    (message "%s x %s is %s"
             x y (* x y))))

(defun v-shuffle (vector)
  "Shuffle VECTOR in-place.
This uses the Knuth shuffle algorithm."
  (let ((i (1- (length vector)))
        j)
    (while (>= i 1)
      (setq j (random (1+ i)))
      ;; swap items at i and j
      (let ((x (aref vector i))
            (y (aref vector j)))
        (aset vector i y)
        (aset vector j x))
      (setq i (1- i)))
    vector))

;; other algorithms could be sort, binary search, ...
;; other primitives could be subset, extend, fill, ...

;; write proper tests (and run them!)
;; write proper docs (see dash and f.el for examples)

;; APIs to steal from:
;; - http://docs.oracle.com/javase/7/docs/api/java/util/Arrays.html
;; - http://srfi.schemers.org/srfi-43/srfi-43.html
;; - http://www.clojuredocs.org/clojure.core

(provide 'v)
