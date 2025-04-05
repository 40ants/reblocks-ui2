(uiop:define-package #:reblocks-ui2-docs/changelog
  (:use #:cl)
  (:import-from #:40ants-doc/changelog
                #:defchangelog))
(in-package #:reblocks-ui2-docs/changelog)


(defchangelog (:ignore-words ("SLY"
                              "ASDF"
                              "REPL"
                              "CSS"
                              "HTTP"))
  (0.2.0 2024-04-04
         "
## Changes

* Allow to set current theme using SETF on REBLOCKS-UI2/THEMES/API:CURRENT-THEME function.
* Now TailwindCSS theme automatically loads https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4 JavaScript dependency.")
  (0.1.0 2023-02-05
         "* Initial version."))
