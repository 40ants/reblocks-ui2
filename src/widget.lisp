(uiop:define-package #:reblocks-ui2/widget
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/page-dependencies)
  (:import-from #:reblocks/dependencies)
  (:import-from #:reblocks-ui2/themes/api
                #:current-theme)
  (:import-from #:moptilities
                #:superclasses)
  (:import-from #:alexandria
                #:flatten
                #:make-keyword)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes)
  (:import-from #:anaphora
                #:it
                #:awhen)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:import-from #:serapeum
                #:defvar-unbound)
  (:export #:render
           #:ui-widget
           #:get-dependencies
           #:get-html-tag))
(in-package #:reblocks-ui2/widget)


(defvar-unbound *current-widget*
  "This variable is for internal use and can be bound during RENDER or different ON-* methods.")


(defwidget ui-widget ()
  ((on-click :initform nil
             :initarg :on-click
             :reader on-click)))


(defgeneric render (widget theme)
  (:documentation "Renders widget in given theme. All reblocks-ui2 widgets
                   should implement this method instead of a method
                   for REBLOCKS/WIDGET:RENDER generic-function.")
  (:method ((widget ui-widget) (theme t))
    (let ((class-name (class-name (class-of widget)))
          (theme-name (class-name (class-of theme))))
      (with-html
        (:p "Please, define:"
            (:pre (format nil
                          "(defmethod reblocks-ui2/widget:render ((widget ~A) (theme ~A))
    (reblocks/html:with-html
        (:p \"My ~A widget\")))"
                          class-name
                          theme-name
                          class-name))))))
  ;; For non UI widgets we fall back to usual Reblocks render method without theme support
  (:method ((widget t) (theme t))
    (declare (ignore theme))
    (reblocks/widget:render widget)))


(defgeneric get-dependencies (widget theme)
  (:documentation "Works like REBLOCKS/DEPENDENCIES:GET-DEPENDENCIES generic-function, but
                   in context of current theme.")
  (:method ((widget ui-widget) (theme t))
    nil))


(defgeneric get-html-tag (widget theme)
  (:documentation "Works like REBLOCKS/WIDGET:GET-HTML-TAG generic-function, but
                   in context of current theme.")
  (:method ((widget ui-widget) (theme t))
    (reblocks/widget:get-html-tag widget)))


(defun make-onclick-wrapper (widget)
  (check-type widget ui-widget)
  (awhen (on-click widget)
    (flet ((on-click-wrapper (&rest args)
             (declare (ignore args))
             (let ((*current-widget* widget))
               (funcall it widget))))
      (make-js-action #'on-click-wrapper))))


(defmethod render :around ((widget ui-widget) (theme t))
  "This function is intended for internal usage only.
   It renders widget with surrounding HTML tag and attributes."
  (let ((widget-dependencies (get-dependencies widget theme)))
    ;; Update new-style dependencies
    (reblocks/page-dependencies::push-dependencies widget-dependencies))

  (reblocks/page::register-widget widget)
  
  (with-html
    (:tag
     :name (get-html-tag widget theme)
     :class (reblocks/widget::get-css-classes-as-string widget)
     :id (reblocks/widgets/dom:dom-id widget)
     :onclick (make-onclick-wrapper widget)
     (call-next-method))))


;; (defmethod reblocks/widget:render ((widget ui-widget))
;;   (render widget (current-theme)))


(defmethod reblocks/widget:render :around ((widget ui-widget))
  ;; For UI-WIDGET main node is rendered by around method of UI2' RENDER method
  (render widget (current-theme)))


(defmethod reblocks/widget:get-css-classes ((widget ui-widget))
  (flatten (css-classes (current-theme) widget)))


(defmethod css-classes ((theme t) (widget ui-widget) &key)
  "Default implementation for  returns class list and all it's parent names."
  (loop for class in (list* (class-of widget)
                            (superclasses (class-of widget)))
        for class-name = (class-name class)
        collect (string-downcase class-name) into results
        until (eql class-name
                   'reblocks/widget:widget)
        finally (return results)))


(defmethod reblocks/dependencies:get-dependencies ((widget ui-widget))
  (get-dependencies widget (current-theme)))


