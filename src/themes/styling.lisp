(uiop:define-package #:reblocks-ui2/themes/styling
  (:use #:cl)
  (:import-from #:alexandria
                #:flatten)
  (:export #:css-classes
           #:css-styles
           #:join-css-classes
           #:join-css-styles))
(in-package #:reblocks-ui2/themes/styling)


(defgeneric css-classes (theme object)
  (:method ((theme t) (object t))
    nil))


(defgeneric css-styles (theme object)
  (:method ((theme t) (object t))
    nil))


(defun join-css-classes (&rest classes)
  (with-output-to-string (output)
    (loop for item in (flatten classes)
          for i upfrom 0
          unless (string= item "")
          do (unless (zerop i)
               (write-string " " output))
             (write-string item output))))


(defun join-css-styles (&rest styles)
  (with-output-to-string (output)
    (loop for item in styles
          for i upfrom 0
          when (and item
                    (not (string= item "")))
          do (unless (zerop i)
               (write-string "; " output))
             (write-string item output))))
