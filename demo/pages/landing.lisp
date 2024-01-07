(uiop:define-package #:reblocks-ui2-demo/pages/landing
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:colors-text-normal
                #:tailwind-theme))
(in-package #:reblocks-ui2-demo/pages/landing)


(defwidget landing-page-widget (ui-widget)
  ())


(defun make-landing-page ()
  (make-instance 'landing-page-widget))



(defmethod render ((widget landing-page-widget) (theme tailwind-theme))
  (with-html
    (:div :class (join-css-classes theme
                                   (colors-text-normal theme))
          (:h1 :class "text-2xl my-8"
               "Landing")

          (:p "Landing page will be here"))))

