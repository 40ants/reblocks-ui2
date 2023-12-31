(uiop:define-package #:reblocks-ui2/themes/color
  (:use #:cl)
  (:import-from #:serapeum
                #:required-argument)
  (:export
   #:color
   #:color-property
   #:color-light
   #:color-dark))
(in-package #:reblocks-ui2/themes/color)


(defclass color ()
  ((property :type string
             :initarg :property
             :initform (required-argument "property")
             :reader color-property)
   (light :type (or null string)
          :initarg :light
          :initform nil
          :reader color-light)
   (dark :type (or null string)
          :initarg :dark
          :initform nil
          :reader color-dark)))


(defun color (property &key light dark)
  (unless (or light dark)
    (error "At least one light or dark color should be given."))
  
  (make-instance 'color
                 :property property
                 :light light
                 :dark dark))
