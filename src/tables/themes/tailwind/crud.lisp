(uiop:define-package #:reblocks-ui2/tables/themes/tailwind/crud
  (:use #:cl)
  (:import-from #:reblocks-ui2/tables/crud
                #:crud-table
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
                #:delete-question-text
                #:submitted-with-submit-button-p)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks/widget
                #:update)
  (:import-from #:event-emitter
                #:on)
  (:import-from #:reblocks-ui2/widget
                #:render)
  (:import-from #:reblocks-ui2/modal
                #:modal
                #:modal-show
                #:modal-hide)
  (:import-from #:reblocks-ui2/tables/table
                #:column
                #:current-row
                #:recalculate-cells
                #:table-row)
  (:import-from #:reblocks-ui2/tables/search
                #:make-search-widget)
  (:import-from #:reblocks-ui2/buttons/button
                #:button)
  (:import-from #:reblocks-ui2/containers/row
                #:row)
  ;; Just a dependency on the package, the COLUMN container function
  ;; is referenced by the full package path, because TABLE:COLUMN
  ;; is already imported above:
  (:import-from #:reblocks-ui2/containers/column)
  (:import-from #:reblocks-ui2/html
                #:html)
  (:import-from #:reblocks-ui2/form/confirm
                #:confirm)
  (:import-from #:serapeum
                #:->))
(in-package #:reblocks-ui2/tables/themes/tailwind/crud)


(-> make-actions-column (crud-table modal)
    (values column &optional))

(defun make-actions-column (widget modal)
  "Returns the last column of the CRUD table, containing the Edit and Delete buttons.

Each button is rendered only when the corresponding callback is given
on the CRUD-TABLE widget."
  (column "Actions"
          :getter #'identity
          :cell-maker
          (lambda (object)
            ;; CURRENT-ROW is bound to the row's widget
            ;; while the cell is being created:
            (let ((table-row (current-row)))
              (row (when (crud-edit-form-maker widget)
                     (button (crud-edit-button-title widget)
                             :view :action
                             :on-click (lambda (button-widget)
                                         (declare (ignore button-widget))
                                         (show-edit-form widget modal table-row object))))
                   (when (crud-on-delete widget)
                     (button (crud-delete-button-title widget)
                             :view :action
                             :on-click (lambda (button-widget)
                                         (declare (ignore button-widget))
                                         (show-delete-form widget modal table-row object))))
                   ;; By default the row container is a flex with
                   ;; justify-between, but we want the buttons
                   ;; at the right edge, like in the donor widget:
                   :css-classes '("justify-end"))))))


(-> show-edit-form (crud-table modal table-row t)
    (values t &optional))

(defun show-edit-form (widget modal table-row object)
  "Creates the edit form for the OBJECT and shows it in the MODAL.

Also subscribes to the form's :SUBMIT event, to recalculate the
TABLE-ROW's cells after the form was submitted by the \"submit\" button."
  (let ((form (funcall (crud-edit-form-maker widget)
                       modal object)))
    (on :submit form
        (lambda (form form-data)
          (declare (ignore form))
          (when (submitted-with-submit-button-p form-data)
            (recalculate-cells table-row))))
    (apply #'modal-show modal
           :content form
           (when (crud-edit-header widget)
             (list :header-content (crud-edit-header widget))))))


(-> show-delete-form (crud-table modal table-row t)
    (values t &optional))

(defun show-delete-form (widget modal table-row object)
  "Creates the confirmation form for the OBJECT's deletion and shows it in the MODAL.

Confirming the form calls the widget's ON-DELETE callback and removes the
row from the page. The modal is hidden after the form was submitted by
any button."
  (let ((form (confirm (delete-question-text (crud-delete-question widget)
                                             object)
                       :confirm-button-title (crud-delete-button-title widget)
                       :on-confirm (lambda (confirm-form)
                                     (declare (ignore confirm-form))
                                     (funcall (crud-on-delete widget)
                                              object)
                                     (update table-row :removed t)))))
    ;; Hide the modal when the user confirms or cancels the deletion:
    (on :submit form
        (lambda (form form-data)
          (declare (ignore form form-data))
          (modal-hide modal)))
    (apply #'modal-show modal
           :content form
           (when (crud-delete-header widget)
             (list :header-content (crud-delete-header widget))))))


(-> show-add-form (crud-table modal)
    (values t &optional))

(defun show-add-form (widget modal)
  "Creates the add form and shows it in the MODAL.

Also subscribes to the form's :SUBMIT event, to update the whole
table after the form was submitted by the \"submit\" button."
  (let ((form (funcall (crud-add-form-maker widget)
                       widget modal)))
    (on :submit form
        (lambda (form form-data)
          (declare (ignore form))
          (when (submitted-with-submit-button-p form-data)
            (update widget))))
    (apply #'modal-show modal
           :content form
           (when (crud-add-header widget)
             (list :header-content (crud-add-header widget))))))


(defmethod render ((widget crud-table) (theme tailwind-theme))
  (let* ((modal (modal (html ())))
         (actions-column (when (or (crud-add-form-maker widget)
                                   (crud-edit-form-maker widget)
                                   (crud-on-delete widget))
                           (make-actions-column widget modal)))
         (columns (append (crud-columns widget)
                          (when actions-column
                            (list actions-column))))
         (search (apply #'make-search-widget
                        columns
                        (crud-data-getter widget)
                        (when (crud-row-class widget)
                          (list :row-class (crud-row-class widget)))))
         (add-button (when (crud-add-form-maker widget)
                       (button (crud-add-button-title widget)
                               :view :action
                               :on-click (lambda (button-widget)
                                           (declare (ignore button-widget))
                                           (show-add-form widget modal)))))
         (controls (when add-button
                     (row add-button
                          :css-classes "flex-row-reverse"))))
    ;; Remember the modal and the search widgets, to make them
    ;; accessible to the application's code and in tests:
    (setf (slot-value widget 'search) search
          (slot-value widget 'modal) modal)
    (render modal theme)
    (render (reblocks-ui2/containers/column:column
             search
             controls)
            theme)))
