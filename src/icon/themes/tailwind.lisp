(uiop:define-package #:reblocks-ui2/icon/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/icon
                #:icon-name
                #:icon-widget)
  (:import-from #:reblocks/dependencies
                #:make-dependency)
  (:import-from #:serapeum
                #:fmt))
(in-package #:reblocks-ui2/icon/themes/tailwind)


(defmethod reblocks-ui2/widget:render ((widget icon-widget) (theme tailwind-theme))
  (reblocks/html:with-html
    
    (let ((class (fmt "fi-~A"
                      (icon-name widget))))
      (:span :class class))))


(defmethod reblocks-ui2/widget:get-dependencies ((widget icon-widget) (theme tailwind-theme))
  (list*
   ;; Here we take icons from Zurb Foundation. Not sure how if there are more generic icons.
   ;; 
   ;; Here is the list of all available icons:
   ;; https://zurb.com/playground/foundation-icon-fonts-3
   (make-dependency "https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css")
   (call-next-method)))
