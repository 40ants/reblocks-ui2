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
                #:ui-widget)
  (:import-from #:serapeum
                #:ensure-suffix
                #:fmt)
  (:import-from #:reblocks/app
                #:get-prefix)
  (:import-from #:reblocks/variables
                #:*current-app*)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:colors-bg-action))
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
                 (:div :class "title text-4xl my-8 text-center text-stone-800 dark:text-stone-300"
                       (:a :href (ensure-suffix
                                  (get-prefix *current-app*)
                                  "/")
                           "Reblocks UI2 Demo App")))))

    (:div :class "flex"
          (let* ((menu-item-classes "text-xl py-2 px-4 shadow-lg hover:shadow-md rounded-r-xl border border-stone-200")
                 (current-menu-item-classes (join-css-classes theme
                                                              menu-item-classes
                                                              (colors-bg-action theme)))
                 (sections (sort (list (cons "button" "Button")
                                       (cons "form" "Form")
                                       (cons "text-input" "Text Input")
                                       (cons "card" "Card")
                                       (cons "containers" "Containers")
                                       (cons "tabs" "Tabs"))
                                 #'string<
                                 :key #'car)))
            (:ul :class "w-[200px] flex flex-col gap-4"
                 (loop for (path . title) in sections
                       for full-path = (fmt "~A/~A"
                                            (get-prefix *current-app*)
                                            path)
                       for current = (string-equal full-path (reblocks/request:get-path))
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
