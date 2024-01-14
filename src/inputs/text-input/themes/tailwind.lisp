(uiop:define-package #:reblocks-ui2/inputs/text-input/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:get-html-tag
                #:render)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/inputs/base
                #:input-name
                #:input-value
                #:input-error)
  (:import-from #:reblocks-ui2/inputs/text-input
                #:input-type
                #:input-size
                #:input-disabled
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
                #:clear)
  (:import-from #:reblocks-ui2/themes/color
                #:color))
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


(defparameter *error-text-class*
  "text-red-400")


(defparameter *error-border-class*
  "border-red-400")


(defparameter *normal-border-color*
  (color "border"
         :light "gray-300"
         :dark "gray-600"
         :hover 2
         :focus 4))


(defmethod get-html-tag ((widget input-widget) (theme tailwind-theme))
  :span)


(defmethod css-classes ((view normal) (theme tailwind-theme) &key invalid-state)
  (list "border"
        (cond
          (invalid-state
           *error-border-class*)
          (t
           *normal-border-color*))
        *input-content-common-classes*))


(defmethod css-classes ((view clear) (theme tailwind-theme) &key invalid-state)
  (declare (ignore invalid-state))
  (list* "border-0"
         *input-content-common-classes*))


(defmethod css-classes ((widget input-widget) (theme tailwind-theme) &key)
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
  (let ((invalid-state (not (null (input-error widget)))))
    (with-html
      (:span :class (join-css-classes theme
                                      (css-classes (input-pin widget)
                                                   theme
                                                   :size (input-size widget))
                                      (when (input-disabled widget)
                                        *disabled-bg-color*)
                                      (css-classes (input-view widget)
                                                   theme
                                                   :invalid-state invalid-state)
                                      (input-content-size-classes theme
                                                                  (input-size widget)))
             (:input :class (join-css-classes theme
                                              "w-full"
                                              "border-0"
                                              "bg-transparent"
                                              "focus:outline-none"
                                              (input-font-size theme (input-size widget))
                                              (cond
                                                ((input-disabled widget)
                                                 *disabled-text-color*)
                                                (t
                                                 (color "text"
                                                        :light "gray-900"
                                                        :dark "gray-100"))))
                     :name (input-name widget)
                     :value (input-value widget)
                     :type (input-type widget)
                     :aria-invalid invalid-state
                     ;; If we don't set this to 1, then minumum input width
                     ;; will be more than 100px. More details are here:
                     ;; https://stackoverflow.com/a/29990524/70293
                     :size 1
                     :placeholder (input-placeholder widget)))
      (when (input-error widget)
        (:div :class (join-css-classes theme
                                       "flex"
                                       (additional-content-size-classes
                                        theme
                                        (input-size widget)))
              (:div :class *error-text-class*
                    (input-error widget)))))))
