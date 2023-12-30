(uiop:define-package #:reblocks-ui2/containers/controls-row
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:create-widget-from
                #:render
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks-ui2/containers/row
                #:row-widget)
  (:export #:controls-row
           #:controls-row-widget))
(in-package #:reblocks-ui2/containers/controls-row)


(defvar *default-gap* :m)


(defwidget controls-row-widget (row-widget)
  ())


(defun make-controls-row-widget (subwidgets &key gap)
  (make-instance 'controls-row-widget
                 :subwidgets (mapcar #'create-widget-from subwidgets)
                 :gap gap))


(defmacro controls-row (&rest subwidgets-and-options)
  (loop with collecting-subwidgets-p = t
        for item in subwidgets-and-options
        when (keywordp item)
        do (setf collecting-subwidgets-p nil)
        if collecting-subwidgets-p
        collect item into subwidget-forms
        else
        collect item into options
        finally (return
                  (destructuring-bind (&key gap)
                      options
                    `(make-controls-row-widget (list ,@subwidget-forms)
                                               :gap (or ,gap
                                                        *default-gap*))))))
