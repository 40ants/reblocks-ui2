(uiop:define-package #:reblocks-ui2/themes/base
  (:use #:cl)
  (:export #:base-theme
           #:overrided-vars))
(in-package #:reblocks-ui2/themes/base)


(defclass base-theme ()
  ((overrided-vars :initform (make-hash-table :test 'equal)
                   :initarg :overridden-vars
                   :reader overrided-vars))
  (:documentation "A base theme class for all `Reblocks-UI2` themes."))
