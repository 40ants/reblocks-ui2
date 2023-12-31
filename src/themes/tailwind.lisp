(uiop:define-package #:reblocks-ui2/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget
                #:get-dependencies)
  (:import-from #:reblocks-ui2/themes/base
                #:base-theme)
  (:import-from #:reblocks/dependencies
                #:make-dependency)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes)
  (:import-from #:reblocks-ui2/themes/color
                #:color-dark
                #:color-property
                #:color-light
                #:color)
  (:import-from #:serapeum
                #:fmt)
  (:export #:make-tailwind-theme
           #:tailwind-theme
           #:tailwind-theme-mode))
(in-package #:reblocks-ui2/themes/tailwind)


(defvar *default-mode* :auto)


(defclass tailwind-theme (base-theme)
  ((mode :type (member :light :dark :auto)
         :initform *default-mode*
         :initarg :mode
         :documentation "When this slot is in :AUTO mode, theme will be light or dark depending on user's preferences."
         :reader tailwind-theme-mode))
  (:documentation "A theme implementing all widgets using TailwindCSS framework."))


(defun make-tailwind-theme (&key (mode *default-mode*))
  (make-instance 'tailwind-theme
                 :mode mode))


(defmethod get-dependencies ((widget ui-widget) (theme tailwind-theme))
  (list*
   (make-dependency
     "https://cdn.tailwindcss.com/3.3.5"
     ;; Old URLs:
     ;; "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"
     ;; "https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"
     :type :js)
   (call-next-method)))


(defmethod css-classes ((theme tailwind-theme) (obj color) &key)
  (let ((light (color-light obj))
        (dark (color-dark obj))
        (property (color-property obj)))
    (cond
      ((and light dark)
       (case (tailwind-theme-mode theme)
         (:auto (list (fmt "~A-~A" property light)
                      (fmt "dark:~A-~A" property dark)))
         (:light (fmt "~A-~A" property light))
         (:dark (fmt "~A-~A" property dark))))
      ;; COLOR's constructor garantee that either light nor dark
      ;; is filled. In case if only one color is given, we'll use
      ;; it for both dark and light theme:
      (t
       (fmt "~A-~A" property (or light dark))))))
