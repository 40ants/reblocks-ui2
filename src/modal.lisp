(uiop:define-package #:reblocks-ui2/modal
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:update
                #:defwidget)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:export #:modal
           #:modal-header-content
           #:modal-main-content
           #:modal-visible-p
           #:modal-show
           #:modal-hide))
(in-package #:reblocks-ui2/modal)


(defwidget modal (ui-widget)
  ((header-content :initarg :header-content
                   :type (or null ui-widget)
                   :accessor modal-header-content)
   (main-content :initarg :main-content
                 :type ui-widget
                 :accessor modal-main-content)
   (visible :initarg :visible
            :initform nil
            :type boolean
            :reader modal-visible-p))
  (:documentation "This widget shows a popup window.")) 


(defun modal (content &key header-content visible)
  (make-instance 'modal
                 :visible (when visible
                            t)
                 :main-content content
                 :header-content header-content))


(defgeneric modal-show (widget &key content header-content)
  (:documentation "Shows modal window.")
  (:method ((widget modal) &key content header-content)
    (unless (slot-value widget 'visible)
      
      (when content
        (setf (modal-main-content widget)
              content))
      
      (when header-content
        (setf (modal-header-content widget)
              header-content))
      
      (setf (slot-value widget 'visible) t)
      (update widget))))


(defgeneric modal-hide (widget)
  (:documentation "Hides modal window.")
  (:method ((widget modal))
    (when (slot-value widget 'visible)
      (setf (slot-value widget 'visible) nil)
      (update widget))))

