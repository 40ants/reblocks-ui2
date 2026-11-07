(uiop:define-package #:reblocks-ui2/form/validators
  (:use #:cl)
  (:import-from #:reblocks-ui2/form/validation
                #:validation-error)
  (:import-from #:alexandria
                #:length=
                #:rcurry)
  (:import-from #:local-time
                #:format-timestring
                #:parse-timestring
                #:timestamp)
  (:import-from #:serapeum
                #:->)
  (:import-from #:str
                #:emptyp)
  (:export #:valid-string
           #:valid-integer
           #:all
           #:valid-password
           #:valid-date
           #:format-date))
(in-package #:reblocks-ui2/form/validators)


(defun valid-string (&key (min-length 1)
                          max-length)
  (flet ((valid-string-validator (value)
           (unless (typep value 'string)
             (error 'validation-error
                    :error-message "Value has wrong type: ~A."
                    :error-args (list (type-of value))))
  
           (let ((length (length value)))
             (when (and min-length
                        (< length min-length))
               (error 'validation-error
                      :error-message "Value should have at least ~A symbols."
                      :error-args (list min-length)))
             (when (and max-length
                        (< max-length length))
               (error 'validation-error
                      :error-message "Value should have no more than ~A symbols."
                      :error-args (list max-length))))
           (values value)))
    #'valid-string-validator))


(defun hash-chars (string)
  (loop with result = (make-hash-table)
        for char across string
        do (setf (gethash char result) 1)
        finally (return result)))


(defun valid-password (&key (min-length 10)
                            max-length
                            required-symbols
                            error)
  (let ((required-symbols
          (loop for (required-count . chars) in required-symbols
                collect (list required-count
                              chars
                              (hash-chars chars)))))
    
    (flet ((valid-password-validator (value)
             (loop for (required-count chars chars-hash) in required-symbols
                   for real-count = (count-if (rcurry #'gethash chars-hash)
                                              value)
                   when (< real-count required-count)
                   do (error 'validation-error
                             :error-message (if error
                                                error
                                                "Value should have at least ~A symbols from \"~A\".")
                             :error-args (list required-count chars)))
             (values value)))
      (all (valid-string :min-length min-length
                         :max-length max-length)
           #'valid-password-validator))))


(defun valid-integer (&key min
                           max)
  (flet ((valid-integer-validator (value)
           (let ((number (etypecase value
                           (null nil)
                           (string (ignore-errors (parse-integer value)))
                           (integer value))))
             (unless number
               (error 'validation-error
                      :error-message "Value is not an integer."))
             (when (and min
                        (< number min))
               (error 'validation-error
                      :error-message "Value should be greater or equal to ~A."
                      :error-args (list min)))
             (when (and max
                        (< max number))
               (error 'validation-error
                      :error-message "Value should be lower or equal to ~A."
                      :error-args (list max)))
             (values number))))
    #'valid-integer-validator))


(defun all (&rest validators)
  "Combines a multiple validators into a chain where every subsequent validator validates output of the previous one."
  (flet ((all-validator (value)
           (loop with current-value = value
                 for func in validators
                 do (setf current-value
                          (funcall func current-value))
                 finally (return current-value))))
    #'all-validator))


(-> parse-date-parts (string character list)
    (values (or null (cons integer (cons integer (cons integer null)))) &optional))

(defun parse-date-parts (string separator lengths)
  "Splits STRING by SEPARATOR into three integer parts.

   Each part should be non-empty, consist only of digits and have the length
   given at the corresponding position of LENGTHS list. Returns NIL when
   any of these checks fails."
  (let ((parts (uiop:split-string string
                                  :separator (string separator))))
    (and (length= 3 parts)
         (every (lambda (part length)
                  (and (= (length part) length)
                       (every #'digit-char-p part)))
                parts
                lengths)
         (mapcar #'parse-integer parts))))


(-> date-parts (string (member :iso :ddmmyyyy))
    (values (or null (cons integer (cons integer (cons integer null)))) &optional))

(defun date-parts (value format)
  "Returns (YEAR MONTH DAY) integers for a date string in given FORMAT.

   Returns NIL when the string does not match the format."
  (ecase format
    (:iso (parse-date-parts value #\- '(4 2 2)))
    (:ddmmyyyy (let ((parts (parse-date-parts value #\. '(2 2 4))))
                 (and parts
                      (list (third parts)
                            (second parts)
                            (first parts)))))))


(-> valid-date (&key (:format (member :iso :ddmmyyyy))
                     (:required boolean))
    (values (function (t) (values (or null timestamp) &optional)) &optional))

(defun valid-date (&key (format :iso)
                     (required t))
  "Returns a validator converting a date string into a local-time timestamp.

   Two formats are supported:

   - :ISO (default) expects \"YYYY-MM-DD\" strings. This is a native format
     of the HTML inputs with type=\"date\".
   - :DDMMYYYY expects \"DD.MM.YYYY\" strings.

   When VALUE is empty and REQUIRED is NIL, the resulting validator returns NIL.
   An empty VALUE with the default REQUIRED = T signals a VALIDATION-ERROR,
   as well as a VALUE which does not match the format or denotes
   a non-existent date like 2025-02-31."
  (flet ((valid-date-validator (value)
           (cond
             ((and (emptyp value)
                   (not required))
              (values nil))
             ((emptyp value)
              (error 'validation-error
                     :error-message "Value is required."))
             (t
              (let ((parts (date-parts value format)))
                (unless parts
                  (error 'validation-error
                         :error-message "Value should be a date in ~A format."
                         :error-args (list (ecase format
                                            (:iso "YYYY-MM-DD")
                                            (:ddmmyyyy "DD.MM.YYYY")))))
                (let ((iso (format nil "~4,'0d-~2,'0d-~2,'0d"
                                   (first parts)
                                   (second parts)
                                   (third parts))))
                  (or (handler-case (parse-timestring iso)
                        (error ()
                          (values nil)))
                      (validation-error "Value should be a real calendar date."))))))))
    #'valid-date-validator))


(-> format-date ((or null timestamp) &key (:format (member :iso :ddmmyyyy)))
    (values string &optional))

(defun format-date (timestamp &key (format :iso))
  "Formats TIMESTAMP as a date string.

   Supported formats are the same as for VALID-DATE:

   - :ISO (default) returns \"YYYY-MM-DD\" strings.
   - :DDMMYYYY returns \"DD.MM.YYYY\" strings.

   A NIL TIMESTAMP is formatted as an empty string, so that the result
   can be used as an input widget's value."
  (cond
    (timestamp
     (format-timestring nil timestamp
                        :format (ecase format
                                  (:iso '((:year 4) #\- (:month 2) #\- (:day 2)))
                                  (:ddmmyyyy '((:day 2) #\. (:month 2) #\. (:year 4))))))
    (t
     "")))
