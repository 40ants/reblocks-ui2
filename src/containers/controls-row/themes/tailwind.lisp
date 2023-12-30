(uiop:define-package #:reblocks-ui2/containers/controls-row/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes)
  (:import-from #:alexandria
                #:flatten)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/containers/controls-row
                #:controls-row-widget))
(in-package #:reblocks-ui2/containers/controls-row/themes/tailwind)


(defmethod css-classes ((theme tailwind-theme) (widget controls-row-widget) &key)
  ;; For controls row we justify all buttons to the right.
  ;; For right to left languages, we have to add "flex-row-reverse" somehow.
  (list* "justify-end"
         (remove "justify-between"
                 (flatten (call-next-method))
                 :test #'string-equal)))
