(uiop:define-package #:reblocks-ui2/charts/chart
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks-ui2/widget
                #:ui-widget)
  (:import-from #:reblocks-ui2/utils/size
                #:size
                #:size-value
                #:responsive-height)
  (:export #:chart-widget
           #:chart-title
           #:chart-data
           #:chart-column-names
           #:chart-height
           #:chart-background-color
           #:chart-extra-options))
(in-package #:reblocks-ui2/charts/chart)


(defwidget chart-widget (ui-widget)
  ((title :initarg :title
          :type string
          :initform ""
          :reader chart-title
          :documentation "A chart title rendered at the top of the chart by Google Charts.")
   (data :initarg :data
         :type (or list function)
         :reader chart-data
         :documentation "Chart rows, each of the form (LABEL NUMBER-VALUE).

                         Alternatively, this may be a function of zero arguments.
                         It is called on each render, so that charts always show
                         fresh data.")
   (column-names :initarg :column-names
                 :type list
                 :initform '("Label" "Value")
                 :reader chart-column-names
                 :documentation "Names of the two DataTable columns, as strings.")
   (height :initarg :height
           :type integer
           :initform 500
           :reader chart-height
           :documentation "Chart height in pixels.")
   (background-color :initarg :background-color
                     :type string
                     :initform "#f9f9f9"
                     :reader chart-background-color
                     :documentation "CSS color of the area around the chart.")
   (extra-options :initarg :extra-options
                  :type (or null string)
                  :initform nil
                  :reader chart-extra-options
                  :documentation "Raw JavaScript, inserted into the Google Charts options object
                                  before the closing bracket. Use it for options which are not
                                  covered by typed slots, like \"legend: {position: 'none'}\"."))
  (:documentation "Base class for chart widgets rendered by Google Charts.

                   Subclasses such as REBLOCKS-UI2/CHARTS/PIE-CHART:PIE-CHART and
                   REBLOCKS-UI2/CHARTS/COLUMN-CHART:COLUMN-CHART define chart type
                   specific options, theming methods do the rendering."))


(defmethod initialize-instance :after ((widget chart-widget) &key &allow-other-keys)
  "Normalize the HEIGHT slot to an integer number of pixels.

   The :AROUND method of UI-WIDGET converts a numeric :HEIGHT argument
   into a REBLOCKS-UI2/UTILS/SIZE:HEIGHT object, but charts need the raw
   integer to build Google Charts options and the container's style."
  (let ((value (slot-value widget 'height)))
    (etypecase value
      (integer)
      (size
       (let ((pixels (size-value value)))
         (etypecase pixels
           (integer
            (setf (slot-value widget 'height)
                  pixels))
           (t
            (error "Chart height should be an integer number of pixels, but got ~S"
                   pixels)))))
      (responsive-height
       (error "Chart height should be an integer number of pixels, but got a responsive height: ~S"
              value)))))
