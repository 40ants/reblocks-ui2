(uiop:define-package #:reblocks-ui2/utils/padding
  (:use #:cl)
  (:export #:padding
           #:padding-size
           #:nullable-padding-size
           #:padding-horizontal-size
           #:padding-vertical-size))
(in-package #:reblocks-ui2/utils/padding)


(deftype padding-size ()
  '(member :s :m :l :xl))

(deftype nullable-padding-size ()
  '(or null padding-size))


(defclass padding ()
  ((horizontal-size :type nullable-padding-size
                    :initarg :horizontal
                    :initform :l
                    :reader padding-horizontal-size)
   (vertical-size :type nullable-padding-size
                  :initarg :vertical
                  :initform :l
                  :reader padding-vertical-size)))


(defmethod print-object ((padding padding) stream)
  (print-unreadable-object (padding stream :type t)
    (if (equal (padding-horizontal-size padding)
               (padding-vertical-size padding))
        (format stream "~A"
                (padding-horizontal-size padding))
        (format stream "x=~A y=~A"
                (padding-horizontal-size padding)
                (padding-vertical-size padding)))))


(defun padding (size)
  (etypecase size
    (null
     (make-instance 'padding
                    :horizontal nil
                    :vertical nil))
    (keyword
     (check-type size padding-size)
     (make-instance 'padding
                    :horizontal size
                    :vertical size))
    (cons
     (destructuring-bind (horizontal . vertical)
         size
       (check-type horizontal nullable-padding-size)
       (check-type vertical nullable-padding-size)
       
       (make-instance 'padding
                      :horizontal horizontal
                      :vertical vertical)))))

