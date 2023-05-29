(uiop:define-package #:reblocks-ui2/tables/search
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:update
                #:create-widget-from
                #:render
                #:defwidget)
  (:import-from #:event-emitter
                #:on
                #:emit
                #:event-emitter)
  (:import-from #:reblocks-ui2/tables/table
                #:append-data
                #:make-table
                #:table-widget)
  (:import-from #:reblocks-ui2/buttons/button
                #:button)
  (:import-from #:reblocks-ui2/events
                #:event-emitting-widget)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:export
   #:make-search-widget
   #:search-widget
   #:controls-widget
   #:filters-updated
   #:show-next-page-button
   #:hide-next-page-button
   #:make-default-controls-widget))
(in-package #:reblocks-ui2/tables/search)


(defwidget search-widget ()
  ((filters :initarg :filters
            :type (or null event-emitter)
            :reader filters-widget)
   (table :initarg :table
          :type table-widget
          :accessor table-widget)
   (controls :initarg :controls
             :type (or null event-emitter)
             :reader controls-widget)
   (data-getter :initarg :data-getter
                :type (or symbol function)
                :reader data-getter)
   (next-page-getter :initarg :next-page-getter
                     :type (or null function)
                     :accessor next-page-getter)))


(defwidget controls-widget (event-emitting-widget)
  ((show-button-p :initform nil
                  :reader show-button-p)
   (next-page-button :initarg :button
                     :reader next-page-button)))


(defun make-default-controls-widget (&key (button-title "Load more"))
  (let* ((widget (make-instance 'controls-widget))
         (button (button button-title
                         :on-click (lambda (&rest args)
                                     (declare (ignore args))
                                     (emit :load-more-data widget widget)))))
    (setf (slot-value widget 'next-page-button)
          button)
    (values widget)))


(defun make-search-widget (columns data-getter &key
                                               (filters-widget nil filters-widget-given-p)
                                               (controls-widget nil controls-widget-given-p)
                                               (widget-class 'search-widget)
                                               (table-class nil table-class-given-p)
                                               (row-class nil row-class-given-p))
  (let ((filters-widget (when filters-widget-given-p
                          (when filters-widget
                            (create-widget-from filters-widget))))
        (controls-widget (if controls-widget-given-p
                             (when controls-widget
                               (create-widget-from controls-widget))
                             (make-default-controls-widget)))
        (table-args (append (when table-class-given-p
                              (list :table-class table-class))
                            (when row-class-given-p
                              (list :row-class row-class)))))
    (let ((search-widget
            (make-instance
             widget-class
             :filters filters-widget
             :controls controls-widget
             :data-getter data-getter)))
      (flet ((on-filters-update (filters-widget &key (do-update t))
               (multiple-value-bind (data next-page-getter)
                   (funcall data-getter filters-widget)
                 (setf (table-widget search-widget)
                       (apply #'make-table
                              columns data
                              table-args)
                       (next-page-getter search-widget)
                       next-page-getter)

                 (if next-page-getter
                     (show-next-page-button controls-widget)
                     (hide-next-page-button controls-widget))
                 
                 (when do-update
                   (update search-widget))))
             (on-load-more (controls-widget)
               (let ((next-page-getter (next-page-getter search-widget)))
                 (when next-page-getter
                   (multiple-value-bind (data next-page-getter)
                       (funcall next-page-getter)
                     (append-data (table-widget search-widget)
                                  data)
                     (setf (next-page-getter search-widget)
                           next-page-getter)
                     
                     (unless next-page-getter
                       (hide-next-page-button controls-widget))
                     
                     (update (table-widget search-widget))
                     (update controls-widget))))))
        (on :filters-update filters-widget
            #'on-filters-update)
        (on :load-more-data controls-widget
            #'on-load-more)
        ;; Do the initial fill of the search results
        (on-filters-update filters-widget
                           :do-update nil))
      (values search-widget))))


(defmethod render ((widget search-widget))
  (when (filters-widget widget)
    (render (filters-widget widget)))
  
  (render (table-widget widget))
  
  (when (controls-widget widget)
    (render (controls-widget widget))))


(defmethod render ((widget controls-widget))
  (when (show-button-p widget)
    (render (next-page-button widget))))


(defmethod get-dependencies ((widget controls-widget))
  (list*
   (reblocks-lass:make-dependency
     `(.controls-widget
       :display flex
       :justify-content space-around
       :padding-bottom 1rem))
   (call-next-method)))


(defgeneric filters-updated (widget)
  (:documentation "Signals that filters state was changed and table with results should be updated.")
  (:method ((widget event-emitting-widget))
    (emit :filters-update widget widget)))


(defgeneric hide-next-page-button (widget)
  (:method ((widget controls-widget))
    (setf (slot-value widget 'show-button-p) nil)
    (values widget)))

(defgeneric show-next-page-button (widget)
  (:method ((widget controls-widget))
    (setf (slot-value widget 'show-button-p) t)
    (values widget)))
