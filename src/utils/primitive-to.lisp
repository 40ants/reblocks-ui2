(uiop:define-package #:reblocks-ui2/utils/primitive-to
  (:use #:cl)
  (:export
   #:process-primitive-args))
(in-package #:reblocks-ui2/utils/primitive-to)


(defgeneric process-primitive-arg (name value)
  (:documentation "Transforms some value like :xl to a class instance of type which depends on a NAME argument. For example, name could be :margin, :width, etc.")
  (:method ((name t) (value t))
    value))


(declaim (ftype (function (list)
                          (values list &optional))
                process-primitive-args))

(defun process-primitive-args (keyword-args)
  (loop for (name value) on keyword-args by #'cddr
        append (list name
                     (process-primitive-arg name value))))
