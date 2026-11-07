<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-40README-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

# reblocks-ui2 - A pack of UI components for Reblocks web-framework.

<a id="reblocks-ui2-asdf-system-details"></a>

## REBLOCKS-UI2 ASDF System Details

* Description: A pack of `UI` components for Reblocks web-framework.
* Licence: Unlicense
* Author: Alexander Artemenko <svetlyak.40wt@gmail.com>
* Homepage: [https://40ants.com/reblocks-ui2/][e41b]
* Bug tracker: [https://github.com/40ants/reblocks-ui2/issues][9c4e]
* Source control: [GIT][2d52]
* Depends on: [alexandria][8236], [anaphora][c9ae], [closer-mop][61a4], [event-emitter][bb23], [lambda-fiddle][3ad9], [local-time][46a1], [log4cl][7f8b], [moptilities][5dbf], [named-readtables][d0a9], [parenscript][7921], [pythonic-string-reader][c01d], [reblocks][184b], [reblocks-lass][28e0], [serapeum][c41d], [str][ef7f], [trivial-arguments][40a0]

[![](https://github-actions.40ants.com/40ants/reblocks-ui2/matrix.svg?only=ci.run-tests)][9201]

![](http://quickdocs.org/badge/reblocks-ui2.svg)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40INSTALLATION-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## Installation

You can install this library from Quicklisp, but you want to receive updates quickly, then install it from Ultralisp.org:

```
(ql-dist:install-dist "http://dist.ultralisp.org/"
                      :prompt nil)
(ql:quickload :reblocks-ui2)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40USAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## Usage

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
is a "`YYYY-MM-DD`" string, native for the browser. Pass `:format :ddmmyyyy`
to parse "`DD`.`MM`.`YYYY`" strings instead, and use
`reblocks-ui2/form/validators:format-date` to convert a timestamp back
into a string suitable for the widget's value.

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
`DATA` is either a list of (`LABEL` `NUMBER`) rows, or a function of zero
arguments returning such a list. The function is called on each render,
so charts always show fresh data. The Google Charts loader script is
added as a widget dependency and requires no manual wiring.

Use `reblocks-ui2/form/confirm:confirm` when an action has to be confirmed
by the user. It returns a usual form with two submit buttons: Confirm and
Cancel. The on-confirm callback is called with the form widget and only when
the Confirm button (or Enter, because the Confirm button is the first
submit button in the `HTML`) was used:

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
A whole `CRUD` table can be created with a single
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
deleting them in `ON-DELETE` is up to the application. After the add form
is submitted, the whole table is updated; after the edit form is
submitted, only the edited row's cells are recalculated. `DELETE-QUESTION`
may also be a plain string.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40API-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## API

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/BUTTONS/BUTTON

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FBUTTONS-2FBUTTON-22-29-20PACKAGE-29"></a>

#### [package](a8cb) `reblocks-ui2/buttons/button`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-24BUTTON-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BUTTON

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20CLASS-29"></a>

###### [class](bd2d) `reblocks-ui2/buttons/button:button` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](3511) `reblocks-ui2/buttons/button:button-class` (button) (:class)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](8ae2) `reblocks-ui2/buttons/button:button-content` (button) (:content)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](ac49) `reblocks-ui2/buttons/button:button-disabled` (button) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](ec0f) `reblocks-ui2/buttons/button:button-pin` (button) (:pin)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](4da4) `reblocks-ui2/buttons/button:button-size` (button) (:size = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-STYLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](edeb) `reblocks-ui2/buttons/button:button-style` (button) (:style)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3A-3ABUTTON-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](9699) `reblocks-ui2/buttons/button::button-type` (button) (:type = nil)

If not given, then type will be "button" for a button having on-click callback or "submit" otherwise.

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](782c) `reblocks-ui2/buttons/button:button-view` (button) (:view = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](3511) `reblocks-ui2/buttons/button:button-class` (button) (:class)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](8ae2) `reblocks-ui2/buttons/button:button-content` (button) (:content)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](ac49) `reblocks-ui2/buttons/button:button-disabled` (button) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](ec0f) `reblocks-ui2/buttons/button:button-pin` (button) (:pin)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](4da4) `reblocks-ui2/buttons/button:button-size` (button) (:size = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-STYLE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](edeb) `reblocks-ui2/buttons/button:button-style` (button) (:style)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3A-3ABUTTON-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](9699) `reblocks-ui2/buttons/button::button-type` (button) (:type = nil)

If not given, then type will be "button" for a button having on-click callback or "submit" otherwise.

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](782c) `reblocks-ui2/buttons/button:button-view` (button) (:view = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20FUNCTION-29"></a>

##### [function](30f9) `reblocks-ui2/buttons/button:button` CONTENT &KEY NAME VALUE TYPE (WIDGET-CLASS 'BUTTON) ON-CLICK (CLASS "button") DISABLED STYLE (VIEW :NORMAL) (SIZE :L) (PIN :ROUND) (WIDTH :MIN) HEIGHT

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/BUTTONS/VIEW

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FBUTTONS-2FVIEW-22-29-20PACKAGE-29"></a>

#### [package](c858) `reblocks-ui2/buttons/view`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24ACTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ACTION

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AACTION-20CLASS-29"></a>

###### [class](e0f7) `reblocks-ui2/buttons/view:action` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24BUTTON-VIEW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BUTTON-VIEW

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ABUTTON-VIEW-20CLASS-29"></a>

###### [class](312b) `reblocks-ui2/buttons/view:button-view` ()

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24NORMAL-DISABLED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL-DISABLED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ANORMAL-DISABLED-20CLASS-29"></a>

###### [class](5ec0) `reblocks-ui2/buttons/view:normal-disabled` (normal)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24NORMAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ANORMAL-20CLASS-29"></a>

###### [class](ce88) `reblocks-ui2/buttons/view:normal` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-ACTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-ACTION

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-ACTION-20CLASS-29"></a>

###### [class](bade) `reblocks-ui2/buttons/view:outlined-action` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-DANGER-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-DANGER

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-DANGER-20CLASS-29"></a>

###### [class](bb7a) `reblocks-ui2/buttons/view:outlined-danger` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-INFO-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-INFO

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-INFO-20CLASS-29"></a>

###### [class](9375) `reblocks-ui2/buttons/view:outlined-info` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-SUCCESS-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-SUCCESS

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-SUCCESS-20CLASS-29"></a>

###### [class](b50e) `reblocks-ui2/buttons/view:outlined-success` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-UTILITY-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-UTILITY

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-UTILITY-20CLASS-29"></a>

###### [class](c320) `reblocks-ui2/buttons/view:outlined-utility` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-WARNING-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-WARNING

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-WARNING-20CLASS-29"></a>

###### [class](a966) `reblocks-ui2/buttons/view:outlined-warning` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-20CLASS-29"></a>

###### [class](650f) `reblocks-ui2/buttons/view:outlined` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24RAISED-DISABLED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RAISED-DISABLED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ARAISED-DISABLED-20CLASS-29"></a>

###### [class](cd85) `reblocks-ui2/buttons/view:raised-disabled` (raised)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24RAISED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RAISED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ARAISED-20CLASS-29"></a>

###### [class](9558) `reblocks-ui2/buttons/view:raised` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AGET-DISABLED-BUTTON-VIEW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](b1da) `reblocks-ui2/buttons/view:get-disabled-button-view` view

Returns an alternative view for a button in disabled state.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AENSURE-VIEW-20FUNCTION-29"></a>

##### [function](732b) `reblocks-ui2/buttons/view:ensure-view` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCARD-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CARD

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCARD-22-29-20PACKAGE-29"></a>

#### [package](07f1) `reblocks-ui2/card`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCARD-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCARD-24CARD-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CARD-WIDGET

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-20CLASS-29"></a>

###### [class](ba3a) `reblocks-ui2/card:card-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](0192) `reblocks-ui2/card:card-content` (card-widget) (:content)

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-PADDING-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](5011) `reblocks-ui2/card:card-padding` (card-widget) (:padding = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](9a19) `reblocks-ui2/card:card-view` (card-widget) (:view = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3AHORIZONTAL-ALIGN-OF-CARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](16cb) `reblocks-ui2/card:horizontal-align-of-card-content` (card-widget) (:horizontal-align = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3AVERTICAL-ALIGN-OF-CARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](84f7) `reblocks-ui2/card:vertical-align-of-card-content` (card-widget) (:vertical-align = :center)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCARD-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-20FUNCTION-29"></a>

##### [function](2dfc) `reblocks-ui2/card:card` CONTENT &KEY (VIEW :OUTLINED) (WIDTH "full") (HEIGHT '(120)) (PADDING :L) (MARGIN '(NIL NIL)) (HORIZONTAL-ALIGN :CENTER) (VERTICAL-ALIGN :CENTER) ON-CLICK (WIDGET-CLASS 'CARD-WIDGET)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCHART-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CHARTS/CHART

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCHARTS-2FCHART-22-29-20PACKAGE-29"></a>

#### [package](d330) `reblocks-ui2/charts/chart`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FCHART-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCHART-24CHART-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CHART-WIDGET

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-20CLASS-29"></a>

###### [class](03d2) `reblocks-ui2/charts/chart:chart-widget` (ui-widget)

Base class for chart widgets rendered by Google Charts.

Subclasses such as `reblocks-ui2/charts/pie-chart:pie-chart` ([`1`][c339] [`2`][a4b2]) and
`reblocks-ui2/charts/column-chart:column-chart` ([`1`][44f8] [`2`][3189]) define chart type
specific options, theming methods do the rendering.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-BACKGROUND-COLOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](5c8e) `reblocks-ui2/charts/chart:chart-background-color` (chart-widget) (:BACKGROUND-COLOR = "#f9f9f9")

`CSS` color of the area around the chart.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-COLUMN-NAMES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](ea7b) `reblocks-ui2/charts/chart:chart-column-names` (chart-widget) (:COLUMN-NAMES = '("Label" "Value"))

Names of the two DataTable columns, as strings.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-DATA-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](edf1) `reblocks-ui2/charts/chart:chart-data` (chart-widget) (:data)

Chart rows, each of the form (`LABEL` `NUMBER-VALUE`).

Alternatively, this may be a function of zero arguments.
It is called on each render, so that charts always show
fresh data.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-EXTRA-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](0f59) `reblocks-ui2/charts/chart:chart-extra-options` (chart-widget) (:extra-options = nil)

Raw JavaScript, inserted into the Google Charts options object
before the closing bracket. Use it for options which are not
covered by typed slots, like "legend: {position: 'none'}".

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](d242) `reblocks-ui2/charts/chart:chart-height` (chart-widget) (:height = 500)

Chart height in pixels.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](2976) `reblocks-ui2/charts/chart:chart-title` (chart-widget) (:title = "")

A chart title rendered at the top of the chart by Google Charts.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CHARTS/COLUMN-CHART

<a id="x-28-23A-28-2832-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-22-29-20PACKAGE-29"></a>

#### [package](3395) `reblocks-ui2/charts/column-chart`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-24COLUMN-CHART-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN-CHART

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-20CLASS-29"></a>

###### [class](06bc) `reblocks-ui2/charts/column-chart:column-chart` (chart-widget)

A column chart widget rendered by Google Charts.

The `column-chart` ([`1`][44f8] [`2`][3189]) symbol names both this class and a constructor
function, following the donor widgets from the lct25 project.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-V-AXIS-MIN-ZERO-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-29-29"></a>

###### [reader](5531) `reblocks-ui2/charts/column-chart:column-chart-v-axis-min-zero-p` (column-chart) (:v-axis-min-zero = t)

When true (the default), the vertical axis starts at zero,
like vAxis.minValue = 0 in Google Charts.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-X-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-29-29"></a>

###### [reader](fd61) `reblocks-ui2/charts/column-chart:column-chart-x-title` (column-chart) (:x-title = nil)

A title for the horizontal axis. When nil, the axis has no title.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-Y-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-29-29"></a>

###### [reader](03ed) `reblocks-ui2/charts/column-chart:column-chart-y-title` (column-chart) (:y-title = nil)

A title for the vertical axis. When nil, the axis has no title.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-20FUNCTION-29"></a>

##### [function](05e7) `reblocks-ui2/charts/column-chart:column-chart` data &rest restargs &key title column-names height background-color extra-options x-title y-title v-axis-min-zero (widget-class 'column-chart)

Returns a column chart widget rendered by Google Charts.

`DATA` is either a list of rows of the form (`LABEL` `NUMBER-VALUE`),
or a function of zero arguments returning such a list. The function
is called on each render to fetch fresh data.

`X-TITLE` and `Y-TITLE` add titles to the horizontal and vertical axes.

`V-AXIS-MIN-ZERO` (the default) makes the vertical axis start at zero.

`EXTRA-OPTIONS` is a raw JavaScript string, inserted into the Google
Charts options object before the closing bracket.

`WIDGET-CLASS` may be a subclass of `column-chart` ([`1`][44f8] [`2`][3189]) to instantiate instead.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CHARTS/PIE-CHART

<a id="x-28-23A-28-2829-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-22-29-20PACKAGE-29"></a>

#### [package](aa3a) `reblocks-ui2/charts/pie-chart`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-24PIE-CHART-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### PIE-CHART

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-20CLASS-29"></a>

###### [class](0a2b) `reblocks-ui2/charts/pie-chart:pie-chart` (chart-widget)

A pie chart widget rendered by Google Charts.

The `pie-chart` ([`1`][c339] [`2`][a4b2]) symbol names both this class and a constructor
function, following the donor widgets from the lct25 project.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-IS3D-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-29-29"></a>

###### [reader](457c) `reblocks-ui2/charts/pie-chart:pie-chart-is3d` (pie-chart) (:is3d = nil)

When true, the chart is rendered with pseudo-`3D` effect.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-PIE-HOLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-29-29"></a>

###### [reader](825d) `reblocks-ui2/charts/pie-chart:pie-chart-pie-hole` (pie-chart) (:pie-hole = 0)

A number between 0 and 1, describing what fraction of the radius
to cut out from the center. 0 gives a usual pie chart,
0.4 gives a donut chart.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-SLICE-COLORS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-29-29"></a>

###### [reader](f270) `reblocks-ui2/charts/pie-chart:pie-chart-slice-colors` (pie-chart) (:slice-colors = nil)

A list of `CSS` colors, applied to the slices in order.
When nil, Google Charts default colors are used.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-20FUNCTION-29"></a>

##### [function](ce2e) `reblocks-ui2/charts/pie-chart:pie-chart` data &rest restargs &key title column-names height background-color extra-options pie-hole is3d slice-colors (widget-class 'pie-chart)

Returns a pie chart widget rendered by Google Charts.

`DATA` is either a list of rows of the form (`LABEL` `NUMBER-VALUE`),
or a function of zero arguments returning such a list. The function
is called on each render to fetch fresh data.

`PIE-HOLE` is a number between 0 and 1, cut out from the center
(0 for a usual pie chart, 0.4 for a donut).

`IS3D` turns on the pseudo-`3D` effect.

`SLICE-COLORS` is a list of `CSS` colors applied to the slices in order.

`EXTRA-OPTIONS` is a raw JavaScript string, inserted into the Google
Charts options object before the closing bracket.

`WIDGET-CLASS` may be a subclass of `pie-chart` ([`1`][c339] [`2`][a4b2]) to instantiate instead.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/COLUMN

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-22-29-20PACKAGE-29"></a>

#### [package](7d09) `reblocks-ui2/containers/column`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-24COLUMN-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3ACOLUMN-WIDGET-20CLASS-29"></a>

###### [class](79f2) `reblocks-ui2/containers/column:column-widget` (container-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3ACOLUMN-20FUNCTION-29"></a>

##### [function](8615) `reblocks-ui2/containers/column:column` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/CONTAINER

<a id="x-28-23A-28-2833-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-22-29-20PACKAGE-29"></a>

#### [package](6732) `reblocks-ui2/containers/container`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-24CONTAINER-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTAINER-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-20CLASS-29"></a>

###### [class](4fb7) `reblocks-ui2/containers/container:container-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AADDITIONAL-CLASSES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](762e) `reblocks-ui2/containers/container:additional-classes` (container-widget) (:css-classes = nil)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACHILDREN-GAP-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](0123) `reblocks-ui2/containers/container:children-gap` (container-widget) (:gap = \*default-gap\*)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](3fa7) `reblocks-ui2/containers/container:subwidgets` (container-widget) (:subwidgets = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [accessor](3fa7) `reblocks-ui2/containers/container:subwidgets` (container-widget) (:subwidgets = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AGAP-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](254c) `reblocks-ui2/containers/container:gap-css-classes` gap theme

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AMAKE-CONTAINER-20FUNCTION-29"></a>

##### [function](f58f) `reblocks-ui2/containers/container:make-container` default-widget-class &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/CONTROLS-ROW

<a id="x-28-23A-28-2836-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-22-29-20PACKAGE-29"></a>

#### [package](bc4e) `reblocks-ui2/containers/controls-row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-24CONTROLS-ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTROLS-ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3ACONTROLS-ROW-WIDGET-20CLASS-29"></a>

###### [class](af14) `reblocks-ui2/containers/controls-row:controls-row-widget` (row-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3ACONTROLS-ROW-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](c038) `reblocks-ui2/containers/controls-row:controls-row` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/ROW

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FROW-22-29-20PACKAGE-29"></a>

#### [package](2db0) `reblocks-ui2/containers/row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FROW-24ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AROW-WIDGET-20CLASS-29"></a>

###### [class](7a77) `reblocks-ui2/containers/row:row-widget` (container-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AMAKE-ROW-WIDGET-20FUNCTION-29"></a>

##### [function](8487) `reblocks-ui2/containers/row:make-row-widget` subwidgets &key (gap \*default-gap\*) on-click

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AROW-20FUNCTION-29"></a>

##### [function](7966) `reblocks-ui2/containers/row:row` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/STACK

<a id="x-28-23A-28-2829-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FSTACK-22-29-20PACKAGE-29"></a>

#### [package](da66) `reblocks-ui2/containers/stack`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-24STACK-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### STACK-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-20CLASS-29"></a>

###### [class](e5c7) `reblocks-ui2/containers/stack:stack-widget` (ui-widget)

Shows only the top child from the stack. Provides methods to push and pop widgets.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-CHILDREN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-29-29"></a>

###### [reader](a91b) `reblocks-ui2/containers/stack:stack-widget-children` (stack-widget) (:children)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APOP-CHILD-20GENERIC-FUNCTION-29"></a>

##### [generic-function](913b) `reblocks-ui2/containers/stack:pop-child` stack-widget

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APUSH-CHILD-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c7df) `reblocks-ui2/containers/stack:push-child` stack-widget child

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ACURRENT-STACK-WIDGET-20FUNCTION-29"></a>

##### [function](cbf2) `reblocks-ui2/containers/stack:current-stack-widget`

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APOP-ME-20FUNCTION-29"></a>

##### [function](ffaf) `reblocks-ui2/containers/stack:pop-me`

Removes current (top) widget from the stack and display the next widget.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3AREPLACE-ME-WITH-20FUNCTION-29"></a>

##### [function](d4a1) `reblocks-ui2/containers/stack:replace-me-with` widget

Adds a new widget ontop of the current.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-20FUNCTION-29"></a>

##### [function](5d40) `reblocks-ui2/containers/stack:stack` &rest children

Makes a stack widget with given subwidgets.

Only first widget in the list will be visible.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/TABS

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FTABS-22-29-20PACKAGE-29"></a>

#### [package](3922) `reblocks-ui2/containers/tabs`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-24TABS-CONTROL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABS-CONTROL

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-20CLASS-29"></a>

###### [class](ebb4) `reblocks-ui2/containers/tabs:tabs-control` (event-emitter ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ACURRENT-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](25b7) `reblocks-ui2/containers/tabs:current-idx` (tabs-control) (:idx = 0)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASUBWIDGETS-TITLES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](19d4) `reblocks-ui2/containers/tabs:subwidgets-titles` (tabs-control) (:titles)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](f3d4) `reblocks-ui2/containers/tabs:tabs-size` (tabs-control) (:size)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ACURRENT-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [accessor](25b7) `reblocks-ui2/containers/tabs:current-idx` (tabs-control) (:idx = 0)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-24TABS-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABS-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-20CLASS-29"></a>

###### [class](d7f1) `reblocks-ui2/containers/tabs:tabs-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-29-29"></a>

###### [reader](427c) `reblocks-ui2/containers/tabs:subwidgets` (tabs-widget) (:subwidgets)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SELECTOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-29-29"></a>

###### [reader](0a15) `reblocks-ui2/containers/tabs:tabs-selector` (tabs-widget) (:selector)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASWITCH-TO-IDX-20FUNCTION-29"></a>

##### [function](848d) `reblocks-ui2/containers/tabs:switch-to-idx` &key widget-id idx &allow-other-keys

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-20FUNCTION-29"></a>

##### [function](7f46) `reblocks-ui2/containers/tabs:tabs` titles subwidgets &key (idx 0) (selector-class 'tabs-control) (class 'tabs-widget) (size :l)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SIZE-20-28TYPE-29-29"></a>

##### [type](6c1a) `reblocks-ui2/containers/tabs:tabs-size`

```
(MEMBER :M :L :XL)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEDITABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/EDITABLE

<a id="x-28-23A-28-2821-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FEDITABLE-22-29-20PACKAGE-29"></a>

#### [package](2534) `reblocks-ui2/editable`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FEDITABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FEDITABLE-3AMAKE-EDITABLE-WIDGET-20GENERIC-FUNCTION-29"></a>

##### [generic-function](74c7) `reblocks-ui2/editable:make-editable-widget` value callback

Creates a widget which can be used to edit a given value.
Every time when the widget loose focus, it will call `CALLBACK` argument with a new value.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEVENTS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/EVENTS

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FEVENTS-22-29-20PACKAGE-29"></a>

#### [package](318d) `reblocks-ui2/events`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FEVENTS-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEVENTS-24EVENT-EMITTING-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EVENT-EMITTING-WIDGET

<a id="x-28REBLOCKS-UI2-2FEVENTS-3AEVENT-EMITTING-WIDGET-20CLASS-29"></a>

###### [class](35fd) `reblocks-ui2/events:event-emitting-widget` (event-emitter ui-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-22-29-20PACKAGE-29"></a>

#### [package](e910) `reblocks-ui2/form`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-24FORM-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FORM-WIDGET

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-20CLASS-29"></a>

###### [class](e5ad) `reblocks-ui2/form:form-widget` (event-emitting-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](3e5d) `reblocks-ui2/form:form-content` (form-widget) (:content)

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-INPUTS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](ffe0) `reblocks-ui2/form:form-inputs` (form-widget) (= (make-hash-table :test 'equal))

Internal structure holding references to all form inputs having a name attribute.

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-ON-SUBMIT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](f9a3) `reblocks-ui2/form:form-on-submit` (form-widget) (:on-submit = 'no-action)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-20FUNCTION-29"></a>

##### [function](11aa) `reblocks-ui2/form:form` content &key (widget-class 'form-widget) on-submit

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FCONFIRM-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM/CONFIRM

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-2FCONFIRM-22-29-20PACKAGE-29"></a>

#### [package](145b) `reblocks-ui2/form/confirm`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FCONFIRM-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FCONFIRM-3ACONFIRM-20FUNCTION-29"></a>

##### [function](18b1) `reblocks-ui2/form/confirm:confirm` CONTENT &KEY (CONFIRM-BUTTON-TITLE "Confirm") (CANCEL-BUTTON-TITLE "Cancel") (CONFIRM-VALUE "submit") (CANCEL-VALUE "cancel") ON-CONFIRM WIDGET-CLASS

Returns a form widget asking the user to confirm an action.

`CONTENT` is a question to show to the user. It might be a string or any other
widget and is processed by [`reblocks/widget:create-widget-from`][5f3d], like the
content of the usual [`form`][23c2].

The form contains two submit buttons sharing the name "button". The
Confirm button submits `CONFIRM-VALUE` and the Cancel button submits
`CANCEL-VALUE`. Both titles and values are customizable.

The Confirm button is the first submit button in the `HTML`. This way pressing
Enter in the form submits it as if the Confirm button was pressed, because
browsers use the first submit button for the implicit submission.

`ON-CONFIRM`, if given, is called with the form widget as the only argument,
but only when the form was submitted with the button whose value is
string-equal to `CONFIRM-VALUE`. Submission of the Cancel button does nothing.
No persistence happens inside the widget, and no modal windows are hidden:
to close a modal showing this form, call [`reblocks-ui2/modal:modal-hide`][ba16] from
the `ON-CONFIRM` callback.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM/VALIDATION

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-2FVALIDATION-22-29-20PACKAGE-29"></a>

#### [package](4021) `reblocks-ui2/form/validation`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24FIELD-VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FIELD-VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](9c3a) `reblocks-ui2/form/validation:field-validation-error` (validation-error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-29-29"></a>

###### [reader](9c3a) `reblocks-ui2/form/validation:field-name` (field-validation-error) (:field-name)

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AINVALID-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-29-29"></a>

###### [reader](9c3a) `reblocks-ui2/form/validation:invalid-value` (field-validation-error) (:invalid-value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24FORM-VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FORM-VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFORM-VALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](4c19) `reblocks-ui2/form/validation:form-validation-error` (validation-error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3ANUM-ERRORS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFORM-VALIDATION-ERROR-29-29"></a>

###### [reader](4c19) `reblocks-ui2/form/validation:num-errors` (form-validation-error) (:num-errors)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](0b8a) `reblocks-ui2/form/validation:validation-error` (error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AERROR-ARGS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-29-29"></a>

###### [reader](0b8a) `reblocks-ui2/form/validation:error-args` (validation-error) (:error-args = 'nil)

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AERROR-MESSAGE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-29-29"></a>

###### [reader](0b8a) `reblocks-ui2/form/validation:error-message` (validation-error) (:error-message = '"")

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATE-FORM-DATA-20GENERIC-FUNCTION-29"></a>

##### [generic-function](5758) `reblocks-ui2/form/validation:validate-form-data` widget form-data

Accepts a form or input widget and a plist of all data sent from the browser.

Should return a plist of validated data. Also, it might change the state of the widgets,
for example, to set an error message saying that entered value is invalid. In the case
when data is invalid, function should signal `validation-error` ([`1`][af7e] [`2`][4945]).

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20FUNCTION-29"></a>

##### [function](cbf4) `reblocks-ui2/form/validation:validation-error` message &rest args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATORS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM/VALIDATORS

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-2FVALIDATORS-22-29-20PACKAGE-29"></a>

#### [package](cf83) `reblocks-ui2/form/validators`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATORS-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AALL-20FUNCTION-29"></a>

##### [function](9ed6) `reblocks-ui2/form/validators:all` &rest validators

Combines a multiple validators into a chain where every subsequent validator validates output of the previous one.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AFORMAT-DATE-20FUNCTION-29"></a>

##### [function](2237) `reblocks-ui2/form/validators:format-date` timestamp &key (format :iso)

Formats `TIMESTAMP` as a date string.

Supported formats are the same as for [`valid-date`][556a]:

* `:ISO` (default) returns "`YYYY-MM-DD`" strings.
* `:DDMMYYYY` returns "`DD`.`MM`.`YYYY`" strings.

A `NIL` `TIMESTAMP` is formatted as an empty string, so that the result
can be used as an input widget's value.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-DATE-20FUNCTION-29"></a>

##### [function](65d5) `reblocks-ui2/form/validators:valid-date` &key (format :iso) (required t)

Returns a validator converting a date string into a local-time timestamp.

Two formats are supported:

* `:ISO` (default) expects "`YYYY-MM-DD`" strings. This is a native format
  of the `HTML` inputs with type="date".
* `:DDMMYYYY` expects "`DD`.`MM`.`YYYY`" strings.

When `VALUE` is empty and `REQUIRED` is `NIL`, the resulting validator returns `NIL`.
An empty `VALUE` with the default `REQUIRED` = T signals a `validation-error` ([`1`][af7e] [`2`][4945]),
as well as a `VALUE` which does not match the format or denotes
a non-existent date like 2025-02-31.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-INTEGER-20FUNCTION-29"></a>

##### [function](5fd8) `reblocks-ui2/form/validators:valid-integer` &key min max (allow-empty nil)

Returns a validator converting a string into an integer.

`MIN` and `MAX`, when given, are checked against the parsed number.

When `ALLOW-EMPTY` is T, an empty string or `NIL` (for example, produced by
a preceding validator in an [`all`][3cb7] chain) returns `NIL`, and `MIN` and `MAX`
are not applied to such a value.  With the default `ALLOW-EMPTY` = `NIL`
an empty value signals a `validation-error` ([`1`][af7e] [`2`][4945]), like any other value
which is not an integer.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-PASSWORD-20FUNCTION-29"></a>

##### [function](4255) `reblocks-ui2/form/validators:valid-password` &key (min-length 10) max-length required-symbols error

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-STRING-20FUNCTION-29"></a>

##### [function](c6f9) `reblocks-ui2/form/validators:valid-string` &key (min-length 1) max-length

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FHTML-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/HTML

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FHTML-22-29-20PACKAGE-29"></a>

#### [package](156b) `reblocks-ui2/html`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FHTML-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FHTML-3APROP-20FUNCTION-29"></a>

##### [function](8585) `reblocks-ui2/html:prop` name &optional default

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FHTML-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FHTML-3AHTML-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](0196) `reblocks-ui2/html:html` (&body body) &key css (html-tag :div) css-classes on-click props width height margin

This macro allows to describe [`html`][b7d1], state, css and event handlers of the widget.
All in the single form.

Here is an example of the simple widget which keeps the counter value in the state
and increment it on click:

(html (:p :class "the-title"
        (fmt "First paragraph with counter: ~A"
             (prop :counter)))
      :props '((:counter . 1))
      :css (.the-title
            :font-size 40px)
      :on-click (lambda (widget)
                  (incf (prop :counter))
                  (update widget)))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FICON-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/ICON

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FICON-22-29-20PACKAGE-29"></a>

#### [package](5434) `reblocks-ui2/icon`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FICON-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FICON-24ICON-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ICON-WIDGET

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-WIDGET-20CLASS-29"></a>

###### [class](f327) `reblocks-ui2/icon:icon-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FICON-3AICON-WIDGET-29-29"></a>

###### [reader](a5d2) `reblocks-ui2/icon:icon-name` (icon-widget) (:name)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FICON-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-20FUNCTION-29"></a>

##### [function](3f00) `reblocks-ui2/icon:icon` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FBASE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/BASE

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FBASE-22-29-20PACKAGE-29"></a>

#### [package](c032) `reblocks-ui2/inputs/base`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FBASE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FBASE-24BASE-INPUT-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BASE-INPUT-WIDGET

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-20CLASS-29"></a>

###### [class](3378) `reblocks-ui2/inputs/base:base-input-widget` (named-input)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-ERROR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](eeb6) `reblocks-ui2/inputs/base:input-error` (base-input-widget) (:error = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-VALIDATOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](5d92) `reblocks-ui2/inputs/base:input-validator` (base-input-widget) (:validator = nil)

A function of one argument returning a validated value or signaling the [`field-validation-error`][6f80].

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](42ae) `reblocks-ui2/inputs/base:input-value` (base-input-widget) (:value = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FNAMED-24NAMED-INPUT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NAMED-INPUT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-20CLASS-29"></a>

###### [class](f770) `reblocks-ui2/inputs/named:named-input` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3AINPUT-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-29-29"></a>

###### [reader](85d8) `reblocks-ui2/inputs/named:input-name` (named-input) (:name = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/CHECKBOX

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-22-29-20PACKAGE-29"></a>

#### [package](2466) `reblocks-ui2/inputs/checkbox`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-24CHECKBOX-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CHECKBOX

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-20CLASS-29"></a>

###### [class](2ef5) `reblocks-ui2/inputs/checkbox:checkbox` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-CHECKED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](e0ac) `reblocks-ui2/inputs/checkbox:checkbox-checked` (checkbox) (:checked = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](ad56) `reblocks-ui2/inputs/checkbox:checkbox-disabled` (checkbox) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](92f9) `reblocks-ui2/inputs/checkbox:checkbox-size` (checkbox) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](ef11) `reblocks-ui2/inputs/checkbox:checkbox-view` (checkbox) (:view = (make-instance 'normal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-20FUNCTION-29"></a>

##### [function](bd55) `reblocks-ui2/inputs/checkbox:checkbox` &key (widget-class 'checkbox) name value (view :normal) (size :m) disabled checked error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/DATE-INPUT

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-22-29-20PACKAGE-29"></a>

#### [package](cb12) `reblocks-ui2/inputs/date-input`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3ADATE-INPUT-20FUNCTION-29"></a>

##### [function](ccfe) `reblocks-ui2/inputs/date-input:date-input` &key (widget-class 'input-widget) name value (format :iso) (required t) placeholder (view :normal) (size :m) disabled error

Returns a native `HTML` date input.

This is a thin constructor over the usual text [`input`][8d22] with `:TYPE` "date"
and a [`valid-date`][556a] validator attached.

`VALUE` should be a "`YYYY-MM-DD`" string, because this is the format
browsers use for inputs with type="date".

`FORMAT` is passed to [`valid-date`][556a] and only controls how the submitted data
is parsed on the server. By default, the date is required; pass
`:REQUIRED` `NIL` to allow empty values, in which case the validator
returns `NIL`.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FNAMED-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/NAMED

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FNAMED-22-29-20PACKAGE-29"></a>

#### [package](b835) `reblocks-ui2/inputs/named`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FNAMED-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FNAMED-24NAMED-INPUT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NAMED-INPUT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-20CLASS-29"></a>

###### [class](f770) `reblocks-ui2/inputs/named:named-input` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3AINPUT-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-29-29"></a>

###### [reader](85d8) `reblocks-ui2/inputs/named:input-name` (named-input) (:name = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/SELECT

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FSELECT-22-29-20PACKAGE-29"></a>

#### [package](79e9) `reblocks-ui2/inputs/select`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-24OPTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OPTION

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-20CLASS-29"></a>

###### [class](7b17) `reblocks-ui2/inputs/select:option` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](eb2b) `reblocks-ui2/inputs/select:option-name` (option) (:name)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-SELECTED-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](77c3) `reblocks-ui2/inputs/select:option-selected-p` (option) (:selected = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](d4bd) `reblocks-ui2/inputs/select:option-value` (option) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-24SELECT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SELECT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-20CLASS-29"></a>

###### [class](16ed) `reblocks-ui2/inputs/select:select` (event-emitter base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](0b2a) `reblocks-ui2/inputs/select:select-disabled` (select) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](b66e) `reblocks-ui2/inputs/select:select-options` (select) (:options)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](1e10) `reblocks-ui2/inputs/select:select-pin` (select) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](efca) `reblocks-ui2/inputs/select:select-size` (select) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](7a5a) `reblocks-ui2/inputs/select:select-view` (select) (:view = (make-instance 'normal))

**Accessors**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [accessor](b66e) `reblocks-ui2/inputs/select:select-options` (select) (:options)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AENSURE-OPTION-20FUNCTION-29"></a>

##### [function](6fe6) `reblocks-ui2/inputs/select:ensure-option` value

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-20FUNCTION-29"></a>

##### [function](35f0) `reblocks-ui2/inputs/select:option` name &key value selected

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-20FUNCTION-29"></a>

##### [function](8f4e) `reblocks-ui2/inputs/select:select` options &key (widget-class 'select) name (view :normal) (pin :round) (size :m) disabled validator error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXT-INPUT

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-22-29-20PACKAGE-29"></a>

#### [package](45f0) `reblocks-ui2/inputs/text-input`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-24INPUT-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### INPUT-WIDGET

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-20CLASS-29"></a>

###### [class](b196) `reblocks-ui2/inputs/text-input:input-widget` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](2bab) `reblocks-ui2/inputs/text-input:input-disabled` (input-widget) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-LEFT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](3e3b) `reblocks-ui2/inputs/text-input:input-left-content` (input-widget) (:left-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](2d26) `reblocks-ui2/inputs/text-input:input-pin` (input-widget) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-PLACEHOLDER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](afba) `reblocks-ui2/inputs/text-input:input-placeholder` (input-widget) (:placeholder = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-RIGHT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](9008) `reblocks-ui2/inputs/text-input:input-right-content` (input-widget) (:right-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](e97e) `reblocks-ui2/inputs/text-input:input-size` (input-widget) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](1a01) `reblocks-ui2/inputs/text-input:input-type` (input-widget) (:type = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](5665) `reblocks-ui2/inputs/text-input:input-view` (input-widget) (:view = (make-instance 'normal))

**Accessors**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-LEFT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [accessor](3e3b) `reblocks-ui2/inputs/text-input:input-left-content` (input-widget) (:left-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-RIGHT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [accessor](9008) `reblocks-ui2/inputs/text-input:input-right-content` (input-widget) (:right-content = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-20FUNCTION-29"></a>

##### [function](3b43) `reblocks-ui2/inputs/text-input:input` &key (widget-class 'input-widget) name value (type :text) placeholder (view :normal) (pin :round) (size :m) disabled validator error left-content right-content

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXT-INPUT/VIEW

<a id="x-28-23A-28-2835-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-22-29-20PACKAGE-29"></a>

#### [package](72a7) `reblocks-ui2/inputs/text-input/view`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24CLEAR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CLEAR

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3ACLEAR-20CLASS-29"></a>

###### [class](b426) `reblocks-ui2/inputs/text-input/view:clear` (input-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24INPUT-VIEW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### INPUT-VIEW

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3AINPUT-VIEW-20CLASS-29"></a>

###### [class](d967) `reblocks-ui2/inputs/text-input/view:input-view` ()

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24NORMAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3ANORMAL-20CLASS-29"></a>

###### [class](985e) `reblocks-ui2/inputs/text-input/view:normal` (input-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3AENSURE-VIEW-20FUNCTION-29"></a>

##### [function](14f4) `reblocks-ui2/inputs/text-input/view:ensure-view` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXTAREA

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-22-29-20PACKAGE-29"></a>

#### [package](1d11) `reblocks-ui2/inputs/textarea`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-24TEXTAREA-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TEXTAREA

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-20CLASS-29"></a>

###### [class](e091) `reblocks-ui2/inputs/textarea:textarea` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](c437) `reblocks-ui2/inputs/textarea:textarea-disabled` (textarea) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](c815) `reblocks-ui2/inputs/textarea:textarea-pin` (textarea) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-PLACEHOLDER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](c9f5) `reblocks-ui2/inputs/textarea:textarea-placeholder` (textarea) (:placeholder = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](ad8e) `reblocks-ui2/inputs/textarea:textarea-size` (textarea) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](f6f2) `reblocks-ui2/inputs/textarea:textarea-type` (textarea) (:type = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](7199) `reblocks-ui2/inputs/textarea:textarea-view` (textarea) (:view = (make-instance 'normal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-20FUNCTION-29"></a>

##### [function](19c1) `reblocks-ui2/inputs/textarea:textarea` &key (widget-class 'textarea) name value (type :text) placeholder (view :normal) (pin :round) (size :m) disabled validator error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FMODAL-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/MODAL

<a id="x-28-23A-28-2818-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FMODAL-22-29-20PACKAGE-29"></a>

#### [package](3a4f) `reblocks-ui2/modal`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FMODAL-24MODAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### MODAL

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-20CLASS-29"></a>

###### [class](882b) `reblocks-ui2/modal:modal` (ui-widget)

This widget shows a popup window.

**Readers**

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HEADER-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](7dc4) `reblocks-ui2/modal:modal-header-content` (modal) (:header-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-MAIN-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](66b3) `reblocks-ui2/modal:modal-main-content` (modal) (:main-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-VISIBLE-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](b969) `reblocks-ui2/modal:modal-visible-p` (modal) (:visible = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HEADER-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [accessor](7dc4) `reblocks-ui2/modal:modal-header-content` (modal) (:header-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-MAIN-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [accessor](66b3) `reblocks-ui2/modal:modal-main-content` (modal) (:main-content)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HIDE-20GENERIC-FUNCTION-29"></a>

##### [generic-function](2da9) `reblocks-ui2/modal:modal-hide` widget

Hides modal window.

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-SHOW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](705b) `reblocks-ui2/modal:modal-show` widget &key content header-content

Shows modal window.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-20FUNCTION-29"></a>

##### [function](347c) `reblocks-ui2/modal:modal` content &key header-content visible

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FSIZES-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/SIZES

<a id="x-28-23A-28-2818-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FSIZES-22-29-20PACKAGE-29"></a>

#### [package](bac9) `reblocks-ui2/sizes`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FSIZES-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FSIZES-3AENSURE-SIZE-20FUNCTION-29"></a>

##### [function](5c92) `reblocks-ui2/sizes:ensure-size` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/CLICKABLE-ROW

<a id="x-28-23A-28-2833-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-22-29-20PACKAGE-29"></a>

#### [package](71d2) `reblocks-ui2/tables/clickable-row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-24CLICKABLE-ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CLICKABLE-ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3ACLICKABLE-ROW-WIDGET-20CLASS-29"></a>

###### [class](defe) `reblocks-ui2/tables/clickable-row:clickable-row-widget` (table-row)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3AMAKE-CLICKABLE-ROW-WIDGET-20FUNCTION-29"></a>

##### [function](4646) `reblocks-ui2/tables/clickable-row:make-clickable-row-widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCRUD-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/CRUD

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FCRUD-22-29-20PACKAGE-29"></a>

#### [package](b51a) `reblocks-ui2/tables/crud`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCRUD-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCRUD-24CRUD-TABLE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CRUD-TABLE

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-20CLASS-29"></a>

###### [class](0ca3) `reblocks-ui2/tables/crud:crud-table` (ui-widget)

A search table with Add, Edit and Delete actions.

This widget knows nothing about the persistence: forms are created by
`ADD-FORM-MAKER` and `EDIT-FORM-MAKER` callbacks, and the deletion is performed
by the `ON-DELETE` callback. All of them are optional: only the corresponding
buttons are rendered for the given callbacks.

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-ADD-BUTTON-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](4ec9) `reblocks-ui2/tables/crud:crud-add-button-title` (crud-table) (:ADD-BUTTON-TITLE = "Add")

The title of the button shown above the table. When `ADD-FORM-MAKER` is nil, the button is not rendered at all.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-ADD-FORM-MAKER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](390b) `reblocks-ui2/tables/crud:crud-add-form-maker` (crud-table) (:add-form-maker = nil)

A function of two arguments (`CRUD-WIDGET` `modal` ([`1`][dffa] [`2`][8f2d])), returning a form widget to show in the modal when the Add button is pressed.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-ADD-HEADER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](72eb) `reblocks-ui2/tables/crud:crud-add-header` (crud-table) (:add-header = nil)

A widget shown as the modal's header content when the add form is opened. When nil, the modal is shown without a header content.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-COLUMNS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](76c6) `reblocks-ui2/tables/crud:crud-columns` (crud-table) (:columns = nil)

Columns to show. Should not include an actions column, because [`crud-table`][1103] adds such a column by itself when at least one of `ADD-FORM-MAKER`, `EDIT-FORM-MAKER` or `ON-DELETE` is given.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-DATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](f11b) `reblocks-ui2/tables/crud:crud-data-getter` (crud-table) (:data-getter)

A function returning a list of objects to show. Given as is to [`reblocks-ui2/tables/search:make-search-widget`][7dcd], which calls it with a filters widget as the argument.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-DELETE-BUTTON-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](037c) `reblocks-ui2/tables/crud:crud-delete-button-title` (crud-table) (:DELETE-BUTTON-TITLE = "Delete")

The title of the Delete button in the actions column. Also used as the confirm button title of the delete confirmation form. When `ON-DELETE` is nil, the button is not rendered at all.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-DELETE-HEADER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](c6bb) `reblocks-ui2/tables/crud:crud-delete-header` (crud-table) (:delete-header = nil)

A widget shown as the modal's header content when the delete confirmation form is opened. When nil, the modal is shown without a header content.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-DELETE-QUESTION-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](d393) `reblocks-ui2/tables/crud:crud-delete-question` (crud-table) (:DELETE-QUESTION = "Delete this record?")

A question to show in the delete confirmation form. Either a string or a function of one argument (`OBJECT`) returning the question string.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-EDIT-BUTTON-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](bcc3) `reblocks-ui2/tables/crud:crud-edit-button-title` (crud-table) (:EDIT-BUTTON-TITLE = "Edit")

The title of the Edit button in the actions column. When `EDIT-FORM-MAKER` is nil, the button is not rendered at all.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-EDIT-FORM-MAKER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](bcab) `reblocks-ui2/tables/crud:crud-edit-form-maker` (crud-table) (:edit-form-maker = nil)

A function of two arguments (`modal` ([`1`][dffa] [`2`][8f2d]) `OBJECT`), returning a form widget to show in the modal when the row's Edit button for the `OBJECT` is pressed.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-EDIT-HEADER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](aa95) `reblocks-ui2/tables/crud:crud-edit-header` (crud-table) (:edit-header = nil)

A widget shown as the modal's header content when the edit form is opened. When nil, the modal is shown without a header content.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-MODAL-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](c287) `reblocks-ui2/tables/crud:crud-modal` (crud-table) (= nil)

The modal widget created by the latest `RENDER`. Useful to hide the modal from application's form callbacks.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-ON-DELETE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](b964) `reblocks-ui2/tables/crud:crud-on-delete` (crud-table) (:on-delete = nil)

A function of one argument (`OBJECT`), called when deletion of the `OBJECT` was confirmed in the modal.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-ROW-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](d18a) `reblocks-ui2/tables/crud:crud-row-class` (crud-table) (:row-class = nil)

A widget class name to create table rows of. Given as `:ROW-CLASS` argument to [`reblocks-ui2/tables/search:make-search-widget`][7dcd].

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-SEARCH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](9202) `reblocks-ui2/tables/crud:crud-search` (crud-table) (= nil)

The search widget created by the latest `RENDER`. Useful to reach the table widget from application's code or in tests.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCRUD-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ADELETE-QUESTION-TEXT-20FUNCTION-29"></a>

##### [function](224d) `reblocks-ui2/tables/crud:delete-question-text` delete-question object

Returns the question to show in the delete confirmation form.

`DELETE-QUESTION` is either a string or a function of one argument, the row's
`OBJECT`, returning the question string.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3AFORM-BUTTON-VALUE-20FUNCTION-29"></a>

##### [function](c1b7) `reblocks-ui2/tables/crud:form-button-value` form-data

Returns the value submitted by the form's button named "button".

`FORM-DATA` is the plist given to a `:SUBMIT` event handler of a form widget.
Reblocks interns the keys of this plist as `UPPERCASE` keywords, that is why
a plain (`GETF` `FORM-DATA` :some-other-case) might not find the value. This
function compares key names as strings instead and works with any case.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3AMAKE-CRUD-TABLE-20FUNCTION-29"></a>

##### [function](5d81) `reblocks-ui2/tables/crud:make-crud-table` columns data-getter &rest restargs &key add-form-maker edit-form-maker on-delete delete-question add-button-title edit-button-title delete-button-title edit-header delete-header add-header row-class widget-class

Returns a table widget with search and Add/Edit/Delete actions.

`COLUMNS` should not include an actions column: it is added automatically
as the last column when at least one of `ADD-FORM-MAKER`, `EDIT-FORM-MAKER`
or `ON-DELETE` is given.

`DATA-GETTER` is given as is to [`reblocks-ui2/tables/search:make-search-widget`][7dcd]
and should return a list of objects to show.

* `ADD-FORM-MAKER` is called as (`FUNCALL` `ADD-FORM-MAKER` `CRUD-WIDGET` `modal` ([`1`][dffa] [`2`][8f2d]))
  and should return a form widget.
* `EDIT-FORM-MAKER` is called as (`FUNCALL` `EDIT-FORM-MAKER` `modal` ([`1`][dffa] [`2`][8f2d]) `OBJECT`)
  and should return a form widget.
* `ON-DELETE` is called as (`FUNCALL` `ON-DELETE` `OBJECT`) after the user has
  confirmed the deletion.

When the library opens a form in the modal, it also subscribes to the
form's `:SUBMIT` event, to update the table after a successful submission:
the whole table is updated after the add form was submitted, and only
the row's cells are recalculated after the edit form was submitted.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ASUBMITTED-WITH-SUBMIT-BUTTON-P-20FUNCTION-29"></a>

##### [function](49c7) `reblocks-ui2/tables/crud:submitted-with-submit-button-p` form-data

Returns T when `FORM-DATA` was submitted by a button having the value "submit".

Use this predicate in `:SUBMIT` event handlers to detect which button was
pressed, see [`form-button-value`][d47c] for the case-sensitivity details.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/EDITABLE-TABLE

<a id="x-28-23A-28-2834-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-22-29-20PACKAGE-29"></a>

#### [package](239b) `reblocks-ui2/tables/editable-table`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24EDITABLE-COLUMN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EDITABLE-COLUMN

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-20CLASS-29"></a>

###### [class](e7a2) `reblocks-ui2/tables/editable-table:editable-column` (column)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3ADATA-SETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-29-29"></a>

###### [reader](4d4c) `reblocks-ui2/tables/editable-table:data-setter` (editable-column) (:setter = #'default-setter)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24EDITABLE-TABLE-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EDITABLE-TABLE-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-20CLASS-29"></a>

###### [class](cc43) `reblocks-ui2/tables/editable-table:editable-table-widget` (table-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-CREATOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29"></a>

###### [reader](d180) `reblocks-ui2/tables/editable-table:object-creator` (editable-table-widget) (:object-creator = nil)

When given, should be a function of zero arguments.
Will be called when user adds a new table row.
Usually you will want to do create and add an object to a database.
Returned object will be bound to a new table row and used to fill cells with new values.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-DELETER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29"></a>

###### [reader](48f3) `reblocks-ui2/tables/editable-table:object-deleter` (editable-table-widget) (:object-deleter = nil)

When given, should be a function of one argument.
Will be called with object instance to be deleted from the table.
Usually you will want to do something like deletion the record from a database.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24ROW-NOT-FOUND-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ROW-NOT-FOUND

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AROW-NOT-FOUND-20CONDITION-29"></a>

###### [condition](e840) `reblocks-ui2/tables/editable-table:row-not-found` (error)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3ADELETE-ROW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f7dc) `reblocks-ui2/tables/editable-table:delete-row` table obj

Deletes row representing given object.
First it calls [`object-deleter`][cc16] callback and then
removes corresponding row from the table.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-20FUNCTION-29"></a>

##### [function](d1fe) `reblocks-ui2/tables/editable-table:editable-column` title &key (getter nil getter-given-p) (setter #'default-setter) (cell-maker #'create-widget-from) (align :left)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AMAKE-EDITABLE-TABLE-20FUNCTION-29"></a>

##### [function](f2cf) `reblocks-ui2/tables/editable-table:make-editable-table` columns rows &key (table-class 'editable-table-widget) (row-class nil row-class-given-p) (object-deleter nil object-deleter-given-p) (object-creator nil object-creator-given-p)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/SEARCH

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FSEARCH-22-29-20PACKAGE-29"></a>

#### [package](e414) `reblocks-ui2/tables/search`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-24CONTROLS-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTROLS-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-20CLASS-29"></a>

###### [class](1f13) `reblocks-ui2/tables/search:controls-widget` (event-emitting-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-BUTTON-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-29-29"></a>

###### [reader](85fc) `reblocks-ui2/tables/search::next-page-button` (controls-widget) (:button)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ASHOW-BUTTON-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-29-29"></a>

###### [reader](e391) `reblocks-ui2/tables/search::show-button-p` (controls-widget) (= nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-24SEARCH-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SEARCH-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-20CLASS-29"></a>

###### [class](62c3) `reblocks-ui2/tables/search:search-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](1f4c) `reblocks-ui2/tables/search:controls-widget` (search-widget) (:controls)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ADATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](9002) `reblocks-ui2/tables/search::data-getter` (search-widget) (:data-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3AFILTERS-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](d719) `reblocks-ui2/tables/search::filters-widget` (search-widget) (:filters)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](3e31) `reblocks-ui2/tables/search::next-page-getter` (search-widget) (:next-page-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](39ec) `reblocks-ui2/tables/table:table-widget` (search-widget) (:table)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [accessor](3e31) `reblocks-ui2/tables/search::next-page-getter` (search-widget) (:next-page-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [accessor](39ec) `reblocks-ui2/tables/table:table-widget` (search-widget) (:table)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AFILTERS-UPDATED-20GENERIC-FUNCTION-29"></a>

##### [generic-function](492e) `reblocks-ui2/tables/search:filters-updated` widget

Signals that filters state was changed and table with results should be updated.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AHIDE-NEXT-PAGE-BUTTON-20GENERIC-FUNCTION-29"></a>

##### [generic-function](b51e) `reblocks-ui2/tables/search:hide-next-page-button` widget

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASHOW-NEXT-PAGE-BUTTON-20GENERIC-FUNCTION-29"></a>

##### [generic-function](a249) `reblocks-ui2/tables/search:show-next-page-button` widget

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AMAKE-DEFAULT-CONTROLS-WIDGET-20FUNCTION-29"></a>

##### [function](cb8d) `reblocks-ui2/tables/search:make-default-controls-widget` &KEY (BUTTON-TITLE "Load more")

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AMAKE-SEARCH-WIDGET-20FUNCTION-29"></a>

##### [function](ec5e) `reblocks-ui2/tables/search:make-search-widget` columns data-getter &key (filters-widget nil filters-widget-given-p) (controls-widget nil controls-widget-given-p) (widget-class 'search-widget) (table-class nil table-class-given-p) (row-class nil row-class-given-p)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/TABLE

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FTABLE-22-29-20PACKAGE-29"></a>

#### [package](2c74) `reblocks-ui2/tables/table`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24COLUMN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20CLASS-29"></a>

###### [class](1f75) `reblocks-ui2/tables/table:column` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACELL-MAKER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](3825) `reblocks-ui2/tables/table:cell-maker` (column) (:cell-maker = #'create-widget-from)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-ALIGN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](f0d5) `reblocks-ui2/tables/table:column-align` (column) (:align = :left)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CLASSES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](2704) `reblocks-ui2/tables/table:column-classes` (column) (:classes = nil)

Additional `CSS` classes for column cells

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](1bee) `reblocks-ui2/tables/table:column-idx` (column) (= nil)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](654e) `reblocks-ui2/tables/table:column-title` (column) (:title)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ADATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](a9dc) `reblocks-ui2/tables/table:data-getter` (column) (:GETTER = (LAMBDA (ROW)
  (DECLARE (IGNORE ROW))
  (ERROR "Real getter should be provided to COLUMN function.")))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-ROW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-ROW

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-20CLASS-29"></a>

###### [class](d64f) `reblocks-ui2/tables/table:table-row` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-CELLS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](2ba1) `reblocks-ui2/tables/table:row-cells` (table-row) (:cells)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-OBJECT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](59b0) `reblocks-ui2/tables/table:row-object` (table-row) (:object)

Original object, passed as a row to the [`make-table`][e390] function.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-TABLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](944f) `reblocks-ui2/tables/table:row-table` (table-row) (:table)

Reference it a table row belong to.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20CLASS-29"></a>

###### [class](8b2d) `reblocks-ui2/tables/table:table-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-COLUMNS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](6de5) `reblocks-ui2/tables/table:table-columns` (table-widget) (:columns = nil)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](c8c8) `reblocks-ui2/tables/table:table-row-class` (table-widget) (:row-class = 'table-row)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROWS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](b0a7) `reblocks-ui2/tables/table:table-rows` (table-widget) (:rows = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AAPPEND-DATA-20GENERIC-FUNCTION-29"></a>

##### [generic-function](0b2d) `reblocks-ui2/tables/table:append-data` widget data

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](9823) `reblocks-ui2/tables/table:column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AHEADER-COLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](0e2d) `reblocks-ui2/tables/table:header-column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20GENERIC-FUNCTION-29"></a>

##### [generic-function] `reblocks-ui2/tables/table:table-widget` object

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20FUNCTION-29"></a>

##### [function](3137) `reblocks-ui2/tables/table:column` title &key (getter nil getter-given-p) (cell-maker nil cell-maker-p) (align :center) (classes nil clases-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-CELL-20FUNCTION-29"></a>

##### [function](9bf6) `reblocks-ui2/tables/table:current-cell`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-COLUMN-20FUNCTION-29"></a>

##### [function](fa2d) `reblocks-ui2/tables/table:current-column`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-ROW-20FUNCTION-29"></a>

##### [function](76f9) `reblocks-ui2/tables/table:current-row`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-TABLE-20FUNCTION-29"></a>

##### [function](cf55) `reblocks-ui2/tables/table:current-table`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AMAKE-TABLE-20FUNCTION-29"></a>

##### [function](6057) `reblocks-ui2/tables/table:make-table` columns rows &key (table-class 'table-widget) (row-class nil row-class-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ARECALCULATE-CELLS-20FUNCTION-29"></a>

##### [function](9651) `reblocks-ui2/tables/table:recalculate-cells` row &key (update t)

Updates cell widgets using base object, stored in the `ROW`.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/API

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FAPI-22-29-20PACKAGE-29"></a>

#### [package](4f12) `reblocks-ui2/themes/api`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FAPI-3ACURRENT-THEME-20FUNCTION-29"></a>

##### [function](aeaf) `reblocks-ui2/themes/api:current-theme`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FAPI-3ADEFTHEME-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](b425) `reblocks-ui2/themes/api:deftheme` name bases &rest var-forms

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/BASE

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FBASE-22-29-20PACKAGE-29"></a>

#### [package](a609) `reblocks-ui2/themes/base`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-24BASE-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BASE-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FBASE-3ABASE-THEME-20CLASS-29"></a>

###### [class](3fd0) `reblocks-ui2/themes/base:base-theme` ()

A base theme class for all `Reblocks-UI2` themes.

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FBASE-3AOVERRIDED-VARS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FBASE-3ABASE-THEME-29-29"></a>

###### [reader](9748) `reblocks-ui2/themes/base:overrided-vars` (base-theme) (:overridden-vars = (make-hash-table :test 'equal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/COLOR

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FCOLOR-22-29-20PACKAGE-29"></a>

#### [package](2e01) `reblocks-ui2/themes/color`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-24COLOR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLOR

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-20CLASS-29"></a>

###### [class](104c) `reblocks-ui2/themes/color:color` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-DARK-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](9728) `reblocks-ui2/themes/color:color-dark` (color) (:dark = nil)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-FOCUS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](674c) `reblocks-ui2/themes/color:color-focus` (color) (:focus = nil)

If string, then it is a color of element in "focus" state. If integer, then it is intensity change relative to the base color. For light scheme intensity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-HOVER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](37f0) `reblocks-ui2/themes/color:color-hover` (color) (:hover = nil)

If string, then it is a color of element in "hover" state. If integer, then it is intensity change relative to the base color. For light scheme intensity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-LIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](953a) `reblocks-ui2/themes/color:color-light` (color) (:light = nil)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-PROPERTY-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](ad37) `reblocks-ui2/themes/color:color-property` (color) (:PROPERTY = (REQUIRED-ARGUMENT "property"))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3AADJUST-BASE-COLOR-20GENERIC-FUNCTION-29"></a>

##### [generic-function](26ed) `reblocks-ui2/themes/color:adjust-base-color` theme base-color adjustment

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3AADJUST-COLOR-20FUNCTION-29"></a>

##### [function](fd86) `reblocks-ui2/themes/color:adjust-color` theme color &key (light nil light-p) (dark nil dark-p) (hover nil hover-p) (focus nil focus-p)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-20FUNCTION-29"></a>

##### [function](7519) `reblocks-ui2/themes/color:color` property &key light dark hover focus

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/STYLING

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FSTYLING-22-29-20PACKAGE-29"></a>

#### [package](c8af) `reblocks-ui2/themes/styling`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3ACSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](ecbf) `reblocks-ui2/themes/styling:css-classes` object theme &key size invalid-state

Returns classes for a widget or it's property.

Result can be a list, string or a keyword.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3ACSS-STYLES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](63dc) `reblocks-ui2/themes/styling:css-styles` object theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](e2f8) `reblocks-ui2/themes/styling:join-css-classes` theme &rest classes

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AMERGE-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](ed39) `reblocks-ui2/themes/styling:merge-css-classes` theme classes

This generic function is called before [`join-css-classes`][0785] will output classes as a string.

Depending on theme some transformations can be applied to the list of `CSS` classes, given as `CLASSES` argument.
For example, a theme based on Tailwind framework, might merge `CSS` classes list allowing to override properties.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-STYLES-20FUNCTION-29"></a>

##### [function](9ea2) `reblocks-ui2/themes/styling:join-css-styles` &rest styles

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/TAILWIND

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FTAILWIND-22-29-20PACKAGE-29"></a>

#### [package](2e57) `reblocks-ui2/themes/tailwind`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-24TAILWIND-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TAILWIND-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ATAILWIND-THEME-20CLASS-29"></a>

###### [class](f22a) `reblocks-ui2/themes/tailwind:tailwind-theme` (base-theme)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACARD-BORDER-RADIUS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:card-border-radius` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-ACTION-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-bg-action` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-DANGER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-bg-danger` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-INFO-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-bg-info` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-bg-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-SUCCESS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-bg-success` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-UTILITY-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-bg-utility` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-WARNING-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-bg-warning` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-ACTION-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-border-action` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-DANGER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-border-danger` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-INFO-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-border-info` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-border-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-SUCCESS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-border-success` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-UTILITY-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-border-utility` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-WARNING-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-border-warning` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-LINE-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-line-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-TEXT-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:colors-text-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-MARGIN-SIZES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:core-margin-sizes` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-MODE-20GENERIC-FUNCTION-29"></a>

##### [generic-function](bd89) `reblocks-ui2/themes/tailwind:core-mode` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-PADDING-SIZES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:core-padding-sizes` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ATABS-ACTIVE-COLOR-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f22a) `reblocks-ui2/themes/tailwind:tabs-active-color` theme

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](f22a) `reblocks-ui2/themes/tailwind:make-tailwind-theme` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-DARK-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](bd89) `reblocks-ui2/themes/tailwind:make-tailwind-theme-dark` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-LIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](40d5) `reblocks-ui2/themes/tailwind:make-tailwind-theme-light` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/TAILWIND/ARBITRARY

<a id="x-28-23A-28-2838-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-22-29-20PACKAGE-29"></a>

#### [package](df4c) `reblocks-ui2/themes/tailwind/arbitrary`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-24ARBITRARY-VALUE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ARBITRARY-VALUE

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-20CLASS-29"></a>

###### [class](0a2d) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-ARGS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-29-29"></a>

###### [reader](d799) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value-args` (arbitrary-value) (:args)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-PREFIX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-29-29"></a>

###### [reader](886c) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value-prefix` (arbitrary-value) (:prefix)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-20FUNCTION-29"></a>

##### [function](c2a3) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value` prefix &rest args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/ALIGN

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FALIGN-22-29-20PACKAGE-29"></a>

#### [package](562e) `reblocks-ui2/utils/align`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-24HORIZONTAL-ALIGN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### HORIZONTAL-ALIGN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-20CLASS-29"></a>

###### [class](be24) `reblocks-ui2/utils/align:horizontal-align` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-29-29"></a>

###### [reader](a212) `reblocks-ui2/utils/align:horizontal-align-value` (horizontal-align) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-24VERTICAL-ALIGN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### VERTICAL-ALIGN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-20CLASS-29"></a>

###### [class](b761) `reblocks-ui2/utils/align:vertical-align` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-29-29"></a>

###### [reader](427a) `reblocks-ui2/utils/align:vertical-align-value` (vertical-align) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-20FUNCTION-29"></a>

##### [function](2fea) `reblocks-ui2/utils/align:horizontal-align` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-20FUNCTION-29"></a>

##### [function](ef6b) `reblocks-ui2/utils/align:vertical-align` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-VALUE-20-28TYPE-29-29"></a>

##### [type](29e8) `reblocks-ui2/utils/align:horizontal-align-value`

```
(MEMBER :LEFT :CENTER :TOP)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-VALUE-20-28TYPE-29-29"></a>

##### [type](8d1c) `reblocks-ui2/utils/align:vertical-align-value`

```
(MEMBER :TOP :CENTER :BOTTOM)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/MARGIN

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FMARGIN-22-29-20PACKAGE-29"></a>

#### [package](1441) `reblocks-ui2/utils/margin`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FMARGIN-24MARGIN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### MARGIN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-20CLASS-29"></a>

###### [class](0be3) `reblocks-ui2/utils/margin:margin` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-BOTTOM-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](ae28) `reblocks-ui2/utils/margin:margin-bottom` (margin) (:bottom = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-LEFT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](619d) `reblocks-ui2/utils/margin:margin-left` (margin) (:left = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-RIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](8416) `reblocks-ui2/utils/margin:margin-right` (margin) (:right = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-TOP-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](a6ac) `reblocks-ui2/utils/margin:margin-top` (margin) (:top = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-20FUNCTION-29"></a>

##### [function](a8ba) `reblocks-ui2/utils/margin:margin` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/PADDING

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FPADDING-22-29-20PACKAGE-29"></a>

#### [package](b67a) `reblocks-ui2/utils/padding`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPADDING-24PADDING-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### PADDING

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-20CLASS-29"></a>

###### [class](e985) `reblocks-ui2/utils/padding:padding` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-HORIZONTAL-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-29-29"></a>

###### [reader](52b2) `reblocks-ui2/utils/padding:padding-horizontal-size` (padding) (:horizontal = :l)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-VERTICAL-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-29-29"></a>

###### [reader](c620) `reblocks-ui2/utils/padding:padding-vertical-size` (padding) (:vertical = :l)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-20FUNCTION-29"></a>

##### [function](bd9f) `reblocks-ui2/utils/padding:padding` size

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3ANULLABLE-PADDING-SIZE-20-28TYPE-29-29"></a>

##### [type](293c) `reblocks-ui2/utils/padding:nullable-padding-size`

```
(OR NULL PADDING-SIZE)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-SIZE-20-28TYPE-29-29"></a>

##### [type](6ff6) `reblocks-ui2/utils/padding:padding-size`

```
(MEMBER :S :M :L :XL)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/PRIMITIVE-TO

<a id="x-28-23A-28-2831-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-22-29-20PACKAGE-29"></a>

#### [package](ee3e) `reblocks-ui2/utils/primitive-to`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3APROCESS-PRIMITIVE-ARGS-20FUNCTION-29"></a>

##### [function](0682) `reblocks-ui2/utils/primitive-to:process-primitive-args` keyword-args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/SIZE

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FSIZE-22-29-20PACKAGE-29"></a>

#### [package](61ad) `reblocks-ui2/utils/size`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24HEIGHT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### HEIGHT

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AHEIGHT-20CLASS-29"></a>

###### [class](ba12) `reblocks-ui2/utils/size:height` (size)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24RESPONSIVE-HEIGHT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RESPONSIVE-HEIGHT

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-20CLASS-29"></a>

###### [class](d6a0) `reblocks-ui2/utils/size:responsive-height` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMAX-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-29-29"></a>

###### [reader](4e62) `reblocks-ui2/utils/size:max-height` (responsive-height) (:max = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMIN-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-29-29"></a>

###### [reader](0543) `reblocks-ui2/utils/size:min-height` (responsive-height) (:min = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24RESPONSIVE-WIDTH-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RESPONSIVE-WIDTH

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-20CLASS-29"></a>

###### [class](b10f) `reblocks-ui2/utils/size:responsive-width` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMAX-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-29-29"></a>

###### [reader](477f) `reblocks-ui2/utils/size:max-width` (responsive-width) (:max = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMIN-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-29-29"></a>

###### [reader](0c85) `reblocks-ui2/utils/size:min-width` (responsive-width) (:min = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24SIZE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SIZE

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-20CLASS-29"></a>

###### [class](bf3f) `reblocks-ui2/utils/size:size` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-29-29"></a>

###### [reader](70d3) `reblocks-ui2/utils/size:size-value` (size) (:value)

If integer, then it will be considered as "px".
If string, then will be used as is (meaning depends on current theme).

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24WIDTH-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### WIDTH

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AWIDTH-20CLASS-29"></a>

###### [class](5755) `reblocks-ui2/utils/size:width` (size)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AENSURE-HEIGHT-20FUNCTION-29"></a>

##### [function](91c5) `reblocks-ui2/utils/size:ensure-height` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AENSURE-WIDTH-20FUNCTION-29"></a>

##### [function](5d50) `reblocks-ui2/utils/size:ensure-width` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AHEIGHT-20FUNCTION-29"></a>

##### [function](60fa) `reblocks-ui2/utils/size:height` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-20FUNCTION-29"></a>

##### [function](6259) `reblocks-ui2/utils/size:responsive-height` &key min max

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-20FUNCTION-29"></a>

##### [function](2ee3) `reblocks-ui2/utils/size:responsive-width` &key min max

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AWIDTH-20FUNCTION-29"></a>

##### [function](069e) `reblocks-ui2/utils/size:width` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASOME-HEIGHT-20-28TYPE-29-29"></a>

##### [type](b204) `reblocks-ui2/utils/size:some-height`

```
(OR HEIGHT RESPONSIVE-HEIGHT)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASOME-WIDTH-20-28TYPE-29-29"></a>

##### [type](1c55) `reblocks-ui2/utils/size:some-width`

```
(OR WIDTH RESPONSIVE-WIDTH)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FWALK-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/WALK

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FWALK-22-29-20PACKAGE-29"></a>

#### [package](47c2) `reblocks-ui2/utils/walk`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FWALK-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FUTILS-2FWALK-3ACHILDREN-20GENERIC-FUNCTION-29"></a>

##### [generic-function](0cff) `reblocks-ui2/utils/walk:children` widget

<a id="x-28REBLOCKS-UI2-2FUTILS-2FWALK-3AWALK-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f6ed) `reblocks-ui2/utils/walk:walk` widget visitor-func

A protocol to go through widgets tree and to call `VISITOR-FUNC` on each node.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/WIDGET

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FWIDGET-22-29-20PACKAGE-29"></a>

#### [package](f6db) `reblocks-ui2/widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-24UI-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### UI-WIDGET

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-20CLASS-29"></a>

###### [class](d2e3) `reblocks-ui2/widget:ui-widget` (widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AON-CLICK-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](d24a) `reblocks-ui2/widget:on-click` (ui-widget) (:on-click = nil)

When an on-click action is given, cursor style will be changed to "pointer".

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](f087) `reblocks-ui2/widget:widget-height` (ui-widget) (:height = nil)

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-MARGIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](3123) `reblocks-ui2/widget:widget-margin` (ui-widget) (:margin = nil)

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](8d0f) `reblocks-ui2/widget:widget-width` (ui-widget) (:width = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-DEPENDENCIES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](abe6) `reblocks-ui2/widget:get-dependencies` widget theme

Works like [`reblocks/dependencies:get-dependencies`][2397] generic-function, but
in context of current theme.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-HTML-TAG-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f45c) `reblocks-ui2/widget:get-html-tag` widget theme

Works like [`reblocks/widget:get-html-tag`][ab65] generic-function, but
in context of current theme.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AHTML-ATTRS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](7ddd) `reblocks-ui2/widget:html-attrs` widget theme

May return a plist of attributes to add to the main widget's `HTML` node.

It should not return `:ID` `:CLASS` or `:ONCLICK` attributes.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3ARENDER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c5f7) `reblocks-ui2/widget:render` widget theme

Renders widget in given theme. All reblocks-ui2 widgets
should implement this method instead of a method
for [`reblocks/widget:render`][5607] generic-function.


[e41b]: https://40ants.com/reblocks-ui2/
[3189]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-20CLASS-29
[44f8]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-20FUNCTION-29
[a4b2]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-20CLASS-29
[c339]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-20FUNCTION-29
[6f80]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-20CONDITION-29
[4945]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20CONDITION-29
[af7e]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20FUNCTION-29
[3cb7]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AALL-20FUNCTION-29
[556a]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-DATE-20FUNCTION-29
[23c2]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FFORM-3AFORM-20FUNCTION-29
[b7d1]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FHTML-3AHTML-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29
[8d22]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-20FUNCTION-29
[8f2d]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FMODAL-3AMODAL-20CLASS-29
[dffa]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FMODAL-3AMODAL-20FUNCTION-29
[ba16]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HIDE-20GENERIC-FUNCTION-29
[1103]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-20CLASS-29
[d47c]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3AFORM-BUTTON-VALUE-20FUNCTION-29
[cc16]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-DELETER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29
[7dcd]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AMAKE-SEARCH-WIDGET-20FUNCTION-29
[e390]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AMAKE-TABLE-20FUNCTION-29
[0785]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-CLASSES-20GENERIC-FUNCTION-29
[2397]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FDEPENDENCIES-3AGET-DEPENDENCIES-20GENERIC-FUNCTION-29
[5f3d]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FWIDGET-3ACREATE-WIDGET-FROM-20GENERIC-FUNCTION-29
[ab65]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FWIDGET-3AGET-HTML-TAG-20GENERIC-FUNCTION-29
[5607]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FWIDGET-3ARENDER-20GENERIC-FUNCTION-29
[2d52]: https://github.com/40ants/reblocks-ui2
[9201]: https://github.com/40ants/reblocks-ui2/actions
[a8cb]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L1
[bd2d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L51
[8ae2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L52
[3511]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L55
[edeb]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L58
[782c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L61
[4da4]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L64
[ec0f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L67
[ac49]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L70
[9699]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L74
[30f9]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/button.lisp#L82
[c858]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L1
[312b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L21
[ce88]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L24
[5ec0]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L27
[e0f7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L30
[9558]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L33
[cd85]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L36
[650f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L39
[bade]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L42
[9375]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L45
[b50e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L48
[a966]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L51
[bb7a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L54
[c320]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L57
[732b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L61
[b1da]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/buttons/view.lisp#L77
[07f1]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/card.lisp#L1
[ba3a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/card.lisp#L51
[0192]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/card.lisp#L52
[9a19]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/card.lisp#L55
[5011]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/card.lisp#L58
[16cb]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/card.lisp#L61
[84f7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/card.lisp#L65
[2dfc]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/card.lisp#L71
[d330]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/chart.lisp#L1
[03d2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/chart.lisp#L21
[2976]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/chart.lisp#L22
[edf1]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/chart.lisp#L27
[ea7b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/chart.lisp#L35
[d242]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/chart.lisp#L40
[5c8e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/chart.lisp#L45
[0f59]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/chart.lisp#L50
[3395]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/column-chart.lisp#L1
[06bc]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/column-chart.lisp#L18
[fd61]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/column-chart.lisp#L19
[03ed]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/column-chart.lisp#L24
[5531]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/column-chart.lisp#L29
[05e7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/column-chart.lisp#L54
[aa3a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/pie-chart.lisp#L1
[0a2b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/pie-chart.lisp#L19
[825d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/pie-chart.lisp#L20
[457c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/pie-chart.lisp#L27
[f270]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/pie-chart.lisp#L32
[ce2e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/charts/pie-chart.lisp#L57
[7d09]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/column.lisp#L1
[79f2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/column.lisp#L23
[8615]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/column.lisp#L27
[6732]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/container.lisp#L1
[4fb7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/container.lisp#L28
[3fa7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/container.lisp#L29
[0123]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/container.lisp#L33
[762e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/container.lisp#L36
[f58f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/container.lisp#L46
[254c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/container.lisp#L77
[bc4e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/controls-row.lisp#L1
[af14]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/controls-row.lisp#L21
[c038]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/controls-row.lisp#L31
[2db0]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/row.lisp#L1
[7a77]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/row.lisp#L25
[7966]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/row.lisp#L29
[8487]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/row.lisp#L35
[da66]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/stack.lisp#L1
[e5c7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/stack.lisp#L25
[a91b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/stack.lisp#L26
[5d40]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/stack.lisp#L31
[913b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/stack.lisp#L45
[c7df]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/stack.lisp#L53
[cbf2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/stack.lisp#L59
[d4a1]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/stack.lisp#L66
[ffaf]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/stack.lisp#L71
[3922]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L1
[6c1a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L39
[ebb4]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L43
[19d4]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L44
[25b7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L46
[f3d4]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L49
[d7f1]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L54
[0a15]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L55
[427c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L57
[7f46]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L63
[848d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/containers/tabs.lisp#L93
[2534]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/editable.lisp#L1
[74c7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/editable.lisp#L7
[318d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/events.lisp#L1
[35fd]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/events.lisp#L13
[e910]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form.lisp#L1
[11aa]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form.lisp#L109
[e5ad]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form.lisp#L46
[3e5d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form.lisp#L47
[f9a3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form.lisp#L49
[ffe0]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form.lisp#L52
[145b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/confirm.lisp#L1
[18b1]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/confirm.lisp#L29
[4021]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validation.lisp#L1
[0b8a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validation.lisp#L16
[cbf4]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validation.lisp#L29
[4c19]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validation.lisp#L35
[9c3a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validation.lisp#L40
[5758]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validation.lisp#L47
[cf83]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validators.lisp#L1
[9ed6]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validators.lisp#L127
[65d5]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validators.lisp#L178
[2237]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validators.lisp#L222
[c6f9]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validators.lisp#L25
[4255]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validators.lisp#L55
[5fd8]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/form/validators.lisp#L86
[156b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/html.lisp#L1
[8585]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/html.lisp#L131
[0196]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/html.lisp#L55
[5434]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/icon.lisp#L1
[f327]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/icon.lisp#L13
[a5d2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/icon.lisp#L14
[3f00]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/icon.lisp#L18
[c032]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/base.lisp#L1
[3378]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/base.lisp#L42
[42ae]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/base.lisp#L43
[5d92]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/base.lisp#L46
[eeb6]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/base.lisp#L50
[2466]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/checkbox.lisp#L1
[2ef5]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/checkbox.lisp#L26
[ef11]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/checkbox.lisp#L27
[92f9]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/checkbox.lisp#L31
[ad56]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/checkbox.lisp#L35
[e0ac]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/checkbox.lisp#L39
[bd55]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/checkbox.lisp#L46
[cb12]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/date-input.lisp#L1
[ccfe]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/date-input.lisp#L27
[b835]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/named.lisp#L1
[f770]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/named.lisp#L13
[85d8]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/named.lisp#L14
[79e9]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L1
[8f4e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L100
[7b17]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L42
[eb2b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L43
[d4bd]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L46
[77c3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L49
[35f0]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L61
[16ed]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L70
[b66e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L71
[7a5a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L74
[1e10]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L78
[efca]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L81
[0b2a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L85
[6fe6]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/select.lisp#L94
[45f0]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L1
[b196]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L34
[1a01]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L35
[afba]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L39
[5665]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L43
[2d26]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L47
[e97e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L50
[2bab]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L54
[3e3b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L58
[9008]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L62
[3b43]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input.lisp#L68
[72a7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input/view.lisp#L1
[d967]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input/view.lisp#L10
[985e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input/view.lisp#L13
[b426]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input/view.lisp#L16
[14f4]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/text-input/view.lisp#L19
[1d11]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/textarea.lisp#L1
[e091]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/textarea.lisp#L31
[f6f2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/textarea.lisp#L32
[c9f5]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/textarea.lisp#L36
[7199]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/textarea.lisp#L40
[c815]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/textarea.lisp#L44
[ad8e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/textarea.lisp#L47
[c437]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/textarea.lisp#L51
[19c1]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/inputs/textarea.lisp#L57
[3a4f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/modal.lisp#L1
[882b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/modal.lisp#L17
[7dc4]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/modal.lisp#L18
[66b3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/modal.lisp#L21
[b969]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/modal.lisp#L24
[347c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/modal.lisp#L31
[705b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/modal.lisp#L39
[2da9]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/modal.lisp#L56
[bac9]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/sizes.lisp#L1
[5c92]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/sizes.lisp#L31
[71d2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/clickable-row.lisp#L1
[defe]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/clickable-row.lisp#L24
[4646]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/clickable-row.lisp#L28
[b51a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L1
[d18a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L101
[9202]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L106
[c287]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L110
[5d81]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L138
[c1b7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L175
[49c7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L191
[224d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L205
[0ca3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L41
[76c6]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L42
[f11b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L47
[390b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L51
[bcab]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L56
[b964]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L61
[d393]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L66
[4ec9]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L71
[bcc3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L76
[037c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L81
[aa95]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L86
[c6bb]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L91
[72eb]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/crud.lisp#L96
[239b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/editable-table.lisp#L1
[d180]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/editable-table.lisp#L100
[f2cf]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/editable-table.lisp#L109
[d1fe]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/editable-table.lisp#L132
[e840]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/editable-table.lisp#L205
[f7dc]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/editable-table.lisp#L209
[e7a2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/editable-table.lisp#L70
[4d4c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/editable-table.lisp#L71
[cc43]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/editable-table.lisp#L90
[48f3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/editable-table.lisp#L94
[e414]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L1
[492e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L165
[b51e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L171
[a249]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L176
[62c3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L35
[d719]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L36
[39ec]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L39
[1f4c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L42
[9002]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L45
[3e31]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L48
[1f13]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L53
[e391]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L54
[85fc]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L56
[cb8d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L60
[ec5e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/search.lisp#L71
[2c74]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L1
[2704]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L102
[6057]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L150
[0e2d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L175
[9823]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L182
[3137]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L189
[cf55]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L227
[76f9]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L232
[fa2d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L237
[9bf6]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L242
[9651]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L248
[0b2d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L256
[d64f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L54
[2ba1]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L55
[944f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L58
[59b0]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L61
[8b2d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L66
[6de5]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L67
[b0a7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L71
[c8c8]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L75
[1f75]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L81
[1bee]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L82
[a9dc]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L85
[3825]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L91
[654e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L95
[f0d5]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/tables/table.lisp#L98
[4f12]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/api.lisp#L1
[b425]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/api.lisp#L210
[aeaf]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/api.lisp#L34
[a609]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/base.lisp#L1
[3fd0]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/base.lisp#L8
[9748]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/base.lisp#L9
[2e01]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/color.lisp#L1
[104c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/color.lisp#L16
[ad37]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/color.lisp#L17
[953a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/color.lisp#L21
[9728]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/color.lisp#L25
[37f0]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/color.lisp#L29
[674c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/color.lisp#L34
[7519]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/color.lisp#L51
[26ed]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/color.lisp#L63
[fd86]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/color.lisp#L66
[c8af]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/styling.lisp#L1
[ecbf]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/styling.lisp#L17
[63dc]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/styling.lisp#L29
[ed39]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/styling.lisp#L34
[e2f8]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/styling.lisp#L66
[9ea2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/styling.lisp#L73
[2e57]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/tailwind.lisp#L1
[40d5]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/tailwind.lisp#L141
[bd89]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/tailwind.lisp#L148
[f22a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/tailwind.lisp#L41
[df4c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/tailwind/arbitrary.lisp#L1
[0a2d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/tailwind/arbitrary.lisp#L19
[886c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/tailwind/arbitrary.lisp#L20
[d799]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/tailwind/arbitrary.lisp#L23
[c2a3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/themes/tailwind/arbitrary.lisp#L28
[562e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/align.lisp#L1
[29e8]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/align.lisp#L10
[8d1c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/align.lisp#L14
[be24]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/align.lisp#L18
[a212]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/align.lisp#L19
[b761]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/align.lisp#L24
[427a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/align.lisp#L25
[2fea]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/align.lisp#L35
[ef6b]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/align.lisp#L46
[1441]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/margin.lisp#L1
[0be3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/margin.lisp#L25
[619d]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/margin.lisp#L26
[8416]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/margin.lisp#L30
[a6ac]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/margin.lisp#L34
[ae28]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/margin.lisp#L38
[a8ba]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/margin.lisp#L50
[b67a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/padding.lisp#L1
[6ff6]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/padding.lisp#L11
[293c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/padding.lisp#L14
[e985]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/padding.lisp#L18
[52b2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/padding.lisp#L19
[c620]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/padding.lisp#L23
[bd9f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/padding.lisp#L40
[ee3e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/primitive-to.lisp#L1
[0682]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/primitive-to.lisp#L18
[61ad]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L1
[91c5]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L112
[bf3f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L22
[70d3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L23
[5755]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L36
[ba12]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L40
[b10f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L44
[0c85]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L45
[477f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L49
[d6a0]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L55
[0543]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L56
[4e62]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L60
[1c55]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L66
[b204]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L70
[069e]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L74
[2ee3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L79
[60fa]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L86
[6259]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L91
[5d50]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/size.lisp#L99
[47c2]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/walk.lisp#L1
[0cff]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/walk.lisp#L17
[f6ed]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/utils/walk.lisp#L8
[f6db]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/widget.lisp#L1
[f45c]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/widget.lisp#L106
[7ddd]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/widget.lisp#L113
[d2e3]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/widget.lisp#L50
[d24a]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/widget.lisp#L51
[3123]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/widget.lisp#L55
[8d0f]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/widget.lisp#L59
[f087]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/widget.lisp#L63
[c5f7]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/widget.lisp#L77
[abe6]: https://github.com/40ants/reblocks-ui2/blob/bb91ca95d2d248ac89f2452fd28b07f8e89f9307/src/widget.lisp#L99
[9c4e]: https://github.com/40ants/reblocks-ui2/issues
[8236]: https://quickdocs.org/alexandria
[c9ae]: https://quickdocs.org/anaphora
[61a4]: https://quickdocs.org/closer-mop
[bb23]: https://quickdocs.org/event-emitter
[3ad9]: https://quickdocs.org/lambda-fiddle
[46a1]: https://quickdocs.org/local-time
[7f8b]: https://quickdocs.org/log4cl
[5dbf]: https://quickdocs.org/moptilities
[d0a9]: https://quickdocs.org/named-readtables
[7921]: https://quickdocs.org/parenscript
[c01d]: https://quickdocs.org/pythonic-string-reader
[184b]: https://quickdocs.org/reblocks
[28e0]: https://quickdocs.org/reblocks-lass
[c41d]: https://quickdocs.org/serapeum
[ef7f]: https://quickdocs.org/str
[40a0]: https://quickdocs.org/trivial-arguments

* * *
###### [generated by [40ANTS-DOC](https://40ants.com/doc/)]
