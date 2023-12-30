(uiop:define-package #:reblocks-ui2/inputs/named
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:export #:named-input
           #:input-name))
(in-package #:reblocks-ui2/inputs/named)


(defwidget named-input (ui-widget)
  ((name :initform nil
         :initarg :name
         :type (or null string)
         :reader input-name)))
