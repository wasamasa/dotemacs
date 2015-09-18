(defalias 'v-line 'make-vector)

(defun v-grid (width height init)
  (let (grid)
    (dotimes (_ height)
      (push (make-vector width init) grid))
    (vconcat grid)))

(defun v-cube (width height depth init)
  (let (cube)
    (dotimes (_ depth)
      (push (v-grid width height init) cube))
    (vconcat cube)))

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
   (t (error "Wrong spec!"))))

(defmacro v-set-in (vector spec value)
  `(v-set (v-ref-in ,vector ,(cdr spec))
          ,(car spec) ,value))

(let ((grid (v-grid 2 2 nil)))
  (v-set-in grid (1 1) t)
  (v-ref-in grid (1 1)))

(defalias 'v-copy 'copy-sequence)

(defun v-deep-copy (vector)
  (copy-tree vector t))

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

;; APIs to steal from:
;; - http://docs.oracle.com/javase/7/docs/api/java/util/Arrays.html
;; - http://srfi.schemers.org/srfi-43/srfi-43.html

(provide 'v)
