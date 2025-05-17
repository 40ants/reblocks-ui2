(uiop:define-package #:reblocks-ui2/sizes
  (:use #:cl)
  (:export #:ensure-size))
(in-package #:reblocks-ui2/sizes)


(defclass size ()
  ())


(defclass xs (size)
  ())


(defclass s (size)
  ())


(defclass m (size)
  ())


(defclass l (size)
  ())


(defclass xl (size)
  ())


(defun ensure-size (name)
  (check-type name (or null symbol))
  
  (when name
    (let* ((package (find-package "REBLOCKS-UI2/SIZES"))
           (class-name (etypecase name
                         (keyword (find-symbol (symbol-name name)
                                               package))
                         (symbol name)))
           (class (find-class class-name)))
      (unless class
        (error "Unable to find size class ~A" class-name))
      
      (make-instance class))))
