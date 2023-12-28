(uiop:define-package #:reblocks-ui2/inputs/text-input/view
  (:use #:cl)
  (:export #:input-view
           #:normal
           #:clear
           #:ensure-view))
(in-package #:reblocks-ui2/inputs/text-input/view)


(defclass input-view ()
  ())

(defclass normal (input-view)
  ())

(defclass clear (input-view)
  ())

(defun ensure-view (name)
  (check-type name (or null symbol))
  
  (when name
    (let* ((package #.*package*)
           (class-name (etypecase name
                         (keyword (find-symbol (symbol-name name)
                                               package))
                         (symbol name)))
           (class (find-class class-name nil)))
      (unless class
        (error "Unable to find view class for view \"~A\"." name))
      
      (make-instance class))))
