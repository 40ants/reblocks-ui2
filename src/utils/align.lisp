(uiop:define-package #:reblocks-ui2/utils/align
  (:use #:cl)
  (:export #:horizontal-align
           #:vertical-align
           #:horizontal-align-value
           #:vertical-align-value))
(in-package #:reblocks-ui2/utils/align)


(deftype horizontal-align-value ()
  '(member :left :center :top))


(deftype vertical-align-value ()
  '(member :top :center :bottom))


(defclass horizontal-align ()
  ((value :initarg :value
          :type horizontal-align-value
          :reader horizontal-align-value)))


(defclass vertical-align ()
  ((value :initarg :value
          :type vertical-align-value
          :reader vertical-align-value)))


(declaim (ftype (function ((or horizontal-align-value
                               horizontal-align))
                          (values horizontal-align &optional))
                horizontal-align))

(defun horizontal-align (value)
  (etypecase value
    (horizontal-align value)
    (horizontal-align-value (make-instance 'horizontal-align :value value))))


(declaim (ftype (function ((or vertical-align-value
                               vertical-align))
                          (values vertical-align &optional))
                vertical-align))

(defun vertical-align (value)
  (etypecase value
    (vertical-align value)
    (vertical-align-value (make-instance 'vertical-align :value value))))
