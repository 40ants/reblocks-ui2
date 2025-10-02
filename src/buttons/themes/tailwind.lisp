(uiop:define-package #:reblocks-ui2/buttons/themes/tailwind
  (:use #:cl)
  (:import-from #:cl-interpol)
  (:import-from #:named-readtables
                #:in-readtable)
  (:import-from #:reblocks-ui2/buttons/view
                #:raised-disabled
                #:normal-disabled
                #:raised
                #:normal
                #:action
                #:outlined
                #:outlined-action
                #:outlined-info
                #:outlined-success
                #:outlined-warning
                #:outlined-danger
                #:outlined-utility)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:colors-border-utility
                #:colors-border-danger
                #:colors-border-warning
                #:colors-border-success
                #:colors-border-info
                #:colors-border-action
                #:colors-border-normal
                #:button-raised-border-color
                #:button-raised-bg-color
                #:button-raised-color
                #:button-normal-color
                #:button-normal-bg-color
                #:colors-text-inverted
                #:button-action-bg-color
                #:button-action-color
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes
                #:css-classes)
  (:import-from #:reblocks-ui2/sizes
                #:xs
                #:s
                #:m
                #:l
                #:xl)
  (:import-from #:reblocks-ui2/utils/pin
                #:left-side
                #:right-side
                #:pin)
  (:import-from #:reblocks-ui2/buttons/button
                #:button)
  (:import-from #:reblocks-ui2/themes/color
                #:adjust-color))
(in-package #:reblocks-ui2/buttons/themes/tailwind)

(in-readtable :interpol-syntax)

;;;;;;;;;;; 
;; Views ;;
;;;;;;;;;;;

(defvar *default-action-css-classes*
  "transition duration-500 ease select-none focus:outline-none focus:shadow-outline")


(defmethod css-classes ((view normal) (theme tailwind-theme) &key)
  (list (button-normal-bg-color theme)
        (button-normal-color theme)
        *default-action-css-classes*))


(defun disabled-css-classes (theme)
  "All disabled buttons should look similar."
  (list (adjust-color theme (button-normal-color theme)
                      :dark -2
                      :light 4
                      :hover nil)
        (adjust-color theme (button-normal-bg-color theme)
                      :dark -1
                      :light 0
                      :hover nil)
        *default-action-css-classes*))


(defmethod css-classes ((view normal-disabled) (theme tailwind-theme) &key)
  (disabled-css-classes theme))


(defmethod css-classes ((view action) (theme tailwind-theme) &key)
  (list
   (button-action-bg-color theme)
   (button-action-color theme)
   *default-action-css-classes*))

(defmethod css-classes ((view raised) (theme tailwind-theme) &key)
  (list #?"shadow-xl border"
        (button-raised-color theme)
        (button-raised-bg-color theme)
        (button-raised-border-color theme)
        *default-action-css-classes*))

(defmethod css-classes ((view raised-disabled) (theme tailwind-theme) &key)
  (disabled-css-classes theme))


(defun outlined-style (theme color)
  (list "border"
        (reblocks-ui2/themes/color:adjust-color theme
                                                color 
                                                :hover 1
                                                :property "border")
        (reblocks-ui2/themes/color:adjust-color theme
                                                color
                                                :light -3
                                                :dark 3
                                                :property "text")
        *default-action-css-classes*))

(defmethod css-classes ((view outlined) (theme tailwind-theme) &key)
  (outlined-style theme (colors-border-normal theme)))

(defmethod css-classes ((view outlined-action) (theme tailwind-theme) &key)
  (outlined-style theme (colors-border-action theme)))

(defmethod css-classes ((view outlined-info) (theme tailwind-theme) &key)
  (outlined-style theme (colors-border-info theme)))

(defmethod css-classes ((view outlined-success) (theme tailwind-theme) &key)
  (outlined-style theme (colors-border-success theme)))

(defmethod css-classes ((view outlined-warning) (theme tailwind-theme) &key)
  (outlined-style theme (colors-border-warning theme)))

(defmethod css-classes ((view outlined-danger) (theme tailwind-theme) &key)
  (outlined-style theme (colors-border-danger theme)))

(defmethod css-classes ((view outlined-utility) (theme tailwind-theme) &key)
  (outlined-style theme (colors-border-utility theme)))


;;;;;;;;;;; 
;; Sizes ;;
;;;;;;;;;;; 


(defmethod css-classes ((size xs) (theme tailwind-theme) &key)
  "text-xs px-1")


(defmethod css-classes ((size s) (theme tailwind-theme) &key)
  "text-sm px-1")


(defmethod css-classes ((size m) (theme tailwind-theme) &key)
  "text-base px-2 py-1")


(defmethod css-classes ((size l) (theme tailwind-theme) &key)
  "text-base px-4 py-2")


(defmethod css-classes ((size xl) (theme tailwind-theme) &key)
  "text-lg px-6 py-2")


;;;;;;;;;; 
;; Pins ;;
;;;;;;;;;; 


(defmethod css-classes ((pin pin) (theme tailwind-theme) &key (size :m))
  (let ((size-suffix
          (case size
            (:m "-md")
            (:l "-lg")
            (:xl "-xl")
            (t nil))))
    (flet ((add-size-suffix (class)
             (if size-suffix
                 (concatenate 'string class size-suffix)
                 class)))
      (list
       (case (left-side pin)
         (:clear "border-l-0")
         (:brick nil)
         (:round (add-size-suffix "rounded-l"))
         (:circle "rounded-l-full"))
       (case (right-side pin)
         (:clear "border-r-0")
         (:brick nil)
         (:round (add-size-suffix "rounded-r"))
         (:circle "rounded-r-full"))))))


;; Button's outer container
;; TODO: remove
(defmethod css-classes ((button button) (theme tailwind-theme) &key)
  (call-next-method)
  ;; (list
  ;;  ;; To make it possible to add a button iside a text block.
  ;;  "inline-block")
  )
