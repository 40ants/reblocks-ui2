(uiop:define-package #:reblocks-ui2/form/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:render)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/form
                #:form-on-submit
                #:form-content
                #:form-widget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:quri
                #:url-encode)
  (:import-from #:reblocks/actions
                #:make-action))
(in-package #:reblocks-ui2/form/themes/tailwind)


(defmethod render ((widget form-widget) (theme tailwind-theme))
  (let* ((action-code (make-action (form-on-submit widget)))
         ;; (submit-fn "initiateFormAction(\"~A\", $(this), \"~A\")")
         (submit-fn "initiateFormAction(\"~A\", event, this)")
         (use-ajax-p t)
         (on-submit (when use-ajax-p
                      (format nil "~A; return false;"
                              (format nil submit-fn
                                      (url-encode (or action-code ""))
                                      ;; Function session-name-string-pair was removed
                                      ;; during reblocks refactoring, so we just
                                      ;; 
                                      ;; ""
                                      ;; (reblocks::session-name-string-pair)
                                      ))))
         (requires-confirmation-p nil)
         (popup-name (when requires-confirmation-p
                       (symbol-name
                        (gensym "popup"))))
         (on-form-submit (if requires-confirmation-p
                             (format nil "show_~A(); return false;"
                                     popup-name)
                             on-submit)))
    (with-html ()
      (:form :method :post
             :onsubmit on-form-submit
             (render (form-content widget) theme)))))
