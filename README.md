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
* Depends on: [alexandria][8236], [moptilities][5dbf], [reblocks][184b], [reblocks-lass][28e0], [serapeum][c41d]

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

`TODO`: Write a library description. Put some examples here.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40API-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## API

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/BUTTONS/BUTTON

<a id="x-28-23A-28-2827-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FBUTTONS-2FBUTTON-22-29-20PACKAGE-29"></a>

#### [package](6304) `reblocks-ui2/buttons/button`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-24BUTTON-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BUTTON

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20CLASS-29"></a>

###### [class](68d7) `reblocks-ui2/buttons/button:button` (widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](a3ea) `reblocks-ui2/buttons/button:button-class` (button) (:class)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](b063) `reblocks-ui2/buttons/button:button-content` (button) (:content)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](59ac) `reblocks-ui2/buttons/button:button-disabled` (button) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-ON-CLICK-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](90c3) `reblocks-ui2/buttons/button:button-on-click` (button) (:on-click)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-STYLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](2cc0) `reblocks-ui2/buttons/button:button-style` (button) (:style)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20FUNCTION-29"></a>

##### [function](b0d6) `reblocks-ui2/buttons/button:button` CONTENT &KEY (WIDGET-CLASS 'BUTTON) ON-CLICK (CLASS "button") DISABLED STYLE

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/POPUP/WIDGET

<a id="x-28-23A-28-2836-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-22-29-20PACKAGE-29"></a>

#### [package](d69a) `reblocks-ui2/containers/popup/widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-24POPUP-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### POPUP-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3APOPUP-WIDGET-20CLASS-29"></a>

###### [class](bbf5) `reblocks-ui2/containers/popup/widget:popup-widget` (ui-widget)

This widgets shows a popup window.

Inherit from this class and define a method for
[`render-popup-content`][fb22] generic-function. Then you
will be able to instantiate your class instance
and call [`show-popup`][2466] generic function.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3AVISIBLE-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3APOPUP-WIDGET-29-29"></a>

###### [reader](5bcf) `reblocks-ui2/containers/popup/widget:visible-p` (popup-widget) (= nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3AVISIBLE-P-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3APOPUP-WIDGET-29-29"></a>

###### [accessor](5bcf) `reblocks-ui2/containers/popup/widget:visible-p` (popup-widget) (= nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3AHIDE-POPUP-20GENERIC-FUNCTION-29"></a>

##### [generic-function](77da) `reblocks-ui2/containers/popup/widget:hide-popup` widget

Hides popup window.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3ARENDER-POPUP-CONTENT-20GENERIC-FUNCTION-29"></a>

##### [generic-function](809e) `reblocks-ui2/containers/popup/widget:render-popup-content` widget

Renders inner `HTML` for popup window.
You need to define a method for this generic function
and specialize it for your own class.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3ASHOW-POPUP-20GENERIC-FUNCTION-29"></a>

##### [generic-function](26b2) `reblocks-ui2/containers/popup/widget:show-popup` widget

Shows popup window.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/CLICKABLE-ROW

<a id="x-28-23A-28-2833-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-22-29-20PACKAGE-29"></a>

#### [package](d313) `reblocks-ui2/tables/clickable-row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-24CLICKABLE-ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CLICKABLE-ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3ACLICKABLE-ROW-WIDGET-20CLASS-29"></a>

###### [class](7771) `reblocks-ui2/tables/clickable-row:clickable-row-widget` (table-row)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3AMAKE-CLICKABLE-ROW-WIDGET-20FUNCTION-29"></a>

##### [function](5a36) `reblocks-ui2/tables/clickable-row:make-clickable-row-widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/TABLE

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FTABLE-22-29-20PACKAGE-29"></a>

#### [package](1703) `reblocks-ui2/tables/table`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24COLUMN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20CLASS-29"></a>

###### [class](6deb) `reblocks-ui2/tables/table:column` (widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACELL-MAKER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](166d) `reblocks-ui2/tables/table:cell-maker` (column) (:cell-maker = #'create-widget-from)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-ALIGN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](e942) `reblocks-ui2/tables/table:column-align` (column) (:align = :left)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CLASSES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](6e2c) `reblocks-ui2/tables/table:column-classes` (column) (:classes = nil)

Additional `CSS` classes for column cells

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](a0b9) `reblocks-ui2/tables/table:column-idx` (column) (= nil)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](ef03) `reblocks-ui2/tables/table:column-title` (column) (:title)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ADATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](b79a) `reblocks-ui2/tables/table:data-getter` (column) (:GETTER = (LAMBDA (ROW)
  (DECLARE (IGNORE ROW))
  (ERROR "Real getter should be provided to COLUMN function.")))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-ROW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-ROW

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-20CLASS-29"></a>

###### [class](88d0) `reblocks-ui2/tables/table:table-row` (widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-CELLS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](4070) `reblocks-ui2/tables/table:row-cells` (table-row) (:cells)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-OBJECT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](2152) `reblocks-ui2/tables/table:row-object` (table-row) (:object)

Original object, passed as a row to the [`make-table`][e390] function.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-TABLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](ee36) `reblocks-ui2/tables/table:row-table` (table-row) (:table)

Reference it a table row belong to.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20CLASS-29"></a>

###### [class](0004) `reblocks-ui2/tables/table:table-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-COLUMNS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](ce26) `reblocks-ui2/tables/table:table-columns` (table-widget) (:columns)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](293c) `reblocks-ui2/tables/table:table-row-class` (table-widget) (:row-class = 'table-row)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROWS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](6438) `reblocks-ui2/tables/table:table-rows` (table-widget) (:rows = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AAPPEND-DATA-20GENERIC-FUNCTION-29"></a>

##### [generic-function](296c) `reblocks-ui2/tables/table:append-data` widget data

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](94e4) `reblocks-ui2/tables/table:column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AHEADER-COLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](1654) `reblocks-ui2/tables/table:header-column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20FUNCTION-29"></a>

##### [function](65c3) `reblocks-ui2/tables/table:column` title &key (getter nil getter-given-p) (cell-maker nil cell-maker-p) (align :center) (classes nil clases-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-CELL-20FUNCTION-29"></a>

##### [function](7814) `reblocks-ui2/tables/table:current-cell`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-COLUMN-20FUNCTION-29"></a>

##### [function](67ca) `reblocks-ui2/tables/table:current-column`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-ROW-20FUNCTION-29"></a>

##### [function](e2a0) `reblocks-ui2/tables/table:current-row`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-TABLE-20FUNCTION-29"></a>

##### [function](bbc5) `reblocks-ui2/tables/table:current-table`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AMAKE-TABLE-20FUNCTION-29"></a>

##### [function](7fba) `reblocks-ui2/tables/table:make-table` columns rows &key (table-class 'table-widget) (row-class nil row-class-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ARECALCULATE-CELLS-20FUNCTION-29"></a>

##### [function](c859) `reblocks-ui2/tables/table:recalculate-cells` row &key (update t)

Updates cell widgets using base object, stored in the `ROW`.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/API

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FAPI-22-29-20PACKAGE-29"></a>

#### [package](6d9c) `reblocks-ui2/themes/api`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FAPI-3ACURRENT-THEME-20FUNCTION-29"></a>

##### [function](6741) `reblocks-ui2/themes/api:current-theme`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/BASE

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FBASE-22-29-20PACKAGE-29"></a>

#### [package](76ff) `reblocks-ui2/themes/base`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-24BASE-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BASE-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FBASE-3ABASE-THEME-20CLASS-29"></a>

###### [class](8c30) `reblocks-ui2/themes/base:base-theme` ()

A base theme class for all `Reblocks-UI2` themes.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FZURB-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/ZURB

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FZURB-22-29-20PACKAGE-29"></a>

#### [package](cbaf) `reblocks-ui2/themes/zurb`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FZURB-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FZURB-24ZURB-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ZURB-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FZURB-3AZURB-THEME-20CLASS-29"></a>

###### [class](f935) `reblocks-ui2/themes/zurb:zurb-theme` (base-theme)

A theme implementing all widgets using Zurb Foundation framework.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FZURB-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FZURB-3AMAKE-ZURB-THEME-20FUNCTION-29"></a>

##### [function](d8bf) `reblocks-ui2/themes/zurb:make-zurb-theme`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/WIDGET

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FWIDGET-22-29-20PACKAGE-29"></a>

#### [package](c85a) `reblocks-ui2/widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-24UI-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### UI-WIDGET

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-20CLASS-29"></a>

###### [class](8bd2) `reblocks-ui2/widget:ui-widget` (widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](0192) `reblocks-ui2/widget:get-css-classes` widget theme

Returns a list of classes for the widget.

Default implementation returns class list and all it's parent names.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-DEPENDENCIES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](d52e) `reblocks-ui2/widget:get-dependencies` widget theme

Works like [`reblocks/dependencies:get-dependencies`][0fcf] generic-function, but
in context of current theme.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3ARENDER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](7f18) `reblocks-ui2/widget:render` widget theme

Renders widget in given theme. All reblocks-ui2 widgets
should implement this method instead of a method
for [`reblocks/widget:render`][73ac] generic-function.


[e41b]: https://40ants.com/reblocks-ui2/
[fb22]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3ARENDER-POPUP-CONTENT-20GENERIC-FUNCTION-29
[2466]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3ASHOW-POPUP-20GENERIC-FUNCTION-29
[e390]: https://40ants.com/reblocks-ui2/#x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AMAKE-TABLE-20FUNCTION-29
[0fcf]: https://40ants.com/reblocks/dependencies/#x-28REBLOCKS-2FDEPENDENCIES-3AGET-DEPENDENCIES-20GENERIC-FUNCTION-29
[73ac]: https://40ants.com/reblocks/widgets/#x-28REBLOCKS-2FWIDGET-3ARENDER-20GENERIC-FUNCTION-29
[2d52]: https://github.com/40ants/reblocks-ui2
[9201]: https://github.com/40ants/reblocks-ui2/actions
[6304]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/buttons/button.lisp#L1
[68d7]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/buttons/button.lisp#L25
[90c3]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/buttons/button.lisp#L26
[b063]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/buttons/button.lisp#L30
[a3ea]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/buttons/button.lisp#L33
[2cc0]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/buttons/button.lisp#L36
[59ac]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/buttons/button.lisp#L39
[b0d6]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/buttons/button.lisp#L45
[d69a]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/containers/popup/widget.lisp#L1
[bbf5]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/containers/popup/widget.lisp#L16
[5bcf]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/containers/popup/widget.lisp#L17
[26b2]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/containers/popup/widget.lisp#L27
[77da]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/containers/popup/widget.lisp#L34
[809e]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/containers/popup/widget.lisp#L41
[d313]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/clickable-row.lisp#L1
[7771]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/clickable-row.lisp#L24
[5a36]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/clickable-row.lisp#L28
[1703]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L1
[6e2c]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L102
[7fba]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L140
[1654]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L155
[94e4]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L162
[65c3]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L169
[bbc5]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L207
[e2a0]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L212
[67ca]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L217
[7814]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L222
[c859]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L228
[296c]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L236
[88d0]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L56
[4070]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L57
[ee36]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L60
[2152]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L63
[0004]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L68
[ce26]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L69
[6438]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L71
[293c]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L75
[6deb]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L81
[a0b9]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L82
[b79a]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L85
[166d]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L91
[ef03]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L95
[e942]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/tables/table.lisp#L98
[6d9c]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/themes/api.lisp#L1
[6741]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/themes/api.lisp#L21
[76ff]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/themes/base.lisp#L1
[8c30]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/themes/base.lisp#L7
[cbaf]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/themes/zurb.lisp#L1
[f935]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/themes/zurb.lisp#L10
[d8bf]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/themes/zurb.lisp#L15
[c85a]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/widget.lisp#L1
[8bd2]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/widget.lisp#L21
[7f18]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/widget.lisp#L25
[0192]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/widget.lisp#L47
[d52e]: https://github.com/40ants/reblocks-ui2/blob/bf6f163d8acd22333a9135dc564a863215546afc/src/widget.lisp#L61
[9c4e]: https://github.com/40ants/reblocks-ui2/issues
[8236]: https://quickdocs.org/alexandria
[5dbf]: https://quickdocs.org/moptilities
[184b]: https://quickdocs.org/reblocks
[28e0]: https://quickdocs.org/reblocks-lass
[c41d]: https://quickdocs.org/serapeum

* * *
###### [generated by [40ANTS-DOC](https://40ants.com/doc/)]
