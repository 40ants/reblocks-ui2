(uiop:define-package #:reblocks-ui2/containers/column/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks/html)
  (:import-from #:reblocks-ui2/widget
                #:widget-margin
                #:render)
  (:import-from #:reblocks-ui2/containers/column
                #:children-gap
                #:gap-css-classes
                #:subwidgets
                #:column-widget)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes))
(in-package #:reblocks-ui2/containers/column/themes/tailwind)


(defmethod render ((widget column-widget) (theme tailwind-theme))
  (reblocks/html:with-html
    (loop for subwidget in (subwidgets widget)
          do (render subwidget theme))))


(defmethod css-classes ((theme tailwind-theme) (widget column-widget) &key)
  (list (list "flex flex-col"
              "items-center justify-between")
        (gap-css-classes theme (children-gap widget))
        (call-next-method)))


(defmethod gap-css-classes ((theme tailwind-theme) (gap symbol))
  (case gap
    (:z (list "gap-0"))
    (:s (list "gap-2"))
    (:m (list "gap-4"))
    (:l (list "gap-8"))
    (:xl (list "gap-12"))
    (t
     (error "Gap \"~A\" is not supported by \"~A\" theme."
            gap theme))))

