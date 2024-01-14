(uiop:define-package #:reblocks-ui2/utils/margin
  (:use #:cl)
  (:import-from #:alexandria
                #:length=)
  (:import-from #:serapeum
                #:soft-list-of)
  (:import-from #:reblocks-ui2/utils/primitive-to
                #:process-primitive-arg)
  (:export #:margin
           #:margin-left
           #:margin-right
           #:margin-top
           #:margin-bottom))
(in-package #:reblocks-ui2/utils/margin)


(deftype margin-size ()
  '(member :s :m :l :xl))


(deftype nullable-margin-size ()
  '(or null margin-size))


(defclass margin ()
  ((left :initform nil
         :initarg :left
         :type nullable-margin-size
         :reader margin-left)
   (right :initform nil
          :initarg :right
          :type nullable-margin-size
          :reader margin-right)
   (top :initform nil
        :initarg :top
        :type nullable-margin-size
        :reader margin-top)
   (bottom :initform nil
           :initarg :bottom
           :type nullable-margin-size
           :reader margin-bottom)))


(declaim (ftype (function ((or margin
                               margin-size
                               (soft-list-of nullable-margin-size)))
                          (values margin &optional))
                margin))

(defun margin (value)
  (typecase value
    (margin
     value)
    (keyword
     (make-instance 'margin
                    :left value
                    :top value
                    :right value
                    :bottom value))
    (list
     (cond
       ((length= 2 value)
        (destructuring-bind (horizontal vertical)
            value
          (make-instance 'margin
                         :left horizontal
                         :right horizontal
                         :top vertical
                         :bottom vertical)))
       ((length= 4 value)
        (destructuring-bind (left top right bottom)
            value
          (make-instance 'margin
                         :left left
                         :right top
                         :top right
                         :bottom bottom)))
       (t
        (error "Margin value ~A should have 2 or 4 items."
               value))))))


(defmethod process-primitive-arg ((name (eql :margin))
                                  value)
  (declare (ignore name))
  (when value
    (margin value)))
