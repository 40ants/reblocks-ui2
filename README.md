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
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40API-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## API

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/BUTTONS/BUTTON

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FBUTTONS-2FBUTTON-22-29-20PACKAGE-29"></a>

#### [package](60bf) `reblocks-ui2/buttons/button`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-24BUTTON-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BUTTON

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20CLASS-29"></a>

###### [class](e85e) `reblocks-ui2/buttons/button:button` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](9782) `reblocks-ui2/buttons/button:button-class` (button) (:class)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](64ed) `reblocks-ui2/buttons/button:button-content` (button) (:content)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](12d4) `reblocks-ui2/buttons/button:button-disabled` (button) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](a858) `reblocks-ui2/buttons/button:button-pin` (button) (:pin)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](d2ce) `reblocks-ui2/buttons/button:button-size` (button) (:size = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-STYLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](6b55) `reblocks-ui2/buttons/button:button-style` (button) (:style)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3A-3ABUTTON-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](6517) `reblocks-ui2/buttons/button::button-type` (button) (:type = nil)

If not given, then type will be "button" for a button having on-click callback or "submit" otherwise.

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](594f) `reblocks-ui2/buttons/button:button-view` (button) (:view = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](9782) `reblocks-ui2/buttons/button:button-class` (button) (:class)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](64ed) `reblocks-ui2/buttons/button:button-content` (button) (:content)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](12d4) `reblocks-ui2/buttons/button:button-disabled` (button) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](a858) `reblocks-ui2/buttons/button:button-pin` (button) (:pin)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](d2ce) `reblocks-ui2/buttons/button:button-size` (button) (:size = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-STYLE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](6b55) `reblocks-ui2/buttons/button:button-style` (button) (:style)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3A-3ABUTTON-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](6517) `reblocks-ui2/buttons/button::button-type` (button) (:type = nil)

If not given, then type will be "button" for a button having on-click callback or "submit" otherwise.

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](594f) `reblocks-ui2/buttons/button:button-view` (button) (:view = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20FUNCTION-29"></a>

##### [function](02e8) `reblocks-ui2/buttons/button:button` CONTENT &KEY NAME VALUE TYPE (WIDGET-CLASS 'BUTTON) ON-CLICK (CLASS "button") DISABLED STYLE (VIEW :NORMAL) (SIZE :L) (PIN :ROUND) (WIDTH :MIN) HEIGHT

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/BUTTONS/VIEW

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FBUTTONS-2FVIEW-22-29-20PACKAGE-29"></a>

#### [package](3d6f) `reblocks-ui2/buttons/view`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24ACTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ACTION

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AACTION-20CLASS-29"></a>

###### [class](0b2b) `reblocks-ui2/buttons/view:action` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24BUTTON-VIEW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BUTTON-VIEW

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ABUTTON-VIEW-20CLASS-29"></a>

###### [class](4347) `reblocks-ui2/buttons/view:button-view` ()

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24NORMAL-DISABLED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL-DISABLED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ANORMAL-DISABLED-20CLASS-29"></a>

###### [class](99c7) `reblocks-ui2/buttons/view:normal-disabled` (normal)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24NORMAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ANORMAL-20CLASS-29"></a>

###### [class](213f) `reblocks-ui2/buttons/view:normal` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-ACTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-ACTION

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-ACTION-20CLASS-29"></a>

###### [class](6920) `reblocks-ui2/buttons/view:outlined-action` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-DANGER-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-DANGER

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-DANGER-20CLASS-29"></a>

###### [class](9f21) `reblocks-ui2/buttons/view:outlined-danger` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-INFO-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-INFO

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-INFO-20CLASS-29"></a>

###### [class](b98b) `reblocks-ui2/buttons/view:outlined-info` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-SUCCESS-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-SUCCESS

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-SUCCESS-20CLASS-29"></a>

###### [class](16bf) `reblocks-ui2/buttons/view:outlined-success` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-UTILITY-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-UTILITY

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-UTILITY-20CLASS-29"></a>

###### [class](30fe) `reblocks-ui2/buttons/view:outlined-utility` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-WARNING-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-WARNING

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-WARNING-20CLASS-29"></a>

###### [class](8581) `reblocks-ui2/buttons/view:outlined-warning` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-20CLASS-29"></a>

###### [class](36a4) `reblocks-ui2/buttons/view:outlined` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24RAISED-DISABLED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RAISED-DISABLED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ARAISED-DISABLED-20CLASS-29"></a>

###### [class](7f73) `reblocks-ui2/buttons/view:raised-disabled` (raised)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24RAISED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RAISED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ARAISED-20CLASS-29"></a>

###### [class](a96a) `reblocks-ui2/buttons/view:raised` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AGET-DISABLED-BUTTON-VIEW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](6e3b) `reblocks-ui2/buttons/view:get-disabled-button-view` view

Returns an alternative view for a button in disabled state.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AENSURE-VIEW-20FUNCTION-29"></a>

##### [function](dca3) `reblocks-ui2/buttons/view:ensure-view` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCARD-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CARD

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCARD-22-29-20PACKAGE-29"></a>

#### [package](0ed1) `reblocks-ui2/card`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCARD-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCARD-24CARD-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CARD-WIDGET

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-20CLASS-29"></a>

###### [class](ee14) `reblocks-ui2/card:card-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](5d6c) `reblocks-ui2/card:card-content` (card-widget) (:content)

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-PADDING-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](05c7) `reblocks-ui2/card:card-padding` (card-widget) (:padding = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](6811) `reblocks-ui2/card:card-view` (card-widget) (:view = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3AHORIZONTAL-ALIGN-OF-CARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](9c7a) `reblocks-ui2/card:horizontal-align-of-card-content` (card-widget) (:horizontal-align = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3AVERTICAL-ALIGN-OF-CARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](06fe) `reblocks-ui2/card:vertical-align-of-card-content` (card-widget) (:vertical-align = :center)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCARD-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-20FUNCTION-29"></a>

##### [function](72a7) `reblocks-ui2/card:card` CONTENT &KEY (VIEW :OUTLINED) (WIDTH "full") (HEIGHT '(120)) (PADDING :L) (MARGIN '(NIL NIL)) (HORIZONTAL-ALIGN :CENTER) (VERTICAL-ALIGN :CENTER) ON-CLICK (WIDGET-CLASS 'CARD-WIDGET)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCHART-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CHARTS/CHART

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCHARTS-2FCHART-22-29-20PACKAGE-29"></a>

#### [package](ab81) `reblocks-ui2/charts/chart`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FCHART-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCHART-24CHART-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CHART-WIDGET

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-20CLASS-29"></a>

###### [class](782c) `reblocks-ui2/charts/chart:chart-widget` (ui-widget)

Base class for chart widgets rendered by Google Charts.

Subclasses such as `reblocks-ui2/charts/pie-chart:pie-chart` ([`1`][7254] [`2`][0484]) and
`reblocks-ui2/charts/column-chart:column-chart` ([`1`][7f5f] [`2`][0851]) define chart type
specific options, theming methods do the rendering.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-BACKGROUND-COLOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](d297) `reblocks-ui2/charts/chart:chart-background-color` (chart-widget) (:BACKGROUND-COLOR = "#f9f9f9")

`CSS` color of the area around the chart.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-COLUMN-NAMES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](b53e) `reblocks-ui2/charts/chart:chart-column-names` (chart-widget) (:COLUMN-NAMES = '("Label" "Value"))

Names of the two DataTable columns, as strings.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-DATA-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](d7eb) `reblocks-ui2/charts/chart:chart-data` (chart-widget) (:data)

Chart rows, each of the form (`LABEL` `NUMBER-VALUE`).

Alternatively, this may be a function of zero arguments.
It is called on each render, so that charts always show
fresh data.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-EXTRA-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](d881) `reblocks-ui2/charts/chart:chart-extra-options` (chart-widget) (:extra-options = nil)

Raw JavaScript, inserted into the Google Charts options object
before the closing bracket. Use it for options which are not
covered by typed slots, like "legend: {position: 'none'}".

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](586f) `reblocks-ui2/charts/chart:chart-height` (chart-widget) (:height = 500)

Chart height in pixels.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCHART-3ACHART-WIDGET-29-29"></a>

###### [reader](9486) `reblocks-ui2/charts/chart:chart-title` (chart-widget) (:title = "")

A chart title rendered at the top of the chart by Google Charts.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CHARTS/COLUMN-CHART

<a id="x-28-23A-28-2832-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-22-29-20PACKAGE-29"></a>

#### [package](9a94) `reblocks-ui2/charts/column-chart`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-24COLUMN-CHART-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN-CHART

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-20CLASS-29"></a>

###### [class](5244) `reblocks-ui2/charts/column-chart:column-chart` (chart-widget)

A column chart widget rendered by Google Charts.

The `column-chart` ([`1`][7f5f] [`2`][0851]) symbol names both this class and a constructor
function, following the donor widgets from the lct25 project.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-V-AXIS-MIN-ZERO-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-29-29"></a>

###### [reader](fdad) `reblocks-ui2/charts/column-chart:column-chart-v-axis-min-zero-p` (column-chart) (:v-axis-min-zero = t)

When true (the default), the vertical axis starts at zero,
like vAxis.minValue = 0 in Google Charts.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-X-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-29-29"></a>

###### [reader](0835) `reblocks-ui2/charts/column-chart:column-chart-x-title` (column-chart) (:x-title = nil)

A title for the horizontal axis. When nil, the axis has no title.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-Y-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-29-29"></a>

###### [reader](ddd9) `reblocks-ui2/charts/column-chart:column-chart-y-title` (column-chart) (:y-title = nil)

A title for the vertical axis. When nil, the axis has no title.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-20FUNCTION-29"></a>

##### [function](a713) `reblocks-ui2/charts/column-chart:column-chart` data &rest restargs &key title column-names height background-color extra-options x-title y-title v-axis-min-zero (widget-class 'column-chart)

Returns a column chart widget rendered by Google Charts.

`DATA` is either a list of rows of the form (`LABEL` `NUMBER-VALUE`),
or a function of zero arguments returning such a list. The function
is called on each render to fetch fresh data.

`X-TITLE` and `Y-TITLE` add titles to the horizontal and vertical axes.

`V-AXIS-MIN-ZERO` (the default) makes the vertical axis start at zero.

`EXTRA-OPTIONS` is a raw JavaScript string, inserted into the Google
Charts options object before the closing bracket.

`WIDGET-CLASS` may be a subclass of `column-chart` ([`1`][7f5f] [`2`][0851]) to instantiate instead.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CHARTS/PIE-CHART

<a id="x-28-23A-28-2829-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-22-29-20PACKAGE-29"></a>

#### [package](fcc7) `reblocks-ui2/charts/pie-chart`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-24PIE-CHART-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### PIE-CHART

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-20CLASS-29"></a>

###### [class](61e8) `reblocks-ui2/charts/pie-chart:pie-chart` (chart-widget)

A pie chart widget rendered by Google Charts.

The `pie-chart` ([`1`][7254] [`2`][0484]) symbol names both this class and a constructor
function, following the donor widgets from the lct25 project.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-IS3D-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-29-29"></a>

###### [reader](8b87) `reblocks-ui2/charts/pie-chart:pie-chart-is3d` (pie-chart) (:is3d = nil)

When true, the chart is rendered with pseudo-`3D` effect.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-PIE-HOLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-29-29"></a>

###### [reader](617d) `reblocks-ui2/charts/pie-chart:pie-chart-pie-hole` (pie-chart) (:pie-hole = 0)

A number between 0 and 1, describing what fraction of the radius
to cut out from the center. 0 gives a usual pie chart,
0.4 gives a donut chart.

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-SLICE-COLORS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-29-29"></a>

###### [reader](98f8) `reblocks-ui2/charts/pie-chart:pie-chart-slice-colors` (pie-chart) (:slice-colors = nil)

A list of `CSS` colors, applied to the slices in order.
When nil, Google Charts default colors are used.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-20FUNCTION-29"></a>

##### [function](caf2) `reblocks-ui2/charts/pie-chart:pie-chart` data &rest restargs &key title column-names height background-color extra-options pie-hole is3d slice-colors (widget-class 'pie-chart)

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

`WIDGET-CLASS` may be a subclass of `pie-chart` ([`1`][7254] [`2`][0484]) to instantiate instead.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/COLUMN

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-22-29-20PACKAGE-29"></a>

#### [package](a0b3) `reblocks-ui2/containers/column`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-24COLUMN-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3ACOLUMN-WIDGET-20CLASS-29"></a>

###### [class](c9df) `reblocks-ui2/containers/column:column-widget` (container-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3ACOLUMN-20FUNCTION-29"></a>

##### [function](5494) `reblocks-ui2/containers/column:column` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/CONTAINER

<a id="x-28-23A-28-2833-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-22-29-20PACKAGE-29"></a>

#### [package](8cb2) `reblocks-ui2/containers/container`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-24CONTAINER-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTAINER-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-20CLASS-29"></a>

###### [class](0cd2) `reblocks-ui2/containers/container:container-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AADDITIONAL-CLASSES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](2e0d) `reblocks-ui2/containers/container:additional-classes` (container-widget) (:css-classes = nil)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACHILDREN-GAP-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](e3b8) `reblocks-ui2/containers/container:children-gap` (container-widget) (:gap = \*default-gap\*)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](88a1) `reblocks-ui2/containers/container:subwidgets` (container-widget) (:subwidgets = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [accessor](88a1) `reblocks-ui2/containers/container:subwidgets` (container-widget) (:subwidgets = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AGAP-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](931b) `reblocks-ui2/containers/container:gap-css-classes` gap theme

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AMAKE-CONTAINER-20FUNCTION-29"></a>

##### [function](1afb) `reblocks-ui2/containers/container:make-container` default-widget-class &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/CONTROLS-ROW

<a id="x-28-23A-28-2836-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-22-29-20PACKAGE-29"></a>

#### [package](339f) `reblocks-ui2/containers/controls-row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-24CONTROLS-ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTROLS-ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3ACONTROLS-ROW-WIDGET-20CLASS-29"></a>

###### [class](f4df) `reblocks-ui2/containers/controls-row:controls-row-widget` (row-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3ACONTROLS-ROW-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](e43d) `reblocks-ui2/containers/controls-row:controls-row` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/ROW

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FROW-22-29-20PACKAGE-29"></a>

#### [package](de37) `reblocks-ui2/containers/row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FROW-24ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AROW-WIDGET-20CLASS-29"></a>

###### [class](6ab6) `reblocks-ui2/containers/row:row-widget` (container-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AMAKE-ROW-WIDGET-20FUNCTION-29"></a>

##### [function](d023) `reblocks-ui2/containers/row:make-row-widget` subwidgets &key (gap \*default-gap\*) on-click

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AROW-20FUNCTION-29"></a>

##### [function](aa8e) `reblocks-ui2/containers/row:row` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/STACK

<a id="x-28-23A-28-2829-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FSTACK-22-29-20PACKAGE-29"></a>

#### [package](4cbc) `reblocks-ui2/containers/stack`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-24STACK-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### STACK-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-20CLASS-29"></a>

###### [class](34ee) `reblocks-ui2/containers/stack:stack-widget` (ui-widget)

Shows only the top child from the stack. Provides methods to push and pop widgets.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-CHILDREN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-29-29"></a>

###### [reader](7188) `reblocks-ui2/containers/stack:stack-widget-children` (stack-widget) (:children)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APOP-CHILD-20GENERIC-FUNCTION-29"></a>

##### [generic-function](ca88) `reblocks-ui2/containers/stack:pop-child` stack-widget

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APUSH-CHILD-20GENERIC-FUNCTION-29"></a>

##### [generic-function](2204) `reblocks-ui2/containers/stack:push-child` stack-widget child

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ACURRENT-STACK-WIDGET-20FUNCTION-29"></a>

##### [function](a06f) `reblocks-ui2/containers/stack:current-stack-widget`

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APOP-ME-20FUNCTION-29"></a>

##### [function](680b) `reblocks-ui2/containers/stack:pop-me`

Removes current (top) widget from the stack and display the next widget.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3AREPLACE-ME-WITH-20FUNCTION-29"></a>

##### [function](1851) `reblocks-ui2/containers/stack:replace-me-with` widget

Adds a new widget ontop of the current.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-20FUNCTION-29"></a>

##### [function](8fa1) `reblocks-ui2/containers/stack:stack` &rest children

Makes a stack widget with given subwidgets.

Only first widget in the list will be visible.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/TABS

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FTABS-22-29-20PACKAGE-29"></a>

#### [package](6efc) `reblocks-ui2/containers/tabs`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-24TABS-CONTROL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABS-CONTROL

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-20CLASS-29"></a>

###### [class](e4d8) `reblocks-ui2/containers/tabs:tabs-control` (event-emitter ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ACURRENT-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](77c3) `reblocks-ui2/containers/tabs:current-idx` (tabs-control) (:idx = 0)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASUBWIDGETS-TITLES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](e11b) `reblocks-ui2/containers/tabs:subwidgets-titles` (tabs-control) (:titles)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](deed) `reblocks-ui2/containers/tabs:tabs-size` (tabs-control) (:size)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ACURRENT-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [accessor](77c3) `reblocks-ui2/containers/tabs:current-idx` (tabs-control) (:idx = 0)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-24TABS-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABS-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-20CLASS-29"></a>

###### [class](7c46) `reblocks-ui2/containers/tabs:tabs-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-29-29"></a>

###### [reader](2905) `reblocks-ui2/containers/tabs:subwidgets` (tabs-widget) (:subwidgets)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SELECTOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-29-29"></a>

###### [reader](b277) `reblocks-ui2/containers/tabs:tabs-selector` (tabs-widget) (:selector)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASWITCH-TO-IDX-20FUNCTION-29"></a>

##### [function](8161) `reblocks-ui2/containers/tabs:switch-to-idx` &key widget-id idx &allow-other-keys

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-20FUNCTION-29"></a>

##### [function](9fc7) `reblocks-ui2/containers/tabs:tabs` titles subwidgets &key (idx 0) (selector-class 'tabs-control) (class 'tabs-widget) (size :l)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SIZE-20-28TYPE-29-29"></a>

##### [type](b033) `reblocks-ui2/containers/tabs:tabs-size`

```
(MEMBER :M :L :XL)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEDITABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/EDITABLE

<a id="x-28-23A-28-2821-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FEDITABLE-22-29-20PACKAGE-29"></a>

#### [package](0a3c) `reblocks-ui2/editable`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FEDITABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FEDITABLE-3AMAKE-EDITABLE-WIDGET-20GENERIC-FUNCTION-29"></a>

##### [generic-function](10af) `reblocks-ui2/editable:make-editable-widget` value callback

Creates a widget which can be used to edit a given value.
Every time when the widget loose focus, it will call `CALLBACK` argument with a new value.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEVENTS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/EVENTS

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FEVENTS-22-29-20PACKAGE-29"></a>

#### [package](3119) `reblocks-ui2/events`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FEVENTS-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEVENTS-24EVENT-EMITTING-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EVENT-EMITTING-WIDGET

<a id="x-28REBLOCKS-UI2-2FEVENTS-3AEVENT-EMITTING-WIDGET-20CLASS-29"></a>

###### [class](e5ce) `reblocks-ui2/events:event-emitting-widget` (event-emitter ui-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-22-29-20PACKAGE-29"></a>

#### [package](20ba) `reblocks-ui2/form`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-24FORM-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FORM-WIDGET

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-20CLASS-29"></a>

###### [class](1ed8) `reblocks-ui2/form:form-widget` (event-emitting-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](1c2e) `reblocks-ui2/form:form-content` (form-widget) (:content)

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-INPUTS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](4504) `reblocks-ui2/form:form-inputs` (form-widget) (= (make-hash-table :test 'equal))

Internal structure holding references to all form inputs having a name attribute.

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-ON-SUBMIT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](6a84) `reblocks-ui2/form:form-on-submit` (form-widget) (:on-submit = 'no-action)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-20FUNCTION-29"></a>

##### [function](2216) `reblocks-ui2/form:form` content &key (widget-class 'form-widget) on-submit

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FCONFIRM-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM/CONFIRM

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-2FCONFIRM-22-29-20PACKAGE-29"></a>

#### [package](a7c0) `reblocks-ui2/form/confirm`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FCONFIRM-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FCONFIRM-3ACONFIRM-20FUNCTION-29"></a>

##### [function](90a7) `reblocks-ui2/form/confirm:confirm` CONTENT &KEY (CONFIRM-BUTTON-TITLE "Confirm") (CANCEL-BUTTON-TITLE "Cancel") (CONFIRM-VALUE "submit") (CANCEL-VALUE "cancel") ON-CONFIRM WIDGET-CLASS

Returns a form widget asking the user to confirm an action.

`CONTENT` is a question to show to the user. It might be a string or any other
widget and is processed by [`reblocks/widget:create-widget-from`][5f3d], like the
content of the usual [`form`][ce02].

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
to close a modal showing this form, call [`reblocks-ui2/modal:modal-hide`][382a] from
the `ON-CONFIRM` callback.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM/VALIDATION

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-2FVALIDATION-22-29-20PACKAGE-29"></a>

#### [package](096d) `reblocks-ui2/form/validation`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24FIELD-VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FIELD-VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](b7b4) `reblocks-ui2/form/validation:field-validation-error` (validation-error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-29-29"></a>

###### [reader](b7b4) `reblocks-ui2/form/validation:field-name` (field-validation-error) (:field-name)

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AINVALID-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-29-29"></a>

###### [reader](b7b4) `reblocks-ui2/form/validation:invalid-value` (field-validation-error) (:invalid-value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24FORM-VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FORM-VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFORM-VALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](12db) `reblocks-ui2/form/validation:form-validation-error` (validation-error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3ANUM-ERRORS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFORM-VALIDATION-ERROR-29-29"></a>

###### [reader](12db) `reblocks-ui2/form/validation:num-errors` (form-validation-error) (:num-errors)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](ccfd) `reblocks-ui2/form/validation:validation-error` (error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AERROR-ARGS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-29-29"></a>

###### [reader](ccfd) `reblocks-ui2/form/validation:error-args` (validation-error) (:error-args = 'nil)

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AERROR-MESSAGE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-29-29"></a>

###### [reader](ccfd) `reblocks-ui2/form/validation:error-message` (validation-error) (:error-message = '"")

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATE-FORM-DATA-20GENERIC-FUNCTION-29"></a>

##### [generic-function](3120) `reblocks-ui2/form/validation:validate-form-data` widget form-data

Accepts a form or input widget and a plist of all data sent from the browser.

Should return a plist of validated data. Also, it might change the state of the widgets,
for example, to set an error message saying that entered value is invalid. In the case
when data is invalid, function should signal `validation-error` ([`1`][f0d1] [`2`][e5e1]).

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20FUNCTION-29"></a>

##### [function](3a33) `reblocks-ui2/form/validation:validation-error` message &rest args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATORS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM/VALIDATORS

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-2FVALIDATORS-22-29-20PACKAGE-29"></a>

#### [package](ba93) `reblocks-ui2/form/validators`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATORS-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AALL-20FUNCTION-29"></a>

##### [function](d852) `reblocks-ui2/form/validators:all` &rest validators

Combines a multiple validators into a chain where every subsequent validator validates output of the previous one.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AFORMAT-DATE-20FUNCTION-29"></a>

##### [function](5520) `reblocks-ui2/form/validators:format-date` timestamp &key (format :iso)

Formats `TIMESTAMP` as a date string.

Supported formats are the same as for [`valid-date`][a897]:

* `:ISO` (default) returns "`YYYY-MM-DD`" strings.
* `:DDMMYYYY` returns "`DD`.`MM`.`YYYY`" strings.

A `NIL` `TIMESTAMP` is formatted as an empty string, so that the result
can be used as an input widget's value.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-DATE-20FUNCTION-29"></a>

##### [function](b3ae) `reblocks-ui2/form/validators:valid-date` &key (format :iso) (required t)

Returns a validator converting a date string into a local-time timestamp.

Two formats are supported:

* `:ISO` (default) expects "`YYYY-MM-DD`" strings. This is a native format
  of the `HTML` inputs with type="date".
* `:DDMMYYYY` expects "`DD`.`MM`.`YYYY`" strings.

When `VALUE` is empty and `REQUIRED` is `NIL`, the resulting validator returns `NIL`.
An empty `VALUE` with the default `REQUIRED` = T signals a `validation-error` ([`1`][f0d1] [`2`][e5e1]),
as well as a `VALUE` which does not match the format or denotes
a non-existent date like 2025-02-31.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-INTEGER-20FUNCTION-29"></a>

##### [function](97be) `reblocks-ui2/form/validators:valid-integer` &key min max

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-PASSWORD-20FUNCTION-29"></a>

##### [function](13df) `reblocks-ui2/form/validators:valid-password` &key (min-length 10) max-length required-symbols error

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-STRING-20FUNCTION-29"></a>

##### [function](c6e5) `reblocks-ui2/form/validators:valid-string` &key (min-length 1) max-length

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FHTML-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/HTML

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FHTML-22-29-20PACKAGE-29"></a>

#### [package](817d) `reblocks-ui2/html`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FHTML-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FHTML-3APROP-20FUNCTION-29"></a>

##### [function](de62) `reblocks-ui2/html:prop` name &optional default

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FHTML-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FHTML-3AHTML-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](8f94) `reblocks-ui2/html:html` (&body body) &key css (html-tag :div) css-classes on-click props width height margin

This macro allows to describe [`html`][c654], state, css and event handlers of the widget.
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

#### [package](0e7d) `reblocks-ui2/icon`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FICON-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FICON-24ICON-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ICON-WIDGET

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-WIDGET-20CLASS-29"></a>

###### [class](06e7) `reblocks-ui2/icon:icon-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FICON-3AICON-WIDGET-29-29"></a>

###### [reader](0a1d) `reblocks-ui2/icon:icon-name` (icon-widget) (:name)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FICON-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-20FUNCTION-29"></a>

##### [function](7bbf) `reblocks-ui2/icon:icon` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FBASE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/BASE

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FBASE-22-29-20PACKAGE-29"></a>

#### [package](751c) `reblocks-ui2/inputs/base`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FBASE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FBASE-24BASE-INPUT-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BASE-INPUT-WIDGET

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-20CLASS-29"></a>

###### [class](ffbd) `reblocks-ui2/inputs/base:base-input-widget` (named-input)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-ERROR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](56fb) `reblocks-ui2/inputs/base:input-error` (base-input-widget) (:error = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-VALIDATOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](c5dc) `reblocks-ui2/inputs/base:input-validator` (base-input-widget) (:validator = nil)

A function of one argument returning a validated value or signaling the [`field-validation-error`][3f91].

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](3e92) `reblocks-ui2/inputs/base:input-value` (base-input-widget) (:value = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FNAMED-24NAMED-INPUT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NAMED-INPUT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-20CLASS-29"></a>

###### [class](1d4e) `reblocks-ui2/inputs/named:named-input` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3AINPUT-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-29-29"></a>

###### [reader](542e) `reblocks-ui2/inputs/named:input-name` (named-input) (:name = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/CHECKBOX

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-22-29-20PACKAGE-29"></a>

#### [package](1353) `reblocks-ui2/inputs/checkbox`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-24CHECKBOX-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CHECKBOX

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-20CLASS-29"></a>

###### [class](d633) `reblocks-ui2/inputs/checkbox:checkbox` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-CHECKED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](3037) `reblocks-ui2/inputs/checkbox:checkbox-checked` (checkbox) (:checked = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](e420) `reblocks-ui2/inputs/checkbox:checkbox-disabled` (checkbox) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](4c5d) `reblocks-ui2/inputs/checkbox:checkbox-size` (checkbox) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](fda0) `reblocks-ui2/inputs/checkbox:checkbox-view` (checkbox) (:view = (make-instance 'normal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-20FUNCTION-29"></a>

##### [function](6f52) `reblocks-ui2/inputs/checkbox:checkbox` &key (widget-class 'checkbox) name value (view :normal) (size :m) disabled checked error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/DATE-INPUT

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-22-29-20PACKAGE-29"></a>

#### [package](f0e7) `reblocks-ui2/inputs/date-input`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3ADATE-INPUT-20FUNCTION-29"></a>

##### [function](4b48) `reblocks-ui2/inputs/date-input:date-input` &key (widget-class 'input-widget) name value (format :iso) (required t) placeholder (view :normal) (size :m) disabled error

Returns a native `HTML` date input.

This is a thin constructor over the usual text [`input`][ef48] with `:TYPE` "date"
and a [`valid-date`][a897] validator attached.

`VALUE` should be a "`YYYY-MM-DD`" string, because this is the format
browsers use for inputs with type="date".

`FORMAT` is passed to [`valid-date`][a897] and only controls how the submitted data
is parsed on the server. By default, the date is required; pass
`:REQUIRED` `NIL` to allow empty values, in which case the validator
returns `NIL`.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FNAMED-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/NAMED

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FNAMED-22-29-20PACKAGE-29"></a>

#### [package](3a49) `reblocks-ui2/inputs/named`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FNAMED-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FNAMED-24NAMED-INPUT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NAMED-INPUT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-20CLASS-29"></a>

###### [class](1d4e) `reblocks-ui2/inputs/named:named-input` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3AINPUT-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-29-29"></a>

###### [reader](542e) `reblocks-ui2/inputs/named:input-name` (named-input) (:name = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/SELECT

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FSELECT-22-29-20PACKAGE-29"></a>

#### [package](2749) `reblocks-ui2/inputs/select`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-24OPTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OPTION

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-20CLASS-29"></a>

###### [class](0bf0) `reblocks-ui2/inputs/select:option` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](7966) `reblocks-ui2/inputs/select:option-name` (option) (:name)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-SELECTED-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](a799) `reblocks-ui2/inputs/select:option-selected-p` (option) (:selected = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](a17c) `reblocks-ui2/inputs/select:option-value` (option) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-24SELECT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SELECT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-20CLASS-29"></a>

###### [class](76cf) `reblocks-ui2/inputs/select:select` (event-emitter base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](e01b) `reblocks-ui2/inputs/select:select-disabled` (select) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](3b69) `reblocks-ui2/inputs/select:select-options` (select) (:options)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](91e6) `reblocks-ui2/inputs/select:select-pin` (select) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](b6e6) `reblocks-ui2/inputs/select:select-size` (select) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](290d) `reblocks-ui2/inputs/select:select-view` (select) (:view = (make-instance 'normal))

**Accessors**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [accessor](3b69) `reblocks-ui2/inputs/select:select-options` (select) (:options)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AENSURE-OPTION-20FUNCTION-29"></a>

##### [function](983c) `reblocks-ui2/inputs/select:ensure-option` value

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-20FUNCTION-29"></a>

##### [function](9cbd) `reblocks-ui2/inputs/select:option` name &key value selected

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-20FUNCTION-29"></a>

##### [function](3ce7) `reblocks-ui2/inputs/select:select` options &key (widget-class 'select) name (view :normal) (pin :round) (size :m) disabled validator error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXT-INPUT

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-22-29-20PACKAGE-29"></a>

#### [package](d5f2) `reblocks-ui2/inputs/text-input`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-24INPUT-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### INPUT-WIDGET

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-20CLASS-29"></a>

###### [class](8ea8) `reblocks-ui2/inputs/text-input:input-widget` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](e552) `reblocks-ui2/inputs/text-input:input-disabled` (input-widget) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-LEFT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](9e95) `reblocks-ui2/inputs/text-input:input-left-content` (input-widget) (:left-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](6070) `reblocks-ui2/inputs/text-input:input-pin` (input-widget) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-PLACEHOLDER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](9aad) `reblocks-ui2/inputs/text-input:input-placeholder` (input-widget) (:placeholder = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-RIGHT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](a950) `reblocks-ui2/inputs/text-input:input-right-content` (input-widget) (:right-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](d84b) `reblocks-ui2/inputs/text-input:input-size` (input-widget) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](e246) `reblocks-ui2/inputs/text-input:input-type` (input-widget) (:type = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](f3c6) `reblocks-ui2/inputs/text-input:input-view` (input-widget) (:view = (make-instance 'normal))

**Accessors**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-LEFT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [accessor](9e95) `reblocks-ui2/inputs/text-input:input-left-content` (input-widget) (:left-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-RIGHT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [accessor](a950) `reblocks-ui2/inputs/text-input:input-right-content` (input-widget) (:right-content = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-20FUNCTION-29"></a>

##### [function](24d1) `reblocks-ui2/inputs/text-input:input` &key (widget-class 'input-widget) name value (type :text) placeholder (view :normal) (pin :round) (size :m) disabled validator error left-content right-content

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXT-INPUT/VIEW

<a id="x-28-23A-28-2835-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-22-29-20PACKAGE-29"></a>

#### [package](d89e) `reblocks-ui2/inputs/text-input/view`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24CLEAR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CLEAR

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3ACLEAR-20CLASS-29"></a>

###### [class](b4bd) `reblocks-ui2/inputs/text-input/view:clear` (input-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24INPUT-VIEW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### INPUT-VIEW

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3AINPUT-VIEW-20CLASS-29"></a>

###### [class](2c84) `reblocks-ui2/inputs/text-input/view:input-view` ()

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24NORMAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3ANORMAL-20CLASS-29"></a>

###### [class](7caf) `reblocks-ui2/inputs/text-input/view:normal` (input-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3AENSURE-VIEW-20FUNCTION-29"></a>

##### [function](e577) `reblocks-ui2/inputs/text-input/view:ensure-view` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXTAREA

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-22-29-20PACKAGE-29"></a>

#### [package](23bb) `reblocks-ui2/inputs/textarea`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-24TEXTAREA-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TEXTAREA

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-20CLASS-29"></a>

###### [class](070e) `reblocks-ui2/inputs/textarea:textarea` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](1880) `reblocks-ui2/inputs/textarea:textarea-disabled` (textarea) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](5404) `reblocks-ui2/inputs/textarea:textarea-pin` (textarea) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-PLACEHOLDER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](b1e7) `reblocks-ui2/inputs/textarea:textarea-placeholder` (textarea) (:placeholder = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](8d53) `reblocks-ui2/inputs/textarea:textarea-size` (textarea) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](76d7) `reblocks-ui2/inputs/textarea:textarea-type` (textarea) (:type = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](cc79) `reblocks-ui2/inputs/textarea:textarea-view` (textarea) (:view = (make-instance 'normal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-20FUNCTION-29"></a>

##### [function](7459) `reblocks-ui2/inputs/textarea:textarea` &key (widget-class 'textarea) name value (type :text) placeholder (view :normal) (pin :round) (size :m) disabled validator error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FMODAL-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/MODAL

<a id="x-28-23A-28-2818-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FMODAL-22-29-20PACKAGE-29"></a>

#### [package](42c9) `reblocks-ui2/modal`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FMODAL-24MODAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### MODAL

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-20CLASS-29"></a>

###### [class](60fb) `reblocks-ui2/modal:modal` (ui-widget)

This widget shows a popup window.

**Readers**

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HEADER-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](fd9a) `reblocks-ui2/modal:modal-header-content` (modal) (:header-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-MAIN-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](0275) `reblocks-ui2/modal:modal-main-content` (modal) (:main-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-VISIBLE-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](811e) `reblocks-ui2/modal:modal-visible-p` (modal) (:visible = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HEADER-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [accessor](fd9a) `reblocks-ui2/modal:modal-header-content` (modal) (:header-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-MAIN-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [accessor](0275) `reblocks-ui2/modal:modal-main-content` (modal) (:main-content)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HIDE-20GENERIC-FUNCTION-29"></a>

##### [generic-function](3e22) `reblocks-ui2/modal:modal-hide` widget

Hides modal window.

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-SHOW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f4d0) `reblocks-ui2/modal:modal-show` widget &key content header-content

Shows modal window.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-20FUNCTION-29"></a>

##### [function](f878) `reblocks-ui2/modal:modal` content &key header-content visible

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FSIZES-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/SIZES

<a id="x-28-23A-28-2818-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FSIZES-22-29-20PACKAGE-29"></a>

#### [package](c9eb) `reblocks-ui2/sizes`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FSIZES-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FSIZES-3AENSURE-SIZE-20FUNCTION-29"></a>

##### [function](e44b) `reblocks-ui2/sizes:ensure-size` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/CLICKABLE-ROW

<a id="x-28-23A-28-2833-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-22-29-20PACKAGE-29"></a>

#### [package](db63) `reblocks-ui2/tables/clickable-row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-24CLICKABLE-ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CLICKABLE-ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3ACLICKABLE-ROW-WIDGET-20CLASS-29"></a>

###### [class](d83d) `reblocks-ui2/tables/clickable-row:clickable-row-widget` (table-row)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3AMAKE-CLICKABLE-ROW-WIDGET-20FUNCTION-29"></a>

##### [function](4867) `reblocks-ui2/tables/clickable-row:make-clickable-row-widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/EDITABLE-TABLE

<a id="x-28-23A-28-2834-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-22-29-20PACKAGE-29"></a>

#### [package](b9a3) `reblocks-ui2/tables/editable-table`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24EDITABLE-COLUMN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EDITABLE-COLUMN

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-20CLASS-29"></a>

###### [class](0bdb) `reblocks-ui2/tables/editable-table:editable-column` (column)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3ADATA-SETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-29-29"></a>

###### [reader](440a) `reblocks-ui2/tables/editable-table:data-setter` (editable-column) (:setter = #'default-setter)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24EDITABLE-TABLE-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EDITABLE-TABLE-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-20CLASS-29"></a>

###### [class](9e5a) `reblocks-ui2/tables/editable-table:editable-table-widget` (table-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-CREATOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29"></a>

###### [reader](4009) `reblocks-ui2/tables/editable-table:object-creator` (editable-table-widget) (:object-creator = nil)

When given, should be a function of zero arguments.
Will be called when user adds a new table row.
Usually you will want to do create and add an object to a database.
Returned object will be bound to a new table row and used to fill cells with new values.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-DELETER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29"></a>

###### [reader](cd43) `reblocks-ui2/tables/editable-table:object-deleter` (editable-table-widget) (:object-deleter = nil)

When given, should be a function of one argument.
Will be called with object instance to be deleted from the table.
Usually you will want to do something like deletion the record from a database.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24ROW-NOT-FOUND-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ROW-NOT-FOUND

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AROW-NOT-FOUND-20CONDITION-29"></a>

###### [condition](2bf2) `reblocks-ui2/tables/editable-table:row-not-found` (error)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3ADELETE-ROW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](5863) `reblocks-ui2/tables/editable-table:delete-row` table obj

Deletes row representing given object.
First it calls [`object-deleter`][f5ed] callback and then
removes corresponding row from the table.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-20FUNCTION-29"></a>

##### [function](903b) `reblocks-ui2/tables/editable-table:editable-column` title &key (getter nil getter-given-p) (setter #'default-setter) (cell-maker #'create-widget-from) (align :left)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AMAKE-EDITABLE-TABLE-20FUNCTION-29"></a>

##### [function](d9ff) `reblocks-ui2/tables/editable-table:make-editable-table` columns rows &key (table-class 'editable-table-widget) (row-class nil row-class-given-p) (object-deleter nil object-deleter-given-p) (object-creator nil object-creator-given-p)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/SEARCH

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FSEARCH-22-29-20PACKAGE-29"></a>

#### [package](2d90) `reblocks-ui2/tables/search`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-24CONTROLS-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTROLS-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-20CLASS-29"></a>

###### [class](398f) `reblocks-ui2/tables/search:controls-widget` (event-emitting-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-BUTTON-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-29-29"></a>

###### [reader](4e58) `reblocks-ui2/tables/search::next-page-button` (controls-widget) (:button)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ASHOW-BUTTON-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-29-29"></a>

###### [reader](73fb) `reblocks-ui2/tables/search::show-button-p` (controls-widget) (= nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-24SEARCH-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SEARCH-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-20CLASS-29"></a>

###### [class](374f) `reblocks-ui2/tables/search:search-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](83c9) `reblocks-ui2/tables/search:controls-widget` (search-widget) (:controls)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ADATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](0c57) `reblocks-ui2/tables/search::data-getter` (search-widget) (:data-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3AFILTERS-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](e671) `reblocks-ui2/tables/search::filters-widget` (search-widget) (:filters)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](5850) `reblocks-ui2/tables/search::next-page-getter` (search-widget) (:next-page-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](5c72) `reblocks-ui2/tables/table:table-widget` (search-widget) (:table)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [accessor](5850) `reblocks-ui2/tables/search::next-page-getter` (search-widget) (:next-page-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [accessor](5c72) `reblocks-ui2/tables/table:table-widget` (search-widget) (:table)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AFILTERS-UPDATED-20GENERIC-FUNCTION-29"></a>

##### [generic-function](16b8) `reblocks-ui2/tables/search:filters-updated` widget

Signals that filters state was changed and table with results should be updated.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AHIDE-NEXT-PAGE-BUTTON-20GENERIC-FUNCTION-29"></a>

##### [generic-function](fa23) `reblocks-ui2/tables/search:hide-next-page-button` widget

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASHOW-NEXT-PAGE-BUTTON-20GENERIC-FUNCTION-29"></a>

##### [generic-function](33c2) `reblocks-ui2/tables/search:show-next-page-button` widget

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AMAKE-DEFAULT-CONTROLS-WIDGET-20FUNCTION-29"></a>

##### [function](58b5) `reblocks-ui2/tables/search:make-default-controls-widget` &KEY (BUTTON-TITLE "Load more")

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AMAKE-SEARCH-WIDGET-20FUNCTION-29"></a>

##### [function](e27c) `reblocks-ui2/tables/search:make-search-widget` columns data-getter &key (filters-widget nil filters-widget-given-p) (controls-widget nil controls-widget-given-p) (widget-class 'search-widget) (table-class nil table-class-given-p) (row-class nil row-class-given-p)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/TABLE

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FTABLE-22-29-20PACKAGE-29"></a>

#### [package](5e62) `reblocks-ui2/tables/table`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24COLUMN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20CLASS-29"></a>

###### [class](997c) `reblocks-ui2/tables/table:column` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACELL-MAKER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](7fc8) `reblocks-ui2/tables/table:cell-maker` (column) (:cell-maker = #'create-widget-from)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-ALIGN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](a7c8) `reblocks-ui2/tables/table:column-align` (column) (:align = :left)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CLASSES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](b928) `reblocks-ui2/tables/table:column-classes` (column) (:classes = nil)

Additional `CSS` classes for column cells

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](e1d2) `reblocks-ui2/tables/table:column-idx` (column) (= nil)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](9ea2) `reblocks-ui2/tables/table:column-title` (column) (:title)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ADATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](91e9) `reblocks-ui2/tables/table:data-getter` (column) (:GETTER = (LAMBDA (ROW)
  (DECLARE (IGNORE ROW))
  (ERROR "Real getter should be provided to COLUMN function.")))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-ROW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-ROW

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-20CLASS-29"></a>

###### [class](2edf) `reblocks-ui2/tables/table:table-row` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-CELLS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](be5f) `reblocks-ui2/tables/table:row-cells` (table-row) (:cells)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-OBJECT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](4272) `reblocks-ui2/tables/table:row-object` (table-row) (:object)

Original object, passed as a row to the [`make-table`][540e] function.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-TABLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](a6c3) `reblocks-ui2/tables/table:row-table` (table-row) (:table)

Reference it a table row belong to.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20CLASS-29"></a>

###### [class](a486) `reblocks-ui2/tables/table:table-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-COLUMNS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](6512) `reblocks-ui2/tables/table:table-columns` (table-widget) (:columns = nil)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](1c88) `reblocks-ui2/tables/table:table-row-class` (table-widget) (:row-class = 'table-row)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROWS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](86f2) `reblocks-ui2/tables/table:table-rows` (table-widget) (:rows = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AAPPEND-DATA-20GENERIC-FUNCTION-29"></a>

##### [generic-function](58e9) `reblocks-ui2/tables/table:append-data` widget data

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](556d) `reblocks-ui2/tables/table:column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AHEADER-COLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f8a3) `reblocks-ui2/tables/table:header-column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20GENERIC-FUNCTION-29"></a>

##### [generic-function] `reblocks-ui2/tables/table:table-widget` object

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20FUNCTION-29"></a>

##### [function](2837) `reblocks-ui2/tables/table:column` title &key (getter nil getter-given-p) (cell-maker nil cell-maker-p) (align :center) (classes nil clases-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-CELL-20FUNCTION-29"></a>

##### [function](532d) `reblocks-ui2/tables/table:current-cell`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-COLUMN-20FUNCTION-29"></a>

##### [function](91ef) `reblocks-ui2/tables/table:current-column`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-ROW-20FUNCTION-29"></a>

##### [function](b5e7) `reblocks-ui2/tables/table:current-row`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-TABLE-20FUNCTION-29"></a>

##### [function](45d4) `reblocks-ui2/tables/table:current-table`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AMAKE-TABLE-20FUNCTION-29"></a>

##### [function](8da0) `reblocks-ui2/tables/table:make-table` columns rows &key (table-class 'table-widget) (row-class nil row-class-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ARECALCULATE-CELLS-20FUNCTION-29"></a>

##### [function](2986) `reblocks-ui2/tables/table:recalculate-cells` row &key (update t)

Updates cell widgets using base object, stored in the `ROW`.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/API

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FAPI-22-29-20PACKAGE-29"></a>

#### [package](e9b4) `reblocks-ui2/themes/api`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FAPI-3ACURRENT-THEME-20FUNCTION-29"></a>

##### [function](d7bf) `reblocks-ui2/themes/api:current-theme`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FAPI-3ADEFTHEME-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](0d52) `reblocks-ui2/themes/api:deftheme` name bases &rest var-forms

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/BASE

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FBASE-22-29-20PACKAGE-29"></a>

#### [package](9268) `reblocks-ui2/themes/base`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-24BASE-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BASE-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FBASE-3ABASE-THEME-20CLASS-29"></a>

###### [class](a796) `reblocks-ui2/themes/base:base-theme` ()

A base theme class for all `Reblocks-UI2` themes.

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FBASE-3AOVERRIDED-VARS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FBASE-3ABASE-THEME-29-29"></a>

###### [reader](2851) `reblocks-ui2/themes/base:overrided-vars` (base-theme) (:overridden-vars = (make-hash-table :test 'equal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/COLOR

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FCOLOR-22-29-20PACKAGE-29"></a>

#### [package](cfbf) `reblocks-ui2/themes/color`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-24COLOR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLOR

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-20CLASS-29"></a>

###### [class](67d0) `reblocks-ui2/themes/color:color` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-DARK-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](99b1) `reblocks-ui2/themes/color:color-dark` (color) (:dark = nil)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-FOCUS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](bc47) `reblocks-ui2/themes/color:color-focus` (color) (:focus = nil)

If string, then it is a color of element in "focus" state. If integer, then it is intensity change relative to the base color. For light scheme intensity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-HOVER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](915e) `reblocks-ui2/themes/color:color-hover` (color) (:hover = nil)

If string, then it is a color of element in "hover" state. If integer, then it is intensity change relative to the base color. For light scheme intensity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-LIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](af04) `reblocks-ui2/themes/color:color-light` (color) (:light = nil)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-PROPERTY-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](d549) `reblocks-ui2/themes/color:color-property` (color) (:PROPERTY = (REQUIRED-ARGUMENT "property"))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3AADJUST-BASE-COLOR-20GENERIC-FUNCTION-29"></a>

##### [generic-function](be8f) `reblocks-ui2/themes/color:adjust-base-color` theme base-color adjustment

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3AADJUST-COLOR-20FUNCTION-29"></a>

##### [function](ae42) `reblocks-ui2/themes/color:adjust-color` theme color &key (light nil light-p) (dark nil dark-p) (hover nil hover-p) (focus nil focus-p)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-20FUNCTION-29"></a>

##### [function](3eb2) `reblocks-ui2/themes/color:color` property &key light dark hover focus

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/STYLING

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FSTYLING-22-29-20PACKAGE-29"></a>

#### [package](06b4) `reblocks-ui2/themes/styling`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3ACSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](043c) `reblocks-ui2/themes/styling:css-classes` object theme &key size invalid-state

Returns classes for a widget or it's property.

Result can be a list, string or a keyword.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3ACSS-STYLES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](a7d3) `reblocks-ui2/themes/styling:css-styles` object theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](2316) `reblocks-ui2/themes/styling:join-css-classes` theme &rest classes

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AMERGE-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](14d7) `reblocks-ui2/themes/styling:merge-css-classes` theme classes

This generic function is called before [`join-css-classes`][fb69] will output classes as a string.

Depending on theme some transformations can be applied to the list of `CSS` classes, given as `CLASSES` argument.
For example, a theme based on Tailwind framework, might merge `CSS` classes list allowing to override properties.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-STYLES-20FUNCTION-29"></a>

##### [function](384e) `reblocks-ui2/themes/styling:join-css-styles` &rest styles

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/TAILWIND

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FTAILWIND-22-29-20PACKAGE-29"></a>

#### [package](b936) `reblocks-ui2/themes/tailwind`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-24TAILWIND-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TAILWIND-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ATAILWIND-THEME-20CLASS-29"></a>

###### [class](c801) `reblocks-ui2/themes/tailwind:tailwind-theme` (base-theme)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACARD-BORDER-RADIUS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:card-border-radius` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-ACTION-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-bg-action` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-DANGER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-bg-danger` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-INFO-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-bg-info` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-bg-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-SUCCESS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-bg-success` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-UTILITY-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-bg-utility` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-WARNING-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-bg-warning` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-ACTION-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-border-action` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-DANGER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-border-danger` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-INFO-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-border-info` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-border-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-SUCCESS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-border-success` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-UTILITY-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-border-utility` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-WARNING-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-border-warning` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-LINE-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-line-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-TEXT-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:colors-text-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-MARGIN-SIZES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:core-margin-sizes` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-MODE-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1ce6) `reblocks-ui2/themes/tailwind:core-mode` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-PADDING-SIZES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:core-padding-sizes` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ATABS-ACTIVE-COLOR-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c801) `reblocks-ui2/themes/tailwind:tabs-active-color` theme

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](c801) `reblocks-ui2/themes/tailwind:make-tailwind-theme` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-DARK-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](1ce6) `reblocks-ui2/themes/tailwind:make-tailwind-theme-dark` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-LIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](1ddf) `reblocks-ui2/themes/tailwind:make-tailwind-theme-light` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/TAILWIND/ARBITRARY

<a id="x-28-23A-28-2838-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-22-29-20PACKAGE-29"></a>

#### [package](effe) `reblocks-ui2/themes/tailwind/arbitrary`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-24ARBITRARY-VALUE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ARBITRARY-VALUE

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-20CLASS-29"></a>

###### [class](67c2) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-ARGS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-29-29"></a>

###### [reader](b3a4) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value-args` (arbitrary-value) (:args)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-PREFIX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-29-29"></a>

###### [reader](9fa2) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value-prefix` (arbitrary-value) (:prefix)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-20FUNCTION-29"></a>

##### [function](c3c4) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value` prefix &rest args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/ALIGN

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FALIGN-22-29-20PACKAGE-29"></a>

#### [package](841b) `reblocks-ui2/utils/align`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-24HORIZONTAL-ALIGN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### HORIZONTAL-ALIGN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-20CLASS-29"></a>

###### [class](8f5c) `reblocks-ui2/utils/align:horizontal-align` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-29-29"></a>

###### [reader](9162) `reblocks-ui2/utils/align:horizontal-align-value` (horizontal-align) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-24VERTICAL-ALIGN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### VERTICAL-ALIGN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-20CLASS-29"></a>

###### [class](98a2) `reblocks-ui2/utils/align:vertical-align` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-29-29"></a>

###### [reader](4b87) `reblocks-ui2/utils/align:vertical-align-value` (vertical-align) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-20FUNCTION-29"></a>

##### [function](86ce) `reblocks-ui2/utils/align:horizontal-align` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-20FUNCTION-29"></a>

##### [function](88fa) `reblocks-ui2/utils/align:vertical-align` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-VALUE-20-28TYPE-29-29"></a>

##### [type](d076) `reblocks-ui2/utils/align:horizontal-align-value`

```
(MEMBER :LEFT :CENTER :TOP)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-VALUE-20-28TYPE-29-29"></a>

##### [type](7136) `reblocks-ui2/utils/align:vertical-align-value`

```
(MEMBER :TOP :CENTER :BOTTOM)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/MARGIN

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FMARGIN-22-29-20PACKAGE-29"></a>

#### [package](adce) `reblocks-ui2/utils/margin`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FMARGIN-24MARGIN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### MARGIN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-20CLASS-29"></a>

###### [class](741e) `reblocks-ui2/utils/margin:margin` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-BOTTOM-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](6e2a) `reblocks-ui2/utils/margin:margin-bottom` (margin) (:bottom = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-LEFT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](1a24) `reblocks-ui2/utils/margin:margin-left` (margin) (:left = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-RIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](e510) `reblocks-ui2/utils/margin:margin-right` (margin) (:right = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-TOP-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](ef6b) `reblocks-ui2/utils/margin:margin-top` (margin) (:top = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-20FUNCTION-29"></a>

##### [function](e272) `reblocks-ui2/utils/margin:margin` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/PADDING

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FPADDING-22-29-20PACKAGE-29"></a>

#### [package](8984) `reblocks-ui2/utils/padding`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPADDING-24PADDING-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### PADDING

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-20CLASS-29"></a>

###### [class](0f83) `reblocks-ui2/utils/padding:padding` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-HORIZONTAL-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-29-29"></a>

###### [reader](edc2) `reblocks-ui2/utils/padding:padding-horizontal-size` (padding) (:horizontal = :l)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-VERTICAL-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-29-29"></a>

###### [reader](7221) `reblocks-ui2/utils/padding:padding-vertical-size` (padding) (:vertical = :l)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-20FUNCTION-29"></a>

##### [function](d8ec) `reblocks-ui2/utils/padding:padding` size

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3ANULLABLE-PADDING-SIZE-20-28TYPE-29-29"></a>

##### [type](1c4b) `reblocks-ui2/utils/padding:nullable-padding-size`

```
(OR NULL PADDING-SIZE)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-SIZE-20-28TYPE-29-29"></a>

##### [type](a41d) `reblocks-ui2/utils/padding:padding-size`

```
(MEMBER :S :M :L :XL)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/PRIMITIVE-TO

<a id="x-28-23A-28-2831-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-22-29-20PACKAGE-29"></a>

#### [package](32a8) `reblocks-ui2/utils/primitive-to`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3APROCESS-PRIMITIVE-ARGS-20FUNCTION-29"></a>

##### [function](9e3e) `reblocks-ui2/utils/primitive-to:process-primitive-args` keyword-args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/SIZE

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FSIZE-22-29-20PACKAGE-29"></a>

#### [package](b867) `reblocks-ui2/utils/size`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24HEIGHT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### HEIGHT

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AHEIGHT-20CLASS-29"></a>

###### [class](7a0d) `reblocks-ui2/utils/size:height` (size)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24RESPONSIVE-HEIGHT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RESPONSIVE-HEIGHT

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-20CLASS-29"></a>

###### [class](e886) `reblocks-ui2/utils/size:responsive-height` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMAX-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-29-29"></a>

###### [reader](503f) `reblocks-ui2/utils/size:max-height` (responsive-height) (:max = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMIN-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-29-29"></a>

###### [reader](a21b) `reblocks-ui2/utils/size:min-height` (responsive-height) (:min = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24RESPONSIVE-WIDTH-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RESPONSIVE-WIDTH

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-20CLASS-29"></a>

###### [class](01ea) `reblocks-ui2/utils/size:responsive-width` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMAX-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-29-29"></a>

###### [reader](8827) `reblocks-ui2/utils/size:max-width` (responsive-width) (:max = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMIN-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-29-29"></a>

###### [reader](56c4) `reblocks-ui2/utils/size:min-width` (responsive-width) (:min = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24SIZE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SIZE

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-20CLASS-29"></a>

###### [class](4760) `reblocks-ui2/utils/size:size` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-29-29"></a>

###### [reader](1b90) `reblocks-ui2/utils/size:size-value` (size) (:value)

If integer, then it will be considered as "px".
If string, then will be used as is (meaning depends on current theme).

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24WIDTH-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### WIDTH

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AWIDTH-20CLASS-29"></a>

###### [class](a5ea) `reblocks-ui2/utils/size:width` (size)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AENSURE-HEIGHT-20FUNCTION-29"></a>

##### [function](bcca) `reblocks-ui2/utils/size:ensure-height` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AENSURE-WIDTH-20FUNCTION-29"></a>

##### [function](1556) `reblocks-ui2/utils/size:ensure-width` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AHEIGHT-20FUNCTION-29"></a>

##### [function](b597) `reblocks-ui2/utils/size:height` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-20FUNCTION-29"></a>

##### [function](d69e) `reblocks-ui2/utils/size:responsive-height` &key min max

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-20FUNCTION-29"></a>

##### [function](d484) `reblocks-ui2/utils/size:responsive-width` &key min max

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AWIDTH-20FUNCTION-29"></a>

##### [function](044c) `reblocks-ui2/utils/size:width` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASOME-HEIGHT-20-28TYPE-29-29"></a>

##### [type](a5b1) `reblocks-ui2/utils/size:some-height`

```
(OR HEIGHT RESPONSIVE-HEIGHT)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASOME-WIDTH-20-28TYPE-29-29"></a>

##### [type](76c0) `reblocks-ui2/utils/size:some-width`

```
(OR WIDTH RESPONSIVE-WIDTH)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FWALK-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/WALK

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FWALK-22-29-20PACKAGE-29"></a>

#### [package](e19d) `reblocks-ui2/utils/walk`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FWALK-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FUTILS-2FWALK-3ACHILDREN-20GENERIC-FUNCTION-29"></a>

##### [generic-function](d1f2) `reblocks-ui2/utils/walk:children` widget

<a id="x-28REBLOCKS-UI2-2FUTILS-2FWALK-3AWALK-20GENERIC-FUNCTION-29"></a>

##### [generic-function](9509) `reblocks-ui2/utils/walk:walk` widget visitor-func

A protocol to go through widgets tree and to call `VISITOR-FUNC` on each node.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/WIDGET

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FWIDGET-22-29-20PACKAGE-29"></a>

#### [package](cea1) `reblocks-ui2/widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-24UI-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### UI-WIDGET

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-20CLASS-29"></a>

###### [class](1822) `reblocks-ui2/widget:ui-widget` (widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AON-CLICK-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](66a3) `reblocks-ui2/widget:on-click` (ui-widget) (:on-click = nil)

When an on-click action is given, cursor style will be changed to "pointer".

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](75ae) `reblocks-ui2/widget:widget-height` (ui-widget) (:height = nil)

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-MARGIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](bdf8) `reblocks-ui2/widget:widget-margin` (ui-widget) (:margin = nil)

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](7d29) `reblocks-ui2/widget:widget-width` (ui-widget) (:width = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-DEPENDENCIES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](5d49) `reblocks-ui2/widget:get-dependencies` widget theme

Works like [`reblocks/dependencies:get-dependencies`][2397] generic-function, but
in context of current theme.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-HTML-TAG-20GENERIC-FUNCTION-29"></a>

##### [generic-function](0e0f) `reblocks-ui2/widget:get-html-tag` widget theme

Works like [`reblocks/widget:get-html-tag`][ab65] generic-function, but
in context of current theme.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AHTML-ATTRS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](03fd) `reblocks-ui2/widget:html-attrs` widget theme

May return a plist of attributes to add to the main widget's `HTML` node.

It should not return `:ID` `:CLASS` or `:ONCLICK` attributes.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3ARENDER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](2a93) `reblocks-ui2/widget:render` widget theme

Renders widget in given theme. All reblocks-ui2 widgets
should implement this method instead of a method
for [`reblocks/widget:render`][5607] generic-function.


[e41b]: https://40ants.com/reblocks-ui2/
[2397]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FDEPENDENCIES-3AGET-DEPENDENCIES-20GENERIC-FUNCTION-29
[5f3d]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FWIDGET-3ACREATE-WIDGET-FROM-20GENERIC-FUNCTION-29
[ab65]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FWIDGET-3AGET-HTML-TAG-20GENERIC-FUNCTION-29
[5607]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FWIDGET-3ARENDER-20GENERIC-FUNCTION-29
[2d52]: https://github.com/40ants/reblocks-ui2
[9201]: https://github.com/40ants/reblocks-ui2/actions
[60bf]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L1
[e85e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L51
[64ed]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L52
[9782]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L55
[6b55]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L58
[594f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L61
[d2ce]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L64
[a858]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L67
[12d4]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L70
[6517]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L74
[02e8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/button.lisp#L82
[3d6f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L1
[4347]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L21
[213f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L24
[99c7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L27
[0b2b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L30
[a96a]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L33
[7f73]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L36
[36a4]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L39
[6920]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L42
[b98b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L45
[16bf]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L48
[8581]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L51
[9f21]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L54
[30fe]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L57
[dca3]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L61
[6e3b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/buttons/view.lisp#L77
[0ed1]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/card.lisp#L1
[ee14]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/card.lisp#L51
[5d6c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/card.lisp#L52
[6811]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/card.lisp#L55
[05c7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/card.lisp#L58
[9c7a]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/card.lisp#L61
[06fe]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/card.lisp#L65
[72a7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/card.lisp#L71
[ab81]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/chart.lisp#L1
[782c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/chart.lisp#L21
[9486]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/chart.lisp#L22
[d7eb]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/chart.lisp#L27
[b53e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/chart.lisp#L35
[586f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/chart.lisp#L40
[d297]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/chart.lisp#L45
[d881]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/chart.lisp#L50
[9a94]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/column-chart.lisp#L1
[5244]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/column-chart.lisp#L18
[0835]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/column-chart.lisp#L19
[ddd9]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/column-chart.lisp#L24
[fdad]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/column-chart.lisp#L29
[a713]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/column-chart.lisp#L54
[fcc7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/pie-chart.lisp#L1
[61e8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/pie-chart.lisp#L19
[617d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/pie-chart.lisp#L20
[8b87]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/pie-chart.lisp#L27
[98f8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/pie-chart.lisp#L32
[caf2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/charts/pie-chart.lisp#L57
[a0b3]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/column.lisp#L1
[c9df]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/column.lisp#L23
[5494]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/column.lisp#L27
[8cb2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/container.lisp#L1
[0cd2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/container.lisp#L28
[88a1]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/container.lisp#L29
[e3b8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/container.lisp#L33
[2e0d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/container.lisp#L36
[1afb]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/container.lisp#L46
[931b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/container.lisp#L77
[339f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/controls-row.lisp#L1
[f4df]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/controls-row.lisp#L21
[e43d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/controls-row.lisp#L31
[de37]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/row.lisp#L1
[6ab6]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/row.lisp#L25
[aa8e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/row.lisp#L29
[d023]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/row.lisp#L35
[4cbc]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/stack.lisp#L1
[34ee]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/stack.lisp#L25
[7188]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/stack.lisp#L26
[8fa1]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/stack.lisp#L31
[ca88]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/stack.lisp#L45
[2204]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/stack.lisp#L53
[a06f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/stack.lisp#L59
[1851]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/stack.lisp#L66
[680b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/stack.lisp#L71
[6efc]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L1
[b033]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L39
[e4d8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L43
[e11b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L44
[77c3]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L46
[deed]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L49
[7c46]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L54
[b277]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L55
[2905]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L57
[9fc7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L63
[8161]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/containers/tabs.lisp#L93
[0a3c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/editable.lisp#L1
[10af]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/editable.lisp#L7
[3119]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/events.lisp#L1
[e5ce]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/events.lisp#L13
[20ba]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form.lisp#L1
[2216]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form.lisp#L109
[1ed8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form.lisp#L46
[1c2e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form.lisp#L47
[6a84]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form.lisp#L49
[4504]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form.lisp#L52
[a7c0]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/confirm.lisp#L1
[90a7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/confirm.lisp#L29
[096d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validation.lisp#L1
[ccfd]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validation.lisp#L16
[3a33]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validation.lisp#L29
[12db]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validation.lisp#L35
[b7b4]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validation.lisp#L40
[3120]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validation.lisp#L47
[ba93]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validators.lisp#L1
[d852]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validators.lisp#L105
[b3ae]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validators.lisp#L156
[5520]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validators.lisp#L200
[c6e5]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validators.lisp#L25
[13df]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validators.lisp#L55
[97be]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/form/validators.lisp#L81
[817d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/html.lisp#L1
[de62]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/html.lisp#L131
[8f94]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/html.lisp#L55
[0e7d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/icon.lisp#L1
[06e7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/icon.lisp#L13
[0a1d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/icon.lisp#L14
[7bbf]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/icon.lisp#L18
[751c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/base.lisp#L1
[ffbd]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/base.lisp#L42
[3e92]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/base.lisp#L43
[c5dc]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/base.lisp#L46
[56fb]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/base.lisp#L50
[1353]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/checkbox.lisp#L1
[d633]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/checkbox.lisp#L26
[fda0]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/checkbox.lisp#L27
[4c5d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/checkbox.lisp#L31
[e420]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/checkbox.lisp#L35
[3037]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/checkbox.lisp#L39
[6f52]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/checkbox.lisp#L46
[f0e7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/date-input.lisp#L1
[4b48]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/date-input.lisp#L27
[3a49]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/named.lisp#L1
[1d4e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/named.lisp#L13
[542e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/named.lisp#L14
[2749]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L1
[3ce7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L100
[0bf0]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L42
[7966]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L43
[a17c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L46
[a799]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L49
[9cbd]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L61
[76cf]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L70
[3b69]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L71
[290d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L74
[91e6]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L78
[b6e6]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L81
[e01b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L85
[983c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/select.lisp#L94
[d5f2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L1
[8ea8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L34
[e246]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L35
[9aad]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L39
[f3c6]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L43
[6070]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L47
[d84b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L50
[e552]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L54
[9e95]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L58
[a950]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L62
[24d1]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input.lisp#L68
[d89e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input/view.lisp#L1
[2c84]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input/view.lisp#L10
[7caf]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input/view.lisp#L13
[b4bd]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input/view.lisp#L16
[e577]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/text-input/view.lisp#L19
[23bb]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/textarea.lisp#L1
[070e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/textarea.lisp#L31
[76d7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/textarea.lisp#L32
[b1e7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/textarea.lisp#L36
[cc79]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/textarea.lisp#L40
[5404]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/textarea.lisp#L44
[8d53]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/textarea.lisp#L47
[1880]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/textarea.lisp#L51
[7459]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/inputs/textarea.lisp#L57
[42c9]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/modal.lisp#L1
[60fb]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/modal.lisp#L17
[fd9a]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/modal.lisp#L18
[0275]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/modal.lisp#L21
[811e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/modal.lisp#L24
[f878]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/modal.lisp#L31
[f4d0]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/modal.lisp#L39
[3e22]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/modal.lisp#L56
[c9eb]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/sizes.lisp#L1
[e44b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/sizes.lisp#L31
[db63]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/clickable-row.lisp#L1
[d83d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/clickable-row.lisp#L24
[4867]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/clickable-row.lisp#L28
[b9a3]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/editable-table.lisp#L1
[4009]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/editable-table.lisp#L100
[d9ff]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/editable-table.lisp#L109
[903b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/editable-table.lisp#L132
[2bf2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/editable-table.lisp#L205
[5863]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/editable-table.lisp#L209
[0bdb]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/editable-table.lisp#L70
[440a]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/editable-table.lisp#L71
[9e5a]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/editable-table.lisp#L90
[cd43]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/editable-table.lisp#L94
[2d90]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L1
[16b8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L165
[fa23]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L171
[33c2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L176
[374f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L35
[e671]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L36
[5c72]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L39
[83c9]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L42
[0c57]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L45
[5850]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L48
[398f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L53
[73fb]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L54
[4e58]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L56
[58b5]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L60
[e27c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/search.lisp#L71
[5e62]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L1
[b928]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L102
[8da0]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L150
[f8a3]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L175
[556d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L182
[2837]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L189
[45d4]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L227
[b5e7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L232
[91ef]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L237
[532d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L242
[2986]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L248
[58e9]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L256
[2edf]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L54
[be5f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L55
[a6c3]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L58
[4272]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L61
[a486]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L66
[6512]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L67
[86f2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L71
[1c88]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L75
[997c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L81
[e1d2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L82
[91e9]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L85
[7fc8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L91
[9ea2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L95
[a7c8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/tables/table.lisp#L98
[e9b4]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/api.lisp#L1
[0d52]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/api.lisp#L210
[d7bf]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/api.lisp#L34
[9268]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/base.lisp#L1
[a796]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/base.lisp#L8
[2851]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/base.lisp#L9
[cfbf]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/color.lisp#L1
[67d0]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/color.lisp#L16
[d549]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/color.lisp#L17
[af04]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/color.lisp#L21
[99b1]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/color.lisp#L25
[915e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/color.lisp#L29
[bc47]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/color.lisp#L34
[3eb2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/color.lisp#L51
[be8f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/color.lisp#L63
[ae42]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/color.lisp#L66
[06b4]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/styling.lisp#L1
[043c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/styling.lisp#L17
[a7d3]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/styling.lisp#L29
[14d7]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/styling.lisp#L34
[2316]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/styling.lisp#L66
[384e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/styling.lisp#L73
[b936]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/tailwind.lisp#L1
[1ddf]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/tailwind.lisp#L141
[1ce6]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/tailwind.lisp#L148
[c801]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/tailwind.lisp#L41
[effe]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/tailwind/arbitrary.lisp#L1
[67c2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/tailwind/arbitrary.lisp#L19
[9fa2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/tailwind/arbitrary.lisp#L20
[b3a4]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/tailwind/arbitrary.lisp#L23
[c3c4]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/themes/tailwind/arbitrary.lisp#L28
[841b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/align.lisp#L1
[d076]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/align.lisp#L10
[7136]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/align.lisp#L14
[8f5c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/align.lisp#L18
[9162]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/align.lisp#L19
[98a2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/align.lisp#L24
[4b87]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/align.lisp#L25
[86ce]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/align.lisp#L35
[88fa]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/align.lisp#L46
[adce]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/margin.lisp#L1
[741e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/margin.lisp#L25
[1a24]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/margin.lisp#L26
[e510]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/margin.lisp#L30
[ef6b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/margin.lisp#L34
[6e2a]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/margin.lisp#L38
[e272]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/margin.lisp#L50
[8984]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/padding.lisp#L1
[a41d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/padding.lisp#L11
[1c4b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/padding.lisp#L14
[0f83]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/padding.lisp#L18
[edc2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/padding.lisp#L19
[7221]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/padding.lisp#L23
[d8ec]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/padding.lisp#L40
[32a8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/primitive-to.lisp#L1
[9e3e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/primitive-to.lisp#L18
[b867]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L1
[bcca]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L112
[4760]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L22
[1b90]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L23
[a5ea]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L36
[7a0d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L40
[01ea]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L44
[56c4]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L45
[8827]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L49
[e886]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L55
[a21b]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L56
[503f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L60
[76c0]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L66
[a5b1]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L70
[044c]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L74
[d484]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L79
[b597]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L86
[d69e]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L91
[1556]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/size.lisp#L99
[e19d]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/walk.lisp#L1
[d1f2]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/walk.lisp#L17
[9509]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/utils/walk.lisp#L8
[cea1]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/widget.lisp#L1
[0e0f]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/widget.lisp#L106
[03fd]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/widget.lisp#L113
[1822]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/widget.lisp#L50
[66a3]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/widget.lisp#L51
[bdf8]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/widget.lisp#L55
[7d29]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/widget.lisp#L59
[75ae]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/widget.lisp#L63
[2a93]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/widget.lisp#L77
[5d49]: https://github.com/40ants/reblocks-ui2/blob/1de028402d251d3229da0d2813dc8c193c91cc05/src/widget.lisp#L99
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
[0851]: index.html#x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-20CLASS-29
[7f5f]: index.html#x-28REBLOCKS-UI2-2FCHARTS-2FCOLUMN-CHART-3ACOLUMN-CHART-20FUNCTION-29
[0484]: index.html#x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-20CLASS-29
[7254]: index.html#x-28REBLOCKS-UI2-2FCHARTS-2FPIE-CHART-3APIE-CHART-20FUNCTION-29
[3f91]: index.html#x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-20CONDITION-29
[e5e1]: index.html#x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20CONDITION-29
[f0d1]: index.html#x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20FUNCTION-29
[a897]: index.html#x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-DATE-20FUNCTION-29
[ce02]: index.html#x-28REBLOCKS-UI2-2FFORM-3AFORM-20FUNCTION-29
[c654]: index.html#x-28REBLOCKS-UI2-2FHTML-3AHTML-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29
[ef48]: index.html#x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-20FUNCTION-29
[382a]: index.html#x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HIDE-20GENERIC-FUNCTION-29
[f5ed]: index.html#x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-DELETER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29
[540e]: index.html#x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AMAKE-TABLE-20FUNCTION-29
[fb69]: index.html#x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-CLASSES-20GENERIC-FUNCTION-29

* * *
###### [generated by [40ANTS-DOC](https://40ants.com/doc/)]
