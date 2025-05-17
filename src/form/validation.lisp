(uiop:define-package #:reblocks-ui2/form/validation
  (:use #:cl)
  (:export #:validation-error
           #:form-validation-error
           #:field-validation-error
           #:validate-form-data
           #:error-args
           #:error-message
           #:field-name
           #:invalid-value
           #:num-errors))
(in-package #:reblocks-ui2/form/validation)


;; TODO: think about validation errors translation system
(define-condition validation-error (error)
  ((error-message :initarg :error-message
                  :initform ""
                  :reader error-message)
   (error-args :initarg :error-args
               :initform nil
               :reader error-args))
  (:report (lambda (condition stream)
             (apply #'format stream
                    (error-message condition)
                    (error-args condition)))))


(define-condition form-validation-error (validation-error)
  ((num-errors :initarg :num-errors
               :reader num-errors)))


(define-condition field-validation-error (validation-error)
  ((field-name :initarg :field-name
               :reader field-name)
   (invalid-value :initarg :invalid-value
                  :reader invalid-value)))


(defgeneric validate-form-data (widget form-data)
  (:documentation "Accepts a form or input widget and a plist of all data sent from the browser.

                   Should return a plist of validated data. Also, it might change the state of the widgets,
                   for example, to set an error message saying that entered value is invalid. In the case
                   when data is invalid, function should signal VALIDATION-ERROR."))
