(uiop:define-package #:reblocks-ui2/buttons/button
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:get-html-tag
                #:create-widget-from
                #:render
                #:widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:export
   #:button))
(in-package #:reblocks-ui2/buttons/button)


(defwidget button ()
  ((on-click :initarg :on-click
             :type (or function
                       null)
             :reader button-on-click)
   (content :initarg :content
            :type widget
            :reader button-content)
   (class :initarg :class
          :type string
          :reader button-class)))


(defun button (content &key on-click (class "button"))
  (make-instance 'button
                 :content (create-widget-from content)
                 :on-click on-click
                 :class class))


(defmethod reblocks/widget:get-css-classes ((widget button))
  (list "button-wrapper"))

(defmethod render ((widget button))
  (let ((action-code (when (button-on-click widget)
                       (make-js-action (button-on-click widget)))))
    (with-html
      (:button :onclick action-code
               :class (button-class widget)
               (render (button-content widget))))))

