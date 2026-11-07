;;;; Tests for the CONFIRM form widget.
;;;;
;;;; Rendering is tested with the reference pattern, described
;;;; in the t/inputs/date-input.lisp file:
;;;;
;;;;   (reblocks/page-dependencies:with-collected-dependencies ()
;;;;     (reblocks/html:with-html-string ()
;;;;       (reblocks-ui2/widget:render widget
;;;;                                   (reblocks-ui2/themes/tailwind:make-tailwind-theme))))
(uiop:define-package #:reblocks-ui2-tests/form/confirm
  (:use #:cl)
  (:import-from #:rove
                #:deftest
                #:ok
                #:testing)
  (:import-from #:reblocks/html
                #:with-html-string)
  (:import-from #:reblocks/page-dependencies
                #:with-collected-dependencies)
  (:import-from #:reblocks/session
                #:with-session)
  (:import-from #:reblocks-ui2/form
                #:form-on-submit)
  (:import-from #:reblocks-ui2/form/confirm
                #:confirm)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:make-tailwind-theme)
  (:import-from #:reblocks-ui2/widget
                #:render))
(in-package #:reblocks-ui2-tests/form/confirm)


(defun count-substring (needle haystack)
  "Returns the number of non-overlapping NEEDLE occurrences in HAYSTACK."
  (loop with start = 0
        for pos = (search needle haystack :start2 start)
        while pos
        count t
        do (setf start (+ pos (length needle)))))


(defun render-confirm (widget)
  "Renders the widget like it happens inside a real application.

   Unlike simple inputs, a form widget creates a Reblocks action on
   render and this requires a session, that is why we fake a Lack
   environment with an empty session hash-table here."
  (reblocks/session:with-session ((list :lack.session
                                        (make-hash-table)))
    (with-collected-dependencies ()
      (with-html-string ()
        (render widget
                (make-tailwind-theme))))))


(deftest test-confirm-render
  "Test that confirm renders a question and two submit buttons."
  (let* ((widget (confirm "Delete this campaign?"
                          :confirm-button-title "Yes, delete"
                          :cancel-button-title "Keep it"))
         (html (render-confirm widget)))
    (testing "The question and both button titles are rendered."
      (ok (search "Delete this campaign?" html)
          "The question should be rendered.")
      (ok (search "Yes, delete" html)
          "The confirm button title should be rendered.")
      (ok (search "Keep it" html)
          "The cancel button title should be rendered."))

    (testing "Buttons submit their values under the shared name."
      (ok (= 2 (count-substring "name=button" html))
          "Both buttons should have the name \"button\".")
      (ok (search "value=submit" html)
          "The confirm button should submit the \"submit\" value.")
      (ok (search "value=cancel" html)
          "The cancel button should submit the \"cancel\" value.")
      (ok (= 2 (count-substring "type=submit" html))
          "Both buttons should have type=\"submit\"."))

    (testing "Rendering is done by real theme methods."
      (ok (not (search "Please, define" html))
          "The markup should not contain fallback render advices."))

    (testing "The confirm button goes before the cancel button."
      ;; This is what makes Enter in the form confirm the action.
      (let ((confirm-pos (search "Yes, delete" html))
            (cancel-pos (search "Keep it" html)))
        (ok (and confirm-pos
                 cancel-pos
                 (< confirm-pos cancel-pos))
            "The confirm button should go first in the HTML.")))))


(deftest test-confirm-on-submit
  "Test that the form's on-submit action calls on-confirm only for the confirm button."
  (let* ((calls '())
         (widget (confirm "Delete this campaign?"
                          :on-confirm
                          (lambda (form)
                            (push form calls)))))
    ;; Render the form first, to register the buttons as form inputs,
    ;; exactly like it happens when the form is shown in the browser:
    (render-confirm widget)

    (let ((on-submit (form-on-submit widget)))
      (testing "Submitting with the confirm button calls on-confirm."
        ;; Reblocks converts form data keys into uppercase keywords
        ;; and applies the plist to the action handler:
        (apply on-submit '(:BUTTON "submit"))
        (ok (= 1 (length calls))
            "ON-CONFIRM should be called exactly once.")
        (ok (eq widget (first calls))
            "ON-CONFIRM should receive the form widget as it's argument."))

      (testing "Submitting with the cancel button does not call on-confirm."
        (apply on-submit '(:BUTTON "cancel"))
        (ok (= 1 (length calls))
            "ON-CONFIRM should not be called for the \"cancel\" value."))

      (testing "Foreign button values are ignored."
        (apply on-submit '(:BUTTON "remove-everything"))
        (ok (= 1 (length calls))
            "ON-CONFIRM should not be called for other values.")))))
