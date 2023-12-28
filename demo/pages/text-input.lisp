(uiop:define-package #:reblocks-ui2-demo/pages/text-input
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:render
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/inputs/text-input
                #:input)
  (:import-from #:reblocks-ui2/containers/row
                #:row))
(in-package #:reblocks-ui2-demo/pages/text-input)


(defwidget text-input-page ()
  ())


(defun make-text-input-page ()
  (make-instance 'text-input-page))


(defmethod render ((widget text-input-page))
  (with-html
    (:h1 :class "text-2xl my-8"
         "Text input")

    (:h2 :class "text-xl my-4"
         "Simple text input")
    (render
     (input :placeholder "Enter a text"))

    (:h2 :class "text-xl my-4"
         "With given value")

    (render
     (input :placeholder "Enter a text"
            :value "Entered text"))

    (:h2 :class "text-xl my-4"
         "Circle pins")
    
    (render
     (input :placeholder "Enter a text"
            :pin :circle))

    (:h2 :class "text-xl my-4"
         "Clear view")
    
    (render
     (input :placeholder "Enter a text"
            :view :clear))

    (:h2 :class "text-xl my-4"
         "With error message")

    (render
     (input :placeholder "Enter a text"
            :value "Entered text"
            :error "Email is expected"))


    (:h2 :class "text-xl my-4"
         "Disabled")

    (render
     (input :placeholder "Enter a text"
            :value "Entered text"
            :disabled t))

    (:h2 :class "text-xl my-4"
         "Different sizes")

    (render
     (row
      (input :placeholder "Small"
             :size :s
             :error "Error")
      (input :placeholder "Medium (normal)"
             :size :m
             :error "Error")
      (input :placeholder "Large"
             :size :l
             :error "Error")
      (input :placeholder "Extra Large"
             :size :xl
             :error "Error")))))
