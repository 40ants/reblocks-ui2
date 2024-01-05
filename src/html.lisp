(uiop:define-package #:reblocks-ui2/html
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
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
  (:import-from #:serapeum/bundle
                #:soft-alist-of)
  (:import-from #:named-readtables
                #:in-readtable)
  (:import-from #:pythonic-string-reader
                #:pythonic-string-syntax)
  (:export #:html
           #:prop))
(in-package #:reblocks-ui2/html)

(in-readtable pythonic-string-syntax)


(defwidget html-widget (ui-widget)
  ((render-func :initarg :render-func
                :reader render-func)
   (css-dependency :initarg :css-dependency
                   :initform nil
                   :reader css-dependency)
   (props :initform (make-hash-table :test 'equal)
          :initarg :props
          :accessor props
          :documentation "This hash stores additional state and can be changed using accessor PROPS.")))


(defmacro html ((&body body) &key css on-click props)
  """
  This macro allows to describe HTML, state, css and event handlers of the widget.
  All in the single form.

  Here is an example of the simple widget which keeps the counter value in the state
  and increment it on click:

  (html (:p :class "the-title"
          (fmt "First paragraph with counter: ~A"
               (prop :counter)))
        :props '((:counter . 1))
        :css (.the-title
              :font-size 40px)
        :on-click (lambda (widget)
                    (incf (prop :counter))
                    (update widget)))
"""
  (let ((body (cond
                ((keywordp (car body))
                 ;; In this case body is a single (:div ...) node
                 ;; and should be wrapped with a list for convenience
                 (list body))
                (t
                 body))))
    (with-gensyms (widget-var)
      (once-only (props)
        `(progn
           (unless (typep ,props '(soft-alist-of t t))
             (error "PROPS argument should have an alist form."))
          
           (let ((widget
                   (make-instance 'html-widget
                                  :render-func (lambda (,widget-var)
                                                 (let ((*current-widget* ,widget-var))
                                                   (with-html
                                                     ,@body)))
                                  :css-dependency
                                  (when ',css
                                    (reblocks-lass:make-dependency
                                      ',css))
                                  :on-click ,on-click)))
             (when ,props
               (loop for (key . value) in ,props
                     do (setf (gethash key (props widget))
                              value)))
             (values widget)))))))


(defmethod render ((widget html-widget) (theme t))
  (funcall (render-func widget)
           widget))


(defmethod get-dependencies ((widget html-widget) (theme t))
  (acond
    ((css-dependency widget)
     (list* it
            (call-next-method)))
    (t
     (call-next-method))))


(defun prop (name &optional default)
  (unless (boundp '*current-widget*)
    (error "PROP should be called inside the body of HTML widget or it's ON-CLICK callback."))
  (gethash name (props *current-widget*)
           default))


(defun (setf prop) (new-value name)
  (unless (boundp '*current-widget*)
    (error "PROP should be called inside the body of HTML widget or it's ON-CLICK callback."))
  (setf (gethash name (props *current-widget*))
        new-value))
