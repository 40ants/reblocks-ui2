(uiop:define-package #:reblocks-ui2/modal/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/widget
                #:render)
  (:import-from #:reblocks-ui2/modal
                #:modal-hide
                #:modal-header-content
                #:modal-main-content
                #:modal)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/html
                #:html)
  (:import-from #:reblocks/widgets/dom
                #:dom-id)
  (:import-from #:reblocks/actions
                #:make-js-action)
  (:import-from #:str
                #:join)
  (:import-from #:serapeum
                #:fmt
                #:dict)
  (:import-from #:reblocks-ui2/buttons/button
                #:button))
(in-package #:reblocks-ui2/modal/themes/tailwind)


;; I tried this global function approach,
;; but sotimemes it stop work l;eading to this erors
;; <ERROR> [2025-10-02T18:50:40.542203Z] reblocks-ui2/modal/themes/tailwind tailwind.lisp (top level form.on-hide) Widget with dom-id = dom862 not found and can't be hidden
;; TODO: search for the reason
(defun on-hide (&key dom-id &allow-other-keys)
  (unless dom-id
    (error "HIDE-MODAL function should be called with dom-id argument."))
  (log:error "Hiding widget with" dom-id)
  (let ((widget (reblocks/page:find-widget-by-id dom-id)))
    (cond
      (widget (modal-hide widget))
      (t
       (log:error "Widget with dom-id = ~A not found and can't be hidden" dom-id))))
  (values))


(defmethod render ((widget modal) (theme tailwind-theme))
  (flet ((hide (&key &allow-other-keys)
           (modal-hide widget)))
    (let ((header-content (modal-header-content widget))
          (main-content (modal-main-content widget))
          (main-content-classes (list "relative" "border-slate-200" "py-4"
                                      "leading-normal" "text-slate-600"
                                      "font-light"))
          (hide-action (fmt "if( event.target === this) { ~A }"
                            (make-js-action #'hide)
                            ;; (make-js-action 'on-hide
                            ;;                 :args (dict "dom-id" (dom-id widget)))
                            ))
          (hide-action-for-button
            (make-js-action #'hide)
            ;; (make-js-action 'on-hide
            ;;                 :args (dict "dom-id" (dom-id widget)))
            ))
      (when header-content
        (push "border-t" main-content-classes))
     
      (html
          ((:div :class "fixed inset-0 z-[999] grid h-screen w-screen place-items-center bg-black bg-opacity-60 backdrop-blur-sm transition-opacity duration-300"
                 :onclick hide-action
                 :tabindex "0"
                 (:div :class "relative m-4 p-4 w-2/5 min-w-[40%] max-w-[40%] rounded-lg bg-white shadow-sm transition-all duration-300 opacity-1 translate-y-0"
                       ;; Close button
                       (button "X"
                               :on-click hide-action-for-button
                               :style "position: absolute; top: 0; right: 0;")
                      
                       (when header-content
                         (:div :class "flex shrink-0 items-center pb-4 text-xl font-medium text-slate-800"
                               header-content))
                       (:div :class (join " " main-content-classes)
                             main-content))))))))


(defmethod reblocks-ui2/themes/styling:css-classes ((widget modal) (theme tailwind-theme) &key)
  (if (reblocks-ui2/modal:modal-visible-p widget)
      (call-next-method)
      (list* "hidden"
             (call-next-method))))
