(uiop:define-package #:reblocks-ui2-demo/pages/containers
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:render
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks-ui2/containers/row
                #:row)
  (:import-from #:reblocks-ui2/containers/column
                #:column))
(in-package #:reblocks-ui2-demo/pages/containers)


(defwidget containers-page-widget ()
  ())


(defun make-containers-page ()
  (make-instance 'containers-page-widget))


(defvar *w* nil)

(defmethod render ((widget containers-page-widget))
  (with-html ()
    (:h1 :class "text-2xl my-8"
         "Containers")

    (:h2 :class "text-xl my-4"
         "Row with default settings")

    (render
     (row "First"
          "Second"
          "Third"))
      
    (:h2 :class "text-xl my-4"
         "With xl gap")
      
    (:p "These items will have more space but you will notice this only on a narrow screen.")

    (render
     (row "First"
          "Second"
          "Third"
          :gap :xl))

    (:h2 :class "text-xl my-4"
         "Column with gap :m (default)")
      
    (render
     (column "First"
             "Second"
             "Third"))

    (:h2 :class "text-xl my-4"
         "Column with gap :l")
    (render
     (column "First"
             "Second"
             "Third"
             :gap :l))
      
    (:h2 :class "text-xl my-4"
         "More complex setup")

    (render (row
             (column "Left column"
                     (row "First"
                          "Second"))
             (column "Right column"
                     (row "Third"
                          "Fourth"
                          "Fifth"))))))

