(uiop:define-package #:reblocks-ui2/inputs/date-input
  (:use #:cl)
  (:import-from #:reblocks-ui2/form/validators
                #:valid-date)
  (:import-from #:reblocks-ui2/inputs/text-input
                #:input
                #:input-widget)
  (:import-from #:serapeum
                #:->)
  (:export #:date-input))
(in-package #:reblocks-ui2/inputs/date-input)


(-> date-input (&key
                (:widget-class symbol)
                (:name (or null string symbol))
                (:value (or null string))
                (:format (member :iso :ddmmyyyy))
                (:required boolean)
                (:placeholder (or null string))
                (:view (or null symbol))
                (:size (member :s :m :l :xl))
                (:disabled boolean)
                (:error (or null string)))
    (values input-widget &optional))

(defun date-input (&key
                     (widget-class 'input-widget)
                     name
                     value
                     (format :iso)
                     (required t)
                     placeholder
                     (view :normal)
                     (size :m)
                     disabled
                     error)
  "Returns a native HTML date input.

   This is a thin constructor over the usual text INPUT with :TYPE \"date\"
   and a VALID-DATE validator attached.

   VALUE should be a \"YYYY-MM-DD\" string, because this is the format
   browsers use for inputs with type=\"date\".

   FORMAT is passed to VALID-DATE and only controls how the submitted data
   is parsed on the server. By default, the date is required; pass
   :REQUIRED NIL to allow empty values, in which case the validator
   returns NIL."
  (input :widget-class widget-class
         :name name
         :value value
         :type "date"
         :placeholder placeholder
         :view view
         :size size
         :disabled disabled
         :validator (valid-date :format format
                                :required required)
         :error error))
