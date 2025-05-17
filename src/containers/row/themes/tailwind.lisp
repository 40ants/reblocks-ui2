(uiop:define-package #:reblocks-ui2/containers/row/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/widget
                #:render)
  (:import-from #:reblocks-ui2/containers/row
                #:row-widget)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes))
(in-package #:reblocks-ui2/containers/row/themes/tailwind)


(defmethod css-classes ((widget row-widget) (theme tailwind-theme) &key)
  (append (list "flex"
                "justify-between")
          (call-next-method)))
