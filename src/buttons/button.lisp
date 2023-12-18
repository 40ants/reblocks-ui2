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
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks-lass)
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
          :type (or null string)
          :reader button-class)
   (style :initarg :style
          :type (or null string)
          :reader button-style)
   (disabled :initarg :disabled
             :initform nil
             :type boolean
             :reader button-disabled)))


(defun button (content &key (widget-class 'button) on-click (class "button") disabled style)
  (make-instance widget-class
                 :content (create-widget-from content)
                 :on-click on-click
                 :class class
                 :style style
                 :disabled disabled))


(defmethod reblocks/widget:get-css-classes ((widget button))
  (list "button-wrapper"))

(defmethod render ((widget button))
  (let ((action-code (when (button-on-click widget)
                       (typecase (button-on-click widget)
                         (string (button-on-click widget))
                         (t
                          (make-js-action (button-on-click widget)))))))
    (with-html
      (:button :onclick (concatenate 'string
                                     ;; We need this stop propagation
                                     ;; to be able to build buttons into
                                     ;; other objects having their own
                                     ;; onClick handlers.
                                     "event.stopPropagation(); "
                                     action-code)
               :class (button-class widget)
               :style (button-style widget)
               :disabled (button-disabled widget)
               (render (button-content widget))))))


(defmethod get-dependencies ((widget button))
  (list*
   (reblocks-lass:make-dependency
     `(.button-wrapper
       (button :margin 0)
       (input :margin 0)))
   (call-next-method)))


