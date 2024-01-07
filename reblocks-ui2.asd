#-asdf3.1 (error "reblocks-ui2 requires ASDF 3.1 because for lower versions pathname does not work for package-inferred systems.")
(defsystem "reblocks-ui2"
  :description "A pack of UI components for Reblocks web-framework."
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/reblocks-ui2/"
  :source-control (:git "https://github.com/40ants/reblocks-ui2")
  :bug-tracker "https://github.com/40ants/reblocks-ui2/issues"
  :class :40ants-asdf-system
  :defsystem-depends-on ("40ants-asdf-system")
  :pathname "src"
  :depends-on ("reblocks-ui2/core"
               "reblocks-ui2/containers/stack"
               "reblocks-ui2/tables/clickable-row"
               ;; And we need to explicitly specify this dependency
               ;; to load all necessary components of Reblocks.
               ;; Otherwise possible some strange errors like:
               ;; https://github.com/40ants/reblocks/issues/47
               "reblocks")
  :in-order-to ((test-op (test-op "reblocks-ui2-tests"))))
