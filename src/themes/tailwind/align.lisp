(uiop:define-package #:reblocks-ui2/themes/tailwind/align
  (:use #:cl)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/utils/align
                #:vertical-align-value
                #:vertical-align
                #:horizontal-align
                #:horizontal-align-value))
(in-package #:reblocks-ui2/themes/tailwind/align)


(defmethod css-classes ((align horizontal-align) (theme tailwind-theme) &key)
  ;; For row flex orientation
  (case (horizontal-align-value align)
    (:left "justify-begin")
    (:center "justify-center")
    (:right "justify-end")))


(defmethod css-classes ((align vertical-align) (theme tailwind-theme) &key)
  ;; For row flex orientation
  (case (vertical-align-value align)
    (:top "items-begin")
    (:center "items-center")
    (:bottom "items-end")))

