(uiop:define-package #:reblocks-ui2/buttons/button
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:create-widget-from
                #:widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:import-from #:reblocks-lass)
  (:import-from #:reblocks-ui2/buttons/view
                #:get-disabled-button-view
                #:ensure-view)
  (:import-from #:reblocks-ui2/themes/api
                #:*current-theme*)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-styles
                #:join-css-classes
                #:css-classes
                #:css-styles)
  (:import-from #:reblocks-ui2/widget
                #:get-html-tag
                #:html-attrs
                #:widget-height
                #:widget-width
                #:on-click
                #:render
                #:ui-widget)
  (:import-from #:reblocks-ui2/sizes
                #:ensure-size)
  (:import-from #:reblocks-ui2/utils/pin
                #:ensure-pin
                #:pin)
  (:import-from #:reblocks-ui2/inputs/base
                #:input-value
                #:base-input-widget)
  (:import-from #:reblocks-ui2/inputs/named
                #:input-name)
  (:export #:button
           #:button-content
           #:button-class
           #:button-style
           #:button-view
           #:button-size
           #:button-pin
           #:button-disabled))
(in-package #:reblocks-ui2/buttons/button)


(defwidget button (base-input-widget)
  ((content :initarg :content
            :type widget
            :accessor button-content)
   (class :initarg :class
          :type (or null string)
          :accessor button-class)
   (style :initarg :style
          :type (or null string)
          :accessor button-style)
   (view :initarg :view
         :initform nil
         :accessor button-view)
   (size :initarg :size
         :initform nil
         :accessor button-size)
   (pin :initarg :pin
        :type pin
        :accessor button-pin)
   (disabled :initarg :disabled
             :initform nil
             :type boolean
             :accessor button-disabled)
   (type :initarg :type
         :initform nil
         :type (or null string)
         :accessor button-type
         :documentation "If not given, then type will be \"button\" for a button having on-click callback or \"submit\" otherwise."))
  (:default-initargs :width :min))


(defun button (content &key
                         name
                         value
                         type
                         (widget-class 'button)
                         on-click
                         (class "button")
                         disabled
                         style
                         (view :normal)
                         (size :l)
                         (pin :round)
                         (width :min)
                         height)
  (make-instance widget-class
                 :name name
                 :value value
                 :type type
                 :content (create-widget-from content)
                 :on-click on-click
                 :class class
                 :style style
                 :view (ensure-view view)
                 :size (ensure-size size)
                 :pin (ensure-pin pin)
                 :disabled disabled
                 :width width
                 :height height))

#+nil
(defmethod render ((widget button) (theme t))
  (let ((view (if (button-disabled widget)
                  (get-disabled-button-view (button-view widget))
                  (button-view widget))))
    (with-html ()
      (:button :type (cond
                       ((button-type widget)
                        (button-type widget))
                       ((on-click widget)
                        ;; We need to set type to button for all buttons having
                        ;; having on-click handler to prevent the handler to be
                        ;; triggered when button is in the form and user hits
                        ;; Enter on some text-input field:
                        ;; https://stackoverflow.com/questions/62144665
                        "button")
                       (t
                        "submit"))
               :name (input-name widget)
               :value (input-value widget)
               :class (join-css-classes theme
                                        (button-class widget)
                                        view
                                        (widget-width widget)
                                        (widget-height widget)
                                        (button-size widget)
                                        (button-pin widget)
                                        ;; TODO: this is a Tailwind's property
                                        ;; and we need to replace it with some object
                                        ;; which will return css classes depending on theme.
                                        "whitespace-nowrap")
               :style (join-css-styles (button-style widget)
                                       (css-styles view
                                                   theme)
                                       (css-styles (button-size widget)
                                                   theme)
                                       (css-styles (button-pin widget)
                                                   theme))
               :disabled (button-disabled widget)
               (render (button-content widget)
                       theme)))))


(defmethod render ((widget button) (theme t))
  (render (button-content widget)
          theme))


(defmethod css-classes ((widget button) (theme t) &key)
  ;; (list
  ;;  ;; To make it possible to add a button iside a text block.
  ;;  "inline-block")

  (let ((view (if (button-disabled widget)
                  (get-disabled-button-view (button-view widget))
                  (button-view widget))))
    (list
     (button-class widget)
     view
     (widget-width widget)
     (widget-height widget)
     (button-size widget)
     (button-pin widget)
     ;; TODO: this is a Tailwind's property
     ;; and we need to replace it with some object
     ;; which will return css classes depending on theme.
     "whitespace-nowrap")))


(defmethod get-html-tag ((button button) (theme t))
  :button)


(defmethod html-attrs ((widget button) (theme t))
  (let ((view (if (button-disabled widget)
                  (get-disabled-button-view (button-view widget))
                  (button-view widget))))
    (list :type (cond
                  ((button-type widget)
                   (button-type widget))
                  ((on-click widget)
                   ;; We need to set type to button for all buttons having
                   ;; having on-click handler to prevent the handler to be
                   ;; triggered when button is in the form and user hits
                   ;; Enter on some text-input field:
                   ;; https://stackoverflow.com/questions/62144665
                   "button")
                  (t
                   "submit"))
          :name (input-name widget)
          :value (input-value widget)
          :style (join-css-styles (button-style widget)
                                  (css-styles view
                                              theme)
                                  (css-styles (button-size widget)
                                              theme)
                                  (css-styles (button-pin widget)
                                              theme))
          :disabled (button-disabled widget))))
