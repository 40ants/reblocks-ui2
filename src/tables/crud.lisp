(uiop:define-package #:reblocks-ui2/tables/crud
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:serapeum
                #:->
                #:soft-list-of)
  (:import-from #:alexandria
                #:remove-from-plist)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:import-from #:reblocks-ui2/tables/table
                #:column)
  (:import-from #:reblocks-ui2/tables/search
                #:search-widget)
  (:import-from #:reblocks-ui2/modal
                #:modal)
  (:export #:crud-table
           #:make-crud-table
           #:crud-columns
           #:crud-data-getter
           #:crud-add-form-maker
           #:crud-edit-form-maker
           #:crud-on-delete
           #:crud-delete-question
           #:crud-add-button-title
           #:crud-edit-button-title
           #:crud-delete-button-title
           #:crud-edit-header
           #:crud-delete-header
           #:crud-add-header
           #:crud-row-class
           #:crud-search
           #:crud-modal
           #:form-button-value
           #:submitted-with-submit-button-p
           #:delete-question-text))
(in-package #:reblocks-ui2/tables/crud)


(defwidget crud-table (ui-widget)
  ((columns :initarg :columns
            :type (soft-list-of column)
            :initform nil
            :reader crud-columns
            :documentation "Columns to show. Should not include an actions column, because CRUD-TABLE adds such a column by itself when at least one of ADD-FORM-MAKER, EDIT-FORM-MAKER or ON-DELETE is given.")
   (data-getter :initarg :data-getter
                :type (or symbol function)
                :reader crud-data-getter
                :documentation "A function returning a list of objects to show. Given as is to REBLOCKS-UI2/TABLES/SEARCH:MAKE-SEARCH-WIDGET, which calls it with a filters widget as the argument.")
   (add-form-maker :initarg :add-form-maker
                   :initform nil
                   :type (or null function)
                   :reader crud-add-form-maker
                   :documentation "A function of two arguments (CRUD-WIDGET MODAL), returning a form widget to show in the modal when the Add button is pressed.")
   (edit-form-maker :initarg :edit-form-maker
                    :initform nil
                    :type (or null function)
                    :reader crud-edit-form-maker
                    :documentation "A function of two arguments (MODAL OBJECT), returning a form widget to show in the modal when the row's Edit button for the OBJECT is pressed.")
   (on-delete :initarg :on-delete
              :initform nil
              :type (or null function)
              :reader crud-on-delete
              :documentation "A function of one argument (OBJECT), called when deletion of the OBJECT was confirmed in the modal.")
   (delete-question :initarg :delete-question
                    :initform "Delete this record?"
                    :type (or string function)
                    :reader crud-delete-question
                    :documentation "A question to show in the delete confirmation form. Either a string or a function of one argument (OBJECT) returning the question string.")
   (add-button-title :initarg :add-button-title
                     :initform "Add"
                     :type string
                     :reader crud-add-button-title
                     :documentation "The title of the button shown above the table. When ADD-FORM-MAKER is nil, the button is not rendered at all.")
   (edit-button-title :initarg :edit-button-title
                      :initform "Edit"
                      :type string
                      :reader crud-edit-button-title
                      :documentation "The title of the Edit button in the actions column. When EDIT-FORM-MAKER is nil, the button is not rendered at all.")
   (delete-button-title :initarg :delete-button-title
                        :initform "Delete"
                        :type string
                        :reader crud-delete-button-title
                        :documentation "The title of the Delete button in the actions column. Also used as the confirm button title of the delete confirmation form. When ON-DELETE is nil, the button is not rendered at all.")
   (edit-header :initarg :edit-header
                :initform nil
                :type (or null ui-widget)
                :reader crud-edit-header
                :documentation "A widget shown as the modal's header content when the edit form is opened. When nil, the modal is shown without a header content.")
   (delete-header :initarg :delete-header
                  :initform nil
                  :type (or null ui-widget)
                  :reader crud-delete-header
                  :documentation "A widget shown as the modal's header content when the delete confirmation form is opened. When nil, the modal is shown without a header content.")
   (add-header :initarg :add-header
               :initform nil
               :type (or null ui-widget)
               :reader crud-add-header
               :documentation "A widget shown as the modal's header content when the add form is opened. When nil, the modal is shown without a header content.")
   (row-class :initarg :row-class
              :initform nil
              :type (or null symbol)
              :reader crud-row-class
              :documentation "A widget class name to create table rows of. Given as :ROW-CLASS argument to REBLOCKS-UI2/TABLES/SEARCH:MAKE-SEARCH-WIDGET.")
   (search :initform nil
           :type (or null search-widget)
           :reader crud-search
           :documentation "The search widget created by the latest RENDER. Useful to reach the table widget from application's code or in tests.")
   (modal :initform nil
          :type (or null modal)
          :reader crud-modal
          :documentation "The modal widget created by the latest RENDER. Useful to hide the modal from application's form callbacks."))
  (:documentation "A search table with Add, Edit and Delete actions.

This widget knows nothing about the persistence: forms are created by
ADD-FORM-MAKER and EDIT-FORM-MAKER callbacks, and the deletion is performed
by the ON-DELETE callback. All of them are optional: only the corresponding
buttons are rendered for the given callbacks."))


(-> make-crud-table ((soft-list-of column) (or symbol function) &rest t
                     &key
                     (:add-form-maker (or null function))
                     (:edit-form-maker (or null function))
                     (:on-delete (or null function))
                     (:delete-question (or string function))
                     (:add-button-title string)
                     (:edit-button-title string)
                     (:delete-button-title string)
                     (:edit-header (or null ui-widget))
                     (:delete-header (or null ui-widget))
                     (:add-header (or null ui-widget))
                     (:row-class (or null symbol))
                     (:widget-class symbol))
    (values crud-table &optional))

(defun make-crud-table (columns data-getter &rest restargs
                        &key add-form-maker edit-form-maker on-delete
                          delete-question add-button-title edit-button-title
                          delete-button-title edit-header delete-header add-header
                          row-class widget-class)
  "Returns a table widget with search and Add/Edit/Delete actions.

COLUMNS should not include an actions column: it is added automatically
as the last column when at least one of ADD-FORM-MAKER, EDIT-FORM-MAKER
or ON-DELETE is given.

DATA-GETTER is given as is to REBLOCKS-UI2/TABLES/SEARCH:MAKE-SEARCH-WIDGET
and should return a list of objects to show.

- ADD-FORM-MAKER is called as (FUNCALL ADD-FORM-MAKER CRUD-WIDGET MODAL)
  and should return a form widget.
- EDIT-FORM-MAKER is called as (FUNCALL EDIT-FORM-MAKER MODAL OBJECT)
  and should return a form widget.
- ON-DELETE is called as (FUNCALL ON-DELETE OBJECT) after the user has
  confirmed the deletion.

When the library opens a form in the modal, it also subscribes to the
form's :SUBMIT event, to update the table after a successful submission:
the whole table is updated after the add form was submitted, and only
the row's cells are recalculated after the edit form was submitted."
  (declare (ignore add-form-maker edit-form-maker on-delete delete-question
                   add-button-title edit-button-title delete-button-title
                   edit-header delete-header add-header row-class))
  (apply #'make-instance (or widget-class 'crud-table)
         :columns columns
         :data-getter data-getter
         (remove-from-plist restargs :widget-class)))


(-> form-button-value (list)
    (values (or null string) &optional))

(defun form-button-value (form-data)
  "Returns the value submitted by the form's button named \"button\".

FORM-DATA is the plist given to a :SUBMIT event handler of a form widget.
Reblocks interns the keys of this plist as UPPERCASE keywords, that is why
a plain (GETF FORM-DATA :some-other-case) might not find the value. This
function compares key names as strings instead and works with any case."
  (loop for (key value) on form-data by #'cddr
        when (and (symbolp key)
                  (string-equal (symbol-name key) "button"))
          return value))


(-> submitted-with-submit-button-p (list)
    (values boolean &optional))

(defun submitted-with-submit-button-p (form-data)
  "Returns T when FORM-DATA was submitted by a button having the value \"submit\".

Use this predicate in :SUBMIT event handlers to detect which button was
pressed, see FORM-BUTTON-VALUE for the case-sensitivity details."
  (let ((value (form-button-value form-data)))
    (and (stringp value)
         (string-equal value "submit")
         t)))


(-> delete-question-text ((or string function) t)
    (values string &optional))

(defun delete-question-text (delete-question object)
  "Returns the question to show in the delete confirmation form.

DELETE-QUESTION is either a string or a function of one argument, the row's
OBJECT, returning the question string."
  (etypecase delete-question
    (string delete-question)
    (function (funcall delete-question object))))
