(uiop:define-package #:reblocks-ui2/buttons/view
  (:use #:cl))
(in-package #:reblocks-ui2/buttons/view)


(defclass button-view ()
  ())

(defclass normal (button-view)
  ())

(defclass action (button-view)
  ())

(defclass raised (button-view)
  ())

(defclass outlined (button-view)
  ())

(defclass outlined-action (outlined)
  ())

(defclass outlined-info (outlined)
  ())

(defclass outlined-success (outlined)
  ())

(defclass outlined-warning (outlined)
  ())

(defclass outlined-danger (outlined)
  ())

(defclass outlined-utility (outlined)
  ())


(defun ensure-view (name)
  (check-type name (or null symbol))
  
  (when name
    (let* ((package (find-package "REBLOCKS-UI2/BUTTONS/VIEW"))
           (class-name (etypecase name
                         (keyword (find-symbol (symbol-name name)
                                               package))
                         (symbol name)))
           (class (find-class class-name nil)))
      (unless class
        (error "Unable to find view class for view \"~A\"." name))
      
      (make-instance class))))
