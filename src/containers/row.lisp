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
  (:import-from #:reblocks-ui2/containers/container
                #:make-container
                #:container-widget)
  (:export #:row-widget
           #:make-row-widget
           #:row
           #:subwidgets))
(in-package #:reblocks-ui2/containers/row)


(defwidget row-widget (container-widget)
  ())


(defun row (&rest subwidgets-and-options)
  (apply #'make-container 'row-widget
         subwidgets-and-options))



(defun make-row-widget (subwidgets
                        &key (gap *default-gap*)
                             on-click)
  (make-instance 'row-widget
                 :subwidgets (mapcar #'create-widget-from subwidgets)
                 :gap gap
                 :on-click on-click))
