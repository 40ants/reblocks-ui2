;;;; This file also defines the reference pattern ("эталонный паттерн")
;;;; for testing how reblocks-ui2 widgets render outside of a real HTTP request:
;;;;
;;;;   (reblocks/page-dependencies:with-collected-dependencies ()
;;;;     (reblocks/html:with-html-string ()
;;;;       (reblocks-ui2/widget:render widget
;;;;                                   (reblocks-ui2/themes/tailwind:make-tailwind-theme))))
;;;;
;;;; No request or session context is needed: widget registration and form input
;;;; registration silently do nothing when there is no current page or form.
;;;;
;;;; Also note: package-inferred ASDF loads only the modules imported by this
;;;; package, but tailwind RENDER methods are spread over multiple modules
;;;; (e.g. the CSS-CLASSES method for PIN lives in the buttons theme module).
;;;; That is why the REBLOCKS-UI2-TESTS system depends on the whole
;;;; REBLOCKS-UI2-TAILWIND system. Without it widgets will be rendered
;;;; by the fallback method, which just prints "Please, define:" advice.
(uiop:define-package #:reblocks-ui2-tests/inputs/date-input
  (:use #:cl)
  (:import-from #:rove
                #:deftest
                #:ok
                #:signals
                #:testing)
  (:import-from #:local-time
                #:encode-timestamp
                #:timestamp=
                #:timestamp-year)
  (:import-from #:reblocks/html
                #:with-html-string)
  (:import-from #:reblocks/page-dependencies
                #:with-collected-dependencies)
  (:import-from #:reblocks-ui2/form/validation
                #:validation-error)
  (:import-from #:reblocks-ui2/form/validators
                #:valid-date
                #:format-date)
  (:import-from #:reblocks-ui2/inputs/date-input
                #:date-input)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:make-tailwind-theme)
  (:import-from #:reblocks-ui2/widget
                #:render))
(in-package #:reblocks-ui2-tests/inputs/date-input)


(defun test-timestamp ()
  "Returns a timestamp denoting the 2025-11-07 date."
  (encode-timestamp 0 0 0 0 7 11 2025 :offset 0))


(deftest test-valid-date
  "Test that valid-date validator parses valid dates and rejects everything else."
  (testing "Valid dates are parsed into timestamps."
    (ok (timestamp= (funcall (valid-date) "2025-11-07")
                    (test-timestamp))
        "A valid ISO date should be parsed into the corresponding timestamp.")
    (ok (timestamp= (funcall (valid-date :format :ddmmyyyy) "07.11.2025")
                    (test-timestamp))
        "A valid DD.MM.YYYY date should be parsed into the corresponding timestamp."))

  (testing "Garbage input signals a validation error."
    (ok (signals (funcall (valid-date) "abc")
                 'validation-error)
        "A string without separators should be rejected.")
    (ok (signals (funcall (valid-date :format :ddmmyyyy) "1.2.3")
                 'validation-error)
        "Parts of a wrong length should be rejected.")
    (ok (signals (funcall (valid-date) "2025/01/01")
                 'validation-error)
        "A wrong separator should be rejected."))

  (testing "Non-existent dates signal a validation error."
    (ok (signals (funcall (valid-date) "2025-02-31")
                 'validation-error)
        "February 31 should be rejected in ISO format.")
    (ok (signals (funcall (valid-date :format :ddmmyyyy) "31.02.2025")
                 'validation-error)
        "February 31 should be rejected in DD.MM.YYYY format."))

  (testing "Empty values."
    (ok (signals (funcall (valid-date) "")
                 'validation-error)
        "An empty string should be rejected when the date is required.")
    (ok (null (funcall (valid-date :required nil) ""))
        "An empty string should give NIL when the date is not required.")))


(deftest test-format-date
  "Test that format-date formats timestamps into date strings."
  (let ((timestamp (test-timestamp)))
    (ok (string= (format-date timestamp :format :iso)
                 "2025-11-07")
        "A timestamp should be formatted as YYYY-MM-DD.")
    (ok (string= (format-date timestamp :format :ddmmyyyy)
                 "07.11.2025")
        "A timestamp should be formatted as DD.MM.YYYY.")
    (ok (string= (format-date timestamp)
                 "2025-11-07")
        "The ISO format should be the default.")
    (ok (string= (format-date nil)
                 "")
        "A NIL timestamp should be formatted as an empty string.")
    (ok (= (timestamp-year (funcall (valid-date)
                                    (format-date timestamp)))
           2025)
        "A formatted date should be parseable back by the valid-date validator.")))


(deftest test-date-input-render
  "Test that date-input renders a native HTML date input."
  (let* ((widget (date-input :name "birthday"
                             :value "2025-11-07"))
         (html (with-collected-dependencies ()
                 (with-html-string ()
                   (render widget
                           (make-tailwind-theme))))))
    (ok (search "type=date" html)
        "Rendered widget should contain an input with type=date.")
    (ok (search "value=2025-11-07" html)
        "Rendered widget should contain the given date value.")
    (ok (search "name=birthday" html)
        "Rendered widget should contain the input name.")))
