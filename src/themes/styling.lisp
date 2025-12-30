(uiop:define-package #:reblocks-ui2/themes/styling
  (:use #:cl)
  (:import-from #:alexandria
                #:flatten)
  (:import-from #:serapeum
                #:prependf)
  (:import-from #:str
                #:split)
  (:export #:css-classes
           #:css-styles
           #:join-css-classes
           #:join-css-styles
           #:merge-css-classes))
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


(defgeneric merge-css-classes (theme classes)
  (:documentation "This generic function is called before JOIN-CSS-CLASSES will output classes as a string.

                   Depending on theme some transformations can be applied to the list of CSS classes, given as CLASSES argument.
                   For example, a theme based on Tailwind framework, might merge CSS classes list allowing to override properties.")
  (:method ((theme t) (classes t))
    classes))


(defun collect-css-classes (theme objects)
  "Collect all CSS classes from OBJECTS into a flat list."
  (let ((classes nil))
    (labels ((traverse (obj)
               (cond
                 ((null obj))
                 ((consp obj)
                  (traverse (car obj))
                  (traverse (cdr obj)))
                 ((typep obj 'string)
                  (cond
                    ((find #\Space obj :test #'char=)
                     (let ((splitted (split #\Space obj :omit-nulls t)))
                       (prependf classes
                                 (nreverse splitted))))
                    (t
                     (push obj classes))))
                 (t
                  (traverse (css-classes obj theme))))))
      (traverse objects)
      (nreverse classes))))


(defgeneric join-css-classes (theme &rest classes)
  (:method ((theme t) &rest classes)
    (let* ((collected-classes (collect-css-classes theme classes))
           (merged-classes (merge-css-classes theme collected-classes)))
      (format nil "~{~A~^ ~}" merged-classes))))


(defun join-css-styles (&rest styles)
  (with-output-to-string (output)
    (loop for item in (flatten styles)
          for i upfrom 0
          when (and item
                    (not (string= item "")))
          do (unless (zerop i)
               (write-string "; " output))
             (write-string item output))))
