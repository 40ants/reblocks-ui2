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
                #:adjust-base-color
                #:color-focus
                #:color-hover
                #:color-dark
                #:color-property
                #:color-light
                #:color)
  (:import-from #:serapeum
                #:soft-alist-of
                #:fmt)
  (:import-from #:str
                #:ends-with-p)
  (:import-from #:reblocks-ui2/themes/api
                #:deftheme)
  (:import-from #:reblocks-ui2/utils/padding
                #:padding-size)
  (:export #:make-tailwind-theme
           #:tailwind-theme))
(in-package #:reblocks-ui2/themes/tailwind)


(defvar *default-mode* :auto)


<<<<<<< HEAD
(defclass tailwind-theme (base-theme)
  ((mode :type (member :light :dark :auto)
         :initform *default-mode*
         :initarg :mode
         :documentation "When this slot is in :AUTO mode, theme will be light or dark depending on user's preferences."
         :reader tailwind-theme-mode))
  (:documentation "A theme implementing all widgets using TailwindCSS framework."))
=======
(defun make-vars (&rest args)
  (log:error "Making vars" args)
  (list :args args))
>>>>>>> 713b417 (Add a "card" component.)


;; (defclass foo ()
;;   ((vars :allocation :class
;;          :initarg :vars
;;          :initform (make-vars 1 2))))

;; (defclass bar (foo)
;;   ()
;;   (:default-initargs :vars (make-vars 4 5)))


;; (defclass tailwind-theme ()
;;   ((mode :type (member :light :dark :auto)
;;          :initform *default-mode*
;;          :initarg :mode
;;          :documentation "When this slot is in :AUTO mode, theme will be light or dark depending on user's preferences."
;;          :reader tailwind-theme-mode)))


(deftheme tailwind-theme ()
  (core
   (mode :type (member :light :dark :auto)
         :value :auto
         :documentation "When this slot is in :AUTO mode, theme will be light or dark depending on user's preferences.")
   (padding-sizes :type (soft-alist-of padding-size string)
                  :value '((:s . "1")
                           (:m . "2")
                           (:l . "4")
                           (:xl . "8"))
                  :documentation "A mapping of :s :m :l :xl sizes to real padding size which can be applied to "))
  (colors
   (text
    (normal :type color
            :value (color "text"
                          :light "stone-800"
                          :dark "stone-300")))
   (border
    (normal :type color
            :value (color "border"
                          :light "stone-300"
                          :dark "stone-600"))
    (action :type color
            :value (color "border"
                          :light "yellow-300"
                          :dark "yellow-600"))
    (info :type color
          :value (color "border"
                        :light "cyan-300"
                        :dark "cyan-600"))
    (success :type color
             :value (color "border"
                           :light "emerald-300"
                           :dark "emerald-600"))
    (warning :type color
             :value (color "border"
                           :light "orange-300"
                           :dark "orange-600"))
    (danger :type color
            :value (color "border"
                          :light "pink-300"
                          :dark "pink-600"))
    (utility :type color
             :value (color "border"
                           :light "purple-300"
                           :dark "purple-600")))
   (bg
    (normal :type color
            :value (color "bg"
                          :light "stone-300"
                          :dark "stone-900"))
    (action :type color
            :value (color "bg"
                          :light "yellow-300"
                          :dark "yellow-950"))
    (info :type color
          :value (color "bg"
                        :light "cyan-300"
                        :dark "cyan-950"))
    (success :type color
             :value (color "bg"
                           :light "emerald-300"
                           :dark "emerald-950"))
    (warning :type color
             :value (color "bg"
                           :light "orange-300"
                           :dark "orange-950"))
    (danger :type color
            :value (color "bg"
                          :light "pink-300"
                          :dark "pink-950"))
    (utility :type color
             :value (color "bg"
                           :light "purple-300"
                           :dark "purple-950"))))

  (card
   (border-radius :type string
                  :value "xl"
                  :documentation "Border radius for card containers.")))


(deftheme tailwind-theme-light (tailwind-theme)
  (core
   (mode :type (member :light :dark :auto)
         :value :light
         :documentation "When this slot is in :AUTO mode, theme will be light or dark depending on user's preferences.")))


(deftheme tailwind-theme-dark (tailwind-theme)
  (core
   (mode :type (member :light :dark :auto)
         :value :dark
         :documentation "When this slot is in :AUTO mode, theme will be light or dark depending on user's preferences.")))


(defmethod get-dependencies ((widget ui-widget) (theme tailwind-theme))
  (list*
   (make-dependency
     "https://cdn.tailwindcss.com/3.3.5"
     ;; Old URLs:
     ;; "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"
     ;; "https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"
     :type :js)
   (call-next-method)))


(defmethod adjust-base-color ((theme tailwind-theme) (tailwind-color-name string) (adjustment integer))
  "Changes brightness in TailwindCSS color.

   Each 1 in adjustments increments color brightness to 100 or 50 like this:

   ```
   green -> green-950
   green-950 -> green-900
   green-900 -> green-800
   ...
   green-100 -> green-50
   ```"

  (destructuring-bind (color-name old-value)
      (if (ends-with-p "0" tailwind-color-name)
          (str:rsplit "-" tailwind-color-name :limit 2)
          (list tailwind-color-name "1000"))

    (let ((new-value (parse-integer old-value)))

      (flet ((increment (value)
               (cond
                 ((= 1000 value)
                  value)
                 ((< value 100)
                  (+ value 50))
                 ((<= 900 value)
                  (+ value 50))
                 (t
                  (+ value 100))))
             (decrement (value)
               (cond
                 ((= 50 value)
                  value)
                 ((< 900 value)
                  (- value 50))
                 ((< 100 value)
                  (- value 100))
                 (t
                  (- value 50)))))
        (if (< 0 adjustment)
            ;; For positive adjustment values
            ;; we decrement color number upto 50 to make color lighter.
            (loop for i from 0 below adjustment
                  do (setf new-value
                           (decrement new-value)))
            ;; For negative adjustment values
            ;; we increment color number upto 1000 to make color lighter.
            ;; (increment new-value)
            (loop for i from 0 above adjustment
                  do (setf new-value
                           (increment new-value)))))
    
      (if (= new-value 1000)
          color-name
          (fmt "~A-~A"
               color-name
               new-value)))))


(defmethod adjust-base-color ((theme tailwind-theme) (tailwind-color-name string) (new-name string))
  "Just replaced the base color with the given name."
  new-name)


(defmethod css-classes ((theme tailwind-theme) (obj color) &key)
  (let ((light (color-light obj))
        (dark (color-dark obj))
        (property (color-property obj)))
    (labels ((invert (color-adjustment)
               (etypecase color-adjustment
                 ;; Color might be given explicitly as string
                 (string color-adjustment)
                 ;; Or as an relative adjustment:
                 (integer (- color-adjustment))))
             
             (generate (base-color &key dark-mode prefix)
               (list (fmt "~@[~A:~]~A-~A" prefix property base-color)
                     (when (color-hover obj)
                       (fmt "~@[~A:~]hover:~A-~A" prefix property
                            (adjust-base-color theme
                                               base-color
                                               (if dark-mode
                                                   (color-hover obj)
                                                   ;; In light mode we make colors
                                                   ;; darker for hovered inputs:
                                                   (invert
                                                    (color-hover obj))))))
                     (when (color-focus obj)
                       (let ((focus-color
                               (adjust-base-color theme
                                                  base-color
                                                  (if dark-mode
                                                      (color-focus obj)
                                                      ;; In light mode we make colors
                                                      ;; darker for focused inputs:
                                                      (invert
                                                       (color-focus obj))))))
                         (list
                          (fmt "~@[~A:~]focus-within:~A-~A" prefix property
                               focus-color)
                          ;; Without this rule, color will flick when
                          ;; you move mouse over focused control:
                          (fmt "~@[~A:~]focus-within:hover:~A-~A" prefix property
                               focus-color)))))))

      (case (core-mode theme)
        (:auto (list (generate (or light dark))
                     (generate (or dark light)
                               :dark-mode t
                               :prefix "dark")))
        (:light (generate (or light dark)))
        (:dark (generate (or dark light)
                         :dark-mode t))))))
