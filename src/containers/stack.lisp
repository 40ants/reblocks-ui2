(uiop:define-package #:reblocks-ui2/containers/stack
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:update
                #:defwidget)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:import-from #:serapeum
                #:length<=)
  (:export #:stack-widget
           #:stack-widget-children
           #:make-stack-widget
           #:push-child
           #:pop-child
           #:current-stack-widget))
(in-package #:reblocks-ui2/containers/stack)


(defvar *current-stack-widget*)


(defwidget stack-widget (ui-widget)
  ((children :initarg :children
             :reader stack-widget-children))
  (:documentation "Shows only the top child from the stack. Provides methods to push and pop widgets."))


(defun make-stack-widget (child)
  (make-instance 'stack-widget
                 :children (list child)))


(defmethod render ((widget stack-widget) (theme t))
  (let ((*current-stack-widget* widget))
    (reblocks/widget:render (first (stack-widget-children widget)))))


(defgeneric pop-child (stack-widget)
  (:method ((widget stack-widget))
    (when (length<= 2
                    (stack-widget-children widget))
      (pop (slot-value widget 'children))
      (update widget))))


(defgeneric push-child (stack-widget child)
  (:method ((widget stack-widget) child)
    (push child (slot-value widget 'children))
    (update widget)))


(defun current-stack-widget ()
  (unless (boundp '*current-stack-widget*)
    (error "Function CURRENT-STACK-WIDGET should be called inside the RENDER method of stack child widget."))

  (values *current-stack-widget*))
