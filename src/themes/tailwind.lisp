(uiop:define-package #:reblocks-ui2/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget
                #:get-dependencies)
  (:import-from #:reblocks-ui2/themes/base
                #:base-theme)
  (:export #:make-tailwind-theme
           #:tailwind-theme))
(in-package #:reblocks-ui2/themes/tailwind)


(defclass tailwind-theme (base-theme)
  ()
  (:documentation "A theme implementing all widgets using TailwindCSS framework."))


(defun make-tailwind-theme ()
  (make-instance 'tailwind-theme))



(defmethod get-dependencies ((widget ui-widget) (theme tailwind-theme))
  (list*
   (reblocks/dependencies:make-dependency "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"
     :type :js)
   (call-next-method)))
