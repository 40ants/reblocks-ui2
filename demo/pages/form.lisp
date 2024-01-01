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
  ())


(defun make-form-page ()
  (make-instance 'form-page))

(defmethod render ((widget form-page))
  (with-html
    (:h2 :class "text-xl my-4"
         "Simple sign up form")
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
        (log:warn "On Submit was called:" name email age password)
        (update form))))))
