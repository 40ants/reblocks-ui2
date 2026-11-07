(uiop:define-package #:reblocks-ui2/charts/column-chart
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks-ui2/charts/chart
                #:chart-widget)
  (:import-from #:alexandria
                #:remove-from-plist)
  (:import-from #:serapeum
                #:->)
  (:export #:column-chart
           #:column-chart-x-title
           #:column-chart-y-title
           #:column-chart-v-axis-min-zero-p))
(in-package #:reblocks-ui2/charts/column-chart)


(defwidget column-chart (chart-widget)
  ((x-title :initarg :x-title
            :type (or null string)
            :initform nil
            :reader column-chart-x-title
            :documentation "A title for the horizontal axis. When nil, the axis has no title.")
   (y-title :initarg :y-title
            :type (or null string)
            :initform nil
            :reader column-chart-y-title
            :documentation "A title for the vertical axis. When nil, the axis has no title.")
   (v-axis-min-zero :initarg :v-axis-min-zero
                    :type boolean
                    :initform t
                    :reader column-chart-v-axis-min-zero-p
                    :documentation "When true (the default), the vertical axis starts at zero,
                                    like vAxis.minValue = 0 in Google Charts."))
  (:documentation "A column chart widget rendered by Google Charts.

                   The COLUMN-CHART symbol names both this class and a constructor
                   function, following the donor widgets from the lct25 project."))


(-> column-chart ((or list function)
                  &key
                  (:title string)
                  (:column-names list)
                  (:height integer)
                  (:background-color string)
                  (:extra-options (or null string))
                  (:x-title (or null string))
                  (:y-title (or null string))
                  (:v-axis-min-zero boolean)
                  (:widget-class symbol))
    (values column-chart &optional))

(defun column-chart (data &rest restargs
                       &key title column-names height background-color extra-options
                         x-title y-title v-axis-min-zero
                         (widget-class 'column-chart))
  "Returns a column chart widget rendered by Google Charts.

   DATA is either a list of rows of the form (LABEL NUMBER-VALUE),
   or a function of zero arguments returning such a list. The function
   is called on each render to fetch fresh data.

   X-TITLE and Y-TITLE add titles to the horizontal and vertical axes.

   V-AXIS-MIN-ZERO (the default) makes the vertical axis start at zero.

   EXTRA-OPTIONS is a raw JavaScript string, inserted into the Google
   Charts options object before the closing bracket.

   WIDGET-CLASS may be a subclass of COLUMN-CHART to instantiate instead."
  (declare (ignore title column-names height background-color extra-options
                   x-title y-title v-axis-min-zero))
  (apply #'make-instance widget-class
         :data data
         (remove-from-plist restargs :widget-class)))
