(uiop:define-package #:reblocks-ui2/form
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:update
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:import-from #:serapeum
                #:defvar-unbound)
  (:import-from #:reblocks-ui2/form/validation
                #:validation-error
                #:form-validation-error
                #:field-validation-error
                #:validate-form-data)
  (:import-from #:lambda-fiddle
                #:with-destructured-lambda-list)
  (:import-from #:reblocks-ui2/inputs/named
                #:input-name
                #:named-input)
  (:import-from #:reblocks-ui2/utils/walk
                #:walk)
  (:import-from #:alexandria
                #:make-keyword
                #:length=)
  (:import-from #:str
                #:downcase)
  (:import-from #:trivial-arguments)
  (:export #:form-widget
           #:form-content
           #:form-on-submit
           #:form))
(in-package #:reblocks-ui2/form)


(defwidget form-widget (ui-widget)
  ((content :initarg :content
            :reader form-content)
   (on-submit :initarg :on-submit
              :reader form-on-submit)
   (all-inputs :initform (make-hash-table :test 'equal)
               :documentation "Internal structure holding references to all form inputs having a name attribute."
               :reader form-inputs)))


(defvar-unbound *current-form*
  "This variable will hold a reference to the currently rendered form widget.")


(defun validate-on-submit-fun-args (content on-submit)
  "Checks if on-submit function accepts one required argument and keyword arguments with names of all input fields.

   If some arguments for some input fields are missing, then form creation will fail."
  (let ((arguments (trivial-arguments:arglist on-submit))
        (known-input-names (uiop:while-collecting (collect)
                             (flet ((visit (widget)
                                      (when (typep widget 'named-input)
                                        (collect (downcase (input-name widget))))))
                               (declare (dynamic-extent (function visit)))
                               (walk content #'visit)))))
    (with-destructured-lambda-list (:required required :key kwargs)
                                   arguments
      (unless (length= 1 required)
        (error "On submit function ~A should accept 1 required argument. But this accepts ~A: ~{~A~#[~; and ~:;, ~]~}"
               on-submit
               (length required)
               arguments))

      (let* ((downcased-kwargs (mapcar #'downcase kwargs))
             (missing-args (set-difference known-input-names
                                           downcased-kwargs
                                           :test #'string=))
             (excessive-args (set-difference downcased-kwargs
                                             known-input-names
                                             :test #'string=)))
        (flet ((to-keywords (items)
                 (mapcar #'string-upcase
                         items)))
          (cond
            ((and missing-args
                  excessive-args)
             (error "On submit function ~A waits ~{~A~#[~; and ~:;, ~]~} arguments but there are no inputs with such names. Also it does not accept ~{~A~#[~; and ~:;, ~]~} arguments and will fail to process action."
                    on-submit
                    (to-keywords excessive-args)
                    (to-keywords missing-args)))
            (missing-args
             (error "On submit function ~A does not accept ~{~A~#[~; and ~:;, ~]~} arguments and will fail to process action."
                    on-submit
                    (to-keywords missing-args)))
            (excessive-args
             (error "On submit function ~A waits ~{~A~#[~; and ~:;, ~]~} arguments but there are no inputs with such names."
                    on-submit
                    (to-keywords excessive-args))))))
      (values))))


(defun form (content &key (widget-class 'form-widget)
                          on-submit)
  (let ((widget (make-instance widget-class
                               :content content)))
    (when on-submit
      (validate-on-submit-fun-args content on-submit)
      
      (setf (slot-value widget 'on-submit)
            (make-on-submit-wrapper widget on-submit)))
    (values widget)))


(defun make-on-submit-wrapper (widget on-submit-func)
  "Makes an action handler which calls on-submit-func only with validated values of all form inputs"
  (flet ((on-submit (&rest form-data)
           (handler-case
               (let ((validated-data (validate-form-data widget form-data)))
                 (apply on-submit-func widget validated-data))
             (validation-error ()
               (update widget)))))
    #'on-submit))


(defmethod validate-form-data ((widget form-widget) (form-data list))
  (loop with num-errors = 0
        for field being the hash-value of (form-inputs widget)
        append (handler-case (validate-form-data field form-data)
                 (field-validation-error ()
                   (incf num-errors)
                   (values)))
        into results
        finally (if (< 0 num-errors)
                    (error 'form-validation-error
                           :num-errors num-errors)
                    (return results))))


(defmethod render :around ((widget form-widget) (theme t))
  (let ((*current-form* widget))
    (call-next-method)))


(defun register-input (name widget)
  (when (and (boundp '*current-form*)
             name)
    (setf (gethash name (form-inputs *current-form*))
          widget)))
