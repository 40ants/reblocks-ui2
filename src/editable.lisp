(uiop:define-package #:reblocks-ui2/editable
  (:use #:cl)
  (:export #:make-editable-widget))
(in-package #:reblocks-ui2/editable)


(defgeneric make-editable-widget (value callback)
  (:documentation "Creates a widget which can be used to edit a given value.
                   Every time when the widget loose focus, it will call CALLBACK argument with a new value."))
