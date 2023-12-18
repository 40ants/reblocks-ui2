(uiop:define-package #:reblocks-ui2/tables/themes/zurb/editable-table
  (:use #:cl))
(in-package #:reblocks-ui2/tables/themes/zurb/editable-table)


(defmethod render-editable-row ((widget table-row) (theme t))
  (with-html
    (:tag :name (reblocks/widget:get-html-tag widget)
          :id (reblocks/widgets/dom:dom-id widget)
          (loop with *current-row* = widget
                for column in (table-columns
                               (row-table widget))
                for *current-cell* in (row-cells widget)
                do (:td :class (column-css-classes column theme)
                        (render-editable-cell column *current-cell* theme))))))


(defmethod reblocks/dependencies:get-dependencies ((widget editable-table-widget))
  (list*
   (reblocks-lass:make-dependency
     `(.editable-table-widget
       ((> .controls)
        :display flex
        :gap 1rem
        :justify-content flex-end
        (button
         :border-radius 50%))))
   (call-next-method)))


