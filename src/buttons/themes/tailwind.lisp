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
                #:button))
(in-package #:reblocks-ui2/buttons/themes/tailwind)

(in-readtable :interpol-syntax)

;;;;;;;;;;; 
;; Views ;;
;;;;;;;;;;;

(defvar *default-action-css-classes*
  "transition duration-500 ease select-none focus:outline-none focus:shadow-outline")


(defvar *normal-color* "slate")
(defvar *action-color* "yellow")
(defvar *info-color* "cyan")
(defvar *success-color* "emerald")
(defvar *warning-color* "orange")
(defvar *danger-color* "pink")
(defvar *utility-color* "purple")


(defmethod css-classes ((view normal) (theme tailwind-theme) &key)
  (list #?"bg-${*normal-color*}-200 hover:bg-${*normal-color*}-300"
        *default-action-css-classes*))

(defmethod css-classes ((view normal-disabled) (theme tailwind-theme) &key)
  (list #?"bg-${*normal-color*}-200 text-${*normal-color*}-500"
        *default-action-css-classes*))

(defmethod css-classes ((view action) (theme tailwind-theme) &key)
  (list #?"bg-${*action-color*}-500 hover:bg-${*action-color*}-400"
        *default-action-css-classes*))

(defmethod css-classes ((view raised) (theme tailwind-theme) &key)
  (list #?"bg-white shadow-xl border border-${*normal-color*}-100 hover:bg-${*normal-color*}-200 hover:border-${*normal-color*}-300"
        *default-action-css-classes*))

(defmethod css-classes ((view raised-disabled) (theme tailwind-theme) &key)
  (list #?"bg-${*normal-color*}-200 text-${*normal-color*}-500 shadow-xl border border-${*normal-color*}-100"
        *default-action-css-classes*))


(defun outlined-style (color)
  (list #?"border bg-white border-${color}-400 text-${color}-600 hover:bg-${*normal-color*}-100 hover:border-${color}-300"
        *default-action-css-classes*))

(defmethod css-classes ((view outlined) (theme tailwind-theme) &key)
  (outlined-style *normal-color*))

(defmethod css-classes ((view outlined-action) (theme tailwind-theme) &key)
  (outlined-style *action-color*))

(defmethod css-classes ((view outlined-info) (theme tailwind-theme) &key)
  (outlined-style *info-color*))

(defmethod css-classes ((view outlined-success) (theme tailwind-theme) &key)
  (outlined-style *success-color*))

(defmethod css-classes ((view outlined-warning) (theme tailwind-theme) &key)
  (outlined-style *warning-color*))

(defmethod css-classes ((view outlined-danger) (theme tailwind-theme) &key)
  (outlined-style *danger-color*))

(defmethod css-classes ((view outlined-utility) (theme tailwind-theme) &key)
  (outlined-style *utility-color*))


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
(defmethod css-classes ((button button) (theme tailwind-theme) &key)
  (list
   ;; To make it possible to add a button iside a text block.
   "inline-block"))
