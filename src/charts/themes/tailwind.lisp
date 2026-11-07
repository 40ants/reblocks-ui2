(uiop:define-package #:reblocks-ui2/charts/themes/tailwind
  (:use #:cl)
  (:import-from #:reblocks/dependencies
                #:make-dependency)
  (:import-from #:reblocks/widgets/dom
                #:dom-id)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:get-dependencies)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:tailwind-theme)
  (:import-from #:reblocks-ui2/charts/chart
                #:chart-widget
                #:chart-title
                #:chart-data
                #:chart-column-names
                #:chart-height
                #:chart-background-color
                #:chart-extra-options)
  (:import-from #:reblocks-ui2/charts/pie-chart
                #:pie-chart
                #:pie-chart-pie-hole
                #:pie-chart-is3d
                #:pie-chart-slice-colors)
  (:import-from #:reblocks-ui2/charts/column-chart
                #:column-chart
                #:column-chart-x-title
                #:column-chart-y-title
                #:column-chart-v-axis-min-zero-p)
  (:import-from #:serapeum
                #:fmt
                #:soft-list-of
                #:->)
  (:import-from #:anaphora
                #:awhen
                #:it)
  (:import-from #:str
                #:replace-all)
  (:import-from #:yason
                #:encode
                #:with-output-to-string*))
(in-package #:reblocks-ui2/charts/themes/tailwind)


(-> %js-string (string)
    (values string &optional))
(defun %js-string (value)
  "Returns VALUE as a single-quoted JavaScript string literal."
  (fmt "'~A'"
       (replace-all "'" "\\'"
                    (replace-all "\\" "\\\\"
                                 value))))


(-> %js-identifier-char-p (character)
    (values boolean &optional))
(defun %js-identifier-char-p (char)
  "Returns true if CHAR is allowed inside a JavaScript identifier."
  (or (alphanumericp char)
      (char= char #\_)))


(defparameter *fallback-id-counter* 0
  "Counter used to generate unique chart container ids when there is no DOM id.

   REBLOCKS/WIDGETS/DOM:DOM-ID returns NIL when there is no session,
   for example, when a widget is rendered in tests. In this case an id
   is generated from this counter to keep chart function names unique.")


(-> %next-fallback-id ()
    (values string &optional))
(defun %next-fallback-id ()
  "Returns a unique chart container id for a widget without a DOM id."
  (fmt "chart-~D" (incf *fallback-id-counter*)))


(-> %js-function-name (string)
    (values string &optional))
(defun %js-function-name (id)
  "Returns a unique drawChart function name for the given DOM id.

   Unlike the donor widgets from the lct25 project, which all define
   a single global drawChart function and work only by accident,
   each chart gets it's own name. Characters which are not allowed
   in JavaScript identifiers are stripped from the id."
  (let ((suffix (remove-if-not #'%js-identifier-char-p
                               id)))
    (if (string= suffix "")
        "drawChart"
        (fmt "drawChart_~A" suffix))))


(-> %chart-rows (chart-widget)
    (values list &optional))
(defun %chart-rows (widget)
  "Returns chart rows, calling DATA when it is a function."
  (let ((data (chart-data widget)))
    (etypecase data
      (function (funcall data))
      (list data))))


(-> %chart-class-name (chart-widget)
    (values string &optional))
(defun %chart-class-name (widget)
  "Returns the name of the Google Charts class to draw the widget with."
  (etypecase widget
    (pie-chart "PieChart")
    (column-chart "ColumnChart")))


(-> %slices-js ((soft-list-of string))
    (values string &optional))
(defun %slices-js (colors)
  "Returns a slices option, assigning a CSS color to each slice."
  (fmt "slices: {~{~A~^, ~}}"
       (loop for color in colors
             for i upfrom 0
             collect (fmt "~A: {color: ~A}"
                          i
                          (%js-string color)))))


(-> %axis-js (&key (:title (or null string)) (:min-zero boolean))
    (values (or null string) &optional))
(defun %axis-js (&key title min-zero)
  "Returns a Google Charts axis option.

   Returns NIL when the axis has neither a title nor a minimal value."
  (let ((parts (append (when min-zero
                         '("minValue: 0"))
                       (when title
                         (list (fmt "title: ~A, titleTextStyle: {color: '#333'}"
                                    (%js-string title)))))))
    (when parts
      (fmt "{~{~A~^, ~}}" parts))))


(-> %chart-specific-options-js (chart-widget)
    (values list &optional))
(defun %chart-specific-options-js (widget)
  "Returns options, specific to the concrete chart type."
  (etypecase widget
    (pie-chart
     (append (list (fmt "pieHole: ~A" (pie-chart-pie-hole widget)))
             (when (pie-chart-is3d widget)
               '("is3D: true"))
             (awhen (pie-chart-slice-colors widget)
               (list (%slices-js it)))))
    (column-chart
     (append (awhen (column-chart-x-title widget)
               (list (fmt "hAxis: ~A" (%axis-js :title it))))
             (awhen (%axis-js :title (column-chart-y-title widget)
                               :min-zero (column-chart-v-axis-min-zero-p widget))
               (list (fmt "vAxis: ~A" it)))))))


(-> %options-js (chart-widget)
    (values string &optional))
(defun %options-js (widget)
  "Returns the JavaScript options object for the widget.

   Typed slots are converted to options and EXTRA-OPTIONS, when given,
   is inserted as a raw JavaScript string before the closing bracket."
  (let ((parts (append (list (fmt "title: ~A" (%js-string (chart-title widget)))
                             (fmt "backgroundColor: ~A"
                                  (%js-string (chart-background-color widget)))
                             "width: '100%'"
                             (fmt "height: ~A" (chart-height widget)))
                       (%chart-specific-options-js widget)
                       (awhen (chart-extra-options widget)
                         (list it)))))
    (fmt "var options = {
  ~{~A~^,
  ~}
  };" parts)))


(defmethod render ((widget chart-widget) (theme tailwind-theme))
  (let* ((height (chart-height widget))
         (column-names (chart-column-names widget))
         (id (or (dom-id widget)
                 (%next-fallback-id)))
         (function-name (%js-function-name id))
         (rows-json (with-output-to-string* ()
                      (encode (%chart-rows widget)))))
    (with-html ()
      ;; Create a div for the chart
      (:div :id id
            :style (fmt "width: 100%; height: ~Apx;" height))
      (:script
       (:raw
        (fmt "google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(~A);

function ~A() {
  var data = new google.visualization.DataTable();
  data.addColumn('string', ~A);
  data.addColumn('number', ~A);
  data.addRows(~A);

  ~A

  var chart = new google.visualization.~A(
    document.getElementById('~A'));
  chart.draw(data, options);
}"
             function-name
             function-name
             (%js-string (first column-names))
             (%js-string (second column-names))
             rows-json
             (%options-js widget)
             (%chart-class-name widget)
             id))))))


(defmethod get-dependencies ((widget chart-widget) (theme tailwind-theme))
  (list* (make-dependency
           "https://www.gstatic.com/charts/loader.js"
           :type :js)
         (call-next-method)))
