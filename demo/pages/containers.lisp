(uiop:define-package #:reblocks-ui2-demo/pages/containers
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks-ui2/widget
                #:render)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes)
  (:import-from #:reblocks-ui2/containers/row
                #:row)
  (:import-from #:reblocks-ui2/containers/column
                #:column)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:colors-text-normal
                #:tailwind-theme))
(in-package #:reblocks-ui2-demo/pages/containers)


(defwidget containers-page-widget ()
  ())


(defun make-containers-page ()
  (make-instance 'containers-page-widget))


(defvar *w* nil)

(defmethod render ((widget containers-page-widget) (theme tailwind-theme))
  (with-html ()
    (:div :class (join-css-classes theme
                                   (colors-text-normal theme))
          (:h1 :class "text-2xl my-8"
               "Containers")

          (:h2 :class "text-xl my-4"
               "Row with default settings")

          (render
           (row "First"
                "Second"
                "Third")
           theme)
      
          (:h2 :class "text-xl my-4"
               "With xl gap")
      
          (:p "These items will have more space but you will notice this only on a narrow screen.")

          (render
           (row "First"
                "Second"
                "Third"
                :gap :xl)
           theme)

          (:h2 :class "text-xl my-4"
               "Column with gap :m (default)")
      
          (render
           (column "First"
                   "Second"
                   "Third")
           theme)

          (:h2 :class "text-xl my-4"
               "Column with gap :l")
          (render
           (column "First"
                   "Second"
                   "Third"
                   :gap :l)
           theme)
      
          (:h2 :class "text-xl my-4"
               "More complex setup")

          (render (row
                   (column "Left column"
                           (row "First"
                                "Second"))
                   (column "Right column"
                           (row "Third"
                                "Fourth"
                                "Fifth")))
                  theme))))

