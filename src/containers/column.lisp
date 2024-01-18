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
  (:import-from #:reblocks-ui2/containers/container
                #:make-container
                #:container-widget)
  (:export #:column-widget
           #:column
           #:subwidgets))
(in-package #:reblocks-ui2/containers/column)


(defwidget column-widget (container-widget)
  ())


(defun column (&rest subwidgets-and-options)
  (apply #'make-container 'column-widget
         subwidgets-and-options))
