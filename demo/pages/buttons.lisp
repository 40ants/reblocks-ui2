(uiop:define-package #:reblocks-ui2-demo/pages/buttons
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:render
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks-ui2/buttons/button
                #:button))
(in-package #:reblocks-ui2-demo/pages/buttons)


(defwidget buttons-page-widget ()
  ())


(defun make-buttons-page ()
  (make-instance 'buttons-page-widget))


(defmethod render ((widget buttons-page-widget))
  (with-html
    (:div :class "flex flex-col gap-8 items-center"
          (:div :class "flex flex-col gap-4 items-center"
                (:h1 "Button with text")
                (:div :class "flex gap-2"
                      (render
                       (button "Action" :view :action))
                      (render
                       (button "Normal" :view :normal))
                      (render
                       (button "Raised" :view :raised))
                      (render
                       (button "Outlined" :view :outlined))))
          
          (:div :class "flex flex-col gap-4 items-center"
                (:h1 "Disabled buttons")
                (:div :class "flex gap-2"
                      (render
                       (button "Action" :view :action
                               :disabled t))
                      (render
                       (button "Normal" :view :normal
                               :disabled t))
                      (render
                       (button "Raised" :view :raised
                               :disabled t))
                      (render
                       (button "Outlined" :view :outlined
                               :disabled t))))
          
          (:div :class "flex flex-col gap-8 items-center"
                (:h1 "Buttons of different size")
                (:div :class "flex gap-2 items-center"
                      (render
                       (button "Click Me!"
                               :view :outlined
                               :size :xs))
                      (render
                       (button "Click Me!"
                               :view :outlined
                               :size :s))
                      (render
                       (button "Click Me!"
                               :view :outlined
                               :size :m))
                      (render
                       (button "Click Me!"
                               :view :outlined
                               :size :l))
                      (render
                       (button "Click Me!"
                               :view :outlined
                               :size :xl))))
          
          (:div :class "flex flex-col gap-8 items-center"
                (:h1 "Buttons with different pins:")
                (:div :class "flex gap-2"
                      (render
                       (button "Circle - Circle"
                               :view :outlined
                               :pin :circle))
                      (render
                       (button "Round - Brick"
                               :view :outlined
                               :pin '(:round :brick)))
                
                      (render
                       (button "Brick - Clear"
                               :view :outlined
                               :pin '(:brick :clear)))))
          
          (:div :class "flex flex-col gap-8 items-center"
                (:h1 "Stacked buttons:")
                (:div :class "flex"
                      (render
                       (button "Left"
                               :view :outlined
                               :pin '(:round :brick)))
                      (render
                       (button "Center"
                               :view :outlined
                               :pin '(:clear :brick)))
                
                      (render
                       (button "Right"
                               :view :outlined
                               :pin '(:clear :round)))))
          
          (:div :class "flex flex-col gap-8 items-center"
                (:h1 "Accented outlined buttons:")
                (:div :class "flex gap-2"
                      (render
                       (button "Action"
                               :view :outlined-action))
                      (render
                       (button "Normal"
                               :view :outlined))
                      (render
                       (button "Info"
                               :view :outlined-info))
                      (render
                       (button "Success"
                               :view :outlined-success))
                      (render
                       (button "Warning"
                               :view :outlined-warning))
                      (render
                       (button "Danger"
                               :view :outlined-danger))
                      (render
                       (button "Utility"
                               :view :outlined-utility)))))))


;; (defmethod get-dependencies ((widget buttons-page-widget))
;;   (list*
;;    (reblocks-lass:make-dependency
;;      `(.buttons-page-widget
;;        :color red))
;;    (call-next-method)))
