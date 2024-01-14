(uiop:define-package #:reblocks-ui2/inputs/text-input
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:import-from #:reblocks-ui2/utils/pin
                #:ensure-pin
                #:pin)
  (:import-from #:reblocks-ui2/inputs/text-input/view
                #:normal
                #:input-view
                #:ensure-view)
  (:import-from #:str
                #:downcase)
  (:import-from #:reblocks-ui2/inputs/base
                #:base-input-widget)
  (:export #:input
           #:input-widget
           #:input-placeholder
           #:input-view
           #:input-pin
           #:input-error
           #:input-disabled
           #:input-size
           #:input-name
           #:input-type
           #:input-left-content
           #:input-right-content))
(in-package #:reblocks-ui2/inputs/text-input)


(defwidget input-widget (base-input-widget)
  ((type :initform nil
         :initarg :type
         :type (or null string)
         :reader input-type)
   (placeholder :initform nil
                :initarg :placeholder
                :type (or null string)
                :reader input-placeholder)
   (view :type input-view
         :initarg :view
         :initform (make-instance 'normal)
         :reader input-view)
   (pin :initarg :pin
        :type pin
        :reader input-pin)
   (size :initarg :size
         :type (member :s :m :l :xl)
         :initform :m
         :reader input-size)
   (disabled :initarg :disabled
             :initform nil
             :type boolean
             :reader input-disabled)
   (left-content :initarg :left-content
                 :type (or null ui-widget)
                 :initform nil
                 :accessor input-left-content)
   (right-content :initarg :right-content
                  :type (or null ui-widget)
                  :initform nil
                  :accessor input-right-content)))


(defun input (&key (widget-class 'input-widget)
                   name
                   value
                   (type :text)
                   placeholder
                   (view :normal)
                   (pin :round)
                   (size :m)
                   disabled
                   validator
                   error
                   left-content
                   right-content)
  (make-instance widget-class
                 :name (downcase name)
                 :type (downcase type)
                 :value value
                 :placeholder placeholder
                 :view (ensure-view view)
                 :pin (ensure-pin pin)
                 :size size
                 :disabled disabled
                 :validator validator
                 :error error
                 :left-content left-content
                 :right-content right-content))



