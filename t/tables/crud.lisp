;;;; Tests for the CRUD table widget.
;;;;
;;;; Rendering is tested with the reference pattern, described
;;;; in the t/inputs/date-input.lisp file.
;;;;
;;;; The CRUD table renders buttons with ON-CLICK callbacks, and such
;;;; buttons create Reblocks actions and require a session. That is why
;;;; rendering happens inside REBLOCKS/SESSION:WITH-SESSION, faking a
;;;; Lack environment with an empty session hash-table, like in
;;;; t/form/confirm.lisp.
;;;;
;;;; Action callbacks (ON-CLICK handlers and form submissions) call
;;;; REBLOCKS/WIDGET:UPDATE, which collects client-side commands and
;;;; renders widgets using the current theme. Tests replicate the real
;;;; request context with REBLOCKS/COMMANDS:WITH-COLLECTED-COMMANDS and
;;;; by setting the current theme.
(uiop:define-package #:reblocks-ui2-tests/tables/crud
  (:use #:cl)
  (:import-from #:rove
                #:deftest
                #:ok
                #:testing)
  (:import-from #:reblocks/html
                #:with-html-string)
  (:import-from #:reblocks/page-dependencies
                #:with-collected-dependencies)
  (:import-from #:reblocks/session
                #:with-session)
  (:import-from #:reblocks/commands
                #:with-collected-commands
                #:get-collected-commands)
  (:import-from #:reblocks/widgets/dom
                #:dom-id)
  (:import-from #:reblocks/widgets/string-widget
                #:string-widget
                #:get-content)
  (:import-from #:reblocks-ui2/widget
                #:on-click
                #:render)
  (:import-from #:reblocks-ui2/themes/api
                #:current-theme)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:make-tailwind-theme)
  (:import-from #:reblocks-ui2/tables/crud
                #:make-crud-table
                #:crud-search
                #:crud-modal
                #:submitted-with-submit-button-p)
  (:import-from #:reblocks-ui2/tables/table
                #:column
                #:row-cells
                #:row-object
                #:table-rows
                #:table-widget)
  (:import-from #:reblocks-ui2/buttons/button
                #:button
                #:button-content)
  (:import-from #:reblocks-ui2/form
                #:form
                #:form-on-submit
                #:form-widget)
  (:import-from #:reblocks-ui2/inputs/text-input
                #:input)
  (:import-from #:reblocks-ui2/modal
                #:modal-main-content)
  (:import-from #:reblocks-ui2/html
                #:html)
  (:import-from #:reblocks-ui2/utils/walk
                #:walk))
(in-package #:reblocks-ui2-tests/tables/crud)


(defclass test-item ()
  ((id :initarg :id
       :reader test-item-id)
   (title :initarg :title
          :initform ""
          :accessor test-item-title)))


(defun make-test-item (id title)
  (make-instance 'test-item
                 :id id
                 :title title))


(defparameter *test-items* nil
  "An in-memory list of objects shown by the CRUD table under test.")


(defun reset-test-items ()
  (setf *test-items*
        (list (make-test-item 1 "First item")
              (make-test-item 2 "Second item")))
  (values))


(defun test-items-getter (&rest args)
  "A DATA-GETTER stub, returning the current content of *TEST-ITEMS*."
  (declare (ignore args))
  (values (copy-list *test-items*)))


(defun make-test-form (title)
  "Returns a simple form widget with a single \"title\" input."
  (form (input :name "title"
               :value title)
        :on-submit (lambda (form &key button title)
                     (declare (ignore form button title))
                     (values))))


(defun make-test-add-form (crud-widget modal)
  "An ADD-FORM-MAKER stub."
  (declare (ignore crud-widget modal))
  (make-test-form ""))


(defun make-test-edit-form (modal object)
  "An EDIT-FORM-MAKER stub, prefilled with the OBJECT's title."
  (declare (ignore modal))
  (make-test-form (test-item-title object)))


(defun render-widget-to-string (widget)
  "Renders the widget like it happens inside a real application.

Should be called inside REBLOCKS/SESSION:WITH-SESSION, because buttons
with ON-CLICK callbacks create Reblocks actions on render."
  (with-collected-dependencies ()
    (with-html-string ()
      (render widget
              (make-tailwind-theme)))))


(defmacro with-action-context (() &body body)
  "Evaluates BODY like Reblocks evaluates an action callback: with places
to collect client-side commands and page dependencies. Widgets rendered
by REBLOCKS/WIDGET:UPDATE require both of them."
  `(with-collected-dependencies ()
     (with-collected-commands ()
       ,@body)))


(defun run-in-action-context (thunk)
  "Calls the THUNK like Reblocks calls an action callback and returns
the client-side commands collected during the call."
  (with-action-context ()
    (funcall thunk)
    (get-collected-commands)))


(defun first-table-row (widget)
  "Returns the first row of the CRUD widget's table."
  (first (table-rows (table-widget (crud-search widget)))))


(defun button-title (button-widget)
  "Returns the string title of the BUTTON-WIDGET or NIL."
  (let ((content (button-content button-widget)))
    (when (typep content 'string-widget)
      (get-content content))))


(defun find-row-button (row title)
  "Finds a button with the TITLE among the widgets of the table ROW's cells."
  (let ((found nil))
    (loop for cell in (row-cells row)
          do (walk cell
                   (lambda (node)
                     (let ((node-title (when (typep node 'button)
                                         (button-title node))))
                       (when (and node-title
                                  (string= node-title title))
                         (setf found node))))))
    found))


(defun command-methods (commands)
  "Returns the list of JSON-RPC method names of the client-side COMMANDS."
  (loop for command in commands
        collect (getf command :|method|)))


(defun row-command-p (commands row method-keyword)
  "Returns T when COMMANDS contain a command with the METHOD-KEYWORD for the ROW's widget."
  (let ((row-dom-id (dom-id row)))
    (loop for command in commands
          for params = (getf command :|params|)
          when (and (eq (getf command :|method|)
                        method-keyword)
                    (member row-dom-id params
                            :test #'string=))
            return t
          finally (return nil))))


(defun row-update-command-html (commands row)
  "Returns the HTML the ROW was re-rendered into by one of the COMMANDS, or NIL."
  (let ((row-dom-id (dom-id row)))
    (loop for command in commands
          for params = (getf command :|params|)
          when (and (eq (getf command :|method|)
                        :|updateWidget|)
                    (string= (getf params :|domId|)
                             row-dom-id))
            return (getf params :|widget|)
          finally (return nil))))


(deftest test-crud-render
  "Test that the CRUD table renders row data and all the action buttons."
  (reset-test-items)
  (let* ((widget (make-crud-table
                  (list (column "Title" :getter #'test-item-title))
                  #'test-items-getter
                  :add-form-maker #'make-test-add-form
                  :edit-form-maker #'make-test-edit-form
                  :on-delete (lambda (object)
                               (declare (ignore object)))
                  :delete-question "Delete this item?"))
         (html (with-session ((list :lack.session
                                    (make-hash-table)))
                 (render-widget-to-string widget))))
    (testing "Row data is rendered."
      (ok (search "First item" html)
          "The first item's title should be rendered.")
      (ok (search "Second item" html)
          "The second item's title should be rendered.")
      (ok (search "Title" html)
          "The column's title should be rendered."))

    (testing "The actions column and the Add button are rendered."
      (ok (search "Actions" html)
          "The actions column header should be rendered.")
      (ok (search "Edit" html)
          "The Edit button should be rendered.")
      (ok (search "Delete" html)
          "The Delete button should be rendered.")
      (ok (search "Add" html)
          "The Add button should be rendered."))

    (testing "Rendering is done by real theme methods."
      (ok (not (search "Please, define" html))
          "The markup should not contain fallback render advices."))))


(deftest test-crud-optional-buttons
  "Test that buttons are rendered only when their callbacks are given."
  (reset-test-items)
  (flet ((render-it (&rest crud-args)
           (let ((widget (apply #'make-crud-table
                                (list (column "Title" :getter #'test-item-title))
                                #'test-items-getter
                                crud-args)))
             (with-session ((list :lack.session
                                  (make-hash-table)))
               (render-widget-to-string widget)))))
    (testing "Without ON-DELETE there is no Delete button."
      (let ((html (render-it :edit-form-maker #'make-test-edit-form)))
        (ok (search "Edit" html)
            "The Edit button should be rendered.")
        (ok (not (search "Delete" html))
            "The Delete button should not be rendered.")))

    (testing "Without ADD-FORM-MAKER there is no Add button."
      (let ((html (render-it :edit-form-maker #'make-test-edit-form
                             :on-delete (lambda (object)
                                          (declare (ignore object))))))
        (ok (not (search "Add" html))
            "The Add button should not be rendered.")))

    (testing "Without any callback there is no actions column at all."
      (let ((html (render-it)))
        (ok (not (search "Actions" html))
            "The actions column header should not be rendered.")
        (ok (not (search "Edit" html))
            "The Edit button should not be rendered.")
        (ok (not (search "Delete" html))
            "The Delete button should not be rendered.")
        (ok (not (search "Add" html))
            "The Add button should not be rendered.")))))


(deftest test-crud-delete-question-function
  "Test that a DELETE-QUESTION function receives the row's object and its result is shown in the confirmation form."
  (reset-test-items)
  (let ((widget (make-crud-table
                 (list (column "Title" :getter #'test-item-title))
                 #'test-items-getter
                 :on-delete (lambda (object)
                              (declare (ignore object)))
                 :delete-question (lambda (object)
                                    (format nil "Delete \"~A\"?"
                                            (test-item-title object))))))
    (with-session ((list :lack.session
                         (make-hash-table)))
      ;; UPDATE called by MODAL-SHOW renders the modal using
      ;; the current theme:
      (setf (current-theme)
            (make-tailwind-theme))
      (render-widget-to-string widget)
      (let* ((row (first-table-row widget))
             (delete-button (find-row-button row "Delete")))
        (with-action-context ()
          (funcall (on-click delete-button)
                   delete-button))
        (let* ((confirm-form (modal-main-content (crud-modal widget)))
               (form-html (render-widget-to-string confirm-form)))
          (ok confirm-form
              "The modal should show the confirmation form after the Delete button was pressed.")
          (ok (search "Delete &quot;First item&quot;?" form-html)
              "The question from the DELETE-QUESTION function should be rendered."))))))


(deftest test-crud-delete-flow
  "Test the full delete flow: the Delete button opens a confirmation form, submitting it calls ON-DELETE and removes the row, cancelling does nothing."
  (reset-test-items)
  ;; LET* here is important: the ON-DELETE lambda closes over DELETED,
  ;; and LET initforms don't see the previous bindings:
  (let* ((deleted '())
         (widget (make-crud-table
                  (list (column "Title" :getter #'test-item-title))
                  #'test-items-getter
                  :on-delete (lambda (object)
                               (push object deleted))
                  :delete-question "Delete this item?")))
    (with-session ((list :lack.session
                         (make-hash-table)))
      (setf (current-theme)
            (make-tailwind-theme))
      (render-widget-to-string widget)
      (let* ((row (first-table-row widget))
             (row-object (row-object row))
             (delete-button (find-row-button row "Delete")))
        (ok delete-button
            "The row should have a Delete button.")

        (testing "Pressing Delete shows the confirmation form in the modal."
          (run-in-action-context
           (lambda ()
             (funcall (on-click delete-button)
                      delete-button)))
          (let ((confirm-form (modal-main-content (crud-modal widget))))
            (ok (typep confirm-form 'form-widget)
                "The modal should contain the confirmation form.")))

        (testing "Confirming the deletion calls ON-DELETE with the row's object and removes the row."
          (let ((commands (run-in-action-context
                           (lambda ()
                             ;; Reblocks applies the form data plist to the
                             ;; action. Keys arrive as UPPERCASE keywords:
                             (apply (form-on-submit
                                     (modal-main-content (crud-modal widget)))
                                    '(:BUTTON "submit"))))))
            (ok (= 1 (length deleted))
                "ON-DELETE should be called exactly once.")
            (ok (eq row-object (first deleted))
                "ON-DELETE should receive the row's object.")
            (ok (row-command-p commands row :|removeWidget|)
                "The row should be removed from the page by (UPDATE TABLE-ROW :REMOVED T).")))

        (testing "Cancelling the deletion does not call ON-DELETE."
          ;; Show the confirmation form again, the modal was hidden
          ;; by the previous submission:
          (run-in-action-context
           (lambda ()
             (funcall (on-click delete-button)
                      delete-button)))
          (let ((commands (run-in-action-context
                           (lambda ()
                             (apply (form-on-submit
                                     (modal-main-content (crud-modal widget)))
                                    '(:BUTTON "cancel"))))))
            (ok (= 1 (length deleted))
                "ON-DELETE should not be called for the \"cancel\" button.")
            (ok (not (row-command-p commands row :|removeWidget|))
                "The row should not be removed when the deletion was cancelled.")))))))


(deftest test-crud-edit-flow
  "Test the full edit flow: the Edit button opens the form created by EDIT-FORM-MAKER, and submitting it recalculates the row's cells."
  (reset-test-items)
  (let ((widget (make-crud-table
                 (list (column "Title" :getter #'test-item-title))
                 #'test-items-getter
                 :edit-form-maker
                 (lambda (modal object)
                   (declare (ignore modal))
                   ;; A realistic form with a Save button, like in the
                   ;; donor application: this way the :BUTTON key is
                   ;; always given to the on-submit callback:
                   (form (html ((:div :class "flex flex-col gap-4"
                                    (input :name "title"
                                           :value (test-item-title object))
                                    (:div :class "flex gap-4 flex-row-reverse"
                                          (button "Save"
                                                  :name "button"
                                                  :value "submit"
                                                  :type "submit"
                                                  :view :action)
                                          (button "Cancel"
                                                  :name "button"
                                                  :value "cancel"
                                                  :type "submit")))))
                         :on-submit (lambda (form &key button title)
                                      (declare (ignore form))
                                      (when (string-equal button "submit")
                                        (setf (test-item-title object)
                                              title))))))))
    (with-session ((list :lack.session
                         (make-hash-table)))
      (setf (current-theme)
            (make-tailwind-theme))
      (render-widget-to-string widget)
      (let* ((row (first-table-row widget))
             (edit-button (find-row-button row "Edit")))
        (ok edit-button
            "The row should have an Edit button.")

        (testing "Pressing Edit shows the EDIT-FORM-MAKER's form in the modal."
          (run-in-action-context
           (lambda ()
             (funcall (on-click edit-button)
                      edit-button)))
          (ok (typep (modal-main-content (crud-modal widget))
                     'form-widget)
              "The modal should contain the edit form."))

        (testing "Submitting the edit form updates the object and recalculates the row."
          (let* ((edit-form (modal-main-content (crud-modal widget)))
                 (commands (run-in-action-context
                            (lambda ()
                              (apply (form-on-submit edit-form)
                                     '(:BUTTON "submit" :TITLE "Edited title"))))))
            (ok (string= (test-item-title (row-object row))
                         "Edited title")
                "The application's on-submit callback should receive the new title.")
            (let ((row-html (row-update-command-html commands row)))
              (ok row-html
                  "The row should be updated by RECALCULATE-CELLS after the edit form was submitted.")
              (ok (search "Edited title" row-html)
                  "The recalculated row should show the new title."))))))))


(deftest test-crud-submit-button-detection
  "Test that the :SUBMIT handlers recognize the submit button in form data with UPPERCASE keys."
  (testing "The \"submit\" value of the :BUTTON key is recognized."
    (ok (submitted-with-submit-button-p '(:BUTTON "submit"))
        "The plist (:BUTTON \"submit\") should be recognized as a submission by the submit button.")
    (ok (submitted-with-submit-button-p '(:button "submit"))
        "Any case of the key name should work, because keys are compared as strings."))

  (testing "Other button values and empty data are not recognized."
    (ok (not (submitted-with-submit-button-p '(:BUTTON "cancel")))
        "The \"cancel\" value should not be recognized as a submission.")
    (ok (not (submitted-with-submit-button-p '(:BUTTON "remove-everything")))
        "Foreign button values should not be recognized.")
    (ok (not (submitted-with-submit-button-p '()))
        "Empty form data should not be recognized as a submission.")))
