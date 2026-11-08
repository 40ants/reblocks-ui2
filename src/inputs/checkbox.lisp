(uiop:define-package #:reblocks-ui2/inputs/checkbox
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
                #:normal
                #:ensure-view)
  (:import-from #:str
                #:downcase)
  (:import-from #:reblocks-ui2/inputs/base
                #:base-input-widget)
  (:export #:checkbox
           #:checkbox-view
           #:checkbox-size
           #:checkbox-disabled
           #:checkbox-checked))
(in-package #:reblocks-ui2/inputs/checkbox)


(defwidget checkbox (base-input-widget)
  ((view :type reblocks-ui2/inputs/text-input/view:input-view
         :initarg :view
         :initform (make-instance 'normal)
         :reader checkbox-view)
   (size :initarg :size
         :type (member :s :m :l :xl)
         :initform :m
         :reader checkbox-size)
   (disabled :initarg :disabled
             :initform nil
             :type boolean
             :reader checkbox-disabled)
   (checked :initarg :checked
            :initform nil
            :type boolean
            :reader checkbox-checked))
  (:default-initargs :width nil))


(defun checkbox (&key
                   (widget-class 'checkbox)
                   name
                   value
                   (view :normal)
                   (size :m)
                   disabled
                   checked
                   error)
  (make-instance widget-class
                 :name (downcase name)
                 :value value
                 :view (ensure-view view)
                 :size size
                 :disabled disabled
                 :checked checked
                 :error error))
