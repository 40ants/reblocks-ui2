(uiop:define-package #:reblocks-ui2/utils/size
  (:use #:cl)
  (:export #:responsive-height
           #:height
           #:responsive-width
           #:width
           #:ensure-width
           #:ensure-height
           #:size
           #:size-value
           #:min-width
           #:max-width
           #:min-height
           #:max-height))
(in-package #:reblocks-ui2/utils/size)


(defclass size ()
  ((value :initarg :value
          :type (or integer string)
          :documentation "If integer, then it will be considered as \"px\".
                          If string, then will be used as is (meaning depends on current theme)."
          :reader size-value)))


(defmethod print-object ((size size) stream)
  (print-unreadable-object (size stream :type t)
    (format stream "~A"
            (size-value size))))


(defclass width (size)
  ())


(defclass height (size)
  ())


(defclass responsive-width ()
  ((min-width :initarg :min
              :initform nil
              :type (or null width)
              :reader min-width)
   (max-width :initarg :max
              :initform nil
              :type (or null width)
              :reader max-width)))


(defclass responsive-height ()
  ((min-height :initarg :min
              :initform nil
              :type (or null height)
              :reader min-height)
   (max-height :initarg :max
               :initform nil
               :type (or null height)
               :reader max-height)))


(defun width (value)
  (make-instance 'width
                 :value value))


(defun responsive-width (&key min max)
  (make-instance 'responsive-width
                 :min (when min
                        (width min))
                 :max (when max
                        (width max))))

(defun height (value)
  (make-instance 'height
                 :value value))


(defun responsive-height (&key min max)
  (make-instance 'responsive-height
                 :min (when min
                        (height min))
                 :max (when max
                        (height max))))


(defun ensure-width (value)
  (etypecase value
    (null value)
    (width value)
    (responsive-width value)
    ((or integer
         string)
     (width value))
    (cons (responsive-width :min (car value)
                            :max (cdr value)))))

(defun ensure-height (value)
  (etypecase value
    (null value)
    (height value)
    (responsive-height value)
    ((or integer
         string)
     (height value))
    (cons (responsive-height :min (car value)
                             :max (cdr value)))))
