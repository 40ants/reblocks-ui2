(uiop:define-package #:reblocks-ui2/tables/themes/tailwind/editable-table
  (:use #:cl)
  (:import-from #:reblocks-ui2/tables/editable-table
                #:render-editable-cell
                #:object-creator
                #:editable-table-widget)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/buttons/button
                #:button)
  (:import-from #:reblocks-ui2/tables/table
                #:column-idx
                #:table-row
                #:column-css-classes
                #:row-cells
                #:*current-cell*
                #:row-table
                #:table-columns
                #:*current-row*
                #:column
                #:rows
                #:table-rows
                #:to-table-row
                #:*current-table*)
  (:import-from #:alexandria
                #:last-elt)
  (:import-from #:serapeum
                #:fmt
                #:push-end)
  (:import-from #:reblocks/widget
                #:update)
  (:import-from #:reblocks-ui2/widget
                #:get-dependencies
                #:render)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks/widgets/string-widget
                #:string-widget)
  (:import-from #:reblocks-ui2/icon
                #:icon)
  (:import-from #:event-emitter
                #:on
                #:event-emitter))
(in-package #:reblocks-ui2/tables/themes/tailwind/editable-table)


(defmethod render ((widget editable-table-widget) (theme tailwind-theme))
  (let ((*current-table* widget)
        (creator (object-creator widget)))
    
    (labels ((add-new-row (object)
               (let* ((row (to-table-row widget object))
                      (last-row (last-elt (table-rows widget))))
                 (push-end row (slot-value widget
                                           'rows))
                 (update row :inserted-after last-row)))
             (on-push-button (&rest args)
               (declare (ignore args))
               (add-new-row (funcall (object-creator widget)))))
      (with-html ()
        (call-next-method)

        (typecase creator
          (reblocks-ui2/widget:ui-widget
           (typecase creator
             (event-emitter
              (on :object-created creator
                  #'add-new-row)
              (render creator theme))
             (t
              (error "Object creator should be inherited from EVENT-EMITTER:EVENT-EMITTER."))))
          ;; If object creator is not a widget,
          ;; then we just funcall it when user press a plus button:
          (t
           (:div :class "controls flex justify-end"
                 (when (object-creator widget)
                   (render (button (icon "plus")
                                   :class "button"
                                   :on-click #'on-push-button)
                           theme)))))))))


(defmethod render-editable-row ((widget table-row) (theme tailwind-theme))
  (with-html ()
    (:tag :name (reblocks/widget:get-html-tag widget)
          :id (reblocks/widgets/dom:dom-id widget)
          (loop with *current-row* = widget
                for column in (table-columns
                               (row-table widget))
                for *current-cell* in (row-cells widget)
                for classes = (str:join " " (column-css-classes column theme))
                do (:td :class classes
                        (render-editable-cell column *current-cell* theme))))))



(defmethod render-editable-cell ((column column) (widget string-widget) (theme tailwind-theme))
  (with-html ()
    (:input :name (fmt "item-~A" (column-idx column))
            :value (reblocks/widgets/string-widget:get-content widget))))


(defmethod get-dependencies ((widget editable-table-widget) (theme tailwind-theme))
  nil
  ;; (list*
  ;;  (reblocks-lass:make-dependency
  ;;    `(.editable-table-widget
  ;;      ((> .controls)
  ;;       :display flex
  ;;       :gap 1rem
  ;;       :justify-content flex-end
  ;;       (button
  ;;        :border-radius 50%))))
  ;;  (call-next-method))
  )
