(uiop:define-package #:reblocks-ui2/themes/zurb
  (:use #:cl)
  (:export #:make-zurb-theme
           #:zurb-theme))
(in-package #:reblocks-ui2/themes/zurb)


(defclass zurb-theme ()
  ())


(defun make-zurb-theme ()
  (make-instance 'zurb-theme))
