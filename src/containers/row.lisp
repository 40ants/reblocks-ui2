(uiop:define-package #:reblocks-ui2/containers/row
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:get-css-classes
                #:widget
                #:render
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:serapeum
                #:soft-list-of)
  (:export
   #:row-widget
   #:make-row-widget))
(in-package #:reblocks-ui2/containers/row)


(defwidget row-widget ()
  ((subwidgets :initarg :subwidgets
               :initform nil
               :type (soft-list-of widget)
               :reader subwidgets)
   (classes :initarg :classes
            :initform nil
            :type (soft-list-of string)
            :reader classes
            :documentation "A list of additional CSS classes.")))


(defun make-row-widget (subwidgets &key classes)
  (make-instance 'row-widget
                 :subwidgets subwidgets
                 :classes (uiop:ensure-list classes)))


(defmethod render ((widget row-widget))
  (with-html
    (mapc #'render (subwidgets widget))))


;; Here is a Tailwind version, we need to use ui2 widget class and themes instead!
(defmethod reblocks/widget:get-css-classes ((widget row-widget))
  (append (list "flex")
          (classes widget)
          (call-next-method)))
