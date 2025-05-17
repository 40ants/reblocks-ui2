(uiop:define-package #:reblocks-ui2/form/validators
  (:use #:cl)
  (:import-from #:reblocks-ui2/form/validation
                #:validation-error)
  (:import-from #:alexandria
                #:rcurry)
  (:export #:valid-string
           #:valid-integer
           #:all
           #:valid-password))
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
