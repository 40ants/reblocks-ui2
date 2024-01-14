(uiop:define-package #:reblocks-ui2/card
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:create-widget-from
                #:defwidget)
  (:import-from #:alexandria
                #:once-only
                #:with-gensyms)
  (:import-from #:anaphora
                #:acond
                #:it)
  (:import-from #:reblocks-ui2/widget
                #:*current-widget*
                #:get-dependencies
                #:render
                #:ui-widget)
  (:import-from #:serapeum
                #:soft-alist-of)
  (:import-from #:named-readtables
                #:in-readtable)
  (:import-from #:pythonic-string-reader
                #:pythonic-string-syntax)
  (:import-from #:reblocks-ui2/card/view
                #:ensure-view)
  (:import-from #:reblocks-ui2/utils/size
                #:ensure-height
                #:ensure-width
                #:responsive-width
                #:width
                #:responsive-height
                #:height)
  (:import-from #:reblocks-ui2/utils/padding
                #:padding)
  (:import-from #:reblocks-ui2/utils/align
                #:vertical-align
                #:horizontal-align)
  (:export #:card
           #:card-widget
           #:card-content
           #:card-view
           #:card-padding
           #:card-width
           #:card-height))
(in-package #:reblocks-ui2/card)

(in-readtable pythonic-string-syntax)


(defwidget card-widget (ui-widget)
  ((content :initarg :content
            :type reblocks/widget:widget
            :reader card-content)
   (view :initarg :view
         :initform nil
         :reader card-view)
   (padding :initarg :padding
            :initform nil
            :reader card-padding)
   (horizontal-align :initarg :horizontal-align
                     :initform nil
                     :type horizontal-align
                     :reader horizontal-align-of-card-content)
   (vertical-align :initarg :vertical-align
                   :initform :center
                   :type vertical-align
                   :reader vertical-align-of-card-content)))


(defun card (content &key
                     (view :outlined)
                     (width "full")
                     (height '(120 . nil))
                     (padding :l)
                     margin
                     (horizontal-align :center)
                     (vertical-align :center)
                     on-click
                     (widget-class 'card-widget))
  (make-instance widget-class
                 :content (create-widget-from content)
                 :on-click on-click
                 :view (ensure-view view)
                 :width (ensure-width width)
                 :height (ensure-height height)
                 :horizontal-align (horizontal-align horizontal-align)
                 :vertical-align (vertical-align vertical-align)
                 :padding (padding padding)
                 :margin margin))
