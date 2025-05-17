(uiop:define-package #:reblocks-ui2-demo/pages/tabs
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:render
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/containers/tabs
                #:tabs)
  (:import-from #:reblocks-ui2/html
                #:html)
  (:import-from #:reblocks-ui2/containers/row
                #:row)
  (:import-from #:reblocks-ui2/containers/column
                #:column))
(in-package #:reblocks-ui2-demo/pages/tabs)


(defwidget tabs-page-widget ()
  ())


(defun make-tabs-page ()
  (make-instance 'tabs-page-widget))


(defmethod render ((widget tabs-page-widget))
  (with-html ()
    (:h1 :class "text-2xl my-8"
         "Tabs")

    (:h2 :class "text-xl my-4"
         "Simple example")
    (render
     (tabs (list "First"
                 "Second"
                 "Third")
           (list "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Id interdum velit laoreet id donec ultrices tincidunt. Eget est lorem ipsum dolor sit amet consectetur adipiscing elit. Sapien faucibus et molestie ac feugiat sed lectus vestibulum. In hac habitasse platea dictumst quisque sagittis purus sit. Massa sapien faucibus et molestie ac feugiat sed lectus. Proin gravida hendrerit lectus a. Nunc scelerisque viverra mauris in aliquam sem fringilla ut. Massa placerat duis ultricies lacus sed turpis. Nunc mi ipsum faucibus vitae aliquet. Et molestie ac feugiat sed lectus vestibulum mattis. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Et molestie ac feugiat sed."
                 (html ((:img :src "https://placekitten.com/300/300")))
                 (html ((:img :src "https://placekitten.com/400/300"))))))
    
    (:h2 :class "text-xl my-4"
         "Different sizes")
    
    (render
     (row (column "Size :M"
                  (tabs (list "First"
                              "Second"
                              "Third")
                        (list "First"
                              "Second"
                              "Third")
                        :size :m))
          (column "Size :L"
                  (tabs (list "First"
                              "Second"
                              "Third")
                        (list "First"
                              "Second"
                              "Third")
                        :size :l))
          (column "Size :XL"
                  (tabs (list "First"
                              "Second"
                              "Third")
                        (list "First"
                              "Second"
                              "Third")
                        :size :xl))))))

