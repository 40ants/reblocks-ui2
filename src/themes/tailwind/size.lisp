(uiop:define-package #:reblocks-ui2/themes/tailwind/size
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
                #:fmt)
  (:import-from #:reblocks-ui2/utils/size
                #:responsive-width
                #:min-width
                #:max-width
                #:max-height
                #:min-height
                #:responsive-height
                #:height
                #:width
                #:size-value
                #:size)
  (:import-from #:anaphora
                #:it
                #:awhen))
(in-package #:reblocks-ui2/themes/tailwind/size)


(declaim (ftype (function (string size) string)
                format-size))
(defun format-size (prefix size)
  (let ((value (size-value size)))
    (etypecase value
      (integer (fmt "~A-[~Apx]"
                    prefix value))
      (string (fmt "~A-~A"
                   prefix value)))))


(defmethod css-classes ((width width) (theme tailwind-theme) &key)
  (format-size "w" width))


(defmethod css-classes ((height height) (theme tailwind-theme) &key)
  (format-size "h" height))


(defmethod css-classes ((width responsive-width) (theme tailwind-theme) &key)
  (list (awhen (min-width width)
          (format-size "min-w" it))
        (awhen (max-width width)
          (format-size "max-w" it))))


(defmethod css-classes ((height responsive-height) (theme tailwind-theme) &key)
  (list (awhen (min-height height)
          (format-size "min-h" it))
        (awhen (max-height height)
          (format-size "max-h" it))))
