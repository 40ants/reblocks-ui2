(uiop:define-package #:reblocks-ui2/inputs/base
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:import-from #:reblocks-ui2/utils/pin
                #:ensure-pin
                #:pin)
  (:import-from #:reblocks-ui2/inputs/text-input/view
                #:ensure-view)
  (:import-from #:str
                #:downcase)
  (:import-from #:reblocks-ui2/form
                #:register-input
                #:validate-form-data)
  (:import-from #:alexandria
                #:make-keyword)
  (:import-from #:reblocks-ui2/form/validation
                #:error-message
                #:error-args
                #:field-validation-error
                #:validation-error)
  (:import-from #:serapeum
                #:fmt)
  (:import-from #:reblocks-ui2/inputs/named
                #:named-input
                #:input-name)
  (:export #:base-input-widget
           #:input-error
           #:input-value
           #:named-input))
(in-package #:reblocks-ui2/inputs/base)


(defwidget base-input-widget (named-input)
  ((value :initform nil
          :initarg :value
          :reader input-value)
   (validator :initform nil
              :initarg :validator
              :documentation "A function of one argument returning a validated value or signaling the FIELD-VALIDATION-ERROR."
              :reader input-validator)
   (error :initarg :error
          :initform nil
          :type (or null string)
          :reader input-error)))


(defmethod initialize-instance :after ((widget base-input-widget) &rest initargs &key validator)
  (declare (ignore initargs))
  (setf (slot-value widget 'validator)
        (cond
          ((null validator)
           #'identity)
          (t
           validator))))


(defmethod validate-form-data ((widget base-input-widget) form-data)
  (when (and (input-name widget)
             (input-validator widget))
    (let* ((name (make-keyword (string-upcase (input-name widget))))
           (initial-value (getf form-data name)))
      (setf (slot-value widget 'error)
            nil)
      ;; Now we need to save an initial-value into the widget
      ;; to make it posible to call REBLOCKS/WIDGET:UPDATE for the form
      ;; and to not loose entered values.
      (setf (slot-value widget 'value)
            initial-value)
      
      (handler-case
          (let ((value (funcall (input-validator widget)
                                initial-value)))
            ;; Method should return a plist with validated
            ;; value in case of success:
            (list name
                  value))
        (validation-error (err)
          (setf (slot-value widget 'error)
                (apply #'fmt
                       (error-message err)
                       (error-args err)))
          (error 'field-validation-error
                 :name name
                 :error-message (error-message err)
                 :error-args (error-args err)))))))


(defmethod render :around ((widget base-input-widget) (theme t))
  (when (input-name widget)
    (register-input (input-name widget) widget))

  (call-next-method))
