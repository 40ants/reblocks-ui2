(uiop:define-package #:reblocks-ui2/inputs/select/themes/tailwind
  (:use #:cl)
  (:import-from #:parenscript)
  (:import-from #:reblocks-ui2/widget
                #:get-html-tag
                #:render)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/inputs/base
                #:input-name
                #:input-value
                #:input-error)
  (:import-from #:reblocks-ui2/inputs/select
                #:option-value
                #:option-selected-p
                #:option-name
                #:select-options
                #:select-type
                #:select-size
                #:select-disabled
                #:select-view
                #:select-pin
                #:select)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes
                #:css-classes
                #:css-styles)
  (:import-from #:reblocks-ui2/inputs/text-input/view
                #:normal
                #:clear)
  (:import-from #:reblocks-ui2/themes/color
                #:color)
  (:import-from #:anaphora
                #:it
                #:awhen)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:import-from #:reblocks/widgets/dom
                #:dom-id)
  (:import-from #:reblocks/page
                #:find-widget-by-id)
  (:import-from #:serapeum
                #:dict))
(in-package #:reblocks-ui2/inputs/select/themes/tailwind)


(defparameter *input-outer-block-classes*
  (list "inline-block"
        "w-full"))


(defparameter *input-content-common-classes*
  (list "flex"
        "w-full"))


(defparameter *disabled-bg-color*
  "bg-slate-200")


(defparameter *disabled-text-color*
  "text-slate-400")


(defparameter *error-text-class*
  "text-red-400")


(defparameter *error-border-class*
  "border-red-400")


(defparameter *normal-border-color*
  (color "border"
         :light "gray-300"
         :dark "gray-600"
         :hover 2
         :focus 4))


(defmethod get-html-tag ((widget select) (theme tailwind-theme))
  :span)

;; NOTE these are defined in text-input/themes/tailwind
;; (defmethod css-classes ((view normal) (theme tailwind-theme) &key invalid-state)
;;   (list "border"
;;         (cond
;;           (invalid-state
;;            *error-border-class*)
;;           (t
;;            *normal-border-color*))
;;         *input-content-common-classes*))


;; (defmethod css-classes ((view clear) (theme tailwind-theme) &key invalid-state)
;;   (declare (ignore invalid-state))
;;   (list* "border-0"
;;          *input-content-common-classes*))


(defmethod css-classes ((widget select) (theme tailwind-theme) &key)
  (list *input-outer-block-classes*
        (call-next-method)))


(defgeneric select-font-size (theme size)
  (:method ((theme tailwind-theme) (size t))
    "text-sm")
  (:method ((theme tailwind-theme) (size (eql :l)))
    "text-base")
  (:method ((theme tailwind-theme) (size (eql :xl)))
    "text-xl"))


(defgeneric select-content-size-classes (theme size)
  (:method ((theme tailwind-theme) (size (eql :s)))
    (list "mx-1"
          "my-0"))
  (:method ((theme tailwind-theme) (size (eql :m)))
    (list "mx-2"
          "my-1"))
  (:method ((theme tailwind-theme) (size (eql :l)))
    (list "mx-2"
          "my-1"))
  (:method ((theme tailwind-theme) (size (eql :xl)))
    (list "mx-4"
          "my-2")))


(defgeneric additional-content-size-classes (theme size)
  (:method ((theme tailwind-theme) (size (eql :s)))
    (list "px-1"))
  (:method ((theme tailwind-theme) (size (eql :m)))
    (list "px-2"))
  (:method ((theme tailwind-theme) (size (eql :l)))
    (list "px-2"))
  (:method ((theme tailwind-theme) (size (eql :xl)))
    (list "px-4")))


(defun %on-change-handler (&key dom-id value &allow-other-keys)
  (let ((widget (find-widget-by-id dom-id)))
    (event-emitter:emit :on-change widget value)))


(defmethod render ((widget select) (theme tailwind-theme))
  (let ((invalid-state (not (null (input-error widget))))
        ;; "console.log(event.target.value)"
        (on-change-action (when (event-emitter:listeners widget :on-change)
                            (make-js-action '%on-change-handler
                                            :args
                                            (dict "dom-id"
                                                  (dom-id widget)
                                                  "value"
                                                  '(ps:chain event target value))))))
    
    (with-html ()
      ;; Outer wrapper
      (:div :class (join-css-classes theme
                                     "flex"
                                     ;; "gap-1"
                                     ;; Center items vertically to make left/right content in line with
                                     ;; the main select.
                                     "items-center"
                                     (css-classes (select-pin widget)
                                                  theme
                                                  :size (select-size widget))
                                     (when (select-disabled widget)
                                       *disabled-bg-color*)
                                     (css-classes (select-view widget)
                                                  theme
                                                  :invalid-state invalid-state))
            
            (:select
                :class (join-css-classes theme
                                         "w-full"
                                         (select-content-size-classes theme
                                                                      (select-size widget))
                                         "border-0"
                                         "bg-transparent"
                                         "focus:outline-none"
                                         (select-font-size theme (select-size widget))
                                         (cond
                                           ((select-disabled widget)
                                            *disabled-text-color*)
                                           (t
                                            (color "text"
                                                   :light "gray-900"
                                                   :dark "gray-100"))))
              :name (input-name widget)
              :onchange on-change-action
              :aria-invalid invalid-state
              (loop for option in (select-options widget)
                    do (:option :value (option-value option)
                                :selected (option-selected-p option)
                                (option-name option)))))
      
      (when (input-error widget)
        (:div :class (join-css-classes theme
                                       "flex"
                                       (additional-content-size-classes
                                        theme
                                        (select-size widget)))
              (:div :class *error-text-class*
                    (input-error widget)))))))
