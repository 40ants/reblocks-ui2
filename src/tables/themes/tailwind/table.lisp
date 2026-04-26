(uiop:define-package #:reblocks-ui2/tables/themes/tailwind/table
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:render)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/tables/table
                #:row-css-classes
                #:column-align
                #:column-classes
                #:column
                #:table-row
                #:*current-cell*
                #:row-cells
                #:row-table
                #:*current-column*
                #:*current-row*
                #:table-widget
                #:table-rows
                #:column-css-classes
                #:header-column-css-classes
                #:table-columns
                #:*current-table*)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:str
                #:join
                #:split)
  (:import-from #:reblocks-ui2/tables/cell
                #:cell-rowspan
                #:cell-colspan
                #:cell-widget
                #:cell)
  (:export
   #:*default-header-cell-styles*
   #:*default-cell-styles*))
(in-package #:reblocks-ui2/tables/themes/tailwind/table)


(defmethod render ((widget table-widget) (theme tailwind-theme))
  (let ((*current-table* widget))
    (with-html ()
      (:table :class "border-collapse w-full"
              (:thead
               (:tr
                (loop for column in (table-columns widget)
                      for classes = (join " " (header-column-css-classes column theme))
                      do (:th :class classes
                              (render column theme)))))
              (:tbody
               (loop for row in (table-rows widget)
                     do (render row theme)))))))


(defmethod render ((widget table-row) (theme tailwind-theme))
  (with-html ()
    (:tr :class (join " " (row-css-classes widget theme))
     (loop with *current-row* = widget
           for *current-column* in (table-columns
                                    (row-table widget))
           for *current-cell* in (row-cells widget)
           ;; Cell maker might return NIL.
           ;; In this case we have to skip TD rendering.
           ;; This could be used when some cells use colspan or rowspan attribute.
           when *current-cell*
             do (let* ((cell-widget (typecase *current-cell*
                                      (cell
                                         (cell-widget *current-cell*))
                                      (t *current-cell*)))
                       (colspan (typecase *current-cell*
                                  (cell
                                     (cell-colspan *current-cell*))
                                  (t nil)))
                       (rowspan (typecase *current-cell*
                                  (cell
                                     (cell-rowspan *current-cell*))
                                  (t nil)))
                       (classes (join " " (column-css-classes *current-column* theme))))
                  (:td :class classes
                       :colspan colspan
                       :rowspan rowspan
                       (render cell-widget theme)))))))


(defvar *default-header-cell-styles*
  "p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell")

(defparameter *default-cell-styles*
  "w-full lg:w-auto p-3 text-gray-800 border border-b block lg:table-cell relative lg:static")

(defmethod header-column-css-classes ((widget column) (theme tailwind-theme))
  (append (split " "
                 *default-header-cell-styles*)
          (column-classes widget)))


(defmethod column-css-classes ((widget column) (theme tailwind-theme))
  (let ((default (split " " *default-cell-styles*)))
    (case (column-align widget)
      (:left (push "text-left" default))
      (:right (push "text-right" default))
      (:center (push "text-center" default)))
    
    (append default
            (column-classes widget))))
