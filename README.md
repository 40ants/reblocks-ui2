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

#### [package](4e02) `reblocks-ui2/buttons/button`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-24BUTTON-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BUTTON

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20CLASS-29"></a>

###### [class](45e5) `reblocks-ui2/buttons/button:button` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](bed3) `reblocks-ui2/buttons/button:button-class` (button) (:class)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](e176) `reblocks-ui2/buttons/button:button-content` (button) (:content)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](3804) `reblocks-ui2/buttons/button:button-disabled` (button) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](1531) `reblocks-ui2/buttons/button:button-pin` (button) (:pin)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](c869) `reblocks-ui2/buttons/button:button-size` (button) (:size = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-STYLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](818b) `reblocks-ui2/buttons/button:button-style` (button) (:style)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3A-3ABUTTON-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](75c8) `reblocks-ui2/buttons/button::button-type` (button) (:type = nil)

If not given, then type will be "button" for a button having on-click callback or "submit" otherwise.

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](5038) `reblocks-ui2/buttons/button:button-view` (button) (:view = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](bed3) `reblocks-ui2/buttons/button:button-class` (button) (:class)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](e176) `reblocks-ui2/buttons/button:button-content` (button) (:content)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](3804) `reblocks-ui2/buttons/button:button-disabled` (button) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](1531) `reblocks-ui2/buttons/button:button-pin` (button) (:pin)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](c869) `reblocks-ui2/buttons/button:button-size` (button) (:size = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-STYLE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](818b) `reblocks-ui2/buttons/button:button-style` (button) (:style)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3A-3ABUTTON-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](75c8) `reblocks-ui2/buttons/button::button-type` (button) (:type = nil)

If not given, then type will be "button" for a button having on-click callback or "submit" otherwise.

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](5038) `reblocks-ui2/buttons/button:button-view` (button) (:view = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20FUNCTION-29"></a>

##### [function](c349) `reblocks-ui2/buttons/button:button` CONTENT &KEY NAME VALUE TYPE (WIDGET-CLASS 'BUTTON) ON-CLICK (CLASS "button") DISABLED STYLE (VIEW :NORMAL) (SIZE :L) (PIN :ROUND) (WIDTH :MIN) HEIGHT

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/BUTTONS/VIEW

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FBUTTONS-2FVIEW-22-29-20PACKAGE-29"></a>

#### [package](4076) `reblocks-ui2/buttons/view`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24ACTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ACTION

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AACTION-20CLASS-29"></a>

###### [class](82ae) `reblocks-ui2/buttons/view:action` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24BUTTON-VIEW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BUTTON-VIEW

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ABUTTON-VIEW-20CLASS-29"></a>

###### [class](20c0) `reblocks-ui2/buttons/view:button-view` ()

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24NORMAL-DISABLED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL-DISABLED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ANORMAL-DISABLED-20CLASS-29"></a>

###### [class](e14b) `reblocks-ui2/buttons/view:normal-disabled` (normal)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24NORMAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ANORMAL-20CLASS-29"></a>

###### [class](d0b0) `reblocks-ui2/buttons/view:normal` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-ACTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-ACTION

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-ACTION-20CLASS-29"></a>

###### [class](d5ec) `reblocks-ui2/buttons/view:outlined-action` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-DANGER-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-DANGER

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-DANGER-20CLASS-29"></a>

###### [class](bf28) `reblocks-ui2/buttons/view:outlined-danger` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-INFO-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-INFO

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-INFO-20CLASS-29"></a>

###### [class](9075) `reblocks-ui2/buttons/view:outlined-info` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-SUCCESS-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-SUCCESS

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-SUCCESS-20CLASS-29"></a>

###### [class](bdc8) `reblocks-ui2/buttons/view:outlined-success` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-UTILITY-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-UTILITY

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-UTILITY-20CLASS-29"></a>

###### [class](6118) `reblocks-ui2/buttons/view:outlined-utility` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-WARNING-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-WARNING

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-WARNING-20CLASS-29"></a>

###### [class](dc43) `reblocks-ui2/buttons/view:outlined-warning` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-20CLASS-29"></a>

###### [class](ff61) `reblocks-ui2/buttons/view:outlined` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24RAISED-DISABLED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RAISED-DISABLED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ARAISED-DISABLED-20CLASS-29"></a>

###### [class](7dbc) `reblocks-ui2/buttons/view:raised-disabled` (raised)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24RAISED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RAISED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ARAISED-20CLASS-29"></a>

###### [class](8a50) `reblocks-ui2/buttons/view:raised` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AGET-DISABLED-BUTTON-VIEW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](0a65) `reblocks-ui2/buttons/view:get-disabled-button-view` view

Returns an alternative view for a button in disabled state.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AENSURE-VIEW-20FUNCTION-29"></a>

##### [function](7ab3) `reblocks-ui2/buttons/view:ensure-view` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCARD-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CARD

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCARD-22-29-20PACKAGE-29"></a>

#### [package](fb47) `reblocks-ui2/card`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCARD-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCARD-24CARD-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CARD-WIDGET

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-20CLASS-29"></a>

###### [class](a534) `reblocks-ui2/card:card-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](d64d) `reblocks-ui2/card:card-content` (card-widget) (:content)

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-PADDING-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](ab83) `reblocks-ui2/card:card-padding` (card-widget) (:padding = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](c61e) `reblocks-ui2/card:card-view` (card-widget) (:view = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3AHORIZONTAL-ALIGN-OF-CARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](993f) `reblocks-ui2/card:horizontal-align-of-card-content` (card-widget) (:horizontal-align = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3AVERTICAL-ALIGN-OF-CARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](b55d) `reblocks-ui2/card:vertical-align-of-card-content` (card-widget) (:vertical-align = :center)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCARD-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-20FUNCTION-29"></a>

##### [function](959c) `reblocks-ui2/card:card` CONTENT &KEY (VIEW :OUTLINED) (WIDTH "full") (HEIGHT '(120)) (PADDING :L) (MARGIN '(NIL NIL)) (HORIZONTAL-ALIGN :CENTER) (VERTICAL-ALIGN :CENTER) ON-CLICK (WIDGET-CLASS 'CARD-WIDGET)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCHART-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CHARTS/CHART

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCHARTS-2FCHART-22-29-20PACKAGE-29"></a>

#### [package](ced1) `reblocks-ui2/charts/chart`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FCHART-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCHART-24CHART-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CHART-WIDGET

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-20CLASS-29"></a>

###### [class](5e80) `reblocks-ui2/charts/chart:chart-widget` (ui-widget)

Base class for chart widgets rendered by Google Charts.

Subclasses such as `reblocks-ui2/charts/pie-chart:pie-chart` ([`1`][c339] [`2`][a4b2]) and
`reblocks-ui2/charts/column-chart:column-chart` ([`1`][44f8] [`2`][3189]) define chart type
specific options, theming methods do the rendering.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-BACKGROUND-COLOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](82f2) `reblocks-ui2/charts/chart:chart-background-color` (chart-widget) (:BACKGROUND-COLOR = "#f9f9f9")

`CSS` color of the area around the chart.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-COLUMN-NAMES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](0059) `reblocks-ui2/charts/chart:chart-column-names` (chart-widget) (:COLUMN-NAMES = '("Label" "Value"))

Names of the two DataTable columns, as strings.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-DATA-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](cb76) `reblocks-ui2/charts/chart:chart-data` (chart-widget) (:data)

Chart rows, each of the form (`LABEL` `NUMBER-VALUE`).

Alternatively, this may be a function of zero arguments.
It is called on each render, so that charts always show
fresh data.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-EXTRA-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](9208) `reblocks-ui2/charts/chart:chart-extra-options` (chart-widget) (:extra-options = nil)

Raw JavaScript, inserted into the Google Charts options object
before the closing bracket. Use it for options which are not
covered by typed slots, like "legend: {position: 'none'}".

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](b5f5) `reblocks-ui2/charts/chart:chart-height` (chart-widget) (:height = 500)

Chart height in pixels.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](a443) `reblocks-ui2/charts/chart:chart-title` (chart-widget) (:title = "")

A chart title rendered at the top of the chart by Google Charts.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CHARTS/COLUMN-CHART

<a id="x-28-23A-28-2832-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-22-29-20PACKAGE-29"></a>

#### [package](2946) `reblocks-ui2/charts/column-chart`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-24COLUMN-CHART-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN-CHART

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-20CLASS-29"></a>

###### [class](76e6) `reblocks-ui2/charts/column-chart:column-chart` (chart-widget)

A column chart widget rendered by Google Charts.

The `column-chart` ([`1`][44f8] [`2`][3189]) symbol names both this class and a constructor
function, following the donor widgets from the lct25 project.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-V-AXIS-MIN-ZERO-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-29-29"></a>

###### [reader](d298) `reblocks-ui2/charts/column-chart:column-chart-v-axis-min-zero-p` (column-chart) (:v-axis-min-zero = t)

When true (the default), the vertical axis starts at zero,
like vAxis.minValue = 0 in Google Charts.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-X-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-29-29"></a>

###### [reader](0e75) `reblocks-ui2/charts/column-chart:column-chart-x-title` (column-chart) (:x-title = nil)

A title for the horizontal axis. When nil, the axis has no title.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-Y-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-29-29"></a>

###### [reader](6617) `reblocks-ui2/charts/column-chart:column-chart-y-title` (column-chart) (:y-title = nil)

A title for the vertical axis. When nil, the axis has no title.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-20FUNCTION-29"></a>

##### [function](612b) `reblocks-ui2/charts/column-chart:column-chart` data &rest restargs &key title column-names height background-color extra-options x-title y-title v-axis-min-zero (widget-class 'column-chart)

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

#### [package](db8d) `reblocks-ui2/charts/pie-chart`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-24PIE-CHART-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### PIE-CHART

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-20CLASS-29"></a>

###### [class](3e7b) `reblocks-ui2/charts/pie-chart:pie-chart` (chart-widget)

A pie chart widget rendered by Google Charts.

The `pie-chart` ([`1`][c339] [`2`][a4b2]) symbol names both this class and a constructor
function, following the donor widgets from the lct25 project.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-IS3D-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-29-29"></a>

###### [reader](2998) `reblocks-ui2/charts/pie-chart:pie-chart-is3d` (pie-chart) (:is3d = nil)

When true, the chart is rendered with pseudo-`3D` effect.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-PIE-HOLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-29-29"></a>

###### [reader](4cae) `reblocks-ui2/charts/pie-chart:pie-chart-pie-hole` (pie-chart) (:pie-hole = 0)

A number between 0 and 1, describing what fraction of the radius
to cut out from the center. 0 gives a usual pie chart,
0.4 gives a donut chart.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-SLICE-COLORS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-29-29"></a>

###### [reader](f64b) `reblocks-ui2/charts/pie-chart:pie-chart-slice-colors` (pie-chart) (:slice-colors = nil)

A list of `CSS` colors, applied to the slices in order.
When nil, Google Charts default colors are used.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-20FUNCTION-29"></a>

##### [function](c4e7) `reblocks-ui2/charts/pie-chart:pie-chart` data &rest restargs &key title column-names height background-color extra-options pie-hole is3d slice-colors (widget-class 'pie-chart)

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

#### [package](b980) `reblocks-ui2/containers/column`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-24COLUMN-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3ACOLUMN-WIDGET-20CLASS-29"></a>

###### [class](9071) `reblocks-ui2/containers/column:column-widget` (container-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3ACOLUMN-20FUNCTION-29"></a>

##### [function](2101) `reblocks-ui2/containers/column:column` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/CONTAINER

<a id="x-28-23A-28-2833-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-22-29-20PACKAGE-29"></a>

#### [package](f1fc) `reblocks-ui2/containers/container`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-24CONTAINER-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTAINER-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-20CLASS-29"></a>

###### [class](f438) `reblocks-ui2/containers/container:container-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AADDITIONAL-CLASSES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](ba73) `reblocks-ui2/containers/container:additional-classes` (container-widget) (:css-classes = nil)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACHILDREN-GAP-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](28c6) `reblocks-ui2/containers/container:children-gap` (container-widget) (:gap = \*default-gap\*)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](6511) `reblocks-ui2/containers/container:subwidgets` (container-widget) (:subwidgets = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [accessor](6511) `reblocks-ui2/containers/container:subwidgets` (container-widget) (:subwidgets = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AGAP-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](3891) `reblocks-ui2/containers/container:gap-css-classes` gap theme

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AMAKE-CONTAINER-20FUNCTION-29"></a>

##### [function](0d6d) `reblocks-ui2/containers/container:make-container` default-widget-class &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/CONTROLS-ROW

<a id="x-28-23A-28-2836-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-22-29-20PACKAGE-29"></a>

#### [package](f5b6) `reblocks-ui2/containers/controls-row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-24CONTROLS-ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTROLS-ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3ACONTROLS-ROW-WIDGET-20CLASS-29"></a>

###### [class](0940) `reblocks-ui2/containers/controls-row:controls-row-widget` (row-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3ACONTROLS-ROW-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](8710) `reblocks-ui2/containers/controls-row:controls-row` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/ROW

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FROW-22-29-20PACKAGE-29"></a>

#### [package](0c3b) `reblocks-ui2/containers/row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FROW-24ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AROW-WIDGET-20CLASS-29"></a>

###### [class](d175) `reblocks-ui2/containers/row:row-widget` (container-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AMAKE-ROW-WIDGET-20FUNCTION-29"></a>

##### [function](bc2d) `reblocks-ui2/containers/row:make-row-widget` subwidgets &key (gap \*default-gap\*) on-click

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AROW-20FUNCTION-29"></a>

##### [function](e8b1) `reblocks-ui2/containers/row:row` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/STACK

<a id="x-28-23A-28-2829-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FSTACK-22-29-20PACKAGE-29"></a>

#### [package](c725) `reblocks-ui2/containers/stack`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-24STACK-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### STACK-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-20CLASS-29"></a>

###### [class](502b) `reblocks-ui2/containers/stack:stack-widget` (ui-widget)

Shows only the top child from the stack. Provides methods to push and pop widgets.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-CHILDREN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-29-29"></a>

###### [reader](5a1c) `reblocks-ui2/containers/stack:stack-widget-children` (stack-widget) (:children)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APOP-CHILD-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c9f4) `reblocks-ui2/containers/stack:pop-child` stack-widget

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APUSH-CHILD-20GENERIC-FUNCTION-29"></a>

##### [generic-function](9b37) `reblocks-ui2/containers/stack:push-child` stack-widget child

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ACURRENT-STACK-WIDGET-20FUNCTION-29"></a>

##### [function](5a49) `reblocks-ui2/containers/stack:current-stack-widget`

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APOP-ME-20FUNCTION-29"></a>

##### [function](7d9a) `reblocks-ui2/containers/stack:pop-me`

Removes current (top) widget from the stack and display the next widget.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3AREPLACE-ME-WITH-20FUNCTION-29"></a>

##### [function](f919) `reblocks-ui2/containers/stack:replace-me-with` widget

Adds a new widget ontop of the current.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-20FUNCTION-29"></a>

##### [function](01c1) `reblocks-ui2/containers/stack:stack` &rest children

Makes a stack widget with given subwidgets.

Only first widget in the list will be visible.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/TABS

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FTABS-22-29-20PACKAGE-29"></a>

#### [package](d96f) `reblocks-ui2/containers/tabs`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-24TABS-CONTROL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABS-CONTROL

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-20CLASS-29"></a>

###### [class](a3f8) `reblocks-ui2/containers/tabs:tabs-control` (event-emitter ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ACURRENT-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](b6f0) `reblocks-ui2/containers/tabs:current-idx` (tabs-control) (:idx = 0)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASUBWIDGETS-TITLES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](a9c8) `reblocks-ui2/containers/tabs:subwidgets-titles` (tabs-control) (:titles)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](b689) `reblocks-ui2/containers/tabs:tabs-size` (tabs-control) (:size)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ACURRENT-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [accessor](b6f0) `reblocks-ui2/containers/tabs:current-idx` (tabs-control) (:idx = 0)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-24TABS-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABS-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-20CLASS-29"></a>

###### [class](f555) `reblocks-ui2/containers/tabs:tabs-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-29-29"></a>

###### [reader](6a22) `reblocks-ui2/containers/tabs:subwidgets` (tabs-widget) (:subwidgets)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SELECTOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-29-29"></a>

###### [reader](03fe) `reblocks-ui2/containers/tabs:tabs-selector` (tabs-widget) (:selector)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASWITCH-TO-IDX-20FUNCTION-29"></a>

##### [function](4ea8) `reblocks-ui2/containers/tabs:switch-to-idx` &key widget-id idx &allow-other-keys

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-20FUNCTION-29"></a>

##### [function](d17b) `reblocks-ui2/containers/tabs:tabs` titles subwidgets &key (idx 0) (selector-class 'tabs-control) (class 'tabs-widget) (size :l)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SIZE-20-28TYPE-29-29"></a>

##### [type](b75a) `reblocks-ui2/containers/tabs:tabs-size`

```
(MEMBER :M :L :XL)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEDITABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/EDITABLE

<a id="x-28-23A-28-2821-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FEDITABLE-22-29-20PACKAGE-29"></a>

#### [package](a3ce) `reblocks-ui2/editable`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FEDITABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FEDITABLE-3AMAKE-EDITABLE-WIDGET-20GENERIC-FUNCTION-29"></a>

##### [generic-function](46ab) `reblocks-ui2/editable:make-editable-widget` value callback

Creates a widget which can be used to edit a given value.
Every time when the widget loose focus, it will call `CALLBACK` argument with a new value.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEVENTS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/EVENTS

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FEVENTS-22-29-20PACKAGE-29"></a>

#### [package](bc9c) `reblocks-ui2/events`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FEVENTS-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEVENTS-24EVENT-EMITTING-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EVENT-EMITTING-WIDGET

<a id="x-28REBLOCKS-UI2-2FEVENTS-3AEVENT-EMITTING-WIDGET-20CLASS-29"></a>

###### [class](6c75) `reblocks-ui2/events:event-emitting-widget` (event-emitter ui-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-22-29-20PACKAGE-29"></a>

#### [package](b918) `reblocks-ui2/form`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-24FORM-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FORM-WIDGET

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-20CLASS-29"></a>

###### [class](f1d4) `reblocks-ui2/form:form-widget` (event-emitting-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](d913) `reblocks-ui2/form:form-content` (form-widget) (:content)

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-INPUTS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](5ed7) `reblocks-ui2/form:form-inputs` (form-widget) (= (make-hash-table :test 'equal))

Internal structure holding references to all form inputs having a name attribute.

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-ON-SUBMIT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](e2dd) `reblocks-ui2/form:form-on-submit` (form-widget) (:on-submit = 'no-action)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-20FUNCTION-29"></a>

##### [function](f690) `reblocks-ui2/form:form` content &key (widget-class 'form-widget) on-submit

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FCONFIRM-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM/CONFIRM

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-2FCONFIRM-22-29-20PACKAGE-29"></a>

#### [package](090e) `reblocks-ui2/form/confirm`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FCONFIRM-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FCONFIRM-3ACONFIRM-20FUNCTION-29"></a>

##### [function](7da6) `reblocks-ui2/form/confirm:confirm` CONTENT &KEY (CONFIRM-BUTTON-TITLE "Confirm") (CANCEL-BUTTON-TITLE "Cancel") (CONFIRM-VALUE "submit") (CANCEL-VALUE "cancel") ON-CONFIRM WIDGET-CLASS

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

#### [package](33ca) `reblocks-ui2/form/validation`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24FIELD-VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FIELD-VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](c957) `reblocks-ui2/form/validation:field-validation-error` (validation-error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-29-29"></a>

###### [reader](c957) `reblocks-ui2/form/validation:field-name` (field-validation-error) (:field-name)

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AINVALID-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-29-29"></a>

###### [reader](c957) `reblocks-ui2/form/validation:invalid-value` (field-validation-error) (:invalid-value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24FORM-VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FORM-VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFORM-VALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](b2d3) `reblocks-ui2/form/validation:form-validation-error` (validation-error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3ANUM-ERRORS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFORM-VALIDATION-ERROR-29-29"></a>

###### [reader](b2d3) `reblocks-ui2/form/validation:num-errors` (form-validation-error) (:num-errors)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](d43b) `reblocks-ui2/form/validation:validation-error` (error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AERROR-ARGS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-29-29"></a>

###### [reader](d43b) `reblocks-ui2/form/validation:error-args` (validation-error) (:error-args = 'nil)

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AERROR-MESSAGE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-29-29"></a>

###### [reader](d43b) `reblocks-ui2/form/validation:error-message` (validation-error) (:error-message = '"")

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATE-FORM-DATA-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1dd6) `reblocks-ui2/form/validation:validate-form-data` widget form-data

Accepts a form or input widget and a plist of all data sent from the browser.

Should return a plist of validated data. Also, it might change the state of the widgets,
for example, to set an error message saying that entered value is invalid. In the case
when data is invalid, function should signal `validation-error` ([`1`][af7e] [`2`][4945]).

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20FUNCTION-29"></a>

##### [function](1bf5) `reblocks-ui2/form/validation:validation-error` message &rest args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATORS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM/VALIDATORS

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-2FVALIDATORS-22-29-20PACKAGE-29"></a>

#### [package](8900) `reblocks-ui2/form/validators`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATORS-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AALL-20FUNCTION-29"></a>

##### [function](7748) `reblocks-ui2/form/validators:all` &rest validators

Combines a multiple validators into a chain where every subsequent validator validates output of the previous one.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AFORMAT-DATE-20FUNCTION-29"></a>

##### [function](24ac) `reblocks-ui2/form/validators:format-date` timestamp &key (format :iso)

Formats `TIMESTAMP` as a date string.

Supported formats are the same as for [`valid-date`][556a]:

* `:ISO` (default) returns "`YYYY-MM-DD`" strings.
* `:DDMMYYYY` returns "`DD`.`MM`.`YYYY`" strings.

A `NIL` `TIMESTAMP` is formatted as an empty string, so that the result
can be used as an input widget's value.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-DATE-20FUNCTION-29"></a>

##### [function](e269) `reblocks-ui2/form/validators:valid-date` &key (format :iso) (required t)

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

##### [function](1cd4) `reblocks-ui2/form/validators:valid-integer` &key min max

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-PASSWORD-20FUNCTION-29"></a>

##### [function](2cc3) `reblocks-ui2/form/validators:valid-password` &key (min-length 10) max-length required-symbols error

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-STRING-20FUNCTION-29"></a>

##### [function](3058) `reblocks-ui2/form/validators:valid-string` &key (min-length 1) max-length

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FHTML-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/HTML

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FHTML-22-29-20PACKAGE-29"></a>

#### [package](2594) `reblocks-ui2/html`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FHTML-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FHTML-3APROP-20FUNCTION-29"></a>

##### [function](eca8) `reblocks-ui2/html:prop` name &optional default

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FHTML-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FHTML-3AHTML-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](47c7) `reblocks-ui2/html:html` (&body body) &key css (html-tag :div) css-classes on-click props width height margin

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

#### [package](53fd) `reblocks-ui2/icon`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FICON-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FICON-24ICON-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ICON-WIDGET

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-WIDGET-20CLASS-29"></a>

###### [class](ff0a) `reblocks-ui2/icon:icon-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FICON-3AICON-WIDGET-29-29"></a>

###### [reader](bb91) `reblocks-ui2/icon:icon-name` (icon-widget) (:name)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FICON-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-20FUNCTION-29"></a>

##### [function](b950) `reblocks-ui2/icon:icon` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FBASE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/BASE

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FBASE-22-29-20PACKAGE-29"></a>

#### [package](6d08) `reblocks-ui2/inputs/base`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FBASE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FBASE-24BASE-INPUT-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BASE-INPUT-WIDGET

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-20CLASS-29"></a>

###### [class](53df) `reblocks-ui2/inputs/base:base-input-widget` (named-input)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-ERROR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](1055) `reblocks-ui2/inputs/base:input-error` (base-input-widget) (:error = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-VALIDATOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](1081) `reblocks-ui2/inputs/base:input-validator` (base-input-widget) (:validator = nil)

A function of one argument returning a validated value or signaling the [`field-validation-error`][6f80].

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](19bf) `reblocks-ui2/inputs/base:input-value` (base-input-widget) (:value = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FNAMED-24NAMED-INPUT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NAMED-INPUT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-20CLASS-29"></a>

###### [class](a9eb) `reblocks-ui2/inputs/named:named-input` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3AINPUT-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-29-29"></a>

###### [reader](d840) `reblocks-ui2/inputs/named:input-name` (named-input) (:name = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/CHECKBOX

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-22-29-20PACKAGE-29"></a>

#### [package](07e0) `reblocks-ui2/inputs/checkbox`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-24CHECKBOX-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CHECKBOX

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-20CLASS-29"></a>

###### [class](0b99) `reblocks-ui2/inputs/checkbox:checkbox` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-CHECKED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](afcc) `reblocks-ui2/inputs/checkbox:checkbox-checked` (checkbox) (:checked = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](30cd) `reblocks-ui2/inputs/checkbox:checkbox-disabled` (checkbox) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](9319) `reblocks-ui2/inputs/checkbox:checkbox-size` (checkbox) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](6a59) `reblocks-ui2/inputs/checkbox:checkbox-view` (checkbox) (:view = (make-instance 'normal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-20FUNCTION-29"></a>

##### [function](9e51) `reblocks-ui2/inputs/checkbox:checkbox` &key (widget-class 'checkbox) name value (view :normal) (size :m) disabled checked error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/DATE-INPUT

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-22-29-20PACKAGE-29"></a>

#### [package](1aa0) `reblocks-ui2/inputs/date-input`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3ADATE-INPUT-20FUNCTION-29"></a>

##### [function](40cf) `reblocks-ui2/inputs/date-input:date-input` &key (widget-class 'input-widget) name value (format :iso) (required t) placeholder (view :normal) (size :m) disabled error

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

#### [package](0311) `reblocks-ui2/inputs/named`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FNAMED-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FNAMED-24NAMED-INPUT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NAMED-INPUT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-20CLASS-29"></a>

###### [class](a9eb) `reblocks-ui2/inputs/named:named-input` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3AINPUT-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-29-29"></a>

###### [reader](d840) `reblocks-ui2/inputs/named:input-name` (named-input) (:name = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/SELECT

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FSELECT-22-29-20PACKAGE-29"></a>

#### [package](b5e4) `reblocks-ui2/inputs/select`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-24OPTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OPTION

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-20CLASS-29"></a>

###### [class](62a5) `reblocks-ui2/inputs/select:option` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](7309) `reblocks-ui2/inputs/select:option-name` (option) (:name)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-SELECTED-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](ad96) `reblocks-ui2/inputs/select:option-selected-p` (option) (:selected = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](426c) `reblocks-ui2/inputs/select:option-value` (option) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-24SELECT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SELECT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-20CLASS-29"></a>

###### [class](8fee) `reblocks-ui2/inputs/select:select` (event-emitter base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](46d8) `reblocks-ui2/inputs/select:select-disabled` (select) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](7ad1) `reblocks-ui2/inputs/select:select-options` (select) (:options)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](cc34) `reblocks-ui2/inputs/select:select-pin` (select) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](0656) `reblocks-ui2/inputs/select:select-size` (select) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](5bde) `reblocks-ui2/inputs/select:select-view` (select) (:view = (make-instance 'normal))

**Accessors**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [accessor](7ad1) `reblocks-ui2/inputs/select:select-options` (select) (:options)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AENSURE-OPTION-20FUNCTION-29"></a>

##### [function](d7d5) `reblocks-ui2/inputs/select:ensure-option` value

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-20FUNCTION-29"></a>

##### [function](baf3) `reblocks-ui2/inputs/select:option` name &key value selected

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-20FUNCTION-29"></a>

##### [function](7cd7) `reblocks-ui2/inputs/select:select` options &key (widget-class 'select) name (view :normal) (pin :round) (size :m) disabled validator error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXT-INPUT

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-22-29-20PACKAGE-29"></a>

#### [package](9340) `reblocks-ui2/inputs/text-input`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-24INPUT-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### INPUT-WIDGET

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-20CLASS-29"></a>

###### [class](ff6e) `reblocks-ui2/inputs/text-input:input-widget` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](01ca) `reblocks-ui2/inputs/text-input:input-disabled` (input-widget) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-LEFT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](face) `reblocks-ui2/inputs/text-input:input-left-content` (input-widget) (:left-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](f8b0) `reblocks-ui2/inputs/text-input:input-pin` (input-widget) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-PLACEHOLDER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](664e) `reblocks-ui2/inputs/text-input:input-placeholder` (input-widget) (:placeholder = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-RIGHT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](5da8) `reblocks-ui2/inputs/text-input:input-right-content` (input-widget) (:right-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](c547) `reblocks-ui2/inputs/text-input:input-size` (input-widget) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](ff09) `reblocks-ui2/inputs/text-input:input-type` (input-widget) (:type = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](641a) `reblocks-ui2/inputs/text-input:input-view` (input-widget) (:view = (make-instance 'normal))

**Accessors**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-LEFT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [accessor](face) `reblocks-ui2/inputs/text-input:input-left-content` (input-widget) (:left-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-RIGHT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [accessor](5da8) `reblocks-ui2/inputs/text-input:input-right-content` (input-widget) (:right-content = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-20FUNCTION-29"></a>

##### [function](c442) `reblocks-ui2/inputs/text-input:input` &key (widget-class 'input-widget) name value (type :text) placeholder (view :normal) (pin :round) (size :m) disabled validator error left-content right-content

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXT-INPUT/VIEW

<a id="x-28-23A-28-2835-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-22-29-20PACKAGE-29"></a>

#### [package](3d0d) `reblocks-ui2/inputs/text-input/view`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24CLEAR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CLEAR

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3ACLEAR-20CLASS-29"></a>

###### [class](2728) `reblocks-ui2/inputs/text-input/view:clear` (input-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24INPUT-VIEW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### INPUT-VIEW

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3AINPUT-VIEW-20CLASS-29"></a>

###### [class](0558) `reblocks-ui2/inputs/text-input/view:input-view` ()

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24NORMAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3ANORMAL-20CLASS-29"></a>

###### [class](f25e) `reblocks-ui2/inputs/text-input/view:normal` (input-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3AENSURE-VIEW-20FUNCTION-29"></a>

##### [function](294d) `reblocks-ui2/inputs/text-input/view:ensure-view` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXTAREA

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-22-29-20PACKAGE-29"></a>

#### [package](53ab) `reblocks-ui2/inputs/textarea`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-24TEXTAREA-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TEXTAREA

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-20CLASS-29"></a>

###### [class](3620) `reblocks-ui2/inputs/textarea:textarea` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](25ae) `reblocks-ui2/inputs/textarea:textarea-disabled` (textarea) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](80d7) `reblocks-ui2/inputs/textarea:textarea-pin` (textarea) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-PLACEHOLDER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](24cd) `reblocks-ui2/inputs/textarea:textarea-placeholder` (textarea) (:placeholder = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](665e) `reblocks-ui2/inputs/textarea:textarea-size` (textarea) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](941e) `reblocks-ui2/inputs/textarea:textarea-type` (textarea) (:type = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](97e2) `reblocks-ui2/inputs/textarea:textarea-view` (textarea) (:view = (make-instance 'normal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-20FUNCTION-29"></a>

##### [function](0b74) `reblocks-ui2/inputs/textarea:textarea` &key (widget-class 'textarea) name value (type :text) placeholder (view :normal) (pin :round) (size :m) disabled validator error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FMODAL-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/MODAL

<a id="x-28-23A-28-2818-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FMODAL-22-29-20PACKAGE-29"></a>

#### [package](446b) `reblocks-ui2/modal`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FMODAL-24MODAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### MODAL

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-20CLASS-29"></a>

###### [class](2b01) `reblocks-ui2/modal:modal` (ui-widget)

This widget shows a popup window.

**Readers**

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HEADER-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](b258) `reblocks-ui2/modal:modal-header-content` (modal) (:header-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-MAIN-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](d6e3) `reblocks-ui2/modal:modal-main-content` (modal) (:main-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-VISIBLE-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](453b) `reblocks-ui2/modal:modal-visible-p` (modal) (:visible = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HEADER-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [accessor](b258) `reblocks-ui2/modal:modal-header-content` (modal) (:header-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-MAIN-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [accessor](d6e3) `reblocks-ui2/modal:modal-main-content` (modal) (:main-content)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HIDE-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f3ec) `reblocks-ui2/modal:modal-hide` widget

Hides modal window.

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-SHOW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](fd5a) `reblocks-ui2/modal:modal-show` widget &key content header-content

Shows modal window.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-20FUNCTION-29"></a>

##### [function](eaba) `reblocks-ui2/modal:modal` content &key header-content visible

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FSIZES-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/SIZES

<a id="x-28-23A-28-2818-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FSIZES-22-29-20PACKAGE-29"></a>

#### [package](210a) `reblocks-ui2/sizes`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FSIZES-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FSIZES-3AENSURE-SIZE-20FUNCTION-29"></a>

##### [function](1e28) `reblocks-ui2/sizes:ensure-size` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/CLICKABLE-ROW

<a id="x-28-23A-28-2833-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-22-29-20PACKAGE-29"></a>

#### [package](3647) `reblocks-ui2/tables/clickable-row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-24CLICKABLE-ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CLICKABLE-ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3ACLICKABLE-ROW-WIDGET-20CLASS-29"></a>

###### [class](49f9) `reblocks-ui2/tables/clickable-row:clickable-row-widget` (table-row)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3AMAKE-CLICKABLE-ROW-WIDGET-20FUNCTION-29"></a>

##### [function](38e3) `reblocks-ui2/tables/clickable-row:make-clickable-row-widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCRUD-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/CRUD

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FCRUD-22-29-20PACKAGE-29"></a>

#### [package](2900) `reblocks-ui2/tables/crud`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCRUD-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCRUD-24CRUD-TABLE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CRUD-TABLE

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-20CLASS-29"></a>

###### [class](3e5d) `reblocks-ui2/tables/crud:crud-table` (ui-widget)

A search table with Add, Edit and Delete actions.

This widget knows nothing about the persistence: forms are created by
`ADD-FORM-MAKER` and `EDIT-FORM-MAKER` callbacks, and the deletion is performed
by the `ON-DELETE` callback. All of them are optional: only the corresponding
buttons are rendered for the given callbacks.

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-ADD-BUTTON-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](0401) `reblocks-ui2/tables/crud:crud-add-button-title` (crud-table) (:ADD-BUTTON-TITLE = "Add")

The title of the button shown above the table. When `ADD-FORM-MAKER` is nil, the button is not rendered at all.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-ADD-FORM-MAKER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](e363) `reblocks-ui2/tables/crud:crud-add-form-maker` (crud-table) (:add-form-maker = nil)

A function of two arguments (`CRUD-WIDGET` `modal` ([`1`][dffa] [`2`][8f2d])), returning a form widget to show in the modal when the Add button is pressed.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-ADD-HEADER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](d213) `reblocks-ui2/tables/crud:crud-add-header` (crud-table) (:add-header = nil)

A widget shown as the modal's header content when the add form is opened. When nil, the modal is shown without a header content.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-COLUMNS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](009f) `reblocks-ui2/tables/crud:crud-columns` (crud-table) (:columns = nil)

Columns to show. Should not include an actions column, because [`crud-table`][1103] adds such a column by itself when at least one of `ADD-FORM-MAKER`, `EDIT-FORM-MAKER` or `ON-DELETE` is given.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-DATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](f19b) `reblocks-ui2/tables/crud:crud-data-getter` (crud-table) (:data-getter)

A function returning a list of objects to show. Given as is to [`reblocks-ui2/tables/search:make-search-widget`][7dcd], which calls it with a filters widget as the argument.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-DELETE-BUTTON-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](82ed) `reblocks-ui2/tables/crud:crud-delete-button-title` (crud-table) (:DELETE-BUTTON-TITLE = "Delete")

The title of the Delete button in the actions column. Also used as the confirm button title of the delete confirmation form. When `ON-DELETE` is nil, the button is not rendered at all.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-DELETE-HEADER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](fc7a) `reblocks-ui2/tables/crud:crud-delete-header` (crud-table) (:delete-header = nil)

A widget shown as the modal's header content when the delete confirmation form is opened. When nil, the modal is shown without a header content.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-DELETE-QUESTION-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](c6e7) `reblocks-ui2/tables/crud:crud-delete-question` (crud-table) (:DELETE-QUESTION = "Delete this record?")

A question to show in the delete confirmation form. Either a string or a function of one argument (`OBJECT`) returning the question string.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-EDIT-BUTTON-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](2b9c) `reblocks-ui2/tables/crud:crud-edit-button-title` (crud-table) (:EDIT-BUTTON-TITLE = "Edit")

The title of the Edit button in the actions column. When `EDIT-FORM-MAKER` is nil, the button is not rendered at all.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-EDIT-FORM-MAKER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](7f75) `reblocks-ui2/tables/crud:crud-edit-form-maker` (crud-table) (:edit-form-maker = nil)

A function of two arguments (`modal` ([`1`][dffa] [`2`][8f2d]) `OBJECT`), returning a form widget to show in the modal when the row's Edit button for the `OBJECT` is pressed.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-EDIT-HEADER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](f00a) `reblocks-ui2/tables/crud:crud-edit-header` (crud-table) (:edit-header = nil)

A widget shown as the modal's header content when the edit form is opened. When nil, the modal is shown without a header content.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-MODAL-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](a570) `reblocks-ui2/tables/crud:crud-modal` (crud-table) (= nil)

The modal widget created by the latest `RENDER`. Useful to hide the modal from application's form callbacks.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-ON-DELETE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](5a18) `reblocks-ui2/tables/crud:crud-on-delete` (crud-table) (:on-delete = nil)

A function of one argument (`OBJECT`), called when deletion of the `OBJECT` was confirmed in the modal.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-ROW-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](60e5) `reblocks-ui2/tables/crud:crud-row-class` (crud-table) (:row-class = nil)

A widget class name to create table rows of. Given as `:ROW-CLASS` argument to [`reblocks-ui2/tables/search:make-search-widget`][7dcd].

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-SEARCH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FCRUD-3ACRUD-TABLE-29-29"></a>

###### [reader](e701) `reblocks-ui2/tables/crud:crud-search` (crud-table) (= nil)

The search widget created by the latest `RENDER`. Useful to reach the table widget from application's code or in tests.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCRUD-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3ADELETE-QUESTION-TEXT-20FUNCTION-29"></a>

##### [function](d4f2) `reblocks-ui2/tables/crud:delete-question-text` delete-question object

Returns the question to show in the delete confirmation form.

`DELETE-QUESTION` is either a string or a function of one argument, the row's
`OBJECT`, returning the question string.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3AFORM-BUTTON-VALUE-20FUNCTION-29"></a>

##### [function](e4a2) `reblocks-ui2/tables/crud:form-button-value` form-data

Returns the value submitted by the form's button named "button".

`FORM-DATA` is the plist given to a `:SUBMIT` event handler of a form widget.
Reblocks interns the keys of this plist as `UPPERCASE` keywords, that is why
a plain (`GETF` `FORM-DATA` :some-other-case) might not find the value. This
function compares key names as strings instead and works with any case.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCRUD-3AMAKE-CRUD-TABLE-20FUNCTION-29"></a>

##### [function](90ac) `reblocks-ui2/tables/crud:make-crud-table` columns data-getter &rest restargs &key add-form-maker edit-form-maker on-delete delete-question add-button-title edit-button-title delete-button-title edit-header delete-header add-header row-class widget-class

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

##### [function](b2b6) `reblocks-ui2/tables/crud:submitted-with-submit-button-p` form-data

Returns T when `FORM-DATA` was submitted by a button having the value "submit".

Use this predicate in `:SUBMIT` event handlers to detect which button was
pressed, see [`form-button-value`][d47c] for the case-sensitivity details.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/EDITABLE-TABLE

<a id="x-28-23A-28-2834-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-22-29-20PACKAGE-29"></a>

#### [package](5c09) `reblocks-ui2/tables/editable-table`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24EDITABLE-COLUMN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EDITABLE-COLUMN

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-20CLASS-29"></a>

###### [class](0df9) `reblocks-ui2/tables/editable-table:editable-column` (column)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3ADATA-SETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-29-29"></a>

###### [reader](f5f9) `reblocks-ui2/tables/editable-table:data-setter` (editable-column) (:setter = #'default-setter)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24EDITABLE-TABLE-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EDITABLE-TABLE-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-20CLASS-29"></a>

###### [class](f24d) `reblocks-ui2/tables/editable-table:editable-table-widget` (table-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-CREATOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29"></a>

###### [reader](e256) `reblocks-ui2/tables/editable-table:object-creator` (editable-table-widget) (:object-creator = nil)

When given, should be a function of zero arguments.
Will be called when user adds a new table row.
Usually you will want to do create and add an object to a database.
Returned object will be bound to a new table row and used to fill cells with new values.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-DELETER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29"></a>

###### [reader](2fc4) `reblocks-ui2/tables/editable-table:object-deleter` (editable-table-widget) (:object-deleter = nil)

When given, should be a function of one argument.
Will be called with object instance to be deleted from the table.
Usually you will want to do something like deletion the record from a database.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24ROW-NOT-FOUND-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ROW-NOT-FOUND

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AROW-NOT-FOUND-20CONDITION-29"></a>

###### [condition](b07e) `reblocks-ui2/tables/editable-table:row-not-found` (error)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3ADELETE-ROW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](9d18) `reblocks-ui2/tables/editable-table:delete-row` table obj

Deletes row representing given object.
First it calls [`object-deleter`][cc16] callback and then
removes corresponding row from the table.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-20FUNCTION-29"></a>

##### [function](724a) `reblocks-ui2/tables/editable-table:editable-column` title &key (getter nil getter-given-p) (setter #'default-setter) (cell-maker #'create-widget-from) (align :left)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AMAKE-EDITABLE-TABLE-20FUNCTION-29"></a>

##### [function](3202) `reblocks-ui2/tables/editable-table:make-editable-table` columns rows &key (table-class 'editable-table-widget) (row-class nil row-class-given-p) (object-deleter nil object-deleter-given-p) (object-creator nil object-creator-given-p)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/SEARCH

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FSEARCH-22-29-20PACKAGE-29"></a>

#### [package](8ab1) `reblocks-ui2/tables/search`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-24CONTROLS-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTROLS-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-20CLASS-29"></a>

###### [class](ed37) `reblocks-ui2/tables/search:controls-widget` (event-emitting-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-BUTTON-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-29-29"></a>

###### [reader](e45b) `reblocks-ui2/tables/search::next-page-button` (controls-widget) (:button)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ASHOW-BUTTON-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-29-29"></a>

###### [reader](dfdd) `reblocks-ui2/tables/search::show-button-p` (controls-widget) (= nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-24SEARCH-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SEARCH-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-20CLASS-29"></a>

###### [class](057e) `reblocks-ui2/tables/search:search-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](c193) `reblocks-ui2/tables/search:controls-widget` (search-widget) (:controls)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ADATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](c709) `reblocks-ui2/tables/search::data-getter` (search-widget) (:data-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3AFILTERS-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](42dc) `reblocks-ui2/tables/search::filters-widget` (search-widget) (:filters)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](7ba3) `reblocks-ui2/tables/search::next-page-getter` (search-widget) (:next-page-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](9640) `reblocks-ui2/tables/table:table-widget` (search-widget) (:table)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [accessor](7ba3) `reblocks-ui2/tables/search::next-page-getter` (search-widget) (:next-page-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [accessor](9640) `reblocks-ui2/tables/table:table-widget` (search-widget) (:table)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AFILTERS-UPDATED-20GENERIC-FUNCTION-29"></a>

##### [generic-function](5547) `reblocks-ui2/tables/search:filters-updated` widget

Signals that filters state was changed and table with results should be updated.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AHIDE-NEXT-PAGE-BUTTON-20GENERIC-FUNCTION-29"></a>

##### [generic-function](efe0) `reblocks-ui2/tables/search:hide-next-page-button` widget

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASHOW-NEXT-PAGE-BUTTON-20GENERIC-FUNCTION-29"></a>

##### [generic-function](64ba) `reblocks-ui2/tables/search:show-next-page-button` widget

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AMAKE-DEFAULT-CONTROLS-WIDGET-20FUNCTION-29"></a>

##### [function](e40b) `reblocks-ui2/tables/search:make-default-controls-widget` &KEY (BUTTON-TITLE "Load more")

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AMAKE-SEARCH-WIDGET-20FUNCTION-29"></a>

##### [function](c91d) `reblocks-ui2/tables/search:make-search-widget` columns data-getter &key (filters-widget nil filters-widget-given-p) (controls-widget nil controls-widget-given-p) (widget-class 'search-widget) (table-class nil table-class-given-p) (row-class nil row-class-given-p)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/TABLE

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FTABLE-22-29-20PACKAGE-29"></a>

#### [package](68fd) `reblocks-ui2/tables/table`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24COLUMN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20CLASS-29"></a>

###### [class](edf2) `reblocks-ui2/tables/table:column` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACELL-MAKER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](5929) `reblocks-ui2/tables/table:cell-maker` (column) (:cell-maker = #'create-widget-from)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-ALIGN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](d87e) `reblocks-ui2/tables/table:column-align` (column) (:align = :left)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CLASSES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](a650) `reblocks-ui2/tables/table:column-classes` (column) (:classes = nil)

Additional `CSS` classes for column cells

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](e77b) `reblocks-ui2/tables/table:column-idx` (column) (= nil)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](3e8e) `reblocks-ui2/tables/table:column-title` (column) (:title)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ADATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](42c5) `reblocks-ui2/tables/table:data-getter` (column) (:GETTER = (LAMBDA (ROW)
  (DECLARE (IGNORE ROW))
  (ERROR "Real getter should be provided to COLUMN function.")))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-ROW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-ROW

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-20CLASS-29"></a>

###### [class](f3f2) `reblocks-ui2/tables/table:table-row` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-CELLS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](3b0a) `reblocks-ui2/tables/table:row-cells` (table-row) (:cells)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-OBJECT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](2cf6) `reblocks-ui2/tables/table:row-object` (table-row) (:object)

Original object, passed as a row to the [`make-table`][e390] function.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-TABLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](4741) `reblocks-ui2/tables/table:row-table` (table-row) (:table)

Reference it a table row belong to.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20CLASS-29"></a>

###### [class](8361) `reblocks-ui2/tables/table:table-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-COLUMNS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](3198) `reblocks-ui2/tables/table:table-columns` (table-widget) (:columns = nil)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](4be8) `reblocks-ui2/tables/table:table-row-class` (table-widget) (:row-class = 'table-row)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROWS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](3c68) `reblocks-ui2/tables/table:table-rows` (table-widget) (:rows = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AAPPEND-DATA-20GENERIC-FUNCTION-29"></a>

##### [generic-function](b458) `reblocks-ui2/tables/table:append-data` widget data

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](8e61) `reblocks-ui2/tables/table:column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AHEADER-COLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](75b3) `reblocks-ui2/tables/table:header-column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20GENERIC-FUNCTION-29"></a>

##### [generic-function] `reblocks-ui2/tables/table:table-widget` object

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20FUNCTION-29"></a>

##### [function](ace4) `reblocks-ui2/tables/table:column` title &key (getter nil getter-given-p) (cell-maker nil cell-maker-p) (align :center) (classes nil clases-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-CELL-20FUNCTION-29"></a>

##### [function](16b1) `reblocks-ui2/tables/table:current-cell`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-COLUMN-20FUNCTION-29"></a>

##### [function](e46e) `reblocks-ui2/tables/table:current-column`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-ROW-20FUNCTION-29"></a>

##### [function](3892) `reblocks-ui2/tables/table:current-row`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-TABLE-20FUNCTION-29"></a>

##### [function](151c) `reblocks-ui2/tables/table:current-table`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AMAKE-TABLE-20FUNCTION-29"></a>

##### [function](7d07) `reblocks-ui2/tables/table:make-table` columns rows &key (table-class 'table-widget) (row-class nil row-class-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ARECALCULATE-CELLS-20FUNCTION-29"></a>

##### [function](84b7) `reblocks-ui2/tables/table:recalculate-cells` row &key (update t)

Updates cell widgets using base object, stored in the `ROW`.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/API

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FAPI-22-29-20PACKAGE-29"></a>

#### [package](bfc4) `reblocks-ui2/themes/api`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FAPI-3ACURRENT-THEME-20FUNCTION-29"></a>

##### [function](4f0e) `reblocks-ui2/themes/api:current-theme`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FAPI-3ADEFTHEME-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](b9b7) `reblocks-ui2/themes/api:deftheme` name bases &rest var-forms

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/BASE

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FBASE-22-29-20PACKAGE-29"></a>

#### [package](6bfb) `reblocks-ui2/themes/base`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-24BASE-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BASE-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FBASE-3ABASE-THEME-20CLASS-29"></a>

###### [class](91e8) `reblocks-ui2/themes/base:base-theme` ()

A base theme class for all `Reblocks-UI2` themes.

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FBASE-3AOVERRIDED-VARS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FBASE-3ABASE-THEME-29-29"></a>

###### [reader](9721) `reblocks-ui2/themes/base:overrided-vars` (base-theme) (:overridden-vars = (make-hash-table :test 'equal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/COLOR

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FCOLOR-22-29-20PACKAGE-29"></a>

#### [package](413d) `reblocks-ui2/themes/color`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-24COLOR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLOR

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-20CLASS-29"></a>

###### [class](fa5c) `reblocks-ui2/themes/color:color` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-DARK-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](6043) `reblocks-ui2/themes/color:color-dark` (color) (:dark = nil)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-FOCUS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](156e) `reblocks-ui2/themes/color:color-focus` (color) (:focus = nil)

If string, then it is a color of element in "focus" state. If integer, then it is intensity change relative to the base color. For light scheme intensity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-HOVER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](db7f) `reblocks-ui2/themes/color:color-hover` (color) (:hover = nil)

If string, then it is a color of element in "hover" state. If integer, then it is intensity change relative to the base color. For light scheme intensity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-LIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](9901) `reblocks-ui2/themes/color:color-light` (color) (:light = nil)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-PROPERTY-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](2d6d) `reblocks-ui2/themes/color:color-property` (color) (:PROPERTY = (REQUIRED-ARGUMENT "property"))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3AADJUST-BASE-COLOR-20GENERIC-FUNCTION-29"></a>

##### [generic-function](db77) `reblocks-ui2/themes/color:adjust-base-color` theme base-color adjustment

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3AADJUST-COLOR-20FUNCTION-29"></a>

##### [function](0ea1) `reblocks-ui2/themes/color:adjust-color` theme color &key (light nil light-p) (dark nil dark-p) (hover nil hover-p) (focus nil focus-p)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-20FUNCTION-29"></a>

##### [function](3722) `reblocks-ui2/themes/color:color` property &key light dark hover focus

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/STYLING

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FSTYLING-22-29-20PACKAGE-29"></a>

#### [package](0d99) `reblocks-ui2/themes/styling`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3ACSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c9e9) `reblocks-ui2/themes/styling:css-classes` object theme &key size invalid-state

Returns classes for a widget or it's property.

Result can be a list, string or a keyword.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3ACSS-STYLES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](831c) `reblocks-ui2/themes/styling:css-styles` object theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](4d76) `reblocks-ui2/themes/styling:join-css-classes` theme &rest classes

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AMERGE-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](6973) `reblocks-ui2/themes/styling:merge-css-classes` theme classes

This generic function is called before [`join-css-classes`][0785] will output classes as a string.

Depending on theme some transformations can be applied to the list of `CSS` classes, given as `CLASSES` argument.
For example, a theme based on Tailwind framework, might merge `CSS` classes list allowing to override properties.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-STYLES-20FUNCTION-29"></a>

##### [function](8697) `reblocks-ui2/themes/styling:join-css-styles` &rest styles

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/TAILWIND

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FTAILWIND-22-29-20PACKAGE-29"></a>

#### [package](5482) `reblocks-ui2/themes/tailwind`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-24TAILWIND-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TAILWIND-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ATAILWIND-THEME-20CLASS-29"></a>

###### [class](1606) `reblocks-ui2/themes/tailwind:tailwind-theme` (base-theme)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACARD-BORDER-RADIUS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:card-border-radius` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-ACTION-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-bg-action` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-DANGER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-bg-danger` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-INFO-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-bg-info` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-bg-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-SUCCESS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-bg-success` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-UTILITY-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-bg-utility` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-WARNING-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-bg-warning` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-ACTION-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-border-action` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-DANGER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-border-danger` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-INFO-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-border-info` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-border-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-SUCCESS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-border-success` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-UTILITY-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-border-utility` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-WARNING-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-border-warning` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-LINE-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-line-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-TEXT-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:colors-text-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-MARGIN-SIZES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:core-margin-sizes` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-MODE-20GENERIC-FUNCTION-29"></a>

##### [generic-function](d825) `reblocks-ui2/themes/tailwind:core-mode` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-PADDING-SIZES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:core-padding-sizes` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ATABS-ACTIVE-COLOR-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1606) `reblocks-ui2/themes/tailwind:tabs-active-color` theme

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](1606) `reblocks-ui2/themes/tailwind:make-tailwind-theme` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-DARK-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](d825) `reblocks-ui2/themes/tailwind:make-tailwind-theme-dark` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-LIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](93a0) `reblocks-ui2/themes/tailwind:make-tailwind-theme-light` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/TAILWIND/ARBITRARY

<a id="x-28-23A-28-2838-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-22-29-20PACKAGE-29"></a>

#### [package](b8e3) `reblocks-ui2/themes/tailwind/arbitrary`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-24ARBITRARY-VALUE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ARBITRARY-VALUE

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-20CLASS-29"></a>

###### [class](28a8) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-ARGS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-29-29"></a>

###### [reader](c1d2) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value-args` (arbitrary-value) (:args)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-PREFIX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-29-29"></a>

###### [reader](7707) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value-prefix` (arbitrary-value) (:prefix)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-20FUNCTION-29"></a>

##### [function](1828) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value` prefix &rest args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/ALIGN

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FALIGN-22-29-20PACKAGE-29"></a>

#### [package](313e) `reblocks-ui2/utils/align`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-24HORIZONTAL-ALIGN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### HORIZONTAL-ALIGN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-20CLASS-29"></a>

###### [class](d471) `reblocks-ui2/utils/align:horizontal-align` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-29-29"></a>

###### [reader](2a5e) `reblocks-ui2/utils/align:horizontal-align-value` (horizontal-align) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-24VERTICAL-ALIGN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### VERTICAL-ALIGN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-20CLASS-29"></a>

###### [class](f667) `reblocks-ui2/utils/align:vertical-align` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-29-29"></a>

###### [reader](73d9) `reblocks-ui2/utils/align:vertical-align-value` (vertical-align) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-20FUNCTION-29"></a>

##### [function](e6cc) `reblocks-ui2/utils/align:horizontal-align` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-20FUNCTION-29"></a>

##### [function](94a5) `reblocks-ui2/utils/align:vertical-align` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-VALUE-20-28TYPE-29-29"></a>

##### [type](0e84) `reblocks-ui2/utils/align:horizontal-align-value`

```
(MEMBER :LEFT :CENTER :TOP)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-VALUE-20-28TYPE-29-29"></a>

##### [type](c3e1) `reblocks-ui2/utils/align:vertical-align-value`

```
(MEMBER :TOP :CENTER :BOTTOM)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/MARGIN

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FMARGIN-22-29-20PACKAGE-29"></a>

#### [package](1ec5) `reblocks-ui2/utils/margin`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FMARGIN-24MARGIN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### MARGIN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-20CLASS-29"></a>

###### [class](3874) `reblocks-ui2/utils/margin:margin` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-BOTTOM-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](567e) `reblocks-ui2/utils/margin:margin-bottom` (margin) (:bottom = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-LEFT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](3311) `reblocks-ui2/utils/margin:margin-left` (margin) (:left = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-RIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](3be0) `reblocks-ui2/utils/margin:margin-right` (margin) (:right = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-TOP-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](379e) `reblocks-ui2/utils/margin:margin-top` (margin) (:top = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-20FUNCTION-29"></a>

##### [function](f77a) `reblocks-ui2/utils/margin:margin` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/PADDING

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FPADDING-22-29-20PACKAGE-29"></a>

#### [package](0afa) `reblocks-ui2/utils/padding`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPADDING-24PADDING-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### PADDING

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-20CLASS-29"></a>

###### [class](18cd) `reblocks-ui2/utils/padding:padding` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-HORIZONTAL-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-29-29"></a>

###### [reader](b868) `reblocks-ui2/utils/padding:padding-horizontal-size` (padding) (:horizontal = :l)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-VERTICAL-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-29-29"></a>

###### [reader](b52c) `reblocks-ui2/utils/padding:padding-vertical-size` (padding) (:vertical = :l)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-20FUNCTION-29"></a>

##### [function](ef94) `reblocks-ui2/utils/padding:padding` size

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3ANULLABLE-PADDING-SIZE-20-28TYPE-29-29"></a>

##### [type](319d) `reblocks-ui2/utils/padding:nullable-padding-size`

```
(OR NULL PADDING-SIZE)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-SIZE-20-28TYPE-29-29"></a>

##### [type](878e) `reblocks-ui2/utils/padding:padding-size`

```
(MEMBER :S :M :L :XL)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/PRIMITIVE-TO

<a id="x-28-23A-28-2831-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-22-29-20PACKAGE-29"></a>

#### [package](dd0a) `reblocks-ui2/utils/primitive-to`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3APROCESS-PRIMITIVE-ARGS-20FUNCTION-29"></a>

##### [function](a0da) `reblocks-ui2/utils/primitive-to:process-primitive-args` keyword-args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/SIZE

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FSIZE-22-29-20PACKAGE-29"></a>

#### [package](b119) `reblocks-ui2/utils/size`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24HEIGHT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### HEIGHT

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AHEIGHT-20CLASS-29"></a>

###### [class](615d) `reblocks-ui2/utils/size:height` (size)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24RESPONSIVE-HEIGHT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RESPONSIVE-HEIGHT

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-20CLASS-29"></a>

###### [class](c209) `reblocks-ui2/utils/size:responsive-height` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMAX-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-29-29"></a>

###### [reader](aba6) `reblocks-ui2/utils/size:max-height` (responsive-height) (:max = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMIN-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-29-29"></a>

###### [reader](c727) `reblocks-ui2/utils/size:min-height` (responsive-height) (:min = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24RESPONSIVE-WIDTH-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RESPONSIVE-WIDTH

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-20CLASS-29"></a>

###### [class](dd41) `reblocks-ui2/utils/size:responsive-width` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMAX-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-29-29"></a>

###### [reader](a2ea) `reblocks-ui2/utils/size:max-width` (responsive-width) (:max = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMIN-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-29-29"></a>

###### [reader](1d5f) `reblocks-ui2/utils/size:min-width` (responsive-width) (:min = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24SIZE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SIZE

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-20CLASS-29"></a>

###### [class](aee8) `reblocks-ui2/utils/size:size` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-29-29"></a>

###### [reader](3530) `reblocks-ui2/utils/size:size-value` (size) (:value)

If integer, then it will be considered as "px".
If string, then will be used as is (meaning depends on current theme).

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24WIDTH-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### WIDTH

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AWIDTH-20CLASS-29"></a>

###### [class](3e2e) `reblocks-ui2/utils/size:width` (size)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AENSURE-HEIGHT-20FUNCTION-29"></a>

##### [function](5847) `reblocks-ui2/utils/size:ensure-height` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AENSURE-WIDTH-20FUNCTION-29"></a>

##### [function](e09b) `reblocks-ui2/utils/size:ensure-width` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AHEIGHT-20FUNCTION-29"></a>

##### [function](2887) `reblocks-ui2/utils/size:height` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-20FUNCTION-29"></a>

##### [function](5297) `reblocks-ui2/utils/size:responsive-height` &key min max

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-20FUNCTION-29"></a>

##### [function](a73a) `reblocks-ui2/utils/size:responsive-width` &key min max

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AWIDTH-20FUNCTION-29"></a>

##### [function](c4c6) `reblocks-ui2/utils/size:width` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASOME-HEIGHT-20-28TYPE-29-29"></a>

##### [type](851c) `reblocks-ui2/utils/size:some-height`

```
(OR HEIGHT RESPONSIVE-HEIGHT)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASOME-WIDTH-20-28TYPE-29-29"></a>

##### [type](3213) `reblocks-ui2/utils/size:some-width`

```
(OR WIDTH RESPONSIVE-WIDTH)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FWALK-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/WALK

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FWALK-22-29-20PACKAGE-29"></a>

#### [package](de23) `reblocks-ui2/utils/walk`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FWALK-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FUTILS-2FWALK-3ACHILDREN-20GENERIC-FUNCTION-29"></a>

##### [generic-function](5592) `reblocks-ui2/utils/walk:children` widget

<a id="x-28REBLOCKS-UI2-2FUTILS-2FWALK-3AWALK-20GENERIC-FUNCTION-29"></a>

##### [generic-function](3cc9) `reblocks-ui2/utils/walk:walk` widget visitor-func

A protocol to go through widgets tree and to call `VISITOR-FUNC` on each node.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/WIDGET

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FWIDGET-22-29-20PACKAGE-29"></a>

#### [package](13c5) `reblocks-ui2/widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-24UI-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### UI-WIDGET

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-20CLASS-29"></a>

###### [class](3546) `reblocks-ui2/widget:ui-widget` (widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AON-CLICK-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](64dc) `reblocks-ui2/widget:on-click` (ui-widget) (:on-click = nil)

When an on-click action is given, cursor style will be changed to "pointer".

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](4aa4) `reblocks-ui2/widget:widget-height` (ui-widget) (:height = nil)

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-MARGIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](6678) `reblocks-ui2/widget:widget-margin` (ui-widget) (:margin = nil)

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](3066) `reblocks-ui2/widget:widget-width` (ui-widget) (:width = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-DEPENDENCIES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](9efe) `reblocks-ui2/widget:get-dependencies` widget theme

Works like [`reblocks/dependencies:get-dependencies`][2397] generic-function, but
in context of current theme.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-HTML-TAG-20GENERIC-FUNCTION-29"></a>

##### [generic-function](3efe) `reblocks-ui2/widget:get-html-tag` widget theme

Works like [`reblocks/widget:get-html-tag`][ab65] generic-function, but
in context of current theme.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AHTML-ATTRS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](2ef8) `reblocks-ui2/widget:html-attrs` widget theme

May return a plist of attributes to add to the main widget's `HTML` node.

It should not return `:ID` `:CLASS` or `:ONCLICK` attributes.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3ARENDER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](617d) `reblocks-ui2/widget:render` widget theme

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
[4e02]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L1
[45e5]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L51
[e176]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L52
[bed3]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L55
[818b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L58
[5038]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L61
[c869]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L64
[1531]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L67
[3804]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L70
[75c8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L74
[c349]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/button.lisp#L82
[4076]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L1
[20c0]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L21
[d0b0]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L24
[e14b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L27
[82ae]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L30
[8a50]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L33
[7dbc]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L36
[ff61]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L39
[d5ec]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L42
[9075]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L45
[bdc8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L48
[dc43]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L51
[bf28]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L54
[6118]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L57
[7ab3]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L61
[0a65]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/buttons/view.lisp#L77
[fb47]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/card.lisp#L1
[a534]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/card.lisp#L51
[d64d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/card.lisp#L52
[c61e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/card.lisp#L55
[ab83]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/card.lisp#L58
[993f]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/card.lisp#L61
[b55d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/card.lisp#L65
[959c]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/card.lisp#L71
[ced1]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/chart.lisp#L1
[5e80]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/chart.lisp#L21
[a443]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/chart.lisp#L22
[cb76]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/chart.lisp#L27
[0059]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/chart.lisp#L35
[b5f5]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/chart.lisp#L40
[82f2]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/chart.lisp#L45
[9208]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/chart.lisp#L50
[2946]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/column-chart.lisp#L1
[76e6]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/column-chart.lisp#L18
[0e75]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/column-chart.lisp#L19
[6617]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/column-chart.lisp#L24
[d298]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/column-chart.lisp#L29
[612b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/column-chart.lisp#L54
[db8d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/pie-chart.lisp#L1
[3e7b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/pie-chart.lisp#L19
[4cae]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/pie-chart.lisp#L20
[2998]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/pie-chart.lisp#L27
[f64b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/pie-chart.lisp#L32
[c4e7]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/charts/pie-chart.lisp#L57
[b980]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/column.lisp#L1
[9071]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/column.lisp#L23
[2101]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/column.lisp#L27
[f1fc]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/container.lisp#L1
[f438]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/container.lisp#L28
[6511]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/container.lisp#L29
[28c6]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/container.lisp#L33
[ba73]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/container.lisp#L36
[0d6d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/container.lisp#L46
[3891]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/container.lisp#L77
[f5b6]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/controls-row.lisp#L1
[0940]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/controls-row.lisp#L21
[8710]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/controls-row.lisp#L31
[0c3b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/row.lisp#L1
[d175]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/row.lisp#L25
[e8b1]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/row.lisp#L29
[bc2d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/row.lisp#L35
[c725]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/stack.lisp#L1
[502b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/stack.lisp#L25
[5a1c]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/stack.lisp#L26
[01c1]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/stack.lisp#L31
[c9f4]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/stack.lisp#L45
[9b37]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/stack.lisp#L53
[5a49]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/stack.lisp#L59
[f919]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/stack.lisp#L66
[7d9a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/stack.lisp#L71
[d96f]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L1
[b75a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L39
[a3f8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L43
[a9c8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L44
[b6f0]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L46
[b689]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L49
[f555]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L54
[03fe]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L55
[6a22]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L57
[d17b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L63
[4ea8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/containers/tabs.lisp#L93
[a3ce]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/editable.lisp#L1
[46ab]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/editable.lisp#L7
[bc9c]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/events.lisp#L1
[6c75]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/events.lisp#L13
[b918]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form.lisp#L1
[f690]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form.lisp#L109
[f1d4]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form.lisp#L46
[d913]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form.lisp#L47
[e2dd]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form.lisp#L49
[5ed7]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form.lisp#L52
[090e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/confirm.lisp#L1
[7da6]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/confirm.lisp#L29
[33ca]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validation.lisp#L1
[d43b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validation.lisp#L16
[1bf5]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validation.lisp#L29
[b2d3]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validation.lisp#L35
[c957]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validation.lisp#L40
[1dd6]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validation.lisp#L47
[8900]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validators.lisp#L1
[7748]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validators.lisp#L105
[e269]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validators.lisp#L156
[24ac]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validators.lisp#L200
[3058]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validators.lisp#L25
[2cc3]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validators.lisp#L55
[1cd4]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/form/validators.lisp#L81
[2594]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/html.lisp#L1
[eca8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/html.lisp#L131
[47c7]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/html.lisp#L55
[53fd]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/icon.lisp#L1
[ff0a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/icon.lisp#L13
[bb91]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/icon.lisp#L14
[b950]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/icon.lisp#L18
[6d08]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/base.lisp#L1
[53df]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/base.lisp#L42
[19bf]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/base.lisp#L43
[1081]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/base.lisp#L46
[1055]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/base.lisp#L50
[07e0]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/checkbox.lisp#L1
[0b99]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/checkbox.lisp#L26
[6a59]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/checkbox.lisp#L27
[9319]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/checkbox.lisp#L31
[30cd]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/checkbox.lisp#L35
[afcc]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/checkbox.lisp#L39
[9e51]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/checkbox.lisp#L46
[1aa0]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/date-input.lisp#L1
[40cf]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/date-input.lisp#L27
[0311]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/named.lisp#L1
[a9eb]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/named.lisp#L13
[d840]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/named.lisp#L14
[b5e4]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L1
[7cd7]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L100
[62a5]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L42
[7309]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L43
[426c]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L46
[ad96]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L49
[baf3]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L61
[8fee]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L70
[7ad1]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L71
[5bde]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L74
[cc34]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L78
[0656]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L81
[46d8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L85
[d7d5]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/select.lisp#L94
[9340]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L1
[ff6e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L34
[ff09]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L35
[664e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L39
[641a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L43
[f8b0]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L47
[c547]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L50
[01ca]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L54
[face]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L58
[5da8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L62
[c442]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input.lisp#L68
[3d0d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input/view.lisp#L1
[0558]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input/view.lisp#L10
[f25e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input/view.lisp#L13
[2728]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input/view.lisp#L16
[294d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/text-input/view.lisp#L19
[53ab]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/textarea.lisp#L1
[3620]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/textarea.lisp#L31
[941e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/textarea.lisp#L32
[24cd]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/textarea.lisp#L36
[97e2]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/textarea.lisp#L40
[80d7]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/textarea.lisp#L44
[665e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/textarea.lisp#L47
[25ae]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/textarea.lisp#L51
[0b74]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/inputs/textarea.lisp#L57
[446b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/modal.lisp#L1
[2b01]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/modal.lisp#L17
[b258]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/modal.lisp#L18
[d6e3]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/modal.lisp#L21
[453b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/modal.lisp#L24
[eaba]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/modal.lisp#L31
[fd5a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/modal.lisp#L39
[f3ec]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/modal.lisp#L56
[210a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/sizes.lisp#L1
[1e28]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/sizes.lisp#L31
[3647]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/clickable-row.lisp#L1
[49f9]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/clickable-row.lisp#L24
[38e3]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/clickable-row.lisp#L28
[2900]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L1
[60e5]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L101
[e701]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L106
[a570]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L110
[90ac]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L138
[e4a2]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L175
[b2b6]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L191
[d4f2]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L205
[3e5d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L41
[009f]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L42
[f19b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L47
[e363]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L51
[7f75]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L56
[5a18]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L61
[c6e7]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L66
[0401]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L71
[2b9c]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L76
[82ed]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L81
[f00a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L86
[fc7a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L91
[d213]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/crud.lisp#L96
[5c09]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/editable-table.lisp#L1
[e256]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/editable-table.lisp#L100
[3202]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/editable-table.lisp#L109
[724a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/editable-table.lisp#L132
[b07e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/editable-table.lisp#L205
[9d18]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/editable-table.lisp#L209
[0df9]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/editable-table.lisp#L70
[f5f9]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/editable-table.lisp#L71
[f24d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/editable-table.lisp#L90
[2fc4]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/editable-table.lisp#L94
[8ab1]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L1
[5547]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L165
[efe0]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L171
[64ba]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L176
[057e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L35
[42dc]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L36
[9640]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L39
[c193]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L42
[c709]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L45
[7ba3]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L48
[ed37]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L53
[dfdd]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L54
[e45b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L56
[e40b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L60
[c91d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/search.lisp#L71
[68fd]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L1
[a650]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L102
[7d07]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L150
[75b3]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L175
[8e61]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L182
[ace4]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L189
[151c]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L227
[3892]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L232
[e46e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L237
[16b1]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L242
[84b7]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L248
[b458]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L256
[f3f2]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L54
[3b0a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L55
[4741]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L58
[2cf6]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L61
[8361]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L66
[3198]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L67
[3c68]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L71
[4be8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L75
[edf2]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L81
[e77b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L82
[42c5]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L85
[5929]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L91
[3e8e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L95
[d87e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/tables/table.lisp#L98
[bfc4]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/api.lisp#L1
[b9b7]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/api.lisp#L210
[4f0e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/api.lisp#L34
[6bfb]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/base.lisp#L1
[91e8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/base.lisp#L8
[9721]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/base.lisp#L9
[413d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/color.lisp#L1
[fa5c]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/color.lisp#L16
[2d6d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/color.lisp#L17
[9901]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/color.lisp#L21
[6043]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/color.lisp#L25
[db7f]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/color.lisp#L29
[156e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/color.lisp#L34
[3722]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/color.lisp#L51
[db77]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/color.lisp#L63
[0ea1]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/color.lisp#L66
[0d99]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/styling.lisp#L1
[c9e9]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/styling.lisp#L17
[831c]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/styling.lisp#L29
[6973]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/styling.lisp#L34
[4d76]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/styling.lisp#L66
[8697]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/styling.lisp#L73
[5482]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/tailwind.lisp#L1
[93a0]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/tailwind.lisp#L141
[d825]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/tailwind.lisp#L148
[1606]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/tailwind.lisp#L41
[b8e3]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/tailwind/arbitrary.lisp#L1
[28a8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/tailwind/arbitrary.lisp#L19
[7707]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/tailwind/arbitrary.lisp#L20
[c1d2]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/tailwind/arbitrary.lisp#L23
[1828]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/themes/tailwind/arbitrary.lisp#L28
[313e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/align.lisp#L1
[0e84]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/align.lisp#L10
[c3e1]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/align.lisp#L14
[d471]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/align.lisp#L18
[2a5e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/align.lisp#L19
[f667]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/align.lisp#L24
[73d9]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/align.lisp#L25
[e6cc]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/align.lisp#L35
[94a5]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/align.lisp#L46
[1ec5]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/margin.lisp#L1
[3874]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/margin.lisp#L25
[3311]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/margin.lisp#L26
[3be0]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/margin.lisp#L30
[379e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/margin.lisp#L34
[567e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/margin.lisp#L38
[f77a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/margin.lisp#L50
[0afa]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/padding.lisp#L1
[878e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/padding.lisp#L11
[319d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/padding.lisp#L14
[18cd]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/padding.lisp#L18
[b868]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/padding.lisp#L19
[b52c]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/padding.lisp#L23
[ef94]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/padding.lisp#L40
[dd0a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/primitive-to.lisp#L1
[a0da]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/primitive-to.lisp#L18
[b119]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L1
[5847]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L112
[aee8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L22
[3530]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L23
[3e2e]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L36
[615d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L40
[dd41]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L44
[1d5f]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L45
[a2ea]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L49
[c209]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L55
[c727]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L56
[aba6]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L60
[3213]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L66
[851c]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L70
[c4c6]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L74
[a73a]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L79
[2887]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L86
[5297]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L91
[e09b]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/size.lisp#L99
[de23]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/walk.lisp#L1
[5592]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/walk.lisp#L17
[3cc9]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/utils/walk.lisp#L8
[13c5]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/widget.lisp#L1
[3efe]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/widget.lisp#L106
[2ef8]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/widget.lisp#L113
[3546]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/widget.lisp#L50
[64dc]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/widget.lisp#L51
[6678]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/widget.lisp#L55
[3066]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/widget.lisp#L59
[4aa4]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/widget.lisp#L63
[617d]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/widget.lisp#L77
[9efe]: https://github.com/40ants/reblocks-ui2/blob/41f0916c5903834f9a66040ea19545bdeeb00f13/src/widget.lisp#L99
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
