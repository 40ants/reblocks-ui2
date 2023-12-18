(uiop:define-package #:reblocks-ui2/icon
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:export #:icon-widget
           #:icon
           #:icon-name))
(in-package #:reblocks-ui2/icon)


(defwidget icon-widget (ui-widget)
  ((name :initarg :name
         :reader icon-name)))


(defun icon (name)
  (make-instance 'icon-widget
                 :name name))
