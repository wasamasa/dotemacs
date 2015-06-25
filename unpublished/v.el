(defun v-line (size &optional init)
  (make-vector size init))

(defun v-grid (width height &optional init)
  (let (grid)
    (dotimes (_ height)
      (push (make-vector width init) grid))
    (vconcat grid)))

(defun v-cube (width height depth &optional init)
  (let (cube)
    (dotimes (_ depth)
      (push (v-grid width height init) cube))
    (vconcat cube)))

(defun v-peek (vector index-or-indices)
  (cond
   ((numberp index-or-indices)
    (aref vector index-or-indices))
   ((arrayp index-or-indices)
    (let ((result vector))
      (dotimes (index (length index-or-indices))
        (setq result (aref result (aref index-or-indices index))))
      result))))

(defun v-poke (vector index-or-indices value)
  (cond
   ((numberp index-or-indices)
    (aset vector index-or-indices value))
   ((arrayp index-or-indices)
    (let ((result vector)
          (last-index (1- (length index-or-indices))))
      (dotimes (index last-index)
        (setq result (aref result (aref index-or-indices index))))
      (aset result (aref index-or-indices last-index) value)))))

(let ((vector [0 1]))
  (v-poke vector 0 -1)
  (v-peek vector 0))

(let ((grid (v-grid 2 2)))
  (v-poke grid [1 1] t)
  (v-peek grid [1 1]))
