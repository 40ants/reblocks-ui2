(defsystem "reblocks-ui2-tests"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/reblocks-ui2/"
  :class :package-inferred-system
  :description "Provides tests for reblocks-ui2."
  :source-control (:git "https://github.com/40ants/reblocks-ui2")
  :bug-tracker "https://github.com/40ants/reblocks-ui2/issues"
  :pathname "t"
  :depends-on ("reblocks-ui2-tests/core")
  :perform (test-op (op c)
                    (unless (symbol-call :rove :run c)
                      (error "Tests failed"))))
