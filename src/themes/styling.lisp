(uiop:define-package #:reblocks-ui2/themes/styling
  (:use #:cl)
  (:import-from #:alexandria
                #:flatten)
  (:export #:css-classes
           #:css-styles
           #:join-css-classes
           #:join-css-styles))
(in-package #:reblocks-ui2/themes/styling)


(defgeneric css-classes (object theme &key)
  (:documentation "Returns classes for a widget or it's property.

                   Result can be a list, string or a keyword.")
  (:method ((object t) (theme t) &key)
    nil)
  (:method ((object string) (theme t) &key)
    object)
  (:method ((object symbol) (theme t) &key)
    object))


(defgeneric css-styles (object theme)
  (:method ((object t) (theme t))
    nil))


(defun join-css-classes (theme &rest classes)
  (with-output-to-string (output)
    (let ((first-item t))
      (labels ((traverse (obj)
                 (cond
                   ((null obj))
                   ((consp obj)
                    (traverse (car obj))
                    (traverse (cdr obj)))
                   ((typep obj 'string)
                    (if first-item
                        (setf first-item nil)
                        (write-string " " output))
                    (write-string obj output))
                   (t
                    (traverse (css-classes obj theme))))))
        (traverse classes)))))


(defun join-css-styles (&rest styles)
  (with-output-to-string (output)
    (loop for item in (flatten styles)
          for i upfrom 0
          when (and item
                    (not (string= item "")))
          do (unless (zerop i)
               (write-string "; " output))
             (write-string item output))))
