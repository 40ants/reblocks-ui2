(uiop:define-package #:reblocks-ui2-demo/pages/form
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:update
                #:render
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/form
                #:form)
  (:import-from #:reblocks-ui2/containers/column
                #:column)
  (:import-from #:reblocks-ui2/buttons/button
                #:button)
  (:import-from #:reblocks-ui2/inputs/text-input
                #:input)
  (:import-from #:reblocks-ui2/containers/row
                #:row)
  (:import-from #:reblocks-ui2/form/validators
                #:valid-integer
                #:valid-password
                #:valid-string)
  (:import-from #:reblocks-ui2/containers/controls-row
                #:controls-row))
(in-package #:reblocks-ui2-demo/pages/form)


(defwidget form-page ()
  ((submittedp :initform nil
               :type boolean
               :accessor submittedp)))


(defun make-form-page ()
  (make-instance 'form-page))

(defmethod render ((widget form-page))
  (with-html ()
    (:h2 :class "text-xl my-4"
         "Simple sign up form")
    (cond
      ((submittedp widget)
       (render
        (form
         (row (reblocks/widgets/string-widget:make-string-widget
               "Thank you for submission!")
              (button "Try again"
                      :view :action))
         :on-submit
         (lambda (form)
           (declare (ignore form))
           (log:warn "Form reset was called")
           (setf (submittedp widget)
                 nil)
           (update widget)))))
      (t
       (render
        (form
         (column
          (row
           (input :name "name"
                  :placeholder "Name"
                  :validator (valid-string)
                  :size :xl)
           (input :name "email"
                  :type :email
                  :placeholder "Email"
                  :size :xl))
          (row
           (input :name "age"
                  :placeholder "Age"
                  :validator (valid-integer :min 18)
                  :size :xl)
           (input :name "password"
                  :type :password
                  :validator
                  (valid-password
                   :min-length 8
                   :required-symbols '((2 . "0123456789")
                                       (1 . ",.@#$%^&*!"))
                   :error "Password should be at least 8 symbols length and include 2 digits and 1 punctuation sign.")
                  :size :xl
                  :placeholder "Password"))
          (controls-row
           (button "Sign Up"
                   :view :action)))
         :on-submit
         (lambda (form &key name email age password)
           (declare (ignore form))
           (log:warn "On Submit was called:" name email age password)
           (setf (submittedp widget)
                 t)
           (update widget))))))))
