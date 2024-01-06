(uiop:define-package #:reblocks-ui2/themes/tailwind/padding
  (:use #:cl)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:core-padding-sizes
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/utils/padding
                #:padding-vertical-size
                #:padding-horizontal-size
                #:padding-size
                #:padding)
  (:import-from #:alexandria
                #:assoc-value)
  (:import-from #:serapeum
                #:fmt))
(in-package #:reblocks-ui2/themes/tailwind/padding)


(defmethod css-classes ((theme tailwind-theme) (padding padding) &key)
  (let ((sizes (core-padding-sizes theme))
        (horizontal (padding-horizontal-size padding))
        (vertical (padding-vertical-size padding)))
    (cond
      ((and horizontal
            vertical
            (eql horizontal
                 vertical))
       (fmt "p-~A"
            (assoc-value sizes
                         horizontal)))
      (t
       (list (when horizontal
               (fmt "xp-~A"
                    (assoc-value sizes
                                 horizontal)))
             (when vertical
               (fmt "yp-~A"
                    (assoc-value sizes
                                 vertical))))))))
