(uiop:define-package #:reblocks-ui2/widget
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/dependencies)
  (:import-from #:reblocks-ui2/themes/api
                #:current-theme)
  (:import-from #:moptilities
                #:superclasses)
  (:import-from #:alexandria
                #:make-keyword)
  (:import-from #:reblocks/html
                #:with-html)
  (:export #:render
           #:ui-widget
           #:get-css-classes
           #:get-dependencies))
(in-package #:reblocks-ui2/widget)


(defwidget ui-widget ()
  ())


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


(defgeneric get-css-classes (widget theme)
  (:documentation "Returns a list of classes for the widget.

                   Default implementation returns class list and all it's parent names.")
  (:method ((widget ui-widget) (theme t))
    (loop for class in (list* (class-of widget)
                              (superclasses (class-of widget)))
          for class-name = (class-name class)
          collect (make-keyword class-name) into results
          until (eql class-name
                     'reblocks/widget:widget)
          finally (return results))))


(defgeneric get-dependencies (widget theme)
  (:documentation "Works like REBLOCKS/DEPENDENCIES:GET-DEPENDENCIES generic-function, but
                   in context of current theme.")
  (:method ((widget ui-widget) (theme t))
    nil))


(defmethod render :around ((widget ui-widget) (theme t))
  "This function is intended for internal usage only.
   It renders widget with surrounding HTML tag and attributes."
  (let ((widget-dependencies (get-dependencies widget theme)))
    ;; Update new-style dependencies
    (reblocks/page-dependencies::push-dependencies widget-dependencies))

  (reblocks/page::register-widget widget)
  
  (with-html
    (:tag
     :name (reblocks/widget::get-html-tag widget)
     :class (reblocks/widget::get-css-classes-as-string widget)
     :id (reblocks/widgets/dom:dom-id widget)
     (call-next-method))))


;; (defmethod reblocks/widget:render ((widget ui-widget))
;;   (render widget (current-theme)))


(defmethod reblocks/widget:render :around ((widget ui-widget))
  ;; For UI-WIDGET main node is rendered by around method of UI2' RENDER method
  (render widget (current-theme)))


(defmethod reblocks/widget:get-css-classes ((widget ui-widget))
  (get-css-classes widget (current-theme)))


(defmethod reblocks/dependencies:get-dependencies ((widget ui-widget))
  (get-dependencies widget (current-theme)))


