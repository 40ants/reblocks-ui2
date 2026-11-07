(uiop:define-package #:reblocks-ui2/charts/pie-chart
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks-ui2/charts/chart
                #:chart-widget)
  (:import-from #:alexandria
                #:remove-from-plist)
  (:import-from #:serapeum
                #:soft-list-of
                #:->)
  (:export #:pie-chart
           #:pie-chart-pie-hole
           #:pie-chart-is3d
           #:pie-chart-slice-colors))
(in-package #:reblocks-ui2/charts/pie-chart)


(defwidget pie-chart (chart-widget)
  ((pie-hole :initarg :pie-hole
             :type (real 0 1)
             :initform 0
             :reader pie-chart-pie-hole
             :documentation "A number between 0 and 1, describing what fraction of the radius
                             to cut out from the center. 0 gives a usual pie chart,
                             0.4 gives a donut chart.")
   (is3d :initarg :is3d
         :type boolean
         :initform nil
         :reader pie-chart-is3d
         :documentation "When true, the chart is rendered with pseudo-3D effect.")
   (slice-colors :initarg :slice-colors
                 :type (soft-list-of string)
                 :initform nil
                 :reader pie-chart-slice-colors
                 :documentation "A list of CSS colors, applied to the slices in order.
                                 When nil, Google Charts default colors are used."))
  (:documentation "A pie chart widget rendered by Google Charts.

                   The PIE-CHART symbol names both this class and a constructor
                   function, following the donor widgets from the lct25 project."))


(-> pie-chart ((or list function)
               &key
               (:title string)
               (:column-names list)
               (:height integer)
               (:background-color string)
               (:extra-options (or null string))
               (:pie-hole (real 0 1))
               (:is3d boolean)
               (:slice-colors (soft-list-of string))
               (:widget-class symbol))
    (values pie-chart &optional))

(defun pie-chart (data &rest restargs
                    &key title column-names height background-color extra-options
                      pie-hole is3d slice-colors
                      (widget-class 'pie-chart))
  "Returns a pie chart widget rendered by Google Charts.

   DATA is either a list of rows of the form (LABEL NUMBER-VALUE),
   or a function of zero arguments returning such a list. The function
   is called on each render to fetch fresh data.

   PIE-HOLE is a number between 0 and 1, cut out from the center
   (0 for a usual pie chart, 0.4 for a donut).

   IS3D turns on the pseudo-3D effect.

   SLICE-COLORS is a list of CSS colors applied to the slices in order.

   EXTRA-OPTIONS is a raw JavaScript string, inserted into the Google
   Charts options object before the closing bracket.

   WIDGET-CLASS may be a subclass of PIE-CHART to instantiate instead."
  (declare (ignore title column-names height background-color extra-options
                   pie-hole is3d slice-colors))
  (apply #'make-instance widget-class
         :data data
         (remove-from-plist restargs :widget-class)))
