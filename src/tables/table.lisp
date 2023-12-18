(uiop:define-package #:reblocks-ui2/tables/table
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:widget
                #:get-html-tag
                #:get-css-classes
                #:create-widget-from
                #:render
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:serapeum
                #:fmt
                #:soft-list-of)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:import-from #:reblocks-lass)
  (:export
   #:make-table
   #:column
   #:current-row
   #:current-table
   #:current-cell
   #:current-column
   #:recalculate-cells
   #:table-row
   #:table-widget
   #:append-data
   #:column-align
   #:column-css-classes
   #:table-columns
   #:table-rows
   #:row-table
   #:row-cells
   #:row-object
   #:column-idx
   #:header-column-css-classes
   #:column-classes))
(in-package #:reblocks-ui2/tables/table)


(defvar *current-table*)

(defvar *current-row*)

;; This variable will be available during CALCULATE-CELLS and RENDER calls.
(defvar *current-column*)

(defvar *current-cell*)

(defwidget table-row ()
  ((cells :initarg :cells
          :type (soft-list-of widget)
          :reader row-cells)
   (table :initarg :table
          :reader row-table
          :documentation "Reference it a table row belong to.")
   (object :initarg :object
           :reader row-object
           :documentation "Original object, passed as a row to the MAKE-TABLE function.")))


(defwidget table-widget (ui-widget)
  ((columns :initarg :columns
            :reader table-columns)
   (rows :initarg :rows
         :type (soft-list-of table-row)
         :initform nil
         :reader table-rows)
   (row-class :initarg :row-class
              :type symbol
              :initform 'table-row
              :reader table-row-class)))


(defwidget column ()
  ((idx :initform nil
        :type (or null integer)
        :reader column-idx)
   (getter :initarg :getter
           :type function
           :initform (lambda (row)
                       (declare (ignore row))
                       (error "Real getter should be provided to COLUMN function."))
           :reader data-getter)
   (cell-maker :initarg :cell-maker
               :type function
               :initform #'create-widget-from
               :reader cell-maker)
   (title :initarg :title
          :type widget
          :reader column-title)
   (align :initarg :align
          :type (member :left :right :center)
          :initform :left
          :reader column-align)
   (classes :initarg :classes
            :type (soft-list-of string)
            :initform nil
            :reader column-classes
            :documentation "Additional CSS classes for column cells")))


(defmethod initialize-instance :after ((widget table-widget) &rest initargs)
  (declare (ignore initargs))
  (loop for column in (table-columns widget)
        for idx upfrom 0
        do (setf (slot-value column 'idx)
                 idx)))


(defun calculate-cells (row)
  (loop with *current-table* = (row-table row)
        with *current-row* = row
        with object = (row-object row)
        for *current-column* in (table-columns *current-table*)
        for data = (funcall (data-getter *current-column*) object)
        for cell = (funcall (cell-maker *current-column*) data)
        collect cell into cells
        finally (setf (slot-value *current-row* 'cells)
                      cells)
                (return *current-row*)))


(defgeneric to-table-row (table object)
  (:documentation "Creates a table rows from objects.")
  (:method ((table t) (object t))
    ;; Here we are creating a *current-row* binding to be able
    ;; to refer to the row widget from the cell creating code:
    (calculate-cells (make-instance (table-row-class table)
                                    :object object
                                    :table table))))


(defun make-table (columns rows &key (table-class 'table-widget)
                                     (row-class nil row-class-given-p))
  (let* ((row-args (when row-class-given-p
                     (list :row-class row-class)))
         (widget (apply #'make-instance
                        table-class
                        :columns (mapcar #'create-widget-from columns)
                        row-args))
         (rows (loop for obj in rows
                     collect (to-table-row widget obj))))
    (setf (slot-value widget 'rows)
          rows)
    widget))


(defgeneric header-column-css-classes (column theme)
  (:method ((widget column) (theme t))
    (fmt "align-~A"
         (string-downcase
          (column-align widget)))))


(defgeneric column-css-classes (column theme)
  (:method ((widget column) (theme t))
    (fmt "align-~A"
         (string-downcase
          (column-align widget)))))


(defun column (title &key (getter nil getter-given-p)
                          (cell-maker nil cell-maker-p)
                          (align :center)
                          (classes nil clases-given-p))
  (let* ((args (append (when getter-given-p
                         (list :getter getter))
                       (when clases-given-p
                         (list :classes
                               (uiop:ensure-list classes)))
                       (when cell-maker-p
                         (list :cell-maker cell-maker))))
         (column (apply #'make-instance
                        'column
                        :title (create-widget-from title)
                        :align align
                        args)))

    ;; Default implementation of data-getter just
    ;; takes item from row by column index
    (unless getter-given-p
      (setf (slot-value column 'getter)
            (lambda (row)
              (elt row (column-idx column)))))
    
    (values column)))


(defmethod reblocks-ui2/widget:render ((widget column) (theme t))
  (reblocks-ui2/widget:render (column-title widget)
                              theme))


;; (defmethod reblocks/widget:get-css-classes ((widget column))
;;   (list* (fmt "align-~A"
;;               (string-downcase (column-align widget)))
;;          (call-next-method)))


(defun current-table ()
  (unless (boundp '*current-table*)
    (error "Function CURRENT-TABLE should be called only in cell creation code."))
  (values *current-table*))

(defun current-row ()
  (unless (boundp '*current-row*)
    (error "Function CURRENT-ROW should be called only in cell creation code."))
  (values *current-row*))

(defun current-column ()
  (unless (boundp '*current-column*)
    (error "Function CURRENT-COLUMN should be called only in cell creation code."))
  (values *current-column*))

(defun current-cell ()
  (unless (boundp '*current-cell*)
    (error "Function CURRENT-CELL should be called only in cell creation code."))
  (values *current-cell*))


(defun recalculate-cells (row &key (update t))
  "Updates cell widgets using base object, stored in the ROW."
  (calculate-cells row)
  (when update
    (reblocks/widget:update row))
  (values row))


(defgeneric append-data (widget data)
  (:method ((widget table-widget) data)
    (let ((rows (loop for obj in data
                      collect (to-table-row widget obj))))
      (alexandria:appendf (slot-value widget 'rows)
                          rows)
      (values widget))))


(defmethod get-dependencies ((widget table-widget))
  (list*
   (reblocks-lass:make-dependency
     `(.table-widget
       ((:or (:and th .align-left)
             (:and td .align-left))
        :text-align left)
       ((:or (:and th .align-right)
             (:and td .align-right))
        :text-align right)
       ((:or (:and th .align-center)
             (:and td .align-center))
        :text-align center)))
   (call-next-method)))
