(uiop:define-package #:reblocks-ui2/containers/popup/themes/zurb
  (:use #:cl)
  (:import-from #:reblocks-lass)
  (:import-from #:reblocks-ui2/widget
                #:get-dependencies
                #:render)
  (:import-from #:reblocks-ui2/containers/popup/widget
                #:hide-popup
                #:visible-p
                #:render-popup-content
                #:popup-widget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/themes/zurb
                #:zurb-theme)
  (:import-from #:reblocks-ui2/buttons/button
                #:button)
  (:import-from #:serapeum
                #:fmt)
  (:import-from #:reblocks/widgets/dom
                #:dom-id)
  (:import-from #:reblocks/response
                #:send-script)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes))
(in-package #:reblocks-ui2/containers/popup/themes/zurb)


(defmethod css-classes ((theme zurb-theme) (widget popup-widget))
  (append (when (visible-p widget)
            (list :active))
          (list* :popup
                 (call-next-method))))


(defmethod render ((widget popup-widget) (theme zurb-theme))
  (with-html
    (flet ((close-current-popup (&rest args)
             (declare (ignore args))
             (hide-popup widget)))
      (let* ((dom-id (dom-id widget))
             (dom-id-selector (fmt "#~A" dom-id))
             (action (reblocks/actions:make-action #'close-current-popup)))
        (when (visible-p widget)
          (:div :class "popup-content"
                (render-popup-content widget)
                ;; TODO: replace with UI2's render
                (reblocks/widget:render
                 (button "×"
                         :class "close-button"
                         :on-click #'close-current-popup)))
          (send-script
           `(let ((element (ps:chain document
                                     (query-selector ,dom-id-selector))))
              (ps:chain element
                        (add-event-listener "click"
                                            (lambda (e)
                                              (when (= (ps:@ e
                                                             target
                                                             id)
                                                       ,dom-id)
                                                (ps:chain console
                                                          (log "Closing popup" e))
                                                (initiate-action ,action))
                                              (values ps:false)))))))))))


(defun make-css ()
  (reblocks-lass:make-dependency
    '(body
      (.popup
       :position fixed
       :top 0
       :left 0
       :width 100%
       :height 100vh
       :background "rgba(0,0,0,0.5)"
       :opacity 0
       :display none
       :pointer-events none
       :transition 0.5s all

       (.popup-content
        :position absolute
        :top 50%
        :left 50%
        ;; Here we are centering content and
        ;; shrinking it to a point in the center of the screen
        :transform "translate(-50%, -50%) scale(0)" 
        :background "#fff"
        ;; TODO: probably we need to customize this param
        ;; or to define it as min-width.
        :width 400px
        :padding 25px
        :transition 0.5s all))
      ((:and .popup .active)
       :display block
       :opacity 1
       :pointer-events all
       :transition 0.5s all

       (.popup-content
        ;; Seems these animations don't work when we
        ;; to UPDATE widget. Maybe we need to
        ;; SEND-SCRIPT instead and just to add a class
        ;; on the frontend, to make everything animated!
        :transform "translate(-50%, -50%) scale(1)"
        :transition 0.5s all)))))


(defmethod get-dependencies ((widget popup-widget) (theme zurb-theme))
  (list* (make-css)
         (call-next-method)))
