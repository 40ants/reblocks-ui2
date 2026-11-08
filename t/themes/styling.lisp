(defpackage #:reblocks-ui2-tests/themes/styling
  (:use #:cl)
  (:import-from #:rove
                #:deftest
                #:testing
                #:ok)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes
                #:merge-css-classes
                #:collect-css-classes))
(in-package #:reblocks-ui2-tests/themes/styling)


(defclass test-theme ()
  ()
  (:documentation "A simple test theme class."))


(defclass test-theme-with-merge ()
  ()
  (:documentation "Theme class which adds a suffix on merge."))


(defmethod merge-css-classes ((theme test-theme-with-merge) classes)
  (mapcar (lambda (x) (concatenate 'string x "-merged")) classes))


(deftest test-join-css-classes-basic
  "Test that join-css-classes works with basic string inputs."
  (let ((theme (make-instance 'test-theme)))
    (ok (string= (join-css-classes theme "class1" "class2")
                 "class1 class2")
        "Basic joining of two classes should work")
    (ok (string= (join-css-classes theme "single-class")
                 "single-class")
        "Single class should work")
    (ok (string= (join-css-classes theme)
                 "")
        "No classes should return empty string")))


(deftest test-join-css-classes-with-merging
  "Test that join-css-classes works with the merge-css-classes function."
  
  (let ((theme (make-instance 'test-theme-with-merge)))
    (ok (string= (join-css-classes theme "class1" "class2")
                 "class1-merged class2-merged")
        "Classes should be merged before joining")))


(deftest test-collect-css-classes-basic
  "Test that collect-css-classes works with basic inputs."
  (let ((theme (make-instance 'test-theme)))
    (ok (equal (collect-css-classes theme '("class1" "class2"))
               '("class1" "class2"))
        "Basic list of classes should be collected")
    (ok (equal (collect-css-classes theme '("class1" ("class2" "class3")))
               '("class1" "class2" "class3"))
        "Nested lists should be flattened")
    (ok (equal (collect-css-classes theme '())
               '())
        "Empty input should return empty list")))
