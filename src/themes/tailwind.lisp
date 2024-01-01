(uiop:define-package #:reblocks-ui2/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget
                #:get-dependencies)
  (:import-from #:reblocks/dependencies
                #:make-dependency)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes)
  (:import-from #:reblocks-ui2/themes/color
                #:color-focus
                #:color-hover
                #:color-dark
                #:color-property
                #:color-light
                #:color)
  (:import-from #:serapeum
                #:fmt)
  (:import-from #:str
                #:ends-with-p)
  (:export #:make-tailwind-theme
           #:tailwind-theme
           #:tailwind-theme-mode))
(in-package #:reblocks-ui2/themes/tailwind)


(defvar *default-mode* :auto)


(defclass tailwind-theme ()
  ((mode :type (member :light :dark :auto)
         :initform *default-mode*
         :initarg :mode
         :documentation "When this slot is in :AUTO mode, theme will be light or dark depending on user's preferences."
         :reader tailwind-theme-mode)))


(defun make-tailwind-theme (&key (mode *default-mode*))
  (make-instance 'tailwind-theme
                 :mode mode))


(defmethod get-dependencies ((widget ui-widget) (theme tailwind-theme))
  (list*
   (make-dependency
     "https://cdn.tailwindcss.com/3.3.5"
     ;; "https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"
     :type :js)
   (call-next-method)))


(defun adjust-color (tailwind-color-name adjustment)
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
                            (adjust-color base-color
                                          (if dark-mode
                                              (color-hover obj)
                                              ;; In light mode we make colors
                                              ;; darker for hovered inputs:
                                              (invert
                                               (color-hover obj))))))
                     (when (color-focus obj)
                       (let ((focus-color
                               (adjust-color base-color
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

      (case (tailwind-theme-mode theme)
        (:auto (list (generate (or light dark))
                     (generate (or dark light)
                               :dark-mode t
                               :prefix "dark")))
        (:light (generate (or light dark)))
        (:dark (generate (or dark light)
                         :dark-mode t))))))
