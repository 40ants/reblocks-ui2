(uiop:define-package #:reblocks-ui2/editable/string
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/editable
                #:make-editable-widget)
  (:import-from #:serapeum
                #:fmt))
(in-package #:reblocks-ui2/editable/string)


(defwidget editable-string-widget (ui-widget)
  ((value :initarg :value
          :initform ""
          :accessor value)
   (callback :initarg :callback
             :reader callback)))


(defmethod make-editable-widget ((value string) callback)
  (make-instance 'editable-string-widget
                 :value value
                 :callback callback))



(defmethod render ((widget editable-string-widget) (theme t))
  (flet ((call-callback (&key new-value &allow-other-keys)
           (funcall (callback widget)
                    new-value)))
    (let ((action-code (reblocks/actions:make-action #'call-callback)))
      (with-html ()
        (:textarea :onblur
                   (fmt "initiateAction(~S, {\"args\": {\"new-value\": event.target.value}})"
                        action-code)
                   (value widget))))))
