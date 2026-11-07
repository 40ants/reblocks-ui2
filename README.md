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

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40API-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## API

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/BUTTONS/BUTTON

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FBUTTONS-2FBUTTON-22-29-20PACKAGE-29"></a>

#### [package](f06f) `reblocks-ui2/buttons/button`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-24BUTTON-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BUTTON

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20CLASS-29"></a>

###### [class](beb1) `reblocks-ui2/buttons/button:button` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](1f75) `reblocks-ui2/buttons/button:button-class` (button) (:class)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](e681) `reblocks-ui2/buttons/button:button-content` (button) (:content)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](098e) `reblocks-ui2/buttons/button:button-disabled` (button) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](0e3d) `reblocks-ui2/buttons/button:button-pin` (button) (:pin)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](9f71) `reblocks-ui2/buttons/button:button-size` (button) (:size = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-STYLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](b38d) `reblocks-ui2/buttons/button:button-style` (button) (:style)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3A-3ABUTTON-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](a966) `reblocks-ui2/buttons/button::button-type` (button) (:type = nil)

If not given, then type will be "button" for a button having on-click callback or "submit" otherwise.

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](dc7c) `reblocks-ui2/buttons/button:button-view` (button) (:view = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](1f75) `reblocks-ui2/buttons/button:button-class` (button) (:class)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](e681) `reblocks-ui2/buttons/button:button-content` (button) (:content)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](098e) `reblocks-ui2/buttons/button:button-disabled` (button) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](0e3d) `reblocks-ui2/buttons/button:button-pin` (button) (:pin)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](9f71) `reblocks-ui2/buttons/button:button-size` (button) (:size = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-STYLE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](b38d) `reblocks-ui2/buttons/button:button-style` (button) (:style)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3A-3ABUTTON-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](a966) `reblocks-ui2/buttons/button::button-type` (button) (:type = nil)

If not given, then type will be "button" for a button having on-click callback or "submit" otherwise.

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [accessor](dc7c) `reblocks-ui2/buttons/button:button-view` (button) (:view = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20FUNCTION-29"></a>

##### [function](bcb6) `reblocks-ui2/buttons/button:button` CONTENT &KEY NAME VALUE TYPE (WIDGET-CLASS 'BUTTON) ON-CLICK (CLASS "button") DISABLED STYLE (VIEW :NORMAL) (SIZE :L) (PIN :ROUND) (WIDTH :MIN) HEIGHT

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/BUTTONS/VIEW

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FBUTTONS-2FVIEW-22-29-20PACKAGE-29"></a>

#### [package](faa8) `reblocks-ui2/buttons/view`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24ACTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ACTION

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AACTION-20CLASS-29"></a>

###### [class](5990) `reblocks-ui2/buttons/view:action` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24BUTTON-VIEW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BUTTON-VIEW

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ABUTTON-VIEW-20CLASS-29"></a>

###### [class](3c27) `reblocks-ui2/buttons/view:button-view` ()

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24NORMAL-DISABLED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL-DISABLED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ANORMAL-DISABLED-20CLASS-29"></a>

###### [class](d85e) `reblocks-ui2/buttons/view:normal-disabled` (normal)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24NORMAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ANORMAL-20CLASS-29"></a>

###### [class](b7a2) `reblocks-ui2/buttons/view:normal` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-ACTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-ACTION

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-ACTION-20CLASS-29"></a>

###### [class](72ad) `reblocks-ui2/buttons/view:outlined-action` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-DANGER-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-DANGER

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-DANGER-20CLASS-29"></a>

###### [class](c3d0) `reblocks-ui2/buttons/view:outlined-danger` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-INFO-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-INFO

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-INFO-20CLASS-29"></a>

###### [class](e9f9) `reblocks-ui2/buttons/view:outlined-info` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-SUCCESS-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-SUCCESS

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-SUCCESS-20CLASS-29"></a>

###### [class](168d) `reblocks-ui2/buttons/view:outlined-success` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-UTILITY-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-UTILITY

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-UTILITY-20CLASS-29"></a>

###### [class](b04d) `reblocks-ui2/buttons/view:outlined-utility` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-WARNING-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED-WARNING

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-WARNING-20CLASS-29"></a>

###### [class](70ae) `reblocks-ui2/buttons/view:outlined-warning` (outlined)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24OUTLINED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OUTLINED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AOUTLINED-20CLASS-29"></a>

###### [class](5190) `reblocks-ui2/buttons/view:outlined` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24RAISED-DISABLED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RAISED-DISABLED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ARAISED-DISABLED-20CLASS-29"></a>

###### [class](44a6) `reblocks-ui2/buttons/view:raised-disabled` (raised)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-24RAISED-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RAISED

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3ARAISED-20CLASS-29"></a>

###### [class](fbb6) `reblocks-ui2/buttons/view:raised` (button-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AGET-DISABLED-BUTTON-VIEW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f800) `reblocks-ui2/buttons/view:get-disabled-button-view` view

Returns an alternative view for a button in disabled state.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FVIEW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FVIEW-3AENSURE-VIEW-20FUNCTION-29"></a>

##### [function](51a9) `reblocks-ui2/buttons/view:ensure-view` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCARD-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CARD

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCARD-22-29-20PACKAGE-29"></a>

#### [package](2bb3) `reblocks-ui2/card`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCARD-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCARD-24CARD-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CARD-WIDGET

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-20CLASS-29"></a>

###### [class](899c) `reblocks-ui2/card:card-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](8ac4) `reblocks-ui2/card:card-content` (card-widget) (:content)

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-PADDING-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](0e09) `reblocks-ui2/card:card-padding` (card-widget) (:padding = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](dc0b) `reblocks-ui2/card:card-view` (card-widget) (:view = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3AHORIZONTAL-ALIGN-OF-CARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](952d) `reblocks-ui2/card:horizontal-align-of-card-content` (card-widget) (:horizontal-align = nil)

<a id="x-28REBLOCKS-UI2-2FCARD-3AVERTICAL-ALIGN-OF-CARD-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCARD-3ACARD-WIDGET-29-29"></a>

###### [reader](c83f) `reblocks-ui2/card:vertical-align-of-card-content` (card-widget) (:vertical-align = :center)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCARD-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCARD-3ACARD-20FUNCTION-29"></a>

##### [function](c14c) `reblocks-ui2/card:card` CONTENT &KEY (VIEW :OUTLINED) (WIDTH "full") (HEIGHT '(120)) (PADDING :L) (MARGIN '(NIL NIL)) (HORIZONTAL-ALIGN :CENTER) (VERTICAL-ALIGN :CENTER) ON-CLICK (WIDGET-CLASS 'CARD-WIDGET)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/COLUMN

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-22-29-20PACKAGE-29"></a>

#### [package](1443) `reblocks-ui2/containers/column`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-24COLUMN-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3ACOLUMN-WIDGET-20CLASS-29"></a>

###### [class](7ebf) `reblocks-ui2/containers/column:column-widget` (container-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCOLUMN-3ACOLUMN-20FUNCTION-29"></a>

##### [function](cf53) `reblocks-ui2/containers/column:column` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/CONTAINER

<a id="x-28-23A-28-2833-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-22-29-20PACKAGE-29"></a>

#### [package](4a30) `reblocks-ui2/containers/container`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-24CONTAINER-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTAINER-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-20CLASS-29"></a>

###### [class](60e2) `reblocks-ui2/containers/container:container-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AADDITIONAL-CLASSES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](7fd8) `reblocks-ui2/containers/container:additional-classes` (container-widget) (:css-classes = nil)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACHILDREN-GAP-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](126a) `reblocks-ui2/containers/container:children-gap` (container-widget) (:gap = \*default-gap\*)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [reader](9b46) `reblocks-ui2/containers/container:subwidgets` (container-widget) (:subwidgets = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3ACONTAINER-WIDGET-29-29"></a>

###### [accessor](9b46) `reblocks-ui2/containers/container:subwidgets` (container-widget) (:subwidgets = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AGAP-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f73a) `reblocks-ui2/containers/container:gap-css-classes` gap theme

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTAINER-3AMAKE-CONTAINER-20FUNCTION-29"></a>

##### [function](c057) `reblocks-ui2/containers/container:make-container` default-widget-class &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/CONTROLS-ROW

<a id="x-28-23A-28-2836-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-22-29-20PACKAGE-29"></a>

#### [package](a82c) `reblocks-ui2/containers/controls-row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-24CONTROLS-ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTROLS-ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3ACONTROLS-ROW-WIDGET-20CLASS-29"></a>

###### [class](4275) `reblocks-ui2/containers/controls-row:controls-row-widget` (row-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FCONTROLS-ROW-3ACONTROLS-ROW-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](61f7) `reblocks-ui2/containers/controls-row:controls-row` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/ROW

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FROW-22-29-20PACKAGE-29"></a>

#### [package](19e8) `reblocks-ui2/containers/row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FROW-24ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AROW-WIDGET-20CLASS-29"></a>

###### [class](73b7) `reblocks-ui2/containers/row:row-widget` (container-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FROW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AMAKE-ROW-WIDGET-20FUNCTION-29"></a>

##### [function](dbcd) `reblocks-ui2/containers/row:make-row-widget` subwidgets &key (gap \*default-gap\*) on-click

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FROW-3AROW-20FUNCTION-29"></a>

##### [function](22d2) `reblocks-ui2/containers/row:row` &rest subwidgets-and-options

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/STACK

<a id="x-28-23A-28-2829-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FSTACK-22-29-20PACKAGE-29"></a>

#### [package](c03c) `reblocks-ui2/containers/stack`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-24STACK-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### STACK-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-20CLASS-29"></a>

###### [class](b3db) `reblocks-ui2/containers/stack:stack-widget` (ui-widget)

Shows only the top child from the stack. Provides methods to push and pop widgets.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-CHILDREN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-WIDGET-29-29"></a>

###### [reader](03b6) `reblocks-ui2/containers/stack:stack-widget-children` (stack-widget) (:children)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APOP-CHILD-20GENERIC-FUNCTION-29"></a>

##### [generic-function](9d1a) `reblocks-ui2/containers/stack:pop-child` stack-widget

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APUSH-CHILD-20GENERIC-FUNCTION-29"></a>

##### [generic-function](53fa) `reblocks-ui2/containers/stack:push-child` stack-widget child

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ACURRENT-STACK-WIDGET-20FUNCTION-29"></a>

##### [function](3038) `reblocks-ui2/containers/stack:current-stack-widget`

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3APOP-ME-20FUNCTION-29"></a>

##### [function](72db) `reblocks-ui2/containers/stack:pop-me`

Removes current (top) widget from the stack and display the next widget.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3AREPLACE-ME-WITH-20FUNCTION-29"></a>

##### [function](22e5) `reblocks-ui2/containers/stack:replace-me-with` widget

Adds a new widget ontop of the current.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FSTACK-3ASTACK-20FUNCTION-29"></a>

##### [function](8ddc) `reblocks-ui2/containers/stack:stack` &rest children

Makes a stack widget with given subwidgets.

Only first widget in the list will be visible.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/TABS

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FTABS-22-29-20PACKAGE-29"></a>

#### [package](fa86) `reblocks-ui2/containers/tabs`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-24TABS-CONTROL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABS-CONTROL

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-20CLASS-29"></a>

###### [class](78ad) `reblocks-ui2/containers/tabs:tabs-control` (event-emitter ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ACURRENT-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](9416) `reblocks-ui2/containers/tabs:current-idx` (tabs-control) (:idx = 0)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASUBWIDGETS-TITLES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](1e83) `reblocks-ui2/containers/tabs:subwidgets-titles` (tabs-control) (:titles)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [reader](8f2a) `reblocks-ui2/containers/tabs:tabs-size` (tabs-control) (:size)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ACURRENT-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-CONTROL-29-29"></a>

###### [accessor](9416) `reblocks-ui2/containers/tabs:current-idx` (tabs-control) (:idx = 0)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-24TABS-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABS-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-20CLASS-29"></a>

###### [class](ef95) `reblocks-ui2/containers/tabs:tabs-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASUBWIDGETS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-29-29"></a>

###### [reader](9fd7) `reblocks-ui2/containers/tabs:subwidgets` (tabs-widget) (:subwidgets)

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SELECTOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-WIDGET-29-29"></a>

###### [reader](bce7) `reblocks-ui2/containers/tabs:tabs-selector` (tabs-widget) (:selector)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ASWITCH-TO-IDX-20FUNCTION-29"></a>

##### [function](6c03) `reblocks-ui2/containers/tabs:switch-to-idx` &key widget-id idx &allow-other-keys

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-20FUNCTION-29"></a>

##### [function](2b51) `reblocks-ui2/containers/tabs:tabs` titles subwidgets &key (idx 0) (selector-class 'tabs-control) (class 'tabs-widget) (size :l)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FTABS-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FTABS-3ATABS-SIZE-20-28TYPE-29-29"></a>

##### [type](51da) `reblocks-ui2/containers/tabs:tabs-size`

```
(MEMBER :M :L :XL)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEDITABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/EDITABLE

<a id="x-28-23A-28-2821-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FEDITABLE-22-29-20PACKAGE-29"></a>

#### [package](3d91) `reblocks-ui2/editable`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FEDITABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FEDITABLE-3AMAKE-EDITABLE-WIDGET-20GENERIC-FUNCTION-29"></a>

##### [generic-function](9f1e) `reblocks-ui2/editable:make-editable-widget` value callback

Creates a widget which can be used to edit a given value.
Every time when the widget loose focus, it will call `CALLBACK` argument with a new value.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEVENTS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/EVENTS

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FEVENTS-22-29-20PACKAGE-29"></a>

#### [package](cdee) `reblocks-ui2/events`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FEVENTS-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FEVENTS-24EVENT-EMITTING-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EVENT-EMITTING-WIDGET

<a id="x-28REBLOCKS-UI2-2FEVENTS-3AEVENT-EMITTING-WIDGET-20CLASS-29"></a>

###### [class](1d09) `reblocks-ui2/events:event-emitting-widget` (event-emitter ui-widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-22-29-20PACKAGE-29"></a>

#### [package](25e3) `reblocks-ui2/form`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-24FORM-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FORM-WIDGET

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-20CLASS-29"></a>

###### [class](6b19) `reblocks-ui2/form:form-widget` (event-emitting-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](1754) `reblocks-ui2/form:form-content` (form-widget) (:content)

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-INPUTS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](2f1d) `reblocks-ui2/form:form-inputs` (form-widget) (= (make-hash-table :test 'equal))

Internal structure holding references to all form inputs having a name attribute.

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-ON-SUBMIT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-3AFORM-WIDGET-29-29"></a>

###### [reader](eb67) `reblocks-ui2/form:form-on-submit` (form-widget) (:on-submit = 'no-action)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-3AFORM-20FUNCTION-29"></a>

##### [function](469f) `reblocks-ui2/form:form` content &key (widget-class 'form-widget) on-submit

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM/VALIDATION

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-2FVALIDATION-22-29-20PACKAGE-29"></a>

#### [package](61b1) `reblocks-ui2/form/validation`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24FIELD-VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FIELD-VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](4639) `reblocks-ui2/form/validation:field-validation-error` (validation-error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-29-29"></a>

###### [reader](4639) `reblocks-ui2/form/validation:field-name` (field-validation-error) (:field-name)

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AINVALID-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-29-29"></a>

###### [reader](4639) `reblocks-ui2/form/validation:invalid-value` (field-validation-error) (:invalid-value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24FORM-VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### FORM-VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFORM-VALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](a807) `reblocks-ui2/form/validation:form-validation-error` (validation-error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3ANUM-ERRORS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFORM-VALIDATION-ERROR-29-29"></a>

###### [reader](a807) `reblocks-ui2/form/validation:num-errors` (form-validation-error) (:num-errors)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATION-24VALIDATION-ERROR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### VALIDATION-ERROR

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20CONDITION-29"></a>

###### [condition](221d) `reblocks-ui2/form/validation:validation-error` (error)

**Readers**

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AERROR-ARGS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-29-29"></a>

###### [reader](221d) `reblocks-ui2/form/validation:error-args` (validation-error) (:error-args = 'nil)

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AERROR-MESSAGE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-29-29"></a>

###### [reader](221d) `reblocks-ui2/form/validation:error-message` (validation-error) (:error-message = '"")

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATE-FORM-DATA-20GENERIC-FUNCTION-29"></a>

##### [generic-function](3e6d) `reblocks-ui2/form/validation:validate-form-data` widget form-data

Accepts a form or input widget and a plist of all data sent from the browser.

Should return a plist of validated data. Also, it might change the state of the widgets,
for example, to set an error message saying that entered value is invalid. In the case
when data is invalid, function should signal `validation-error` ([`1`][f0d1] [`2`][e5e1]).

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATION-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20FUNCTION-29"></a>

##### [function](0097) `reblocks-ui2/form/validation:validation-error` message &rest args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FFORM-2FVALIDATORS-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/FORM/VALIDATORS

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FFORM-2FVALIDATORS-22-29-20PACKAGE-29"></a>

#### [package](ce9d) `reblocks-ui2/form/validators`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FFORM-2FVALIDATORS-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AALL-20FUNCTION-29"></a>

##### [function](04e9) `reblocks-ui2/form/validators:all` &rest validators

Combines a multiple validators into a chain where every subsequent validator validates output of the previous one.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AFORMAT-DATE-20FUNCTION-29"></a>

##### [function](47bc) `reblocks-ui2/form/validators:format-date` timestamp &key (format :iso)

Formats `TIMESTAMP` as a date string.

Supported formats are the same as for [`valid-date`][a897]:

* `:ISO` (default) returns "`YYYY-MM-DD`" strings.
* `:DDMMYYYY` returns "`DD`.`MM`.`YYYY`" strings.

A `NIL` `TIMESTAMP` is formatted as an empty string, so that the result
can be used as an input widget's value.

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-DATE-20FUNCTION-29"></a>

##### [function](4abc) `reblocks-ui2/form/validators:valid-date` &key (format :iso) (required t)

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

##### [function](b79e) `reblocks-ui2/form/validators:valid-integer` &key min max

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-PASSWORD-20FUNCTION-29"></a>

##### [function](d780) `reblocks-ui2/form/validators:valid-password` &key (min-length 10) max-length required-symbols error

<a id="x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-STRING-20FUNCTION-29"></a>

##### [function](a3b8) `reblocks-ui2/form/validators:valid-string` &key (min-length 1) max-length

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FHTML-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/HTML

<a id="x-28-23A-28-2817-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FHTML-22-29-20PACKAGE-29"></a>

#### [package](34df) `reblocks-ui2/html`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FHTML-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FHTML-3APROP-20FUNCTION-29"></a>

##### [function](1bb7) `reblocks-ui2/html:prop` name &optional default

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FHTML-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FHTML-3AHTML-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](25d0) `reblocks-ui2/html:html` (&body body) &key css (html-tag :div) css-classes on-click props width height margin

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

#### [package](1149) `reblocks-ui2/icon`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FICON-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FICON-24ICON-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ICON-WIDGET

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-WIDGET-20CLASS-29"></a>

###### [class](7514) `reblocks-ui2/icon:icon-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FICON-3AICON-WIDGET-29-29"></a>

###### [reader](eb81) `reblocks-ui2/icon:icon-name` (icon-widget) (:name)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FICON-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FICON-3AICON-20FUNCTION-29"></a>

##### [function](12eb) `reblocks-ui2/icon:icon` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FBASE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/BASE

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FBASE-22-29-20PACKAGE-29"></a>

#### [package](b9b7) `reblocks-ui2/inputs/base`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FBASE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FBASE-24BASE-INPUT-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BASE-INPUT-WIDGET

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-20CLASS-29"></a>

###### [class](4352) `reblocks-ui2/inputs/base:base-input-widget` (named-input)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-ERROR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](5efb) `reblocks-ui2/inputs/base:input-error` (base-input-widget) (:error = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-VALIDATOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](2ed3) `reblocks-ui2/inputs/base:input-validator` (base-input-widget) (:validator = nil)

A function of one argument returning a validated value or signaling the [`field-validation-error`][3f91].

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FBASE-3AINPUT-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FBASE-3ABASE-INPUT-WIDGET-29-29"></a>

###### [reader](22aa) `reblocks-ui2/inputs/base:input-value` (base-input-widget) (:value = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FNAMED-24NAMED-INPUT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NAMED-INPUT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-20CLASS-29"></a>

###### [class](9676) `reblocks-ui2/inputs/named:named-input` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3AINPUT-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-29-29"></a>

###### [reader](ac4f) `reblocks-ui2/inputs/named:input-name` (named-input) (:name = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/CHECKBOX

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-22-29-20PACKAGE-29"></a>

#### [package](3549) `reblocks-ui2/inputs/checkbox`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-24CHECKBOX-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CHECKBOX

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-20CLASS-29"></a>

###### [class](2303) `reblocks-ui2/inputs/checkbox:checkbox` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-CHECKED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](cd27) `reblocks-ui2/inputs/checkbox:checkbox-checked` (checkbox) (:checked = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](231b) `reblocks-ui2/inputs/checkbox:checkbox-disabled` (checkbox) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](bce9) `reblocks-ui2/inputs/checkbox:checkbox-size` (checkbox) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-29-29"></a>

###### [reader](3e21) `reblocks-ui2/inputs/checkbox:checkbox-view` (checkbox) (:view = (make-instance 'normal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FCHECKBOX-3ACHECKBOX-20FUNCTION-29"></a>

##### [function](cde4) `reblocks-ui2/inputs/checkbox:checkbox` &key (widget-class 'checkbox) name value (view :normal) (size :m) disabled checked error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/DATE-INPUT

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-22-29-20PACKAGE-29"></a>

#### [package](15bf) `reblocks-ui2/inputs/date-input`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FDATE-INPUT-3ADATE-INPUT-20FUNCTION-29"></a>

##### [function](5443) `reblocks-ui2/inputs/date-input:date-input` &key (widget-class 'input-widget) name value (format :iso) (required t) placeholder (view :normal) (size :m) disabled error

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

#### [package](a554) `reblocks-ui2/inputs/named`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FNAMED-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FNAMED-24NAMED-INPUT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NAMED-INPUT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-20CLASS-29"></a>

###### [class](9676) `reblocks-ui2/inputs/named:named-input` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FNAMED-3AINPUT-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FNAMED-3ANAMED-INPUT-29-29"></a>

###### [reader](ac4f) `reblocks-ui2/inputs/named:input-name` (named-input) (:name = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/SELECT

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FSELECT-22-29-20PACKAGE-29"></a>

#### [package](fdcc) `reblocks-ui2/inputs/select`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-24OPTION-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### OPTION

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-20CLASS-29"></a>

###### [class](59d6) `reblocks-ui2/inputs/select:option` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-NAME-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](102f) `reblocks-ui2/inputs/select:option-name` (option) (:name)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-SELECTED-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](f849) `reblocks-ui2/inputs/select:option-selected-p` (option) (:selected = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-29-29"></a>

###### [reader](d590) `reblocks-ui2/inputs/select:option-value` (option) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FSELECT-24SELECT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SELECT

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-20CLASS-29"></a>

###### [class](afba) `reblocks-ui2/inputs/select:select` (event-emitter base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](9ca3) `reblocks-ui2/inputs/select:select-disabled` (select) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](a991) `reblocks-ui2/inputs/select:select-options` (select) (:options)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](555c) `reblocks-ui2/inputs/select:select-pin` (select) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](789c) `reblocks-ui2/inputs/select:select-size` (select) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [reader](e3c5) `reblocks-ui2/inputs/select:select-view` (select) (:view = (make-instance 'normal))

**Accessors**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-OPTIONS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-29-29"></a>

###### [accessor](a991) `reblocks-ui2/inputs/select:select-options` (select) (:options)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FSELECT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AENSURE-OPTION-20FUNCTION-29"></a>

##### [function](b327) `reblocks-ui2/inputs/select:ensure-option` value

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3AOPTION-20FUNCTION-29"></a>

##### [function](6844) `reblocks-ui2/inputs/select:option` name &key value selected

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FSELECT-3ASELECT-20FUNCTION-29"></a>

##### [function](c537) `reblocks-ui2/inputs/select:select` options &key (widget-class 'select) name (view :normal) (pin :round) (size :m) disabled validator error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXT-INPUT

<a id="x-28-23A-28-2830-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-22-29-20PACKAGE-29"></a>

#### [package](59b3) `reblocks-ui2/inputs/text-input`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-24INPUT-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### INPUT-WIDGET

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-20CLASS-29"></a>

###### [class](edaa) `reblocks-ui2/inputs/text-input:input-widget` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](b3cf) `reblocks-ui2/inputs/text-input:input-disabled` (input-widget) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-LEFT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](e3cf) `reblocks-ui2/inputs/text-input:input-left-content` (input-widget) (:left-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](b005) `reblocks-ui2/inputs/text-input:input-pin` (input-widget) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-PLACEHOLDER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](d4a3) `reblocks-ui2/inputs/text-input:input-placeholder` (input-widget) (:placeholder = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-RIGHT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](b0c3) `reblocks-ui2/inputs/text-input:input-right-content` (input-widget) (:right-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](a679) `reblocks-ui2/inputs/text-input:input-size` (input-widget) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](9291) `reblocks-ui2/inputs/text-input:input-type` (input-widget) (:type = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [reader](0457) `reblocks-ui2/inputs/text-input:input-view` (input-widget) (:view = (make-instance 'normal))

**Accessors**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-LEFT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [accessor](e3cf) `reblocks-ui2/inputs/text-input:input-left-content` (input-widget) (:left-content = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-RIGHT-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-WIDGET-29-29"></a>

###### [accessor](b0c3) `reblocks-ui2/inputs/text-input:input-right-content` (input-widget) (:right-content = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-20FUNCTION-29"></a>

##### [function](ec3d) `reblocks-ui2/inputs/text-input:input` &key (widget-class 'input-widget) name value (type :text) placeholder (view :normal) (pin :round) (size :m) disabled validator error left-content right-content

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXT-INPUT/VIEW

<a id="x-28-23A-28-2835-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-22-29-20PACKAGE-29"></a>

#### [package](3031) `reblocks-ui2/inputs/text-input/view`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24CLEAR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CLEAR

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3ACLEAR-20CLASS-29"></a>

###### [class](1278) `reblocks-ui2/inputs/text-input/view:clear` (input-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24INPUT-VIEW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### INPUT-VIEW

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3AINPUT-VIEW-20CLASS-29"></a>

###### [class](2733) `reblocks-ui2/inputs/text-input/view:input-view` ()

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-24NORMAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### NORMAL

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3ANORMAL-20CLASS-29"></a>

###### [class](0f3b) `reblocks-ui2/inputs/text-input/view:normal` (input-view)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-2FVIEW-3AENSURE-VIEW-20FUNCTION-29"></a>

##### [function](8df6) `reblocks-ui2/inputs/text-input/view:ensure-view` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/INPUTS/TEXTAREA

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-22-29-20PACKAGE-29"></a>

#### [package](e500) `reblocks-ui2/inputs/textarea`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-24TEXTAREA-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TEXTAREA

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-20CLASS-29"></a>

###### [class](5939) `reblocks-ui2/inputs/textarea:textarea` (base-input-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](dcf7) `reblocks-ui2/inputs/textarea:textarea-disabled` (textarea) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-PIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](020b) `reblocks-ui2/inputs/textarea:textarea-pin` (textarea) (:pin)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-PLACEHOLDER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](bd4a) `reblocks-ui2/inputs/textarea:textarea-placeholder` (textarea) (:placeholder = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](2757) `reblocks-ui2/inputs/textarea:textarea-size` (textarea) (:size = :m)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-TYPE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](6f34) `reblocks-ui2/inputs/textarea:textarea-type` (textarea) (:type = nil)

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-VIEW-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-29-29"></a>

###### [reader](ee90) `reblocks-ui2/inputs/textarea:textarea-view` (textarea) (:view = (make-instance 'normal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FINPUTS-2FTEXTAREA-3ATEXTAREA-20FUNCTION-29"></a>

##### [function](5469) `reblocks-ui2/inputs/textarea:textarea` &key (widget-class 'textarea) name value (type :text) placeholder (view :normal) (pin :round) (size :m) disabled validator error

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FMODAL-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/MODAL

<a id="x-28-23A-28-2818-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FMODAL-22-29-20PACKAGE-29"></a>

#### [package](58a2) `reblocks-ui2/modal`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FMODAL-24MODAL-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### MODAL

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-20CLASS-29"></a>

###### [class](5f01) `reblocks-ui2/modal:modal` (ui-widget)

This widget shows a popup window.

**Readers**

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HEADER-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](dc1e) `reblocks-ui2/modal:modal-header-content` (modal) (:header-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-MAIN-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](17e0) `reblocks-ui2/modal:modal-main-content` (modal) (:main-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-VISIBLE-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [reader](f3e4) `reblocks-ui2/modal:modal-visible-p` (modal) (:visible = nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HEADER-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [accessor](dc1e) `reblocks-ui2/modal:modal-header-content` (modal) (:header-content)

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-MAIN-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FMODAL-3AMODAL-29-29"></a>

###### [accessor](17e0) `reblocks-ui2/modal:modal-main-content` (modal) (:main-content)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-HIDE-20GENERIC-FUNCTION-29"></a>

##### [generic-function](9e8d) `reblocks-ui2/modal:modal-hide` widget

Hides modal window.

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-SHOW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c2f4) `reblocks-ui2/modal:modal-show` widget &key content header-content

Shows modal window.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FMODAL-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FMODAL-3AMODAL-20FUNCTION-29"></a>

##### [function](89bf) `reblocks-ui2/modal:modal` content &key header-content visible

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FSIZES-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/SIZES

<a id="x-28-23A-28-2818-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FSIZES-22-29-20PACKAGE-29"></a>

#### [package](67e9) `reblocks-ui2/sizes`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FSIZES-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FSIZES-3AENSURE-SIZE-20FUNCTION-29"></a>

##### [function](a6c0) `reblocks-ui2/sizes:ensure-size` name

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/CLICKABLE-ROW

<a id="x-28-23A-28-2833-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-22-29-20PACKAGE-29"></a>

#### [package](5391) `reblocks-ui2/tables/clickable-row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-24CLICKABLE-ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CLICKABLE-ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3ACLICKABLE-ROW-WIDGET-20CLASS-29"></a>

###### [class](b711) `reblocks-ui2/tables/clickable-row:clickable-row-widget` (table-row)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3AMAKE-CLICKABLE-ROW-WIDGET-20FUNCTION-29"></a>

##### [function](cf28) `reblocks-ui2/tables/clickable-row:make-clickable-row-widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/EDITABLE-TABLE

<a id="x-28-23A-28-2834-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-22-29-20PACKAGE-29"></a>

#### [package](0936) `reblocks-ui2/tables/editable-table`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24EDITABLE-COLUMN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EDITABLE-COLUMN

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-20CLASS-29"></a>

###### [class](4a78) `reblocks-ui2/tables/editable-table:editable-column` (column)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3ADATA-SETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-29-29"></a>

###### [reader](043f) `reblocks-ui2/tables/editable-table:data-setter` (editable-column) (:setter = #'default-setter)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24EDITABLE-TABLE-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### EDITABLE-TABLE-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-20CLASS-29"></a>

###### [class](771f) `reblocks-ui2/tables/editable-table:editable-table-widget` (table-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-CREATOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29"></a>

###### [reader](1488) `reblocks-ui2/tables/editable-table:object-creator` (editable-table-widget) (:object-creator = nil)

When given, should be a function of zero arguments.
Will be called when user adds a new table row.
Usually you will want to do create and add an object to a database.
Returned object will be bound to a new table row and used to fill cells with new values.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-DELETER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29"></a>

###### [reader](a652) `reblocks-ui2/tables/editable-table:object-deleter` (editable-table-widget) (:object-deleter = nil)

When given, should be a function of one argument.
Will be called with object instance to be deleted from the table.
Usually you will want to do something like deletion the record from a database.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-24ROW-NOT-FOUND-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ROW-NOT-FOUND

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AROW-NOT-FOUND-20CONDITION-29"></a>

###### [condition](b531) `reblocks-ui2/tables/editable-table:row-not-found` (error)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3ADELETE-ROW-20GENERIC-FUNCTION-29"></a>

##### [generic-function](f831) `reblocks-ui2/tables/editable-table:delete-row` table obj

Deletes row representing given object.
First it calls [`object-deleter`][f5ed] callback and then
removes corresponding row from the table.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-COLUMN-20FUNCTION-29"></a>

##### [function](d25a) `reblocks-ui2/tables/editable-table:editable-column` title &key (getter nil getter-given-p) (setter #'default-setter) (cell-maker #'create-widget-from) (align :left)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AMAKE-EDITABLE-TABLE-20FUNCTION-29"></a>

##### [function](9152) `reblocks-ui2/tables/editable-table:make-editable-table` columns rows &key (table-class 'editable-table-widget) (row-class nil row-class-given-p) (object-deleter nil object-deleter-given-p) (object-creator nil object-creator-given-p)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/SEARCH

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FSEARCH-22-29-20PACKAGE-29"></a>

#### [package](6622) `reblocks-ui2/tables/search`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-24CONTROLS-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CONTROLS-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-20CLASS-29"></a>

###### [class](ba14) `reblocks-ui2/tables/search:controls-widget` (event-emitting-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-BUTTON-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-29-29"></a>

###### [reader](e511) `reblocks-ui2/tables/search::next-page-button` (controls-widget) (:button)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ASHOW-BUTTON-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-29-29"></a>

###### [reader](de41) `reblocks-ui2/tables/search::show-button-p` (controls-widget) (= nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FSEARCH-24SEARCH-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SEARCH-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-20CLASS-29"></a>

###### [class](a1cb) `reblocks-ui2/tables/search:search-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ACONTROLS-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](9070) `reblocks-ui2/tables/search:controls-widget` (search-widget) (:controls)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ADATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](c2d2) `reblocks-ui2/tables/search::data-getter` (search-widget) (:data-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3AFILTERS-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](4f12) `reblocks-ui2/tables/search::filters-widget` (search-widget) (:filters)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](61f9) `reblocks-ui2/tables/search::next-page-getter` (search-widget) (:next-page-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [reader](68f0) `reblocks-ui2/tables/table:table-widget` (search-widget) (:table)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3A-3ANEXT-PAGE-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [accessor](61f9) `reblocks-ui2/tables/search::next-page-getter` (search-widget) (:next-page-getter)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASEARCH-WIDGET-29-29"></a>

###### [accessor](68f0) `reblocks-ui2/tables/table:table-widget` (search-widget) (:table)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AFILTERS-UPDATED-20GENERIC-FUNCTION-29"></a>

##### [generic-function](eadd) `reblocks-ui2/tables/search:filters-updated` widget

Signals that filters state was changed and table with results should be updated.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AHIDE-NEXT-PAGE-BUTTON-20GENERIC-FUNCTION-29"></a>

##### [generic-function](2027) `reblocks-ui2/tables/search:hide-next-page-button` widget

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3ASHOW-NEXT-PAGE-BUTTON-20GENERIC-FUNCTION-29"></a>

##### [generic-function](3029) `reblocks-ui2/tables/search:show-next-page-button` widget

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FSEARCH-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AMAKE-DEFAULT-CONTROLS-WIDGET-20FUNCTION-29"></a>

##### [function](66f7) `reblocks-ui2/tables/search:make-default-controls-widget` &KEY (BUTTON-TITLE "Load more")

<a id="x-28REBLOCKS-UI2-2FTABLES-2FSEARCH-3AMAKE-SEARCH-WIDGET-20FUNCTION-29"></a>

##### [function](3264) `reblocks-ui2/tables/search:make-search-widget` columns data-getter &key (filters-widget nil filters-widget-given-p) (controls-widget nil controls-widget-given-p) (widget-class 'search-widget) (table-class nil table-class-given-p) (row-class nil row-class-given-p)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/TABLE

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FTABLE-22-29-20PACKAGE-29"></a>

#### [package](fbf4) `reblocks-ui2/tables/table`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24COLUMN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20CLASS-29"></a>

###### [class](8090) `reblocks-ui2/tables/table:column` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACELL-MAKER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](80f5) `reblocks-ui2/tables/table:cell-maker` (column) (:cell-maker = #'create-widget-from)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-ALIGN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](05ea) `reblocks-ui2/tables/table:column-align` (column) (:align = :left)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CLASSES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](c389) `reblocks-ui2/tables/table:column-classes` (column) (:classes = nil)

Additional `CSS` classes for column cells

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](510d) `reblocks-ui2/tables/table:column-idx` (column) (= nil)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](5168) `reblocks-ui2/tables/table:column-title` (column) (:title)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ADATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](8728) `reblocks-ui2/tables/table:data-getter` (column) (:GETTER = (LAMBDA (ROW)
  (DECLARE (IGNORE ROW))
  (ERROR "Real getter should be provided to COLUMN function.")))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-ROW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-ROW

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-20CLASS-29"></a>

###### [class](d4af) `reblocks-ui2/tables/table:table-row` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-CELLS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](ed0e) `reblocks-ui2/tables/table:row-cells` (table-row) (:cells)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-OBJECT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](7872) `reblocks-ui2/tables/table:row-object` (table-row) (:object)

Original object, passed as a row to the [`make-table`][540e] function.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-TABLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](3428) `reblocks-ui2/tables/table:row-table` (table-row) (:table)

Reference it a table row belong to.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20CLASS-29"></a>

###### [class](3241) `reblocks-ui2/tables/table:table-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-COLUMNS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](fb75) `reblocks-ui2/tables/table:table-columns` (table-widget) (:columns = nil)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](127a) `reblocks-ui2/tables/table:table-row-class` (table-widget) (:row-class = 'table-row)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROWS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](e8fd) `reblocks-ui2/tables/table:table-rows` (table-widget) (:rows = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AAPPEND-DATA-20GENERIC-FUNCTION-29"></a>

##### [generic-function](d3b7) `reblocks-ui2/tables/table:append-data` widget data

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](5309) `reblocks-ui2/tables/table:column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AHEADER-COLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](ebdb) `reblocks-ui2/tables/table:header-column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20GENERIC-FUNCTION-29"></a>

##### [generic-function] `reblocks-ui2/tables/table:table-widget` object

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20FUNCTION-29"></a>

##### [function](66c3) `reblocks-ui2/tables/table:column` title &key (getter nil getter-given-p) (cell-maker nil cell-maker-p) (align :center) (classes nil clases-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-CELL-20FUNCTION-29"></a>

##### [function](0148) `reblocks-ui2/tables/table:current-cell`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-COLUMN-20FUNCTION-29"></a>

##### [function](d8a1) `reblocks-ui2/tables/table:current-column`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-ROW-20FUNCTION-29"></a>

##### [function](b1bf) `reblocks-ui2/tables/table:current-row`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-TABLE-20FUNCTION-29"></a>

##### [function](3957) `reblocks-ui2/tables/table:current-table`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AMAKE-TABLE-20FUNCTION-29"></a>

##### [function](e1d6) `reblocks-ui2/tables/table:make-table` columns rows &key (table-class 'table-widget) (row-class nil row-class-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ARECALCULATE-CELLS-20FUNCTION-29"></a>

##### [function](a01b) `reblocks-ui2/tables/table:recalculate-cells` row &key (update t)

Updates cell widgets using base object, stored in the `ROW`.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/API

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FAPI-22-29-20PACKAGE-29"></a>

#### [package](56ca) `reblocks-ui2/themes/api`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FAPI-3ACURRENT-THEME-20FUNCTION-29"></a>

##### [function](a854) `reblocks-ui2/themes/api:current-theme`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FAPI-3ADEFTHEME-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](4c08) `reblocks-ui2/themes/api:deftheme` name bases &rest var-forms

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/BASE

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FBASE-22-29-20PACKAGE-29"></a>

#### [package](1659) `reblocks-ui2/themes/base`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-24BASE-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BASE-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FBASE-3ABASE-THEME-20CLASS-29"></a>

###### [class](adff) `reblocks-ui2/themes/base:base-theme` ()

A base theme class for all `Reblocks-UI2` themes.

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FBASE-3AOVERRIDED-VARS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FBASE-3ABASE-THEME-29-29"></a>

###### [reader](3fce) `reblocks-ui2/themes/base:overrided-vars` (base-theme) (:overridden-vars = (make-hash-table :test 'equal))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/COLOR

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FCOLOR-22-29-20PACKAGE-29"></a>

#### [package](7ea0) `reblocks-ui2/themes/color`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-24COLOR-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLOR

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-20CLASS-29"></a>

###### [class](1e95) `reblocks-ui2/themes/color:color` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-DARK-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](2a74) `reblocks-ui2/themes/color:color-dark` (color) (:dark = nil)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-FOCUS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](f4cc) `reblocks-ui2/themes/color:color-focus` (color) (:focus = nil)

If string, then it is a color of element in "focus" state. If integer, then it is intensity change relative to the base color. For light scheme intensity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-HOVER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](ab11) `reblocks-ui2/themes/color:color-hover` (color) (:hover = nil)

If string, then it is a color of element in "hover" state. If integer, then it is intensity change relative to the base color. For light scheme intensity will be changed down if number is positive, for dark scheme intencity will go up. Negative number reverses this behaviour.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-LIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](9679) `reblocks-ui2/themes/color:color-light` (color) (:light = nil)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-PROPERTY-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-29-29"></a>

###### [reader](bb85) `reblocks-ui2/themes/color:color-property` (color) (:PROPERTY = (REQUIRED-ARGUMENT "property"))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3AADJUST-BASE-COLOR-20GENERIC-FUNCTION-29"></a>

##### [generic-function](3b7d) `reblocks-ui2/themes/color:adjust-base-color` theme base-color adjustment

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FCOLOR-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3AADJUST-COLOR-20FUNCTION-29"></a>

##### [function](6444) `reblocks-ui2/themes/color:adjust-color` theme color &key (light nil light-p) (dark nil dark-p) (hover nil hover-p) (focus nil focus-p)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FCOLOR-3ACOLOR-20FUNCTION-29"></a>

##### [function](ef9f) `reblocks-ui2/themes/color:color` property &key light dark hover focus

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/STYLING

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FSTYLING-22-29-20PACKAGE-29"></a>

#### [package](91fb) `reblocks-ui2/themes/styling`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3ACSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](78cd) `reblocks-ui2/themes/styling:css-classes` object theme &key size invalid-state

Returns classes for a widget or it's property.

Result can be a list, string or a keyword.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3ACSS-STYLES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](b204) `reblocks-ui2/themes/styling:css-styles` object theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](96e3) `reblocks-ui2/themes/styling:join-css-classes` theme &rest classes

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AMERGE-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](97eb) `reblocks-ui2/themes/styling:merge-css-classes` theme classes

This generic function is called before [`join-css-classes`][fb69] will output classes as a string.

Depending on theme some transformations can be applied to the list of `CSS` classes, given as `CLASSES` argument.
For example, a theme based on Tailwind framework, might merge `CSS` classes list allowing to override properties.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FSTYLING-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-STYLES-20FUNCTION-29"></a>

##### [function](0a8a) `reblocks-ui2/themes/styling:join-css-styles` &rest styles

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/TAILWIND

<a id="x-28-23A-28-2828-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FTAILWIND-22-29-20PACKAGE-29"></a>

#### [package](39ed) `reblocks-ui2/themes/tailwind`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-24TAILWIND-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TAILWIND-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ATAILWIND-THEME-20CLASS-29"></a>

###### [class](809d) `reblocks-ui2/themes/tailwind:tailwind-theme` (base-theme)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACARD-BORDER-RADIUS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:card-border-radius` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-ACTION-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-bg-action` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-DANGER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-bg-danger` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-INFO-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-bg-info` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-bg-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-SUCCESS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-bg-success` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-UTILITY-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-bg-utility` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BG-WARNING-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-bg-warning` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-ACTION-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-border-action` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-DANGER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-border-danger` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-INFO-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-border-info` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-border-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-SUCCESS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-border-success` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-UTILITY-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-border-utility` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-BORDER-WARNING-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-border-warning` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-LINE-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-line-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACOLORS-TEXT-NORMAL-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:colors-text-normal` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-MARGIN-SIZES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:core-margin-sizes` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-MODE-20GENERIC-FUNCTION-29"></a>

##### [generic-function](5d28) `reblocks-ui2/themes/tailwind:core-mode` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ACORE-PADDING-SIZES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:core-padding-sizes` theme

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3ATABS-ACTIVE-COLOR-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809d) `reblocks-ui2/themes/tailwind:tabs-active-color` theme

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](809d) `reblocks-ui2/themes/tailwind:make-tailwind-theme` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-DARK-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](5d28) `reblocks-ui2/themes/tailwind:make-tailwind-theme-dark` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-3AMAKE-TAILWIND-THEME-LIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](22c0) `reblocks-ui2/themes/tailwind:make-tailwind-theme-light` &rest overriden-var-forms

Creates a theme object.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/TAILWIND/ARBITRARY

<a id="x-28-23A-28-2838-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-22-29-20PACKAGE-29"></a>

#### [package](da07) `reblocks-ui2/themes/tailwind/arbitrary`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-24ARBITRARY-VALUE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ARBITRARY-VALUE

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-20CLASS-29"></a>

###### [class](da46) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-ARGS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-29-29"></a>

###### [reader](4c7e) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value-args` (arbitrary-value) (:args)

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-PREFIX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-29-29"></a>

###### [reader](a8be) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value-prefix` (arbitrary-value) (:prefix)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FTAILWIND-2FARBITRARY-3AARBITRARY-VALUE-20FUNCTION-29"></a>

##### [function](d472) `reblocks-ui2/themes/tailwind/arbitrary:arbitrary-value` prefix &rest args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/ALIGN

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FALIGN-22-29-20PACKAGE-29"></a>

#### [package](90f7) `reblocks-ui2/utils/align`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-24HORIZONTAL-ALIGN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### HORIZONTAL-ALIGN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-20CLASS-29"></a>

###### [class](302c) `reblocks-ui2/utils/align:horizontal-align` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-29-29"></a>

###### [reader](0fa4) `reblocks-ui2/utils/align:horizontal-align-value` (horizontal-align) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FALIGN-24VERTICAL-ALIGN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### VERTICAL-ALIGN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-20CLASS-29"></a>

###### [class](24c1) `reblocks-ui2/utils/align:vertical-align` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-29-29"></a>

###### [reader](47d5) `reblocks-ui2/utils/align:vertical-align-value` (vertical-align) (:value)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-20FUNCTION-29"></a>

##### [function](ec79) `reblocks-ui2/utils/align:horizontal-align` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-20FUNCTION-29"></a>

##### [function](51ff) `reblocks-ui2/utils/align:vertical-align` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FALIGN-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AHORIZONTAL-ALIGN-VALUE-20-28TYPE-29-29"></a>

##### [type](e820) `reblocks-ui2/utils/align:horizontal-align-value`

```
(MEMBER :LEFT :CENTER :TOP)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FALIGN-3AVERTICAL-ALIGN-VALUE-20-28TYPE-29-29"></a>

##### [type](630b) `reblocks-ui2/utils/align:vertical-align-value`

```
(MEMBER :TOP :CENTER :BOTTOM)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/MARGIN

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FMARGIN-22-29-20PACKAGE-29"></a>

#### [package](fef8) `reblocks-ui2/utils/margin`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FMARGIN-24MARGIN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### MARGIN

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-20CLASS-29"></a>

###### [class](0ceb) `reblocks-ui2/utils/margin:margin` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-BOTTOM-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](8756) `reblocks-ui2/utils/margin:margin-bottom` (margin) (:bottom = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-LEFT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](f83c) `reblocks-ui2/utils/margin:margin-left` (margin) (:left = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-RIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](7be1) `reblocks-ui2/utils/margin:margin-right` (margin) (:right = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-TOP-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-29-29"></a>

###### [reader](3436) `reblocks-ui2/utils/margin:margin-top` (margin) (:top = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FMARGIN-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FMARGIN-3AMARGIN-20FUNCTION-29"></a>

##### [function](320a) `reblocks-ui2/utils/margin:margin` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/PADDING

<a id="x-28-23A-28-2826-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FPADDING-22-29-20PACKAGE-29"></a>

#### [package](7064) `reblocks-ui2/utils/padding`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPADDING-24PADDING-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### PADDING

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-20CLASS-29"></a>

###### [class](e672) `reblocks-ui2/utils/padding:padding` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-HORIZONTAL-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-29-29"></a>

###### [reader](5e37) `reblocks-ui2/utils/padding:padding-horizontal-size` (padding) (:horizontal = :l)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-VERTICAL-SIZE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-29-29"></a>

###### [reader](0956) `reblocks-ui2/utils/padding:padding-vertical-size` (padding) (:vertical = :l)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-20FUNCTION-29"></a>

##### [function](3b87) `reblocks-ui2/utils/padding:padding` size

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPADDING-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3ANULLABLE-PADDING-SIZE-20-28TYPE-29-29"></a>

##### [type](2d6e) `reblocks-ui2/utils/padding:nullable-padding-size`

```
(OR NULL PADDING-SIZE)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FPADDING-3APADDING-SIZE-20-28TYPE-29-29"></a>

##### [type](83f7) `reblocks-ui2/utils/padding:padding-size`

```
(MEMBER :S :M :L :XL)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/PRIMITIVE-TO

<a id="x-28-23A-28-2831-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-22-29-20PACKAGE-29"></a>

#### [package](c0f3) `reblocks-ui2/utils/primitive-to`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FPRIMITIVE-TO-3APROCESS-PRIMITIVE-ARGS-20FUNCTION-29"></a>

##### [function](fb8e) `reblocks-ui2/utils/primitive-to:process-primitive-args` keyword-args

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/SIZE

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FSIZE-22-29-20PACKAGE-29"></a>

#### [package](519b) `reblocks-ui2/utils/size`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24HEIGHT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### HEIGHT

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AHEIGHT-20CLASS-29"></a>

###### [class](de01) `reblocks-ui2/utils/size:height` (size)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24RESPONSIVE-HEIGHT-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RESPONSIVE-HEIGHT

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-20CLASS-29"></a>

###### [class](0e16) `reblocks-ui2/utils/size:responsive-height` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMAX-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-29-29"></a>

###### [reader](cbc0) `reblocks-ui2/utils/size:max-height` (responsive-height) (:max = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMIN-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-29-29"></a>

###### [reader](567e) `reblocks-ui2/utils/size:min-height` (responsive-height) (:min = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24RESPONSIVE-WIDTH-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### RESPONSIVE-WIDTH

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-20CLASS-29"></a>

###### [class](f9d8) `reblocks-ui2/utils/size:responsive-width` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMAX-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-29-29"></a>

###### [reader](acb9) `reblocks-ui2/utils/size:max-width` (responsive-width) (:max = nil)

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AMIN-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-29-29"></a>

###### [reader](92f9) `reblocks-ui2/utils/size:min-width` (responsive-width) (:min = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24SIZE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SIZE

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-20CLASS-29"></a>

###### [class](e91b) `reblocks-ui2/utils/size:size` ()

**Readers**

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FUTILS-2FSIZE-3ASIZE-29-29"></a>

###### [reader](3a60) `reblocks-ui2/utils/size:size-value` (size) (:value)

If integer, then it will be considered as "px".
If string, then will be used as is (meaning depends on current theme).

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FSIZE-24WIDTH-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### WIDTH

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AWIDTH-20CLASS-29"></a>

###### [class](1c67) `reblocks-ui2/utils/size:width` (size)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AENSURE-HEIGHT-20FUNCTION-29"></a>

##### [function](0d5d) `reblocks-ui2/utils/size:ensure-height` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AENSURE-WIDTH-20FUNCTION-29"></a>

##### [function](682a) `reblocks-ui2/utils/size:ensure-width` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AHEIGHT-20FUNCTION-29"></a>

##### [function](47b0) `reblocks-ui2/utils/size:height` value

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-HEIGHT-20FUNCTION-29"></a>

##### [function](f1e8) `reblocks-ui2/utils/size:responsive-height` &key min max

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ARESPONSIVE-WIDTH-20FUNCTION-29"></a>

##### [function](ff1d) `reblocks-ui2/utils/size:responsive-width` &key min max

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3AWIDTH-20FUNCTION-29"></a>

##### [function](cfa1) `reblocks-ui2/utils/size:width` value

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FSIZE-3FTypes-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Types

<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASOME-HEIGHT-20-28TYPE-29-29"></a>

##### [type](3d71) `reblocks-ui2/utils/size:some-height`

```
(OR HEIGHT RESPONSIVE-HEIGHT)
```
<a id="x-28REBLOCKS-UI2-2FUTILS-2FSIZE-3ASOME-WIDTH-20-28TYPE-29-29"></a>

##### [type](c40d) `reblocks-ui2/utils/size:some-width`

```
(OR WIDTH RESPONSIVE-WIDTH)
```
<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FUTILS-2FWALK-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/UTILS/WALK

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FUTILS-2FWALK-22-29-20PACKAGE-29"></a>

#### [package](91e1) `reblocks-ui2/utils/walk`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FUTILS-2FWALK-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FUTILS-2FWALK-3ACHILDREN-20GENERIC-FUNCTION-29"></a>

##### [generic-function](e9cf) `reblocks-ui2/utils/walk:children` widget

<a id="x-28REBLOCKS-UI2-2FUTILS-2FWALK-3AWALK-20GENERIC-FUNCTION-29"></a>

##### [generic-function](cdce) `reblocks-ui2/utils/walk:walk` widget visitor-func

A protocol to go through widgets tree and to call `VISITOR-FUNC` on each node.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/WIDGET

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FWIDGET-22-29-20PACKAGE-29"></a>

#### [package](0132) `reblocks-ui2/widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-24UI-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### UI-WIDGET

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-20CLASS-29"></a>

###### [class](b167) `reblocks-ui2/widget:ui-widget` (widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AON-CLICK-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](e016) `reblocks-ui2/widget:on-click` (ui-widget) (:on-click = nil)

When an on-click action is given, cursor style will be changed to "pointer".

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-HEIGHT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](c5fc) `reblocks-ui2/widget:widget-height` (ui-widget) (:height = nil)

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-MARGIN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](978d) `reblocks-ui2/widget:widget-margin` (ui-widget) (:margin = nil)

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AWIDGET-WIDTH-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-29-29"></a>

###### [reader](f75d) `reblocks-ui2/widget:widget-width` (ui-widget) (:width = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-DEPENDENCIES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c280) `reblocks-ui2/widget:get-dependencies` widget theme

Works like [`reblocks/dependencies:get-dependencies`][2397] generic-function, but
in context of current theme.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-HTML-TAG-20GENERIC-FUNCTION-29"></a>

##### [generic-function](15c8) `reblocks-ui2/widget:get-html-tag` widget theme

Works like [`reblocks/widget:get-html-tag`][ab65] generic-function, but
in context of current theme.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AHTML-ATTRS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](b402) `reblocks-ui2/widget:html-attrs` widget theme

May return a plist of attributes to add to the main widget's `HTML` node.

It should not return `:ID` `:CLASS` or `:ONCLICK` attributes.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3ARENDER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](236e) `reblocks-ui2/widget:render` widget theme

Renders widget in given theme. All reblocks-ui2 widgets
should implement this method instead of a method
for [`reblocks/widget:render`][5607] generic-function.


[e41b]: https://40ants.com/reblocks-ui2/
[2397]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FDEPENDENCIES-3AGET-DEPENDENCIES-20GENERIC-FUNCTION-29
[ab65]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FWIDGET-3AGET-HTML-TAG-20GENERIC-FUNCTION-29
[5607]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FWIDGET-3ARENDER-20GENERIC-FUNCTION-29
[2d52]: https://github.com/40ants/reblocks-ui2
[9201]: https://github.com/40ants/reblocks-ui2/actions
[f06f]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L1
[beb1]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L51
[e681]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L52
[1f75]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L55
[b38d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L58
[dc7c]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L61
[9f71]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L64
[0e3d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L67
[098e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L70
[a966]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L74
[bcb6]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/button.lisp#L82
[faa8]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L1
[3c27]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L21
[b7a2]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L24
[d85e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L27
[5990]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L30
[fbb6]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L33
[44a6]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L36
[5190]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L39
[72ad]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L42
[e9f9]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L45
[168d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L48
[70ae]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L51
[c3d0]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L54
[b04d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L57
[51a9]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L61
[f800]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/buttons/view.lisp#L77
[2bb3]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/card.lisp#L1
[899c]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/card.lisp#L51
[8ac4]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/card.lisp#L52
[dc0b]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/card.lisp#L55
[0e09]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/card.lisp#L58
[952d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/card.lisp#L61
[c83f]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/card.lisp#L65
[c14c]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/card.lisp#L71
[1443]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/column.lisp#L1
[7ebf]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/column.lisp#L23
[cf53]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/column.lisp#L27
[4a30]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/container.lisp#L1
[60e2]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/container.lisp#L28
[9b46]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/container.lisp#L29
[126a]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/container.lisp#L33
[7fd8]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/container.lisp#L36
[c057]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/container.lisp#L46
[f73a]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/container.lisp#L77
[a82c]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/controls-row.lisp#L1
[4275]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/controls-row.lisp#L21
[61f7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/controls-row.lisp#L31
[19e8]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/row.lisp#L1
[73b7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/row.lisp#L25
[22d2]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/row.lisp#L29
[dbcd]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/row.lisp#L35
[c03c]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/stack.lisp#L1
[b3db]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/stack.lisp#L25
[03b6]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/stack.lisp#L26
[8ddc]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/stack.lisp#L31
[9d1a]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/stack.lisp#L45
[53fa]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/stack.lisp#L53
[3038]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/stack.lisp#L59
[22e5]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/stack.lisp#L66
[72db]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/stack.lisp#L71
[fa86]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L1
[51da]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L39
[78ad]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L43
[1e83]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L44
[9416]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L46
[8f2a]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L49
[ef95]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L54
[bce7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L55
[9fd7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L57
[2b51]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L63
[6c03]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/containers/tabs.lisp#L93
[3d91]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/editable.lisp#L1
[9f1e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/editable.lisp#L7
[cdee]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/events.lisp#L1
[1d09]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/events.lisp#L13
[25e3]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form.lisp#L1
[469f]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form.lisp#L109
[6b19]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form.lisp#L46
[1754]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form.lisp#L47
[eb67]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form.lisp#L49
[2f1d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form.lisp#L52
[61b1]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validation.lisp#L1
[221d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validation.lisp#L16
[0097]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validation.lisp#L29
[a807]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validation.lisp#L35
[4639]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validation.lisp#L40
[3e6d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validation.lisp#L47
[ce9d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validators.lisp#L1
[04e9]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validators.lisp#L105
[4abc]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validators.lisp#L156
[47bc]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validators.lisp#L200
[a3b8]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validators.lisp#L25
[d780]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validators.lisp#L55
[b79e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/form/validators.lisp#L81
[34df]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/html.lisp#L1
[1bb7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/html.lisp#L131
[25d0]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/html.lisp#L55
[1149]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/icon.lisp#L1
[7514]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/icon.lisp#L13
[eb81]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/icon.lisp#L14
[12eb]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/icon.lisp#L18
[b9b7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/base.lisp#L1
[4352]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/base.lisp#L42
[22aa]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/base.lisp#L43
[2ed3]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/base.lisp#L46
[5efb]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/base.lisp#L50
[3549]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/checkbox.lisp#L1
[2303]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/checkbox.lisp#L26
[3e21]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/checkbox.lisp#L27
[bce9]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/checkbox.lisp#L31
[231b]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/checkbox.lisp#L35
[cd27]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/checkbox.lisp#L39
[cde4]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/checkbox.lisp#L46
[15bf]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/date-input.lisp#L1
[5443]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/date-input.lisp#L27
[a554]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/named.lisp#L1
[9676]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/named.lisp#L13
[ac4f]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/named.lisp#L14
[fdcc]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L1
[c537]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L100
[59d6]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L42
[102f]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L43
[d590]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L46
[f849]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L49
[6844]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L61
[afba]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L70
[a991]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L71
[e3c5]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L74
[555c]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L78
[789c]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L81
[9ca3]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L85
[b327]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/select.lisp#L94
[59b3]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L1
[edaa]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L34
[9291]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L35
[d4a3]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L39
[0457]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L43
[b005]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L47
[a679]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L50
[b3cf]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L54
[e3cf]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L58
[b0c3]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L62
[ec3d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input.lisp#L68
[3031]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input/view.lisp#L1
[2733]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input/view.lisp#L10
[0f3b]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input/view.lisp#L13
[1278]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input/view.lisp#L16
[8df6]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/text-input/view.lisp#L19
[e500]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/textarea.lisp#L1
[5939]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/textarea.lisp#L31
[6f34]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/textarea.lisp#L32
[bd4a]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/textarea.lisp#L36
[ee90]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/textarea.lisp#L40
[020b]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/textarea.lisp#L44
[2757]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/textarea.lisp#L47
[dcf7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/textarea.lisp#L51
[5469]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/inputs/textarea.lisp#L57
[58a2]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/modal.lisp#L1
[5f01]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/modal.lisp#L17
[dc1e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/modal.lisp#L18
[17e0]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/modal.lisp#L21
[f3e4]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/modal.lisp#L24
[89bf]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/modal.lisp#L31
[c2f4]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/modal.lisp#L39
[9e8d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/modal.lisp#L56
[67e9]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/sizes.lisp#L1
[a6c0]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/sizes.lisp#L31
[5391]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/clickable-row.lisp#L1
[b711]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/clickable-row.lisp#L24
[cf28]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/clickable-row.lisp#L28
[0936]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/editable-table.lisp#L1
[1488]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/editable-table.lisp#L100
[9152]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/editable-table.lisp#L109
[d25a]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/editable-table.lisp#L132
[b531]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/editable-table.lisp#L205
[f831]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/editable-table.lisp#L209
[4a78]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/editable-table.lisp#L70
[043f]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/editable-table.lisp#L71
[771f]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/editable-table.lisp#L90
[a652]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/editable-table.lisp#L94
[6622]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L1
[eadd]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L165
[2027]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L171
[3029]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L176
[a1cb]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L35
[4f12]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L36
[68f0]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L39
[9070]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L42
[c2d2]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L45
[61f9]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L48
[ba14]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L53
[de41]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L54
[e511]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L56
[66f7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L60
[3264]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/search.lisp#L71
[fbf4]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L1
[c389]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L102
[e1d6]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L150
[ebdb]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L175
[5309]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L182
[66c3]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L189
[3957]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L227
[b1bf]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L232
[d8a1]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L237
[0148]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L242
[a01b]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L248
[d3b7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L256
[d4af]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L54
[ed0e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L55
[3428]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L58
[7872]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L61
[3241]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L66
[fb75]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L67
[e8fd]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L71
[127a]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L75
[8090]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L81
[510d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L82
[8728]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L85
[80f5]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L91
[5168]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L95
[05ea]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/tables/table.lisp#L98
[56ca]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/api.lisp#L1
[4c08]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/api.lisp#L210
[a854]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/api.lisp#L34
[1659]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/base.lisp#L1
[adff]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/base.lisp#L8
[3fce]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/base.lisp#L9
[7ea0]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/color.lisp#L1
[1e95]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/color.lisp#L16
[bb85]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/color.lisp#L17
[9679]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/color.lisp#L21
[2a74]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/color.lisp#L25
[ab11]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/color.lisp#L29
[f4cc]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/color.lisp#L34
[ef9f]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/color.lisp#L51
[3b7d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/color.lisp#L63
[6444]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/color.lisp#L66
[91fb]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/styling.lisp#L1
[78cd]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/styling.lisp#L17
[b204]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/styling.lisp#L29
[97eb]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/styling.lisp#L34
[96e3]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/styling.lisp#L66
[0a8a]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/styling.lisp#L73
[39ed]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/tailwind.lisp#L1
[22c0]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/tailwind.lisp#L141
[5d28]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/tailwind.lisp#L148
[809d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/tailwind.lisp#L41
[da07]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/tailwind/arbitrary.lisp#L1
[da46]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/tailwind/arbitrary.lisp#L19
[a8be]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/tailwind/arbitrary.lisp#L20
[4c7e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/tailwind/arbitrary.lisp#L23
[d472]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/themes/tailwind/arbitrary.lisp#L28
[90f7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/align.lisp#L1
[e820]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/align.lisp#L10
[630b]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/align.lisp#L14
[302c]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/align.lisp#L18
[0fa4]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/align.lisp#L19
[24c1]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/align.lisp#L24
[47d5]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/align.lisp#L25
[ec79]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/align.lisp#L35
[51ff]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/align.lisp#L46
[fef8]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/margin.lisp#L1
[0ceb]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/margin.lisp#L25
[f83c]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/margin.lisp#L26
[7be1]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/margin.lisp#L30
[3436]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/margin.lisp#L34
[8756]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/margin.lisp#L38
[320a]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/margin.lisp#L50
[7064]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/padding.lisp#L1
[83f7]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/padding.lisp#L11
[2d6e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/padding.lisp#L14
[e672]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/padding.lisp#L18
[5e37]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/padding.lisp#L19
[0956]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/padding.lisp#L23
[3b87]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/padding.lisp#L40
[c0f3]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/primitive-to.lisp#L1
[fb8e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/primitive-to.lisp#L18
[519b]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L1
[0d5d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L112
[e91b]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L22
[3a60]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L23
[1c67]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L36
[de01]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L40
[f9d8]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L44
[92f9]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L45
[acb9]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L49
[0e16]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L55
[567e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L56
[cbc0]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L60
[c40d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L66
[3d71]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L70
[cfa1]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L74
[ff1d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L79
[47b0]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L86
[f1e8]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L91
[682a]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/size.lisp#L99
[91e1]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/walk.lisp#L1
[e9cf]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/walk.lisp#L17
[cdce]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/utils/walk.lisp#L8
[0132]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/widget.lisp#L1
[15c8]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/widget.lisp#L106
[b402]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/widget.lisp#L113
[b167]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/widget.lisp#L50
[e016]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/widget.lisp#L51
[978d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/widget.lisp#L55
[f75d]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/widget.lisp#L59
[c5fc]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/widget.lisp#L63
[236e]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/widget.lisp#L77
[c280]: https://github.com/40ants/reblocks-ui2/blob/b23d8023c718370c83824491530a0323e74ab78e/src/widget.lisp#L99
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
[3f91]: index.html#x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AFIELD-VALIDATION-ERROR-20CONDITION-29
[e5e1]: index.html#x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20CONDITION-29
[f0d1]: index.html#x-28REBLOCKS-UI2-2FFORM-2FVALIDATION-3AVALIDATION-ERROR-20FUNCTION-29
[a897]: index.html#x-28REBLOCKS-UI2-2FFORM-2FVALIDATORS-3AVALID-DATE-20FUNCTION-29
[c654]: index.html#x-28REBLOCKS-UI2-2FHTML-3AHTML-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29
[ef48]: index.html#x-28REBLOCKS-UI2-2FINPUTS-2FTEXT-INPUT-3AINPUT-20FUNCTION-29
[f5ed]: index.html#x-28REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AOBJECT-DELETER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FEDITABLE-TABLE-3AEDITABLE-TABLE-WIDGET-29-29
[540e]: index.html#x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AMAKE-TABLE-20FUNCTION-29
[fb69]: index.html#x-28REBLOCKS-UI2-2FTHEMES-2FSTYLING-3AJOIN-CSS-CLASSES-20GENERIC-FUNCTION-29

* * *
###### [generated by [40ANTS-DOC](https://40ants.com/doc/)]
