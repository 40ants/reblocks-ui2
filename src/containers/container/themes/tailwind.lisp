(uiop:define-package #:reblocks-ui2/containers/container/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks/html)
  (:import-from #:reblocks-ui2/widget
                #:widget-margin
                #:render)
  (:import-from #:reblocks-ui2/containers/container
                #:additional-classes
                #:children-gap
                #:gap-css-classes
                #:subwidgets
                #:container-widget)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes))
(in-package #:reblocks-ui2/containers/container/themes/tailwind)


(defmethod render ((widget container-widget) (theme tailwind-theme))
  (reblocks/html:with-html
    (loop for subwidget in (subwidgets widget)
          do (render subwidget theme))))


(defmethod css-classes ((widget container-widget) (theme tailwind-theme) &key)
  (list (gap-css-classes (children-gap widget) theme)
        (additional-classes widget)
        (call-next-method)))


(defmethod gap-css-classes ((gap symbol) (theme tailwind-theme))
  (case gap
    (:z (list "gap-0"))
    (:s (list "gap-2"))
    (:m (list "gap-4"))
    (:l (list "gap-8"))
    (:xl (list "gap-12"))
    (t
     (error "Gap \"~A\" is not supported by \"~A\" theme."
            gap theme))))


