(uiop:define-package #:reblocks-ui2/themes/zurb
  (:use #:cl)
  (:import-from #:reblocks-ui2/themes/base
                #:base-theme)
  (:export #:make-zurb-theme
           #:zurb-theme))
(in-package #:reblocks-ui2/themes/zurb)


(defclass zurb-theme (base-theme)
  ()
  (:documentation "A theme implementing all widgets using Zurb Foundation framework."))


(defun make-zurb-theme ()
  (make-instance 'zurb-theme))
