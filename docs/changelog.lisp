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
  (0.4.0 2026-04-26
         "
## Changes

* Table cells which are NIL will be skipped - `<td>` element is not rendered for them.
* Your `cell-maker` function now may return objects of class REBLOCKS-UI2/TABLES/CELL:CELL
  to add `colspan` or `rowspan` property.
* Default cell-maker function now transforms lists to REBLOCKS-UI2/TABLES/CELL:CELL class objects
  by applying the list to the REBLOCKS-UI2/TABLES/CELL:CELL function.

  Here is an example of table with spans:

  ```
  (make-table (list (column \"Name\")
                    (column \"Version\")
                    (column \"Built-at\"))
              (list (list '(\"Foo\" :rowspan 2) \"bar\" \"baz\")
                    (list nil '(\"blah\" :colspan 2) nil)))
  ```

")
  (0.3.0 2025-05-21
         "
## Fixes

* Code was updated to work with latest Reblocks and it's routing.

## Changes

* Variable `reblocks-ui2/themes/api:*current-theme*` is not imported from it's package anymore. Use REBLOCKS-UI2/THEMES/API:CURRENT-THEME function function instead.

")
  (0.2.0 2024-04-04
         "
## Changes

* Allow to set current theme using SETF on REBLOCKS-UI2/THEMES/API:CURRENT-THEME function.
* Now TailwindCSS theme automatically loads https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4 JavaScript dependency.")
  (0.1.0 2023-02-05
         "* Initial version."))
