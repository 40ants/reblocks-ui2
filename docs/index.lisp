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
  (@date-input section)
  (@charts section)
  (@confirm section)
  (@crud-table section)
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
  """
All widgets are theme-aware: a widget knows nothing about the markup and is
rendered by the current theme via the `reblocks-ui2/widget:render` generic
function which receives the widget and the theme. To style the widgets with
Tailwind, load the `reblocks-ui2-tailwind` system and make the Tailwind theme
current before starting the server:

```lisp
(ql:quickload :reblocks-ui2-tailwind)
(setf (reblocks-ui2/themes/api:current-theme)
      (reblocks-ui2/themes/tailwind:make-tailwind-theme))
```

Particular widgets are described in the sections below — Date Input, Charts,
Confirmation Form and CRUD Table — and the full API reference is in the API
section.
""")


(defsection @date-input (:title "Date Input")
  (reblocks-ui2/inputs/date-input:date-input function)
  (reblocks-ui2/form/validators:valid-date function)
  (reblocks-ui2/form/validators:format-date function)
  """
Here is how a form with a native date input can be created:

```lisp
(reblocks-ui2/form:form
 (reblocks-ui2/containers/column:column
  (reblocks-ui2/inputs/date-input:date-input
   :name "birthday"
   :value "2025-11-07"
   :required nil))
 :on-submit
 (lambda (form &key birthday)
   ;; BIRTHDAY is a local-time timestamp here, or NIL because
   ;; the date is optional in this example.
   (declare (ignore form birthday))))
```

The widget is a thin wrapper around a text input with type="date" and
attaches a `reblocks-ui2/form/validators:valid-date` validator. The value
is a "YYYY-MM-DD" string, native for the browser. Pass `:format :ddmmyyyy`
to parse "DD.MM.YYYY" strings instead, and use
`reblocks-ui2/form/validators:format-date` to convert a timestamp back
into a string suitable for the widget's value.
""")


(defsection @charts (:title "Charts"
                     :ignore-words ("LABEL"
                                    "NUMBER-VALUE"
                                    "3D"))
  (reblocks-ui2/charts/pie-chart:pie-chart function)
  (reblocks-ui2/charts/pie-chart:pie-chart class)
  (reblocks-ui2/charts/column-chart:column-chart function)
  (reblocks-ui2/charts/column-chart:column-chart class)
  (reblocks-ui2/charts/chart:chart-widget class)
  """
Charts are rendered by Google Charts:

```lisp
(reblocks-ui2/charts/pie-chart:pie-chart
 '(("Alpha" 10)
   ("Beta" 25))
 :title "Tasks by mission"
 :column-names '("Mission" "Tasks"))

(reblocks-ui2/charts/column-chart:column-chart
 '(("2026-W1" 3)
   ("2026-W2" 7))
 :title "Users by week"
 :column-names '("Week" "Users")
 :x-title "Week"
 :y-title "Users")
```

DATA is either a list of (LABEL NUMBER) rows, or a function of zero
arguments returning such a list. The function is called on each render,
so charts always show fresh data. The Google Charts loader script is
added as a widget dependency and requires no manual wiring.
""")


(defsection @confirm (:title "Confirmation Form")
  (reblocks-ui2/form/confirm:confirm function)
  """
Use `reblocks-ui2/form/confirm:confirm` when an action has to be confirmed
by the user. It returns a usual form with two submit buttons: Confirm and
Cancel. The on-confirm callback is called with the form widget and only when
the Confirm button (or Enter, because the Confirm button is the first
submit button in the HTML) was used:

```lisp
(reblocks-ui2/form/confirm:confirm
 "Delete this mission?"
 :confirm-button-title "Yes, delete"
 :on-confirm
 (lambda (form)
   (declare (ignore form))
   ;; Perform the action here.
   ))
```

The widget does not close modal windows by itself. When the form is shown
inside a `reblocks-ui2/modal:modal`, hide the modal from the callback:

```lisp
(let ((modal (reblocks-ui2/modal:modal
              (reblocks-ui2/form/confirm:confirm
               "Delete this mission?"
               :on-confirm
               (lambda (form)
                 (declare (ignore form))
                 (reblocks-ui2/modal:modal-hide modal))))))
  ;; Show the modal from some button's ON-CLICK callback:
  (reblocks-ui2/buttons/button:button
   "Delete mission"
   :on-click (lambda (button)
               (declare (ignore button))
               (reblocks-ui2/modal:modal-show modal))))
```
""")


(defsection @crud-table (:title "CRUD Table"
                         :ignore-words ("CRUD"
                                        "CRUD-WIDGET"))
  (reblocks-ui2/tables/crud:make-crud-table function)
  (reblocks-ui2/tables/crud:crud-table class)
  """
A whole CRUD table can be created with a single
`reblocks-ui2/tables/crud:make-crud-table` call. It renders a search
table and adds an actions column with Edit and Delete buttons, plus an
Add button above the table. Forms are created by the application and
shown in a modal:

```lisp
(reblocks-ui2/tables/crud:make-crud-table
 (list (reblocks-ui2/tables/table:column "Title"
                                         :getter #'task-title))
 ;; DATA-GETTER is given to the search widget and
 ;; returns the list of objects to show:
 (lambda (&rest args)
   (declare (ignore args))
   (copy-list *tasks*))
 :add-form-maker (lambda (crud-widget modal)
                   (reblocks-ui2/form:form
                    (reblocks-ui2/inputs/text-input:input
                     :name "title")
                    :on-submit (lambda (form &key button title)
                                 (declare (ignore form))
                                 (when (string-equal button "submit")
                                   (push (make-task title)
                                         *tasks*))
                                 (reblocks-ui2/modal:modal-hide modal))))
 :edit-form-maker (lambda (modal task)
                    ;; Should return a form editing the TASK.
                    ...)
 :on-delete (lambda (task)
              (setf *tasks*
                    (remove task *tasks*)))
 :delete-question (lambda (task)
                    (format nil "Delete this task: ~A?"
                            (task-title task))))
```

Each button is rendered only when the corresponding callback is given;
without any callback the table has no actions column at all. The widget
knows nothing about the persistence: saving objects inside the forms and
deleting them in ON-DELETE is up to the application. After the add form
is submitted, the whole table is updated; after the edit form is
submitted, only the edited row's cells are recalculated. DELETE-QUESTION
may also be a plain string.
""")


(defautodoc @api (:system "reblocks-ui2"))
