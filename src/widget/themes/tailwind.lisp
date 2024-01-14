(uiop:define-package #:reblocks-ui2/widget/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks-ui2/themes/styling
                #:css-classes)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:import-from #:alexandria
                #:flatten))
(in-package #:reblocks-ui2/widget/themes/tailwind)


(defmethod css-classes ((widget ui-widget) (theme tailwind-theme) &key)
  ;; Ignore default css classes based on widget class and inherited classes,
  ;; because in Tailwind theme we don't use CSS rules.
  ;; This way HTML will be smaller.
  (list (reblocks-ui2/widget:widget-margin widget)
        (reblocks-ui2/widget:widget-width widget)
        (reblocks-ui2/widget:widget-height widget)))
