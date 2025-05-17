(uiop:define-package #:reblocks-ui2/tables/editable-table
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:update
                #:render
                #:create-widget-from
                #:defwidget)
  (:import-from #:reblocks-ui2/tables/table
                #:current-column
                #:current-row
                #:row-object
                #:recalculate-cells
                #:column-idx
                #:column
                #:table-rows
                #:table-columns
                #:row-table
                #:row-cells
                #:*current-cell*
                #:*current-row*
                #:table-row
                #:column-css-classes
                #:table-widget
                #:*current-table*
                #:to-table-row)
  (:import-from #:reblocks-ui2/buttons/button
                #:button)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/widgets/string-widget
                #:string-widget)
  (:import-from #:reblocks/widgets/dom
                #:dom-id)
  (:import-from #:serapeum
                #:push-end
                #:dict
                #:fmt)
  (:import-from #:reblocks/response
                #:send-script)
  (:import-from #:parenscript
                #:@
                #:chain)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:import-from #:alexandria
                #:last-elt
                #:assoc-value)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:import-from #:reblocks-ui2/editable
                #:make-editable-widget)
  (:import-from #:reblocks-ui2/icon
                #:icon)
  (:export #:editable-table-widget
           #:make-editable-table
           #:data-setter
           #:editable-column
           #:object-deleter
           #:delete-row
           #:row-not-found
           #:object-creator))
(in-package #:reblocks-ui2/tables/editable-table)


(defun default-setter (column object value)
  (setf (elt object (column-idx column))
        value))


(defwidget editable-column (column)
  ((setter :initarg :setter
           :type function
           :initform #'default-setter
           :reader data-setter)))


(defwidget editable-cell (ui-widget)
  ((edit-mode-p :initform nil
                :initarg :edit-mode
                :type boolean
                :accessor edit-mode-p)
   (child :initform nil
          :initarg :child
          :accessor cell-child)
   (editable-child :initform nil
                   :initarg :editable-child
                   :accessor cell-editable-child)))


(defwidget editable-table-widget (table-widget)
  (;; (edit-mode-p :initform nil
   ;;              :initarg nil
   ;;              :reader edit-mode-p)
   (object-deleter :initform nil
                   :initarg :object-deleter
                   :documentation "When given, should be a function of one argument.
                                   Will be called with object instance to be deleted from the table.
                                   Usually you will want to do something like deletion the record from a database."
                   :reader object-deleter)
   (object-creator :initform nil
                   :initarg :object-creator
                   :documentation "When given, should be a function of zero arguments.
                                   Will be called when user adds a new table row.
                                   Usually you will want to do create and add an object to a database.
                                   Returned object will be bound to a new table row and used to fill cells with new values."
                   :reader object-creator)))


(defun make-editable-table (columns rows &key (table-class 'editable-table-widget)
                                              (row-class nil row-class-given-p)
                                              (object-deleter nil object-deleter-given-p)
                                              (object-creator nil object-creator-given-p))
  (let* ((args (append
                (when row-class-given-p
                  (list :row-class row-class))
                (when object-deleter-given-p
                  (list :object-deleter object-deleter))
                (when object-creator-given-p
                  (list :object-creator object-creator))))
         
         (widget (apply #'make-instance
                        table-class
                        :columns (mapcar #'create-widget-from columns)
                        args))
         (rows (loop for obj in rows
                     collect (to-table-row widget obj))))
    (setf (slot-value widget 'reblocks-ui2/tables/table::rows)
          rows)
    widget))


(defun editable-column (title &key (getter nil getter-given-p)
                                   (setter #'default-setter)
                                   (cell-maker #'create-widget-from)
                                   (align :left))
  (let ((args (append (when getter-given-p
                        (list :getter getter))
                      (list :setter setter))))
    (flet ((cell-maker-wrapper (value)
             (let* ((row (current-row))
                    (object (row-object row))
                    (column (current-column))
                    (cell (make-instance 'editable-cell
                                         :child (funcall cell-maker value))))
               (labels ((update-value (new-value)
                          (if setter
                              (funcall setter
                                       column
                                       object
                                       new-value)
                              (log:warn "No setter was given for" column))
                          ;; Now return back to the read-only
                          (setf (edit-mode-p cell)
                                (not (edit-mode-p cell)))
                          (setf (cell-child cell)
                                (funcall cell-maker new-value))
                          (setf (cell-editable-child cell)
                                (make-editable-widget new-value #'update-value))
                          (update cell)))
                 (setf (cell-editable-child cell)
                       (make-editable-widget value #'update-value))
                 (values cell)))))
      (apply #'make-instance
             'editable-column
             :title (create-widget-from title)
             :align align
             :cell-maker #'cell-maker-wrapper
             args))))


(defun update-rows (widget data)
  (log:info "Updating widget" widget data)
  (let* ((id-to-items
           (loop with result = (dict)
                 for row in data
                 do (setf (gethash (assoc-value row "id" :test #'string-equal) result)
                          (assoc-value row "items" :test #'string-equal))
                 finally (return result))))
    (loop for row in (table-rows widget)
          for row-id = (dom-id row)
          for new-items = (gethash row-id id-to-items)
          for object = (row-object row)
          when new-items
          do (loop for column in (table-columns widget)
                   for item in new-items
                   for new-value = (assoc-value item "value" :test #'string-equal)
                   ;; TODO: assert column idx
                   do (funcall (data-setter column)
                               column
                               object
                               new-value)
                   finally (recalculate-cells row))))
  (values))


(defgeneric render-editable-row (row-widget theme)
  (:documentation "Renders a row as form inputs."))


(defgeneric render-editable-cell (column cell-widget theme)
  (:documentation "Renders a row as form inputs."))



(define-condition row-not-found (error)
  ())


(defgeneric delete-row (table obj)
  (:documentation "Deletes row representing given object.
                   First it calls OBJECT-DELETER callback and then
                   removes corresponding row from the table.")
  (:method ((table editable-table-widget) (obj t))
    (let ((row (find obj (table-rows table)
                     :key #'row-object)))
      (unless row
        (error 'row-not-found
               "Row corresponding to ~S was not found."
               obj))

      (when (object-deleter table)
        (funcall (object-deleter table)
                 obj))

      (setf (slot-value table 'reblocks-ui2/tables/table::rows)
            (remove row (table-rows table)))

      ;; TODO: think about a special command to delete row element
      ;; instead of updating whole table widget
      (update table)
      (values))))



(defmethod reblocks-ui2/widget:render ((widget editable-cell) (theme t))
  ;; TODO: probably this will eat too many memory and we need to
  ;; create a single action per table?
  (let ((action (make-js-action (lambda (&rest args)
                                  (declare (ignore args))
                                  (setf (edit-mode-p widget)
                                        (not (edit-mode-p widget)))
                                  (update widget)))))
    (with-html ()
      (cond
        ((edit-mode-p widget)
         (:div :class "content"
               (render (cell-editable-child widget))))
        (t
         (:div :class "content"
               :ondblclick action
               (render (cell-child widget))))))))

