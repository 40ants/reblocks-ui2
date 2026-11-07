;;;; Tests for the form validators.
(uiop:define-package #:reblocks-ui2-tests/form/validators
  (:use #:cl)
  (:import-from #:rove
                #:deftest
                #:ok
                #:signals
                #:testing)
  (:import-from #:reblocks-ui2/form/validation
                #:validation-error)
  (:import-from #:reblocks-ui2/form/validators
                #:all
                #:valid-integer))
(in-package #:reblocks-ui2-tests/form/validators)


(deftest test-valid-integer
  "Test that valid-integer parses integer strings and checks the boundaries."
  (testing "Integer values are parsed and passed through."
    (ok (= (funcall (valid-integer) "42")
           42)
        "A numeric string should be parsed into an integer.")
    (ok (= (funcall (valid-integer) 42)
           42)
        "An integer value should be passed through as is."))

  (testing "Garbage signals a validation error."
    (ok (signals (funcall (valid-integer) "abc")
                 'validation-error)
        "A non-numeric string should be rejected."))

  (testing "MIN and MAX boundaries are checked."
    (ok (signals (funcall (valid-integer :min 10) "9")
                 'validation-error)
        "A value lower than MIN should be rejected.")
    (ok (signals (funcall (valid-integer :max 10) "11")
                 'validation-error)
        "A value greater than MAX should be rejected.")
    (ok (= (funcall (valid-integer :min 10 :max 100) "10")
           10)
        "A value equal to MIN should be accepted.")
    (ok (= (funcall (valid-integer :min 10 :max 100) "100")
           100)
        "A value equal to MAX should be accepted."))

  (testing "Empty values are rejected by default."
    (ok (signals (funcall (valid-integer) "")
                 'validation-error)
        "An empty string should be rejected by default.")
    (ok (signals (funcall (valid-integer :min 10) "")
                 'validation-error)
        "An empty string should be rejected even when MIN is given.")))


(deftest test-valid-integer-allow-empty
  "Test that valid-integer with allow-empty returns NIL for empty values."
  (testing "Empty values give NIL without boundary checks."
    (ok (null (funcall (valid-integer :allow-empty t) ""))
        "An empty string should give NIL.")
    (ok (null (funcall (valid-integer :allow-empty t :min 10) ""))
        "MIN should not be applied to an empty string.")
    (ok (null (funcall (valid-integer :allow-empty t :max 10) ""))
        "MAX should not be applied to an empty string.")
    (ok (null (funcall (valid-integer :allow-empty t) nil))
        "A NIL value should also be treated as empty."))

  (testing "Non-empty values are validated as usual."
    (ok (= (funcall (valid-integer :allow-empty t :min 10) "20")
           20)
        "A good value should be parsed into an integer.")
    (ok (signals (funcall (valid-integer :allow-empty t :min 10) "5")
                 'validation-error)
        "MIN should still be applied to a non-empty value.")
    (ok (signals (funcall (valid-integer :allow-empty t) "abc")
                 'validation-error)
        "A garbage string should be rejected even with allow-empty."))

  (testing "ALLOW-EMPTY validators work inside an ALL chain."
    (let ((validator (all (valid-integer :allow-empty t)
                          (valid-integer :allow-empty t :min 10))))
      (ok (null (funcall validator ""))
          "An empty string should pass through the chain as NIL.")
      (ok (= (funcall validator "20")
             20)
          "A non-empty string should be parsed by the whole chain."))))
