(uiop:define-package #:reblocks-ui2/containers/tabs
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:widget
                #:render
                #:create-widget-from
                #:defwidget)
  (:import-from #:alexandria
                #:length=)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:serapeum
                #:->
                #:dict)
  (:import-from #:reblocks/widgets/dom
                #:dom-id)
  (:import-from #:reblocks/page
                #:find-widget-by-id)
  (:import-from #:event-emitter
                #:event-emitter)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:export #:tabs
           #:tabs-widget
           #:tabs-control
           #:tabs-selector
           #:subwidgets
           #:subwidgets-titles
           #:current-idx
           #:switch-to-idx
           #:tabs-size))
(in-package #:reblocks-ui2/containers/tabs)


(deftype tabs-size ()
  '(member :m :l :xl))


(defwidget tabs-control (event-emitter ui-widget)
  ((titles :initarg :titles
           :reader subwidgets-titles)
   (current-idx :initarg :idx
                :initform 0
                :accessor current-idx)
   (size :initarg :size
         :type tabs-size
         :reader tabs-size)))


(defwidget tabs-widget (ui-widget)
  ((selector :initarg :selector
     :reader tabs-selector)
   (subwidgets :initarg :subwidgets
               :reader subwidgets)))


(-> tabs (list list &key (:idx integer) (:selector-class symbol) (:class symbol) (:size tabs-size)))

(defun tabs (titles subwidgets &key (idx 0)
                                    (selector-class 'tabs-control)
                                    (class 'tabs-widget)
                                    (size :l))
  (unless (length= titles subwidgets)
    (error "Titles and subwidgets count should be equal."))
  (when (zerop (length titles))
    (error "Provide at least one title to select from."))

  (when (>= idx (length titles))
    (error "IDX argument should be in [0:~A] range."
           (1- (length titles))))
  
  (let* ((selector (make-instance selector-class
                                  :titles (mapcar #'create-widget-from
                                                  titles)
                                  :idx idx
                                  :size size))
         (widget (make-instance class
                                :selector selector
                                :subwidgets (mapcar #'create-widget-from
                                                    subwidgets))))
    (event-emitter:on :change selector
                      (lambda (idx)
                        (declare (ignore idx))
                        (log:debug "Changing main widget")
                        (reblocks/widget:update widget)))
    (values widget)))


(defun switch-to-idx (&key widget-id idx &allow-other-keys)
  (let ((widget (find-widget-by-id widget-id)))
    (log:debug "Switching to idx" widget-id idx widget)
    
    (when widget
      (log:debug "Changing to" idx)
      (setf (current-idx widget)
            idx)
      (reblocks/widget:update widget)
      (event-emitter:emit :change widget
                          idx))))

