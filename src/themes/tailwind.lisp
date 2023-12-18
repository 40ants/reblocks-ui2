(uiop:define-package #:reblocks-ui2/themes/tailwind
  (:use #:cl)
  (:export #:make-tailwind-theme
           #:tailwind-theme))
(in-package #:reblocks-ui2/themes/tailwind)


(defclass tailwind-theme ()
  ())


(defun make-tailwind-theme ()
  (make-instance 'tailwind-theme))
