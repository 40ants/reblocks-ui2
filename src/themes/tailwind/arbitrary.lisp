(uiop:define-package #:reblocks-ui2/themes/tailwind/arbitrary
  (:use #:cl)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:serapeum
                #:fmt)
  (:import-from #:str
                #:join)
  (:import-from #:alexandria
                #:flatten)
  (:export #:arbitrary-value
           #:arbitrary-value-prefix
           #:arbitrary-value-args))
(in-package #:reblocks-ui2/themes/tailwind/arbitrary)


(defclass arbitrary-value ()
  ((prefix :initarg :prefix
           :type string
           :reader arbitrary-value-prefix)
   (args :initarg :args
         :type list
         :reader arbitrary-value-args)))


(defun arbitrary-value (prefix &rest args)
  (make-instance 'arbitrary-value
                 :prefix prefix
                 :args args))


(defmethod css-classes ((value arbitrary-value) (theme tailwind-theme) &key)
  (loop for arg in (arbitrary-value-args value)
        for classes = (css-classes arg theme)
        collect classes into result
        finally (return (fmt "~A-[~A]"
                             (arbitrary-value-prefix value)
                             (join "_" (flatten result))))))
