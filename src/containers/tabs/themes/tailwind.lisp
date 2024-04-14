(uiop:define-package #:reblocks-ui2/containers/tabs/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tabs-active-color
                #:colors-line-normal
                #:tailwind-theme)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/widget
                #:render)
  (:import-from #:reblocks-ui2/containers/tabs
                #:tabs-size
                #:switch-to-idx
                #:subwidgets-titles
                #:tabs-control
                #:current-idx
                #:subwidgets
                #:tabs-selector
                #:tabs-widget)
  (:import-from #:serapeum
                #:fmt
                #:dict)
  (:import-from #:reblocks/widgets/dom
                #:dom-id)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:import-from #:reblocks-ui2/themes/tailwind/arbitrary
                #:arbitrary-value)
  (:import-from #:reblocks-ui2/themes/color
                #:color-dark
                #:color-light)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes))
(in-package #:reblocks-ui2/containers/tabs/themes/tailwind)


(defmethod render ((widget tabs-widget) (theme tailwind-theme))
  (with-html
    (render (tabs-selector widget)
            theme)
    (:div :class "tabs-content"
          (render (elt (subwidgets widget)
                       (current-idx (tabs-selector widget)))
                  theme))))


(defmethod reblocks-ui2/themes/styling:css-classes ((widget tabs-widget) (theme tailwind-theme) &key)
  '("flex flex-col gap-4"))


(defmethod reblocks-ui2/widget:html-attrs ((widget tabs-control) (theme tailwind-theme))
  '(:role "tablist"))


(defmethod reblocks-ui2/themes/styling:css-classes ((widget tabs-control) (theme tailwind-theme) &key)
  ;; First I wanted to use colors-line-normal as is, but it's value inserted for
  ;; both modes like this and didn't worked:
  ;; shadow-[inset_0_-1px_0_0_text-rgba(0,0,0,0.1)_dark:text-rgba(255,255,255,0.15)]
  ;; I need to think about a smarter way to support different modes.
  (let ((light-border (arbitrary-value "shadow" "inset" "0" "-1px" "0" "0"
                                       (color-light (colors-line-normal theme))))
        (dark-border (arbitrary-value "dark-shadow" "inset" "0" "-1px" "0" "0"
                                      (color-dark (colors-line-normal theme)))))
    (list* "flex"
           "gap-4"
           (fmt "text-~A"
                (string-downcase (tabs-size widget)))
           light-border
           dark-border
           (call-next-method))))


(defmethod render ((widget tabs-control) (theme tailwind-theme))
  (with-html
    (loop for title in (subwidgets-titles widget)
          for idx upfrom 0
          for activep = (= idx (current-idx widget))
          for cls = (apply #'join-css-classes theme
                           "cursor-pointer"
                           (when activep
                             (list
                              "border-b-4"
                              (tabs-active-color theme))))
          for action-code = (make-js-action #'switch-to-idx
                                            :args
                                            (dict "widget-id"
                                                  (dom-id widget)
                                                  "idx" idx))
          do (:div :role "tab" :class cls
                   (:a :aria-selected (when activep
                                        "true") 
                       :onclick action-code
                       (render title theme))))))


(defmethod get-dependencies ((widget tabs-widget))
  (list*
   (reblocks-lass:make-dependency
     `(.tabs-widget
       (.tabs-content
        ;; We need to set these
        ;; flex properties to make margin on nested elements
        ;; work propertly:
        :display flex
        :flex-direction column)))
   (call-next-method)))
