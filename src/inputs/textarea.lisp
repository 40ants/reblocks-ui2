(uiop:define-package #:reblocks-ui2/inputs/textarea
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
                #:ensure-view)
  (:import-from #:str
                #:downcase)
  (:import-from #:reblocks-ui2/inputs/base
                #:base-input-widget)
  (:export #:textarea
           #:textarea-type
           #:textarea-placeholder
           #:textarea-view
           #:textarea-pin
           #:textarea-size
           #:textarea-disabled))
(in-package #:reblocks-ui2/inputs/textarea)


(defwidget textarea (base-input-widget)
  ((type :initform nil
         :initarg :type
         :type (or null string)
         :reader textarea-type)
   (placeholder :initform nil
                :initarg :placeholder
                :type (or null string)
                :reader textarea-placeholder)
   (view :type reblocks-ui2/inputs/text-input/view:input-view
         :initarg :view
         :initform (make-instance 'normal)
         :reader textarea-view)
   (pin :initarg :pin
        :type pin
        :reader textarea-pin)
   (size :initarg :size
         :type (member :s :m :l :xl)
         :initform :m
         :reader textarea-size)
   (disabled :initarg :disabled
             :initform nil
             :type boolean
             :reader textarea-disabled)))


(defun textarea (&key (widget-class 'textarea)
                   name
                   value
                   (type :text)
                   placeholder
                   (view :normal)
                   (pin :round)
                   (size :m)
                   disabled
                   validator
                   error)
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
                 :error error))
