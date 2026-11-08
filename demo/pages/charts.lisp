(uiop:define-package #:reblocks-ui2-demo/pages/charts
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:colors-text-normal
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/charts/pie-chart
                #:pie-chart)
  (:import-from #:reblocks-ui2/charts/column-chart
                #:column-chart))
(in-package #:reblocks-ui2-demo/pages/charts)


(defwidget charts-page-widget (ui-widget)
  ())


(defun make-charts-page ()
  (make-instance 'charts-page-widget))


(defmethod render ((widget charts-page-widget) (theme tailwind-theme))
  (with-html ()
    (:div :class (join-css-classes theme
                                   (colors-text-normal theme))
      (:h1 :class "text-2xl my-8"
           "Charts")

      (:h2 :class "text-xl my-4"
           "Pie chart")
      (render (pie-chart '(("Alpha" 10)
                           ("Beta" 25)
                           ("Gamma" 15))
                         :title "Tasks by mission"
                         :column-names '("Mission" "Tasks"))
              theme)

      (:h2 :class "text-xl my-4"
           "Donut chart with slice colors")
      (render (pie-chart '(("Admin" 5)
                           ("Editor" 12)
                           ("Viewer" 30)
                           ("Guest" 3))
                         :title "Users by role"
                         :column-names '("Role" "Users")
                         :pie-hole 0.4
                         :slice-colors '("#3366CC"
                                         "#DC3912"
                                         "#FF9900"
                                         "#109618"))
              theme)

      (:h2 :class "text-xl my-4"
           "Column chart")
      (render (column-chart '(("2026-W1" 3)
                              ("2026-W2" 7)
                              ("2026-W3" 5))
                            :title "Users by week"
                            :column-names '("Week" "Users")
                            :x-title "Week"
                            :y-title "Users")
              theme))))
