(uiop:define-package #:reblocks-ui2/card/view
  (:use #:cl))
(in-package #:reblocks-ui2/card/view)


(defclass card-view ()
  ())

(defclass clear (card-view)
  ())

(defclass filled (card-view)
  ())

(defclass filled-action (filled)
  ())

(defclass filled-info (filled)
  ())

(defclass filled-success (filled)
  ())

(defclass filled-warning (filled)
  ())

(defclass filled-danger (filled)
  ())

(defclass filled-utility (filled)
  ())

(defclass outlined (card-view)
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


(defclass raised (card-view)
  ())

(defclass raised-action (raised)
  ())

(defclass raised-info (raised)
  ())

(defclass raised-success (raised)
  ())

(defclass raised-warning (raised)
  ())

(defclass raised-danger (raised)
  ())

(defclass raised-utility (raised)
  ())


(defun ensure-view (name)
  (check-type name (or null symbol))
  
  (when name
    (let* ((package (find-package "REBLOCKS-UI2/CARD/VIEW"))
           (class-name (etypecase name
                         (keyword (find-symbol (symbol-name name)
                                               package))
                         (symbol name)))
           (class (find-class class-name nil)))
      (unless class
        (error "Unable to find view class for view \"~A\"." name))
      
      (make-instance class))))
