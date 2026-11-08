(uiop:define-package #:reblocks-ui2/form/confirm
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:create-widget-from)
  (:import-from #:reblocks-ui2/form
                #:form
                #:form-widget)
  (:import-from #:reblocks-ui2/buttons/button
                #:button)
  (:import-from #:reblocks-ui2/containers/column
                #:column)
  (:import-from #:reblocks-ui2/containers/controls-row
                #:controls-row)
  (:import-from #:serapeum
                #:->)
  (:export #:confirm))
(in-package #:reblocks-ui2/form/confirm)


(-> confirm (t &key
               (:confirm-button-title string)
               (:cancel-button-title string)
               (:confirm-value string)
               (:cancel-value string)
               (:on-confirm (or null (function (form-widget) *)))
               (:widget-class symbol))
    (values form-widget &optional))

(defun confirm (content &key (confirm-button-title "Confirm")
                         (cancel-button-title "Cancel")
                         (confirm-value "submit")
                         (cancel-value "cancel")
                         on-confirm
                         widget-class)
  "Returns a form widget asking the user to confirm an action.

   CONTENT is a question to show to the user. It might be a string or any other
   widget and is processed by REBLOCKS/WIDGET:CREATE-WIDGET-FROM, like the
   content of the usual FORM.

   The form contains two submit buttons sharing the name \"button\". The
   Confirm button submits CONFIRM-VALUE and the Cancel button submits
   CANCEL-VALUE. Both titles and values are customizable.

   The Confirm button is the first submit button in the HTML. This way pressing
   Enter in the form submits it as if the Confirm button was pressed, because
   browsers use the first submit button for the implicit submission.

   ON-CONFIRM, if given, is called with the form widget as the only argument,
   but only when the form was submitted with the button whose value is
   string-equal to CONFIRM-VALUE. Submission of the Cancel button does nothing.
   No persistence happens inside the widget, and no modal windows are hidden:
   to close a modal showing this form, call REBLOCKS-UI2/MODAL:MODAL-HIDE from
   the ON-CONFIRM callback."
  (form (column (create-widget-from content)
                (controls-row
                 ;; The Confirm button has to be the first submit button
                 ;; in the DOM. Otherwise pressing Enter in the form will
                 ;; trigger the Cancel button.
                 (button confirm-button-title
                         :name "button"
                         :value confirm-value
                         :type "submit"
                         :view :action)
                 (button cancel-button-title
                         :name "button"
                         :value cancel-value
                         :type "submit")))
        :widget-class (or widget-class
                          'form-widget)
        :on-submit
        (lambda (form &key button)
          ;; Form buttons are submitted as a form data argument
          ;; named after the button's :name argument.
          (when (and on-confirm
                     (string-equal button confirm-value))
            (funcall on-confirm form)))))
