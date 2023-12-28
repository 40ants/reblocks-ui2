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
                #:ensure-view)
  (:export #:input
           #:input-widget
           #:input-placeholder
           #:input-view
           #:input-pin
           #:input-value
           #:input-error
           #:input-disabled
           #:input-size))
(in-package #:reblocks-ui2/inputs/text-input)


(defwidget input-widget (ui-widget)
  ((value :initform nil
          :initarg :value
          :type (or null string)
          :reader input-value)
   (placeholder :initform nil
                :initarg :placeholder
                :type (or null string)
                :reader input-placeholder)
   (view :type symbol
         :initarg :view
         :initform :normal
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
   (error :initarg :error
          :initform nil
          :type (or null string)
          :reader input-error)))


(defun input (&key (widget-class 'input-widget)
                   value
                   placeholder
                   (view :normal)
                   (pin :round)
                   (size :m)
                   disabled
                   error)
  (make-instance widget-class
                 :value value
                 :placeholder placeholder
                 :view (ensure-view view)
                 :pin (ensure-pin pin)
                 :size size
                 :disabled disabled
                 :error error))



