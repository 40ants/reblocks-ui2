(uiop:define-package #:reblocks-ui2/events
  (:use #:cl)
  (:import-from #:event-emitter
                #:event-emitter)
  (:import-from #:reblocks/widget
                #:defwidget
                #:widget)
  (:export #:event-emitting-widget))
(in-package #:reblocks-ui2/events)


(defwidget event-emitting-widget (event-emitter widget)
  ())
