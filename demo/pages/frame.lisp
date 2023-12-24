(uiop:define-package #:reblocks-ui2-demo/pages/frame
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:render
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies))
(in-package #:reblocks-ui2-demo/pages/frame)


(defwidget page-frame-widget ()
  ((content-widget :initarg :content
                   :reader content)))


(defun wrap-with-frame (widget)
  (make-instance 'page-frame-widget
                 :content widget))



(defmethod render ((widget page-frame-widget))
  (reblocks/html:with-html
    (:header
     (:div :class "navbar"
           (:div :class "main-logo"
                 (:div :class "title text-4xl my-8 text-center"
                       (:a :href "/"
                           "Reblocks UI2 Demo App")))))

    (:div :class "page-content"
          (render (content widget)))

    (:div :class "footer"
          (when (string-equal (reblocks/request:get-path)
                              "/")
            (:p :class "contacts"
                "Have a question? File an issue: "
                (:a :href "https://github.com/40ants/reblocks-ui2"
                    "https://github.com/40ants/reblocks-ui2"))))))


;; (defmethod get-dependencies ((widget page-frame-widget))
;;   (list*
;;    (reblocks-lass:make-dependency
;;      `(.frame-widget
;;        :color red))
;;    (call-next-method)))

