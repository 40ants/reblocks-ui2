(uiop:define-package #:reblocks-ui2-demo/pages/frame
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:colors-bg-action)
  (:import-from #:40ants-routes/route-url
                #:route-url))
(in-package #:reblocks-ui2-demo/pages/frame)


(defwidget page-frame-widget (ui-widget)
  ((content-widget :initarg :content
                   :reader content)))


(defun wrap-with-frame (widget)
  (make-instance 'page-frame-widget
                 :content widget))


(defmethod render ((widget page-frame-widget) (theme t))
  (reblocks/html:with-html ()
    (:header
     (:div :class "navbar"
           (:div :class "main-logo"
                 (:div :class "title text-4xl my-8 text-center text-stone-800 dark:text-stone-300"
                       (:a :href "/"
                           "Reblocks UI2 Demo App")))))

    (:div :class "flex"
          (let* ((menu-item-classes "text-xl py-2 px-4 shadow-lg hover:shadow-md rounded-r-xl border border-stone-200")
                 (current-menu-item-classes (join-css-classes theme
                                                              menu-item-classes
                                                              (colors-bg-action theme)))
                 (sections (append
                            (sort (list '("button" "Button")
                                        '("form" "Form")
                                        '("text-input" "Text Input")
                                        '("card" "Card")
                                        '("containers" "Containers")
                                        '("tabs" "Tabs"))
                                  #'string<
                                  :key #'car)
                            (list
                             '("sources" "Sources" :path "")))))
            (:ul :class "w-[200px] flex flex-col gap-4"
                 (loop for (page-name title . route-args) in sections
                       for full-path = (apply #'route-url
                                              page-name
                                              :namespace "app"
                                              route-args)
                       ;; Here we use starts-with, because for Sources
                       ;; section there might be different URLs behind the prefix.
                       for current = (str:starts-with-p full-path
                                                        (reblocks/request:get-path))
                       do (:li :class (if current
                                          current-menu-item-classes
                                          menu-item-classes)
                               (:a :class "block text-right"
                                   :href full-path
                                   title)))))
          
          (:div :class "page-content w-1/2 mx-auto"
                (render (content widget) theme)))

    (:div :class "footer w-1/2 mx-auto my-4 text-slate-400"
          (:p "Have a question?")
          (:p "File an issue: "
              (:a :class "text-blue-400"
                  :href "https://github.com/40ants/reblocks-ui2"
                  "https://github.com/40ants/reblocks-ui2")))))
