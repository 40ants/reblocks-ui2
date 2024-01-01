(uiop:define-package #:reblocks-ui2/themes/color
  (:use #:cl)
  (:import-from #:serapeum
                #:required-argument)
  (:export #:color
           #:color-property
           #:color-light
           #:color-dark
           #:color-hover
           #:color-focus))
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
         :reader color-dark)
   (hover :type (or null string int)
          :initarg :hover
          :initform nil
          :documentation "If string, then it is a color of element in \"hover\" state. If integer, then it is intensity change relative to the base color. For light scheme intencity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour."
          :reader color-hover)
   (focus :type (or null string int)
          :initarg :focus
          :initform nil
          :documentation "If string, then it is a color of element in \"focus\" state. If integer, then it is intensity change relative to the base color. For light scheme intencity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour."
          :reader color-focus)))


(defun color (property &key light dark hover focus)
  (unless (or light dark)
    (error "At least one light or dark color should be given."))
  
  (make-instance 'color
                 :property property
                 :light light
                 :dark dark
                 :hover hover
                 :focus focus))
