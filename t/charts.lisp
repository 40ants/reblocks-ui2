;;;; Chart widget tests follow the reference pattern from
;;;; reblocks-ui2-tests/inputs/date-input: rendering happens inside
;;;; REBLOCKS/HTML:WITH-HTML-STRING wrapped into
;;;; REBLOCKS/PAGE-DEPENDENCIES:WITH-COLLECTED-DEPENDENCIES, so that
;;;; no real HTTP request is needed.
(uiop:define-package #:reblocks-ui2-tests/charts
  (:use #:cl)
  (:import-from #:rove
                #:deftest
                #:ok)
  (:import-from #:reblocks/html
                #:with-html-string)
  (:import-from #:reblocks/page-dependencies
                #:with-collected-dependencies)
  (:import-from #:reblocks/dependencies
                #:dependency-url)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:get-dependencies)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:make-tailwind-theme)
  (:import-from #:reblocks-ui2/charts/pie-chart
                #:pie-chart)
  (:import-from #:reblocks-ui2/charts/column-chart
                #:column-chart)
  (:import-from #:str
                #:count-substring))
(in-package #:reblocks-ui2-tests/charts)


(defun render-chart (widget)
  "Returns HTML, produced by rendering a single chart widget."
  (with-collected-dependencies ()
    (with-html-string ()
      (render widget
              (make-tailwind-theme)))))


(deftest test-pie-chart-render
  "Test that pie-chart renders Google Charts JavaScript."
  (let ((html (render-chart (pie-chart '(("Alpha" 10)
                                         ("Beta" 25))
                                       :title "Tasks by mission"
                                       :column-names '("Mission" "Tasks")))))
    (ok (search "google.charts.load" html)
        "Rendered widget should load the Google Charts library.")
    (ok (search "PieChart" html)
        "Rendered widget should use the PieChart class.")
    (ok (search "\"Alpha\"" html)
        "Rendered widget should contain data labels as JSON strings.")
    (ok (search "Tasks by mission" html)
        "Rendered widget should contain the title.")
    (ok (search "drawChart_" html)
        "Rendered widget should define a unique drawChart function.")))


(deftest test-column-chart-render
  "Test that column-chart renders Google Charts JavaScript."
  (let ((html (render-chart (column-chart '(("2026-W1" 3)
                                            ("2026-W2" 7))
                                          :title "Users by week"
                                          :column-names '("Week" "Users")
                                          :x-title "Week"
                                          :y-title "Users"))))
    (ok (search "ColumnChart" html)
        "Rendered widget should use the ColumnChart class.")
    (ok (search "hAxis" html)
        "Rendered widget should contain the hAxis option.")
    (ok (search "vAxis" html)
        "Rendered widget should contain the vAxis option.")
    (ok (search "minValue: 0" html)
        "By default the vertical axis should start at zero.")))


(defun draw-chart-function-names (html)
  "Returns names of all drawChart functions defined in the HTML."
  (loop with marker = "function drawChart_"
        for pos = (search marker html)
          then (search marker html :start2 next)
        while pos
        for name-start = (+ pos (length "function "))
        for name-end = (position #\( html :start name-start)
        for next = (1+ name-end)
        collect (subseq html name-start name-end)))


(deftest test-chart-function-names-are-unique
  "Test that two charts rendered together define two different drawChart functions."
  (let* ((first-chart (pie-chart '(("Alpha" 10))))
         (second-chart (pie-chart '(("Beta" 20))))
         (html (with-collected-dependencies ()
                 (with-html-string ()
                   (render first-chart (make-tailwind-theme))
                   (render second-chart (make-tailwind-theme)))))
         (names (draw-chart-function-names html)))
    (ok (= 2 (length names))
        "Two chart widgets should define two drawChart functions.")
    (ok (= 2 (length (remove-duplicates names :test #'string=)))
        "The two drawChart function names should not collide.")
    (ok (every (lambda (name)
                 (= 2 (count-substring name html)))
               names)
        "Each function name should be defined once and used in setOnLoadCallback once.")))


(deftest test-chart-data-as-function
  "Test that DATA may be a function called on render."
  (let ((html (render-chart (pie-chart (lambda ()
                                         '(("A" 1)))))))
    (ok (search "\"A\"" html)
        "Data returned by the function should be rendered into the chart.")))


(deftest test-pie-chart-slice-colors
  "Test that SLICE-COLORS are rendered into the slices option."
  (let ((html (render-chart (pie-chart '(("Alpha" 10)
                                         ("Beta" 25))
                                       :slice-colors '("#3366CC"
                                                       "#DC3912")))))
    (ok (search "slices" html)
        "Rendered widget should contain the slices option.")
    (ok (search "#3366CC" html)
        "The first slice color should be used for the first slice.")
    (ok (search "#DC3912" html)
        "The second slice color should be used for the second slice.")))


(deftest test-chart-dependencies
  "Test that charts depend on the Google Charts loader."
  (let* ((widget (pie-chart '(("Alpha" 10))))
         (urls (mapcar #'dependency-url
                       (get-dependencies widget
                                         (make-tailwind-theme)))))
    (ok (some (lambda (url)
                (search "gstatic" url))
              urls)
        "Chart dependencies should include the gstatic loader.js URL.")
    (ok (some (lambda (url)
                (search "cdn.tailwindcss.com" url))
              urls)
        "Chart dependencies should still include the Tailwind CDN.")))
