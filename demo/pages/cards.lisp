(uiop:define-package #:reblocks-ui2-demo/pages/cards
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/containers/row
                #:make-row-widget
                #:row)
  (:import-from #:reblocks-ui2/card
                #:card)
  (:import-from #:reblocks-ui2/containers/column
                #:column)
  (:import-from #:alexandria
                #:make-keyword
                #:symbolicate)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:colors-text-normal
                #:tailwind-theme))
(in-package #:reblocks-ui2-demo/pages/cards)


(defwidget cards-page-widget (ui-widget)
  ())


(defun make-cards-page ()
  (make-instance 'cards-page-widget))



(defmethod render ((widget cards-page-widget) (theme tailwind-theme))
  (with-html
    (:div :class (join-css-classes theme
                                   (colors-text-normal theme))
     (:h1 :class "text-2xl my-8"
          "Cards")

     (:h2 :class "text-xl my-4"
          "Different types of view")
     (render
      (row
       (card "Outlined"
             :view :outlined)
       (card "Clear"
             :view :clear)
       (card "Filled"
             :view :filled)
       (card "Raised"
             :view :raised))
      theme)

     (:h2 :class "text-xl my-4"
          "Different colors supported for :outlined, :filled and :raised")

     (let ((height 60))
       (render
        (column
         (make-row-widget
          (loop for color in '(:normal :action :info :success :warning :danger :utility)
                for title = (str:capitalize color)
                collect
                (flet ((view (type)
                         (case color
                           (:normal type)
                           (t (make-keyword
                               (symbolicate type
                                            "-"
                                            color))))))
                  (column
                   (card title
                         :view (view :outlined)
                         :height height)
                   (card title
                         :view (view :filled)
                         :height height)
                   (card title
                         :view (view :raised)
                         :height height)
                   :gap :s)))))
        theme))

     (:h2 :class "text-xl my-4"
          "Precise width")
    
     (render
      (row
       (card "60px"
             :width 60)
      
       (card "120px"
             :width 120)
      
       (card "240px"
             :width 240))
      theme)
    
     (:h2 :class "text-xl my-4"
          "Full width (default)")

     (render
      (card "Full width"
            :width "full")
      theme))))

