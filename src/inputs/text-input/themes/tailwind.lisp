(uiop:define-package #:reblocks-ui2/inputs/text-input/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:get-html-tag
                #:render)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/inputs/text-input
                #:input-size
                #:input-disabled
                #:input-error
                #:input-value
                #:input-view
                #:input-pin
                #:input-placeholder
                #:input-widget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes
                #:css-classes
                #:css-styles)
  (:import-from #:reblocks-ui2/inputs/text-input/view
                #:normal
                #:clear))
(in-package #:reblocks-ui2/inputs/text-input/themes/tailwind)


(defparameter *input-outer-block-classes*
  (list "inline-block"
        "w-full"))


(defparameter *input-content-common-classes*
  (list "flex"
        "w-full"))


(defparameter *disabled-bg-color*
  "bg-slate-200")


(defparameter *disabled-text-color*
  "text-slate-400")


(defparameter *error-color*
  "text-red-400")


(defmethod get-html-tag ((widget input-widget) (theme tailwind-theme))
  :span)


(defmethod css-classes ((theme tailwind-theme) (view normal) &key)
  (list* "border"
         *input-content-common-classes*))


(defmethod css-classes ((theme tailwind-theme) (view clear) &key)
  (list* "border-0"
         *input-content-common-classes*))


(defmethod css-classes ((theme tailwind-theme) (widget input-widget) &key)
  (list *input-outer-block-classes*
        (call-next-method)))


(defgeneric input-font-size (theme size)
  (:method ((theme tailwind-theme) (size t))
    "text-sm")
  (:method ((theme tailwind-theme) (size (eql :l)))
    "text-base")
  (:method ((theme tailwind-theme) (size (eql :xl)))
    "text-xl"))


(defgeneric input-content-size-classes (theme size)
  (:method ((theme tailwind-theme) (size (eql :s)))
    (list "px-1"
          "py-0"))
  (:method ((theme tailwind-theme) (size (eql :m)))
    (list "px-2"
          "py-1"))
  (:method ((theme tailwind-theme) (size (eql :l)))
    (list "px-2"
          "py-1"))
  (:method ((theme tailwind-theme) (size (eql :xl)))
    (list "px-4"
          "py-2")))

(defgeneric additional-content-size-classes (theme size)
  (:method ((theme tailwind-theme) (size (eql :s)))
    (list "px-1"))
  (:method ((theme tailwind-theme) (size (eql :m)))
    (list "px-2"))
  (:method ((theme tailwind-theme) (size (eql :l)))
    (list "px-2"))
  (:method ((theme tailwind-theme) (size (eql :xl)))
    (list "px-4")))


(defmethod render ((widget input-widget) (theme tailwind-theme))
  (with-html
    (:span :class (join-css-classes
                   (list (css-classes theme
                                      (input-pin widget)
                                      :size (input-size widget))
                         (when (input-disabled widget)
                           *disabled-bg-color*)
                         (css-classes theme
                                      (input-view widget))
                         (input-content-size-classes theme (input-size widget))))
           (:input :class (join-css-classes (append (list "w-full"
                                                          "border-0"
                                                          "bg-transparent"
                                                          "focus:outline-0"
                                                          (input-font-size theme (input-size widget)))
                                                    (when (input-disabled widget)
                                                      *disabled-text-color*)))
                   :aria-invalid (not (null (input-error widget)))
                   :value (input-value widget)
                   ;; If we don't set this to 1, then minumum input width
                   ;; will be more than 100px. More details are here:
                   ;; https://stackoverflow.com/a/29990524/70293
                   :size 1
                   :placeholder (input-placeholder widget)))
    (when (input-error widget)
      (:div :class (join-css-classes
                    (list* "flex"
                           (additional-content-size-classes theme (input-size widget))))
            (:div :class *error-color*
                  (input-error widget))))))
