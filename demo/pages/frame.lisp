(uiop:define-package #:reblocks-ui2-demo/pages/frame
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget))
(in-package #:reblocks-ui2-demo/pages/frame)


(defwidget page-frame-widget (ui-widget)
  ((content-widget :initarg :content
                   :reader content)))


(defun wrap-with-frame (widget)
  (make-instance 'page-frame-widget
                 :content widget))



(defmethod render ((widget page-frame-widget) (theme t))
  (reblocks/html:with-html
    (:header
     (:div :class "navbar"
           (:div :class "main-logo"
                 (:div :class "title text-4xl my-8 text-center"
                       (:a :href "/"
                           "Reblocks UI2 Demo App")))))

    (:div :class "page-content w-1/2 mx-auto"
          (render (content widget) theme))

    (:div :class "footer w-1/2 mx-auto my-4 text-slate-400"
          (:p "Have a question?")
          (:p "File an issue: "
              (:a :class "text-blue-400"
                  :href "https://github.com/40ants/reblocks-ui2"
                  "https://github.com/40ants/reblocks-ui2")))))
