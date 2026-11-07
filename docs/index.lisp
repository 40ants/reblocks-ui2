(uiop:define-package #:reblocks-ui2-docs/index
  (:use #:cl)
  (:import-from #:pythonic-string-reader
                #:pythonic-string-syntax)
  #+quicklisp
  (:import-from #:quicklisp)
  (:import-from #:named-readtables
                #:in-readtable)
  (:import-from #:40ants-doc
                #:defsection
                #:defsection-copy)
  (:import-from #:reblocks-ui2-docs/changelog
                #:@changelog)
  (:import-from #:docs-config
                #:docs-config)
  (:import-from #:40ants-doc/autodoc
                #:defautodoc)
  (:export #:@index
           #:@readme
           #:@changelog))
(in-package #:reblocks-ui2-docs/index)

(in-readtable pythonic-string-syntax)


(defmethod docs-config ((system (eql (asdf:find-system "reblocks-ui2-docs"))))
  ;; 40ANTS-DOC-THEME-40ANTS system will bring
  ;; as dependency a full 40ANTS-DOC but we don't want
  ;; unnecessary dependencies here:
  #+quicklisp
  (ql:quickload "40ants-doc-theme-40ants")
  #-quicklisp
  (asdf:load-system "40ants-doc-theme-40ants")
  
  (list :theme
        (find-symbol "40ANTS-THEME"
                     (find-package "40ANTS-DOC-THEME-40ANTS"))))


(defsection @index (:title "reblocks-ui2 - A pack of UI components for Reblocks web-framework."
                    :ignore-words ("JSON"
                                   "HTTP"
                                   "HTML"
                                   "CSS"
                                   "TODO"
                                   "Unlicense"
                                   "Reblocks-UI2"
                                   "REPL"
                                   "ASDF:PACKAGE-INFERRED-SYSTEM"
                                   "ASDF"
                                   "40A"
                                   "API"
                                   "UI"
                                   "URL"
                                   "URI"
                                   "RPC"
                                   "GIT"
                                   "DD"
                                   "MM"
                                   "YYYY"
                                   "YYYY-MM-DD"
                                   "DD.MM.YYYY")
                    :external-docs ("https://40ants.com/reblocks/"))
  (reblocks-ui2 system)
  "
[![](https://github-actions.40ants.com/40ants/reblocks-ui2/matrix.svg?only=ci.run-tests)](https://github.com/40ants/reblocks-ui2/actions)

![Quicklisp](http://quickdocs.org/badge/reblocks-ui2.svg)
"
  (@installation section)
  (@usage section)
  (@api section))


(defsection-copy @readme @index)


(defsection @installation (:title "Installation")
  """
You can install this library from Quicklisp, but you want to receive updates quickly, then install it from Ultralisp.org:

```
(ql-dist:install-dist "http://dist.ultralisp.org/"
                      :prompt nil)
(ql:quickload :reblocks-ui2)
```
""")


(defsection @usage (:title "Usage")
  "
Here is how a form with a native date input can be created:

```lisp
(reblocks-ui2/form:form
 (reblocks-ui2/containers/column:column
  (reblocks-ui2/inputs/date-input:date-input
   :name \"birthday\"
   :value \"2025-11-07\"
   :required nil))
 :on-submit
 (lambda (form &key birthday)
   ;; BIRTHDAY is a local-time timestamp here, or NIL because
   ;; the date is optional in this example.
   (declare (ignore form birthday))))
```

The widget is a thin wrapper around a text input with type=\"date\" and
attaches a `reblocks-ui2/form/validators:valid-date` validator. The value
is a \"YYYY-MM-DD\" string, native for the browser. Pass `:format :ddmmyyyy`
to parse \"DD.MM.YYYY\" strings instead, and use
`reblocks-ui2/form/validators:format-date` to convert a timestamp back
into a string suitable for the widget's value.

Charts are rendered by Google Charts:

```lisp
(reblocks-ui2/charts/pie-chart:pie-chart
 '((\"Alpha\" 10)
   (\"Beta\" 25))
 :title \"Tasks by mission\"
 :column-names '(\"Mission\" \"Tasks\"))

(reblocks-ui2/charts/column-chart:column-chart
 '((\"2026-W1\" 3)
   (\"2026-W2\" 7))
 :title \"Users by week\"
 :column-names '(\"Week\" \"Users\")
 :x-title \"Week\"
 :y-title \"Users\")
```

DATA is either a list of (LABEL NUMBER) rows, or a function of zero
arguments returning such a list. The function is called on each render,
so charts always show fresh data. The Google Charts loader script is
added as a widget dependency and requires no manual wiring.
")


(defautodoc @api (:system "reblocks-ui2"))

