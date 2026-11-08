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
  (:import-from #:reblocks-ui2/inputs/date-input
                #:date-input)
  (:import-from #:reblocks-ui2/containers/row
                #:row)
  (:import-from #:reblocks-ui2/form/validators
                #:valid-integer
                #:valid-password
                #:valid-string)
  (:import-from #:reblocks-ui2/containers/controls-row
                #:controls-row)
  (:import-from #:reblocks-ui2/form/confirm
                #:confirm)
  (:import-from #:reblocks-ui2/modal
                #:modal
                #:modal-header-content
                #:modal-hide
                #:modal-main-content
                #:modal-show))
(in-package #:reblocks-ui2-demo/pages/form)


(defwidget form-page ()
  ((submittedp :initform nil
               :type boolean
               :accessor submittedp)
   (confirmedp :initform nil
               :type boolean
               :accessor confirmedp)))


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
          (row
           (date-input :name "birthdate"
                       :placeholder "Birth date"
                       :size :xl)
           (date-input :name "deadline"
                       :required nil
                       :placeholder "Deadline (optional)"
                       :size :xl))
          (controls-row
           (button "Sign Up"
                   :view :action)))
         :on-submit
         (lambda (form &key name email age password birthdate deadline)
           (declare (ignore form))
           (log:warn "On Submit was called:" name email age password birthdate deadline)
           (setf (submittedp widget)
                 t)
           (update widget))))))

    (:h2 :class "text-xl my-4"
         "Confirmation")

    (cond
      ((confirmedp widget)
       (render (reblocks/widgets/string-widget:make-string-widget
                "Action was confirmed.")))
      (t
       (render (confirm "Do you really want to archive this mission?"
                        :confirm-button-title "Yes, archive"
                        :cancel-button-title "No, keep it"
                        :on-confirm
                        (lambda (form)
                          (declare (ignore form))
                          (log:info "Confirm's on-confirm callback was called")
                          (setf (confirmedp widget)
                                t)
                          (update widget))))))

    (:h2 :class "text-xl my-4"
         "Confirmation in a modal")

    (let ((modal (modal (reblocks/widgets/string-widget:make-string-widget ""))))
      ;; The content is set after the modal, because the on-confirm
      ;; callback has to close the modal itself:
      (setf (modal-main-content modal)
            (confirm "Delete this mission?"
                     :on-confirm
                     (lambda (form)
                       (declare (ignore form))
                       (modal-hide modal))))
      (setf (modal-header-content modal)
            (reblocks/widgets/string-widget:make-string-widget
             "Mission deletion"))
      (render (button "Delete mission"
                      :on-click (lambda (button-widget)
                                  (declare (ignore button-widget))
                                  (modal-show modal))))
      (render modal))))
