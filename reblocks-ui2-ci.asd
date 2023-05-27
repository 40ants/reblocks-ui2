(defsystem "reblocks-ui2-ci"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/reblocks-ui2/"
  :class :package-inferred-system
  :description "Provides CI settings for reblocks-ui2."
  :source-control (:git "https://github.com/40ants/reblocks-ui2")
  :bug-tracker "https://github.com/40ants/reblocks-ui2/issues"
  :pathname "src"
  :depends-on ("40ants-ci"
               "reblocks-ui2-ci/ci"))
