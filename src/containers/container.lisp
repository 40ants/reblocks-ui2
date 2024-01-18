(uiop:define-package #:reblocks-ui2/containers/container
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
           #:subwidgets
           #:container-widget
           #:make-container
           #:gap-css-classes
           #:additional-classes))
(in-package #:reblocks-ui2/containers/container)


(defvar *default-gap* :m)


(defwidget container-widget (ui-widget)
  ((subwidgets :initarg :subwidgets
               :initform nil
               :type (soft-list-of widget)
               :accessor subwidgets)
   (gap :initform *default-gap*
        :initarg :gap
        :reader children-gap)
   (classes :initform nil
            :type (soft-list-of string)
            :initarg :css-classes
            :reader additional-classes)))


(declaim (ftype (function (symbol &rest list)
                          (values container-widget &optional))
                make-container))

(defun make-container (default-widget-class &rest subwidgets-and-options)
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
                                            (column-type default-widget-class)
                                            margin
                                            (width :full)
                                            height
                                            on-click
                                            css-classes)
                      options
                    (make-instance column-type
                                   :subwidgets (mapcar #'create-widget-from
                                                       (remove-if #'null subwidgets))
                                   :gap gap
                                   :margin margin
                                   :width width
                                   :height height
                                   :on-click on-click
                                   :css-classes (uiop:ensure-list css-classes))))))



(defgeneric gap-css-classes (gap theme)
  (:method (gap theme)
    nil))


(defmethod reblocks-ui2/utils/walk:children ((widget container-widget))
  (subwidgets widget))
