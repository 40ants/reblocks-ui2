(uiop:define-package #:reblocks-ui2/buttons/pin
  (:use #:cl)
  (:import-from #:serapeum
                #:soft-list-of)
  (:import-from #:alexandria
                #:length=)
  (:shadow #:round))
(in-package #:reblocks-ui2/buttons/pin)


(defclass pin ()
  ((left :type (member :clear :brick :round :circle)
         :initarg :left
         :reader left-side)
   (right :type (member :clear :brick :round :circle)
          :initarg :right
          :reader right-side)))


(defun ensure-pin (sides)
  (check-type sides (or keyword
                        (soft-list-of keyword)))

  (destructuring-bind (left-side right-side)
      (typecase sides
        (keyword (list sides sides))
        ((soft-list-of keyword)
         (unless (length= 2 sides)
           (error "When given as a list, pin should be a list of two keywords, for example: '(:round :brick)"))
         sides))
    (make-instance 'pin
                   :left left-side
                   :right right-side)))
