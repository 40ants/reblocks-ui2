(uiop:define-package #:reblocks-ui2/widget
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:parenscript)
  (:import-from #:reblocks/debug)
  (:import-from #:reblocks/page-dependencies)
  (:import-from #:reblocks/dependencies)
  (:import-from #:reblocks-ui2/themes/api
                #:*current-theme*
                #:current-theme)
  (:import-from #:moptilities
                #:superclasses)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes
                #:css-classes)
  (:import-from #:anaphora
                #:it
                #:awhen)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:import-from #:serapeum
                #:fmt
                #:defvar-unbound)
  (:import-from #:reblocks-ui2/utils/margin
                #:margin)
  (:import-from #:reblocks-ui2/utils/size
                #:some-width
                #:some-height)
  (:import-from #:reblocks-ui2/utils/primitive-to
                #:process-primitive-args)
  (:export #:render
           #:ui-widget
           #:get-dependencies
           #:get-html-tag
           #:widget-margin
           #:widget-height
           #:widget-width
           #:on-click
           #:html-attrs))
(in-package #:reblocks-ui2/widget)


(defvar-unbound *current-widget*
  "This variable is for internal use and can be bound during RENDER or different ON-* methods.")


(defwidget ui-widget ()
  ((on-click :initform nil
             :initarg :on-click
             :reader on-click
             :documentation "When an on-click action is given, cursor style will be changed to \"pointer\".")
   (margin :initform nil
           :initarg :margin
           :type (or null margin)
           :reader widget-margin)
   (width :initform nil
          :initarg :width
          :type (or null some-width)
          :reader widget-width)
   (height :initform nil
           :initarg :height
           :type (or null some-height)
           :reader widget-height))
  (:default-initargs :width :full))


(defmethod initialize-instance :around ((instance ui-widget) &rest initargs)
  (let ((initargs (process-primitive-args initargs)))
    (apply #'call-next-method
           instance
           initargs)))


(defgeneric render (widget theme)
  (:documentation "Renders widget in given theme. All reblocks-ui2 widgets
                   should implement this method instead of a method
                   for REBLOCKS/WIDGET:RENDER generic-function.")
  (:method ((widget ui-widget) (theme t))
    (let ((class-name (class-name (class-of widget)))
          (theme-name (class-name (class-of theme))))
      (with-html ()
        (:p "Please, define:"
            (:pre (format nil
                          "(defmethod reblocks-ui2/widget:render ((widget ~A) (theme ~A))
    (reblocks/html:with-html ()
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


(defgeneric html-attrs (widget theme)
  (:documentation "May return a plist of attributes to add to the main widget's HTML node.

                   It should not return :ID :CLASS or :ONCLICK attributes.")
  (:method ((widget t) (theme t))
    nil))


(defun make-onclick-wrapper (widget)
  (check-type widget ui-widget)
  (awhen (on-click widget)
    (concatenate 'string
                 ;; We need this stop propagation
                 ;; to be able to build buttons into
                 ;; other objects having their own
                 ;; onClick handlers.
                 "event.stopPropagation(); "
                 (typecase it
                   ;; We were given a raw JavaScript
                   (string it)
                   ;; We were given a Parenscript code
                   ;; and need to translate it to JS:
                   (cons (ps:ps* it))
                   (t
                    ;; Otherwise, we are given a function
                    ;; to be called as a callback
                    (unless (or (typep it 'function)
                                (and (typep it 'symbol)
                                     (fboundp it)))
                      (error "Callback ~A should be a function or a fbound symbol."
                             it))
                    
                    (make-js-action
                     (flet ((on-click-wrapper (&rest args)
                              (declare (ignore args))
                              (let ((*current-widget* widget))
                                (funcall it widget))))
                       #'on-click-wrapper)))))))


(defmethod render :around ((widget ui-widget) (theme t))
  "This function is intended for internal usage only.
   It renders widget with surrounding HTML tag and attributes."
  (let ((*current-theme* theme))
    (let ((widget-dependencies (get-dependencies widget theme)))
      ;; Update new-style dependencies
      (reblocks/page-dependencies::push-dependencies widget-dependencies))

    (reblocks/page::register-widget widget)
  
    (with-html ()
      (when (reblocks/debug:status)
        ;; Tailwind theme does not use semantic classes and sometimes
        ;; it is hard to figure out where starts some widget.
        ;; In debug mode we render these comments to help with debug.
        (:comment (fmt "Widget \"~S\""
                       (class-name (class-of widget)))))
    
      (:tag
       :name (get-html-tag widget theme)
       :class (join-css-classes theme
                                (css-classes widget theme))
       :id (reblocks/widgets/dom:dom-id widget)
       :onclick (make-onclick-wrapper widget)
       :attrs (html-attrs widget theme)
       (call-next-method)))))


(defmethod reblocks/widget:render :around ((widget ui-widget))
  ;; For UI-WIDGET main node is rendered by around method of UI2' RENDER method
  (render widget (current-theme)))


(defmethod css-classes ((widget ui-widget) (theme t) &key)
  "Default implementation for widget returns class list and all it's parent names."
  (loop for class in (list* (class-of widget)
                            (superclasses (class-of widget)))
        for class-name = (class-name class)
        collect (string-downcase class-name) into results
        until (eql class-name
                   'reblocks/widget:widget)
        finally (return results)))


(defmethod reblocks/dependencies:get-dependencies ((widget ui-widget))
  (get-dependencies widget (current-theme)))


