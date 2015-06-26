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

