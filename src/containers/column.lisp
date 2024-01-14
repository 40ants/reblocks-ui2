(uiop:define-package #:reblocks-ui2/containers/column
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:create-widget-from
                #:widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:serapeum
                #:soft-list-of)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:import-from #:reblocks-ui2/utils/walk)
  (:export #:column-widget
           #:column
           #:subwidgets))
(in-package #:reblocks-ui2/containers/column)


(defvar *default-gap* :m)


(defwidget column-widget (ui-widget)
  ((subwidgets :initarg :subwidgets
               :initform nil
               :type (soft-list-of widget)
               :accessor subwidgets)
   (gap :initform *default-gap*
        :initarg :gap
        :reader children-gap)))


(defun make-column-widget (subwidgets
                           &key gap)
  (make-instance 'column-widget
                 :subwidgets (mapcar #'create-widget-from subwidgets)
                 :gap gap))


(defun column (&rest subwidgets-and-options)
  (loop with collecting-subwidgets-p = t
        for item in subwidgets-and-options
        when (keywordp item)
        do (setf collecting-subwidgets-p nil)
        if collecting-subwidgets-p
        collect item into subwidgets
        else
        collect item into options
        finally (return
                  (destructuring-bind (&key (gap *default-gap*)
                                            (column-type 'column-widget)
                                            margin
                                            width
                                            height)
                      options
                    (make-instance column-type
                                   :subwidgets (mapcar #'create-widget-from
                                                       (remove-if #'null subwidgets))
                                   :gap gap
                                   :margin margin
                                   :width width
                                   :height height)))))



(defgeneric gap-css-classes (theme gap)
  (:method (theme gap)
    nil))


(defgeneric gap-css-styles (theme gap)
  (:method (theme gap)
    nil))


(defmethod reblocks-ui2/utils/walk:children ((widget column-widget))
  (subwidgets widget))
