(uiop:define-package #:reblocks-ui2/themes/color
  (:use #:cl)
  (:import-from #:serapeum
                #:required-argument)
  (:export #:color
           #:color-property
           #:color-light
           #:color-dark
           #:color-hover
           #:color-focus
           #:adjust-color
           #:adjust-base-color))
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
          :documentation "If string, then it is a color of element in \"hover\" state. If integer, then it is intensity change relative to the base color. For light scheme intensity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour."
          :reader color-hover)
   (focus :type (or null string int)
          :initarg :focus
          :initform nil
          :documentation "If string, then it is a color of element in \"focus\" state. If integer, then it is intensity change relative to the base color. For light scheme intensity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour."
          :reader color-focus)))


(defmethod print-object ((color color) stream)
  (print-unreadable-object (color stream :type t)
    (format stream "~A~@[ light=~A~]~@[ dark=~A~]~@[ hover=~A~]~@[ focus=~A~]"
            (color-property color)
            (color-light color)
            (color-dark color)
            (color-hover color)
            (color-focus color))))


(defun color (property &key light dark hover focus)
  (unless (or light dark)
    (error "At least one light or dark color should be given."))
  
  (make-instance 'color
                 :property property
                 :light light
                 :dark dark
                 :hover hover
                 :focus focus))


(defgeneric adjust-base-color (theme base-color adjustment))


(defun adjust-color (theme color &key
                                   (light nil light-p)
                                   (dark nil dark-p)
                                   (hover nil hover-p)
                                   (focus nil focus-p))
  (color (color-property color)
         :light (if light-p
                    (adjust-base-color theme
                                       (color-light color)
                                       light)
                    (color-light color))
         :dark (if dark-p
                   (adjust-base-color theme
                                      (color-dark color)
                                      dark)
                   (color-dark color))
         :hover (if hover-p
                    (adjust-base-color theme
                                       (color-hover color)
                                       hover)
                    (color-hover color))
         :focus (if focus-p
                    (adjust-base-color theme
                                       (color-focus color)
                                       focus)
                    (color-focus color))))
