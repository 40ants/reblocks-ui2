#-asdf3.1 (error "reblocks-ui2 requires ASDF 3.1 because for lower versions pathname does not work for package-inferred systems.")
(defsystem "reblocks-ui2-tailwind"
  :description "A pack of UI components for Reblocks web-framework."
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/reblocks-ui2/"
  :source-control (:git "https://github.com/40ants/reblocks-ui2")
  :bug-tracker "https://github.com/40ants/reblocks-ui2/issues"
  :class :40ants-asdf-system
  :defsystem-depends-on ("40ants-asdf-system")
  :pathname "src"
  :depends-on ("reblocks-ui2/tables/themes/tailwind/table"
               "reblocks-ui2/widget/themes/tailwind"
               "reblocks-ui2/tables/themes/tailwind/editable-table"
               "reblocks-ui2/containers/row/themes/tailwind"
               "reblocks-ui2/containers/column/themes/tailwind"
               "reblocks-ui2/inputs/text-input/themes/tailwind"
               "reblocks-ui2/themes/tailwind/padding"
               "reblocks-ui2/card/themes/tailwind"
               "reblocks-ui2/form/themes/tailwind"
               "reblocks-ui2/themes/tailwind/size"
               "reblocks-ui2/containers/controls-row/themes/tailwind"
               "reblocks-ui2/icon/themes/tailwind"
               "reblocks-ui2/buttons/themes/tailwind"))
