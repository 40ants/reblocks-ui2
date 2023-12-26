(uiop:define-package #:reblocks-ui2/containers/row/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks/html)
  (:import-from #:reblocks-ui2/widget
                #:render)
  (:import-from #:reblocks-ui2/containers/row
                #:children-gap
                #:gap-css-classes
                #:subwidgets
                #:row-widget)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme))
(in-package #:reblocks-ui2/containers/row/themes/tailwind)


(defmethod render ((widget row-widget) (theme tailwind-theme))
  (reblocks/html:with-html
    (loop for subwidget in (subwidgets widget)
          do (render subwidget theme))))


(defmethod reblocks-ui2/widget:get-css-classes ((widget row-widget) (theme tailwind-theme))
  (append (list "flex" "w-full justify-between")
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

