(uiop:define-package #:reblocks-ui2/card/themes/tailwind
  (:use #:cl)
  (:import-from #:cl-interpol)
  (:import-from #:named-readtables
                #:in-readtable)
  (:import-from #:reblocks-ui2/card
                #:horizontal-align-of-card-content
                #:vertical-align-of-card-content
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
                #:core-mode
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
                #:adjust-color)
  (:import-from #:str
                #:ensure-prefix)
  (:import-from #:alexandria
                #:curry))
(in-package #:reblocks-ui2/card/themes/tailwind)

(in-readtable :interpol-syntax)

;;;;;;;;;;; 
;; Views ;;
;;;;;;;;;;;


(defun outlined-style (border-color)
  (list "border"
        border-color))


(defmethod css-classes ((view outlined) (theme tailwind-theme) &key)
  (outlined-style (colors-border-normal theme)))

(defmethod css-classes ((view outlined-action) (theme tailwind-theme) &key)
  (outlined-style (colors-border-action theme)))

(defmethod css-classes ((view outlined-info) (theme tailwind-theme) &key)
  (outlined-style (colors-border-info theme)))

(defmethod css-classes ((view outlined-success) (theme tailwind-theme) &key)
  (outlined-style (colors-border-success theme)))

(defmethod css-classes ((view outlined-warning) (theme tailwind-theme) &key)
  (outlined-style (colors-border-warning theme)))

(defmethod css-classes ((view outlined-danger) (theme tailwind-theme) &key)
  (outlined-style (colors-border-danger theme)))

(defmethod css-classes ((view outlined-utility) (theme tailwind-theme) &key)
  (outlined-style (colors-border-utility theme)))


(defmethod css-classes ((view filled) (theme tailwind-theme) &key)
  (reblocks-ui2/themes/color:adjust-color theme
                                          (colors-bg-normal theme)
                                          :light -2
                                          :dark 2))

(defmethod css-classes ((view filled-action) (theme tailwind-theme) &key)
  (colors-bg-action theme))

(defmethod css-classes ((view filled-info) (theme tailwind-theme) &key)
  (colors-bg-info theme))

(defmethod css-classes ((view filled-success) (theme tailwind-theme) &key)
  (colors-bg-success theme))

(defmethod css-classes ((view filled-warning) (theme tailwind-theme) &key)
  (colors-bg-warning theme))

(defmethod css-classes ((view filled-danger) (theme tailwind-theme) &key)
  (colors-bg-danger theme))

(defmethod css-classes ((view filled-utility) (theme tailwind-theme) &key)
  (colors-bg-utility theme))


(defun raised-style (theme border-color bg-color)
  (let ((light-border (list "border"
                            "shadow-xl"))
        (dark-border (list "shadow-none"
                           "border-none")))
    (list (case (core-mode theme)
            (:auto (append light-border
                           (mapcar (curry #'ensure-prefix "dark:")
                                   dark-border)))
            (:light light-border)
            (:dark dark-border))
          (adjust-color theme
                        border-color
                        :dark "none")
          (adjust-color theme
                        bg-color
                        :light "none"
                        ;; Raise cards should appear more light than filled one,
                        ;; because we can't make them popup using shadow:
                        :dark 2))))


(defmethod css-classes ((view raised) (theme tailwind-theme) &key)
  (raised-style theme
                (colors-border-normal theme)
                (colors-bg-normal theme)))

(defmethod css-classes ((view raised-action) (theme tailwind-theme) &key)
  (raised-style theme
                (colors-border-action theme)
                (colors-bg-action theme)))

(defmethod css-classes ((view raised-info) (theme tailwind-theme) &key)
  (raised-style theme
                (colors-border-info theme)
                (colors-bg-info theme)))

(defmethod css-classes ((view raised-success) (theme tailwind-theme) &key)
  (raised-style theme
                (colors-border-success theme)
                (colors-bg-success theme)))

(defmethod css-classes ((view raised-warning) (theme tailwind-theme) &key)
  (raised-style theme
                (colors-border-warning theme)
                (colors-bg-warning theme)))

(defmethod css-classes ((view raised-danger) (theme tailwind-theme) &key)
  (raised-style theme
                (colors-border-danger theme)
                (colors-bg-danger theme)))

(defmethod css-classes ((view raised-utility) (theme tailwind-theme) &key)
  (raised-style theme
                (colors-border-utility theme)
                (colors-bg-utility theme)))


(defmethod render ((widget card-widget) (theme tailwind-theme))
  (render (card-content widget) theme))


(defmethod css-classes ((widget card-widget) (theme tailwind-theme) &key)
  (list*
   (list
    "flex"
    (awhen (card-border-radius theme)
      (list (fmt "rounded-~A" it)
            ;; We need this rule to hide inner block's corners
            ;; in case if padding is NIL or too small and
            ;; nested items have some background:
            "overflow-hidden"))

    (colors-text-normal theme))
   
   (card-padding widget)
   (horizontal-align-of-card-content widget)
   (vertical-align-of-card-content widget)
   (card-view widget)
   (call-next-method)))
