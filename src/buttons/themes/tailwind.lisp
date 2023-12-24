(uiop:define-package #:reblocks-ui2/buttons/themes/tailwind
  (:use #:cl)
  (:import-from #:cl-interpol)
  (:import-from #:named-readtables
                #:in-readtable)
  (:import-from #:reblocks-ui2/buttons/view
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
  (:import-from #:reblocks-ui2/buttons/pin
                #:left-side
                #:right-side
                #:pin))
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


(defmethod css-classes ((theme tailwind-theme) (view normal))
  (list #?"bg-${*normal-color*}-200 hover:bg-${*normal-color*}-300"
        *default-action-css-classes*))

(defmethod css-classes ((theme tailwind-theme) (view action))
  (list #?"bg-${*action-color*}-500 hover:bg-${*action-color*}-400"
        *default-action-css-classes*))

(defmethod css-classes ((theme tailwind-theme) (view raised))
  (list #?"bg-white shadow-xl border border-${*normal-color*}-100 hover:bg-${*normal-color*}-200 hover:border-${*normal-color*}-300"
        *default-action-css-classes*))


(defun outlined-style (color)
  (list #?"border bg-white border-${color}-400 text-${color}-600 hover:bg-${*normal-color*}-100 hover:border-${color}-300"
        *default-action-css-classes*))

(defmethod css-classes ((theme tailwind-theme) (view outlined))
  (outlined-style *normal-color*))

(defmethod css-classes ((theme tailwind-theme) (view outlined-action))
  (outlined-style *action-color*))

(defmethod css-classes ((theme tailwind-theme) (view outlined-info))
  (outlined-style *info-color*))

(defmethod css-classes ((theme tailwind-theme) (view outlined-success))
  (outlined-style *success-color*))

(defmethod css-classes ((theme tailwind-theme) (view outlined-warning))
  (outlined-style *warning-color*))

(defmethod css-classes ((theme tailwind-theme) (view outlined-danger))
  (outlined-style *danger-color*))

(defmethod css-classes ((theme tailwind-theme) (view outlined-utility))
  (outlined-style *utility-color*))


;;;;;;;;;;; 
;; Sizes ;;
;;;;;;;;;;; 


(defmethod css-classes ((theme tailwind-theme) (size xs))
  "text-xs px-1")


(defmethod css-classes ((theme tailwind-theme) (size s))
  "text-sm px-1")


(defmethod css-classes ((theme tailwind-theme) (size m))
  "text-m px-1")


(defmethod css-classes ((theme tailwind-theme) (size l))
  "text-base px-4 py-2")


(defmethod css-classes ((theme tailwind-theme) (size xl))
  "text-lg px-6 py-2")


;;;;;;;;;; 
;; Pins ;;
;;;;;;;;;; 


(defmethod css-classes ((theme tailwind-theme) (pin pin))
  (join-css-classes
   (case (left-side pin)
     (:clear "border-l-0")
     (:brick nil)
     (:round "rounded-l")
     (:circle "rounded-l-full"))
   (case (right-side pin)
     (:clear "border-r-0")
     (:brick nil)
     (:round "rounded-r")
     (:circle "rounded-r-full"))))
