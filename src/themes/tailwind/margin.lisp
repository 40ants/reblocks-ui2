(uiop:define-package #:reblocks-ui2/themes/tailwind/margin
  (:use #:cl)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:core-margin-sizes
                #:tailwind-theme)
  (:import-from #:alexandria
                #:assoc-value)
  (:import-from #:serapeum
                #:fmt)
  (:import-from #:reblocks-ui2/utils/margin
                #:margin))
(in-package #:reblocks-ui2/themes/tailwind/margin)


(defmethod css-classes ((margin margin) (theme tailwind-theme) &key)
  (let* ((sizes (core-margin-sizes theme))
         (left (reblocks-ui2/utils/margin:margin-left margin))
         (right (reblocks-ui2/utils/margin:margin-right margin))
         (top (reblocks-ui2/utils/margin:margin-top margin))
         (bottom (reblocks-ui2/utils/margin:margin-bottom margin))
         (horizontal (when (eql left right)
                       left))
         (vertical (when (eql top bottom)
                     top))
         (total (when (eql horizontal vertical)
                  horizontal)))
    (uiop:while-collecting (collect)
      (flet ((collect-value (margin-type value)
               (collect
                   (fmt "~A-~A"
                        margin-type
                        (assoc-value sizes
                                     value)))))
        (cond
          (total
           (collect-value "m" total))
          (t
           (cond
             (horizontal
              (collect-value "mx" horizontal))
             (t
              (when left
                (collect-value "ml" left))
              (when right
                (collect-value "mr" right))))
           
           (cond
             (vertical
              (collect-value "my" vertical))
             (t
              (when top
                (collect-value "mt" top))
              (when bottom
                (collect-value "mb" bottom))))))))))
