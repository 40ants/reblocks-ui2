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
                #:dict)
  (:import-from #:reblocks/widgets/dom
                #:dom-id)
  (:import-from #:reblocks/page
                #:find-widget-by-id)
  (:import-from #:event-emitter
                #:event-emitter)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:export #:make-tabs-widget
           #:tabs-widget
           #:tabs-control))
(in-package #:reblocks-ui2/containers/tabs)


(defwidget tabs-control (event-emitter widget)
  ((titles :initarg :titles
           :reader subwidgets-titles)
   (current-idx :initarg :idx
                :initform 0
                :accessor current-idx)))


(defwidget tabs-widget ()
  ((selector :initarg :selector
     :reader tabs-selector)
   (subwidgets :initarg :subwidgets
               :reader subwidgets)))


(defun make-tabs-widget (titles subwidgets &key (idx 0)
                                                        (selector-class 'tabs-control)
                                                        (class 'tabs-widget))
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
                                  :idx idx))
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


(defmethod render ((widget tabs-widget))
  (with-html
    (render (tabs-selector widget))
    (:div :class "tabs-content"
          (render (elt (subwidgets widget)
                       (current-idx (tabs-selector widget)))))))


(defmethod reblocks/widget:get-html-tag ((widget tabs-control))
  :ul)


(defmethod reblocks/widget:get-css-classes ((widget tabs-control))
  (list* :tabs                          ;
         (call-next-method)))


(defmethod render ((widget tabs-control))
  (with-html
    (loop for title in (subwidgets-titles widget)
          for idx upfrom 0
          for activep = (= idx (current-idx widget))
          for cls = (apply #'concatenate
                           'string
                           "tabs-title"
                           (when activep
                             (list " is-active")))
          for action-code = (make-js-action #'switch-to-idx
                                            :args
                                            (dict "widget-id"
                                                  (dom-id widget)
                                                  "idx" idx))
          do (:li :class cls
                  (:a :aria-selected (when activep
                                       "true") 
                      :onclick action-code
                                        (render title))))))


(defmethod get-dependencies ((widget tabs-control))
  (list*
   (reblocks-lass:make-dependency
     `(.tabs-control))
   (call-next-method)))
