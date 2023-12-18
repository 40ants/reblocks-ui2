(uiop:define-package #:reblocks-ui2/widget/themes/zurb
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:import-from #:reblocks-ui2/themes/zurb
                #:zurb-theme)
  (:import-from #:reblocks/dependencies
                #:make-dependency))
(in-package #:reblocks-ui2/widget/themes/zurb)


(defmethod reblocks-ui2/widget:get-dependencies ((widget ui-widget) (theme zurb-theme))
  (list*
   (make-dependency "https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css")
   (call-next-method)))
