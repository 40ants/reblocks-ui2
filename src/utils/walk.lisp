(uiop:define-package #:reblocks-ui2/utils/walk
  (:use #:cl)
  (:export #:walk
           #:children))
(in-package #:reblocks-ui2/utils/walk)


(defgeneric walk (widget visitor-func)
  (:documentation "A protocol to go through widgets tree and to call VISITOR-FUNC on each node.")
  (:method ((widget t) (visitor-func t))
    (funcall visitor-func widget)
    (loop for child in (children widget)
          do (walk child visitor-func))
    (values)))


(defgeneric children (widget)
  (:method ((widget t))
    nil))
