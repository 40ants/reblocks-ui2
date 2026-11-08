(defsystem "reblocks-ui2-tests"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/reblocks-ui2/"
  :class :package-inferred-system
  :description "Provides tests for reblocks-ui2."
  :source-control (:git "https://github.com/40ants/reblocks-ui2")
  :bug-tracker "https://github.com/40ants/reblocks-ui2/issues"
  :pathname "t"
  :depends-on (;; This module defines the primary REBLOCKS/WIDGET:RENDER method
               ;; and the SPINNERET:HTML method for widgets. They are required
               ;; to render widgets from REBLOCKS/WIDGET:UPDATE, called by the
               ;; CRUD table's callbacks. Usually this module is loaded together
               ;; with the root "reblocks" system, but the test system only loads
               ;; reblocks-ui2 modules and theme methods.
               "reblocks/widgets/render-methods"
               "reblocks-ui2-tailwind"
               "reblocks-ui2-tests/core"
               "reblocks-ui2-tests/form/confirm"
               "reblocks-ui2-tests/form/validators"
               "reblocks-ui2-tests/inputs/date-input"
               "reblocks-ui2-tests/tables/crud"
               "reblocks-ui2-tests/charts"
               "reblocks-ui2-tests/themes/styling")
  :perform (test-op (op c)
                    (unless (symbol-call :rove :run c)
                      (error "Tests failed"))))
