(uiop:define-package #:reblocks-ui2/tables/cell
  (:use #:cl)
  (:import-from #:serapeum
                #:->)
  (:import-from #:reblocks/widget
                #:widget)
  (:export #:cell
           #:cell-colspan
           #:cell-rowspan
           #:cell-widget))
(in-package #:reblocks-ui2/tables/cell)


(defclass cell ()
  ((colspan :initarg :colspan
            :type (or null integer)
            :initform nil
            :reader cell-colspan)
   (rowspan :initarg :rowspan
            :type (or null integer)
            :initform nil
            :reader cell-rowspan)
   (widget :initarg :widget
           :type widget
           :reader cell-widget))
  (:documentation "A thin wrapper around cell content allowing to add such attributes as :colspan or :rowspan."))


(-> cell (widget
          &key
          (:colspan (or null integer))
          (:rowspan (or null integer))
          (:cell-class (or symbol class)))
    (values cell &optional))

(defun cell (widget &key colspan rowspan (cell-class 'cell))
  (make-instance cell-class
                 :widget widget
                 :colspan colspan
                 :rowspan rowspan))
