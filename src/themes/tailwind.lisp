(uiop:define-package #:reblocks-ui2/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget
                #:get-dependencies)
  (:import-from #:reblocks/dependencies
                #:make-dependency)
  (:export #:make-tailwind-theme
           #:tailwind-theme))
(in-package #:reblocks-ui2/themes/tailwind)


(defclass tailwind-theme ()
  ())


(defun make-tailwind-theme ()
  (make-instance 'tailwind-theme))


(defmethod get-dependencies ((widget ui-widget) (theme tailwind-theme))
  (list*
   (make-dependency
     "https://cdn.tailwindcss.com/3.3.5"
     ;; "https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"
     :type :js)
   (call-next-method)))
