(uiop:define-package #:reblocks-ui2/inputs/select
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:import-from #:reblocks-ui2/inputs/text-input/view
                #:input-view
                #:normal
                #:ensure-view)
  (:import-from #:str
                #:downcase)
  (:import-from #:reblocks-ui2/inputs/base
                #:base-input-widget)
  (:import-from #:serapeum
                #:soft-list-of
                #:->)
  (:import-from #:reblocks-ui2/utils/pin
                #:ensure-pin
                #:pin)
  (:import-from #:event-emitter
                #:event-emitter)
  (:export #:select
           #:select-widget
           #:select-disabled
           #:select-size
           #:select-view
           #:select-pin
           #:option
           #:option-name
           #:option-value
           #:option-selected-p
           #:ensure-option
           #:select-options))
(in-package #:reblocks-ui2/inputs/select)


(defclass option ()
  ((name :initarg :name
         :type string
         :reader option-name)
   (value :initarg :value
          :type string
          :reader option-value)
   (selected :initarg :selected
             :type boolean
             :initform nil
             :reader option-selected-p)))


(-> option (string
            &key
            (:value (or null string))
            (:selected boolean))
    (values option &optional))

(defun option (name &key value selected)
  (make-instance 'option
                 :name name
                 :value (or value
                            name)
                 :selected (when selected
                             t)))


(defwidget select (event-emitter base-input-widget)
  ((options :initarg :options
            :type (soft-list-of option)
            :accessor select-options)
   (view :type input-view
         :initarg :view
         :initform (make-instance 'normal)
         :reader select-view)
   (pin :initarg :pin
        :type pin
        :reader select-pin)
   (size :initarg :size
         :type (member :s :m :l :xl)
         :initform :m
         :reader select-size)
   (disabled :initarg :disabled
             :initform nil
             :type boolean
             :reader select-disabled)))


(-> ensure-option ((or string option))
    (values option &optional))

(defun ensure-option (value)
  (etypecase value
    (string (option value))
    (option value)))


(defun select (options
               &key
                 (widget-class 'select)
                 name
                 (view :normal)
                 (pin :round)
                 (size :m)
                 disabled
                 validator
                 error)
  (make-instance widget-class
                 :options (mapcar #'ensure-option options)
                 :name (downcase name)
                 :view (ensure-view view)
                 :pin (ensure-pin pin)
                 :size size
                 :disabled disabled
                 :validator validator
                 :error error))
