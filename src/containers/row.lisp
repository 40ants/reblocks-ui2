(uiop:define-package #:reblocks-ui2/containers/row
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
  (:export #:row-widget
           #:make-row-widget
           #:row
           #:subwidgets))
(in-package #:reblocks-ui2/containers/row)


(defvar *default-gap* :m)


(defwidget row-widget (ui-widget)
  ((subwidgets :initarg :subwidgets
               :initform nil
               :type (soft-list-of widget)
               :reader subwidgets)
   (gap :initform *default-gap*
        :initarg :gap
        :reader children-gap)
   ;; (classes :initarg :classes
   ;;          :initform nil
   ;;          :type (soft-list-of string)
   ;;          :reader classes
   ;;          :documentation "A list of additional CSS classes.")
   ))


(defun make-row-widget (subwidgets
                        &key (gap *default-gap*)
                             on-click)
  (make-instance 'row-widget
                 :subwidgets (mapcar #'create-widget-from subwidgets)
                 :gap gap
                 :on-click on-click))


(defmacro row (&rest subwidgets-and-options)
  (loop with collecting-subwidgets-p = t
        for item in subwidgets-and-options
        when (keywordp item)
        do (setf collecting-subwidgets-p nil)
        if collecting-subwidgets-p
        collect item into subwidget-forms
        else
        collect item into options
        finally (return
                  (destructuring-bind (&key gap on-click)
                      options
                    `(make-row-widget (list ,@subwidget-forms)
                                      :gap (or ,gap
                                               *default-gap*)
                                      :on-click ,on-click)))))



(defgeneric gap-css-classes (theme gap)
  (:method (theme gap)
    nil))


(defgeneric gap-css-styles (theme gap)
  (:method (theme gap)
    nil))


(defmethod reblocks-ui2/utils/walk:children ((widget row-widget))
  (subwidgets widget))
