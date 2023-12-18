(uiop:define-package #:reblocks-ui2/containers/popup/widget
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:import-from #:reblocks/widget
                #:update
                #:defwidget)
  (:export #:popup-widget
           #:show-popup
           #:hide-popup
           #:render-popup-content
           #:visible-p))
(in-package #:reblocks-ui2/containers/popup/widget)


(defwidget popup-widget (ui-widget)
  ((visible :initform nil
            :accessor visible-p))
  (:documentation "This widgets shows a popup window.

                   Inherit from this class and define a method for
                   RENDER-POPUP-CONTENT generic-function. Then you
                   will be able to instantiate your class instance
                   and call SHOW-POPUP generic function."))


(defgeneric show-popup (widget)
  (:documentation "Shows popup window.")
  (:method ((widget popup-widget))
    (setf (visible-p widget) t)
    (update widget)))


(defgeneric hide-popup (widget)
  (:documentation "Hides popup window.")
  (:method ((widget popup-widget))
    (setf (visible-p widget) nil)
    (update widget)))


(defgeneric render-popup-content (widget)
  (:documentation "Renders inner HTML for popup window.
                   You need to define a method for this generic function
                   and specialize it for your own class.")
  (:method ((widget popup-widget))
    (reblocks/html:with-html
      (:p (format nil "Define RENDER-POPUP-CONTENT method for ~S class."
                  (class-name (class-of widget)))))))
