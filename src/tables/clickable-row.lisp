(uiop:define-package #:reblocks-ui2/tables/clickable-row
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:render
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks-ui2/tables/table
                #:*current-cell*
                #:column-css-classes
                #:row-cells
                #:row-table
                #:table-columns
                #:*current-row*
                #:table-row)
  (:export
   #:make-clickable-row-widget
   #:clickable-row-widget))
(in-package #:reblocks-ui2/tables/clickable-row)


(defwidget clickable-row-widget (table-row)
  ())


(defun make-clickable-row-widget ()
  (make-instance 'service-stats-widget))


(defmethod reblocks-ui2/widget:render ((widget clickable-row-widget) (theme t))
  (with-html
    (loop with *current-row* = widget
          for column in (table-columns
                         (row-table widget))
          for *current-cell* in (row-cells widget)
          do (:td :class (column-css-classes column theme)
                  :onclick "alert(\"Helo\")"
                  (render *current-cell*)))))


(defmethod get-dependencies ((widget clickable-row-widget))
  (list*
   (reblocks-lass:make-dependency
     `((:and .clickable-row-widget
        :hover)
       :color red
       :cursor pointer))
   (call-next-method)))
