(uiop:define-package #:reblocks-ui2/card/themes/tailwind
  (:use #:cl)
  (:import-from #:cl-interpol)
  (:import-from #:named-readtables
                #:in-readtable)
  (:import-from #:reblocks-ui2/card
                #:card-height
                #:card-width
                #:card-padding
                #:card-view
                #:card-content
                #:card-widget)
  (:import-from #:reblocks-ui2/card/view
                #:filled
                #:filled-action
                #:filled-info
                #:filled-success
                #:filled-warning
                #:filled-danger
                #:filled-utility
                
                #:raised
                #:raised-action
                #:raised-info
                #:raised-success
                #:raised-warning
                #:raised-danger
                #:raised-utility
                
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
                #:colors-bg-utility
                #:colors-bg-danger
                #:colors-bg-warning
                #:colors-bg-success
                #:colors-bg-info
                #:colors-bg-action
                #:colors-bg-normal
                #:colors-text-normal
                #:card-filled-normal-color
                #:card-border-radius
                #:colors-border-normal
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes
                #:css-classes)
  (:import-from #:reblocks-ui2/widget
                #:render)
  (:import-from #:serapeum
                #:fmt)
  (:import-from #:anaphora
                #:awhen
                #:it)
  (:import-from #:reblocks-ui2/themes/color
                #:adjust-color))
(in-package #:reblocks-ui2/card/themes/tailwind)

(in-readtable :interpol-syntax)

;;;;;;;;;;; 
;; Views ;;
;;;;;;;;;;;

;; (defvar *default-action-css-classes*
;;   "transition duration-500 ease select-none focus:outline-none focus:shadow-outline")


;; (defvar *normal-color* "slate")
;; (defvar *action-color* "yellow")
;; (defvar *info-color* "cyan")
;; (defvar *success-color* "emerald")
;; (defvar *warning-color* "orange")
;; (defvar *danger-color* "pink")
;; (defvar *utility-color* "purple")


;; (defmethod css-classes ((theme tailwind-theme) (view normal) &key)
;;   (list #?"bg-${*normal-color*}-200 hover:bg-${*normal-color*}-300"
;;         *default-action-css-classes*))

;; (defmethod css-classes ((theme tailwind-theme) (view action) &key)
;;   (list #?"bg-${*action-color*}-500 hover:bg-${*action-color*}-400"
;;         *default-action-css-classes*))

;; (defmethod css-classes ((theme tailwind-theme) (view raised) &key)
;;   (list #?"bg-white shadow-xl border border-${*normal-color*}-100 hover:bg-${*normal-color*}-200 hover:border-${*normal-color*}-300"
;;         *default-action-css-classes*))


(defun outlined-style (border-color)
  (list "border"
        border-color))


(defmethod css-classes ((theme tailwind-theme) (view outlined) &key)
  (outlined-style (colors-border-normal theme)))

(defmethod css-classes ((theme tailwind-theme) (view outlined-action) &key)
  (outlined-style (colors-border-action theme)))

(defmethod css-classes ((theme tailwind-theme) (view outlined-info) &key)
  (outlined-style (colors-border-info theme)))

(defmethod css-classes ((theme tailwind-theme) (view outlined-success) &key)
  (outlined-style (colors-border-success theme)))

(defmethod css-classes ((theme tailwind-theme) (view outlined-warning) &key)
  (outlined-style (colors-border-warning theme)))

(defmethod css-classes ((theme tailwind-theme) (view outlined-danger) &key)
  (outlined-style (colors-border-danger theme)))

(defmethod css-classes ((theme tailwind-theme) (view outlined-utility) &key)
  (outlined-style (colors-border-utility theme)))


(defmethod css-classes ((theme tailwind-theme) (view filled) &key)
  (colors-bg-normal theme))

(defmethod css-classes ((theme tailwind-theme) (view filled-action) &key)
  (colors-bg-action theme))

(defmethod css-classes ((theme tailwind-theme) (view filled-info) &key)
  (colors-bg-info theme))

(defmethod css-classes ((theme tailwind-theme) (view filled-success) &key)
  (colors-bg-success theme))

(defmethod css-classes ((theme tailwind-theme) (view filled-warning) &key)
  (colors-bg-warning theme))

(defmethod css-classes ((theme tailwind-theme) (view filled-danger) &key)
  (colors-bg-danger theme))

(defmethod css-classes ((theme tailwind-theme) (view filled-utility) &key)
  (colors-bg-utility theme))


(defun raised-style (theme border-color bg-color)
  (list "border shadow-xl dark:shadow-none dark:border-none"
        (adjust-color theme
                      border-color
                      :dark "none")
        (adjust-color theme
                      bg-color
                 :light "none"
                 ;; Raise cards should appear more light than filled one,
                 ;; because we can't make them popup using shadow:
                 :dark 2)))


(defmethod css-classes ((theme tailwind-theme) (view raised) &key)
  (raised-style theme
                (colors-border-normal theme)
                (colors-bg-normal theme)))

(defmethod css-classes ((theme tailwind-theme) (view raised-action) &key)
  (raised-style theme
                (colors-border-action theme)
                (colors-bg-action theme)))

(defmethod css-classes ((theme tailwind-theme) (view raised-info) &key)
  (raised-style theme
                (colors-border-info theme)
                (colors-bg-info theme)))

(defmethod css-classes ((theme tailwind-theme) (view raised-success) &key)
  (raised-style theme
                (colors-border-success theme)
                (colors-bg-success theme)))

(defmethod css-classes ((theme tailwind-theme) (view raised-warning) &key)
  (raised-style theme
                (colors-border-warning theme)
                (colors-bg-warning theme)))

(defmethod css-classes ((theme tailwind-theme) (view raised-danger) &key)
  (raised-style theme
                (colors-border-danger theme)
                (colors-bg-danger theme)))

(defmethod css-classes ((theme tailwind-theme) (view raised-utility) &key)
  (raised-style theme
                (colors-border-utility theme)
                (colors-bg-utility theme)))


(defmethod render ((widget card-widget) (theme tailwind-theme))
  (render (card-content widget) theme))


(defmethod css-classes ((theme tailwind-theme) (widget card-widget) &key)
  (list
   (list
    "flex"
    ;; align-items: center
    "items-center"
    ;; justify-content: center
    "justify-center"
    (awhen (card-border-radius theme)
      (fmt "rounded-~A" it))

    (colors-text-normal theme))
   
   (card-padding widget)
   (card-width widget)
   (card-height widget)
   (card-view widget)))
