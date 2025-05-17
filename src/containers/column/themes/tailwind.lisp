(uiop:define-package #:reblocks-ui2/containers/column/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks/html)
  (:import-from #:reblocks-ui2/widget
                #:widget-margin
                #:render)
  (:import-from #:reblocks-ui2/containers/column
                #:column-widget)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes))
(in-package #:reblocks-ui2/containers/column/themes/tailwind)


(defmethod css-classes ((widget column-widget) (theme tailwind-theme) &key)
  (list (list "flex flex-col"
              "items-center justify-between")
        (call-next-method)))


