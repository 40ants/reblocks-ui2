(uiop:define-package #:reblocks-ui2/utils/pin
  (:use #:cl)
  (:import-from #:serapeum
                #:soft-list-of)
  (:import-from #:alexandria
                #:length=)
  (:shadow #:round))
(in-package #:reblocks-ui2/utils/pin)


(deftype pin-side-type ()
  '(member :clear :brick :round :circle))


(defclass pin ()
  ((left :type pin-side-type
         :initarg :left
         :reader left-side)
   (right :type pin-side-type
          :initarg :right
          :reader right-side)))


(defmethod print-object ((obj pin) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~A - ~A"
            (left-side obj)
            (right-side obj))))


(declaim (ftype (function ((or pin-side-type
                               (soft-list-of pin-side-type)))
                          (values pin &optional))
                ensure-pin))

(defun ensure-pin (sides)
  (destructuring-bind (left-side right-side)
      (typecase sides
        (pin-side-type (list sides sides))
        ((soft-list-of pin-side-type)
         (unless (length= 2 sides)
           (error "When given as a list, pin should be a list of two keywords, for example: '(:round :brick)"))
         sides))
    (make-instance 'pin
                   :left left-side
                   :right right-side)))
