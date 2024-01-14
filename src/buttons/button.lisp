(uiop:define-package #:reblocks-ui2/buttons/button
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:get-html-tag
                #:create-widget-from
                #:widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:import-from #:reblocks-lass)
  (:import-from #:reblocks-ui2/buttons/view
                #:ensure-view)
  (:import-from #:reblocks-ui2/themes/api
                #:*current-theme*)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-styles
                #:join-css-classes
                #:css-classes
                #:css-styles)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:import-from #:reblocks-ui2/sizes
                #:ensure-size)
  (:import-from #:reblocks-ui2/utils/pin
                #:ensure-pin
                #:pin)
  (:export #:button
           #:button-on-click
           #:button-content
           #:button-class
           #:button-style
           #:button-disabled))
(in-package #:reblocks-ui2/buttons/button)


(defwidget button (ui-widget)
  ((on-click :initarg :on-click
             :type (or function
                       null)
             :reader button-on-click)
   (content :initarg :content
            :type widget
            :reader button-content)
   (class :initarg :class
          :type (or null string)
          :reader button-class)
   (style :initarg :style
          :type (or null string)
          :reader button-style)
   (view :initarg :view
         :initform nil
         :reader button-view)
   (size :initarg :size
         :initform nil
         :reader button-size)
   (pin :initarg :pin
        :type pin
        :reader button-pin)
   (disabled :initarg :disabled
             :initform nil
             :type boolean
             :reader button-disabled))
  (:default-initargs :width :min))


(defun button (content &key (widget-class 'button) on-click (class "button") disabled style
                            (view :normal)
                            (size :l)
                            (pin :round)
                            (width :min)
                            height)
  (make-instance widget-class
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


(defmethod render ((widget button) (theme t))
  (let ((action-code (when (button-on-click widget)
                       (typecase (button-on-click widget)
                         (string (button-on-click widget))
                         (t
                          (make-js-action (button-on-click widget))))))
        (view (if (button-disabled widget)
                  (reblocks-ui2/buttons/view::get-disabled-button-view (button-view widget))
                  (button-view widget))))
    (with-html
      (:button :type (if action-code
                         ;; We need to set type to button for all buttons having
                         ;; having on-click handler to prevent the handler to be
                         ;; triggered when button is in the form and user hits
                         ;; Enter on some text-input field:
                         ;; https://stackoverflow.com/questions/62144665
                         "button"
                         "submit")
               :onclick (when action-code
                          (concatenate 'string
                                       ;; We need this stop propagation
                                       ;; to be able to build buttons into
                                       ;; other objects having their own
                                       ;; onClick handlers.
                                       "event.stopPropagation(); "
                                       action-code))
               :class (join-css-classes theme
                                        (button-class widget)
                                        view
                                        (reblocks-ui2/widget:widget-width widget)
                                        (reblocks-ui2/widget:widget-height widget)
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
