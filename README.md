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

#### [package](317f) `reblocks-ui2/buttons/button`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-24BUTTON-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BUTTON

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20CLASS-29"></a>

###### [class](24ce) `reblocks-ui2/buttons/button:button` (widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](8474) `reblocks-ui2/buttons/button:button-class` (button) (:class)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-CONTENT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](67dd) `reblocks-ui2/buttons/button:button-content` (button) (:content)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-DISABLED-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](5158) `reblocks-ui2/buttons/button:button-disabled` (button) (:disabled = nil)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-ON-CLICK-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](7be5) `reblocks-ui2/buttons/button:button-on-click` (button) (:on-click)

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-STYLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-29-29"></a>

###### [reader](b5b5) `reblocks-ui2/buttons/button:button-style` (button) (:style)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FBUTTONS-2FBUTTON-3ABUTTON-20FUNCTION-29"></a>

##### [function](6c2c) `reblocks-ui2/buttons/button:button` CONTENT &KEY (WIDGET-CLASS 'BUTTON) ON-CLICK (CLASS "button") DISABLED STYLE

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/CONTAINERS/POPUP/WIDGET

<a id="x-28-23A-28-2836-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-22-29-20PACKAGE-29"></a>

#### [package](09f2) `reblocks-ui2/containers/popup/widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-24POPUP-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### POPUP-WIDGET

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3APOPUP-WIDGET-20CLASS-29"></a>

###### [class](88bc) `reblocks-ui2/containers/popup/widget:popup-widget` (ui-widget)

This widgets shows a popup window.

Inherit from this class and define a method for
[`render-popup-content`][fb22] generic-function. Then you
will be able to instantiate your class instance
and call [`show-popup`][2466] generic function.

**Readers**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3AVISIBLE-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3APOPUP-WIDGET-29-29"></a>

###### [reader](2166) `reblocks-ui2/containers/popup/widget:visible-p` (popup-widget) (= nil)

**Accessors**

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3AVISIBLE-P-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3APOPUP-WIDGET-29-29"></a>

###### [accessor](2166) `reblocks-ui2/containers/popup/widget:visible-p` (popup-widget) (= nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3AHIDE-POPUP-20GENERIC-FUNCTION-29"></a>

##### [generic-function](3f41) `reblocks-ui2/containers/popup/widget:hide-popup` widget

Hides popup window.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3ARENDER-POPUP-CONTENT-20GENERIC-FUNCTION-29"></a>

##### [generic-function](ca82) `reblocks-ui2/containers/popup/widget:render-popup-content` widget

Renders inner `HTML` for popup window.
You need to define a method for this generic function
and specialize it for your own class.

<a id="x-28REBLOCKS-UI2-2FCONTAINERS-2FPOPUP-2FWIDGET-3ASHOW-POPUP-20GENERIC-FUNCTION-29"></a>

##### [generic-function](8e05) `reblocks-ui2/containers/popup/widget:show-popup` widget

Shows popup window.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/CLICKABLE-ROW

<a id="x-28-23A-28-2833-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-22-29-20PACKAGE-29"></a>

#### [package](aa9e) `reblocks-ui2/tables/clickable-row`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-24CLICKABLE-ROW-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### CLICKABLE-ROW-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3ACLICKABLE-ROW-WIDGET-20CLASS-29"></a>

###### [class](261d) `reblocks-ui2/tables/clickable-row:clickable-row-widget` (table-row)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FCLICKABLE-ROW-3AMAKE-CLICKABLE-ROW-WIDGET-20FUNCTION-29"></a>

##### [function](8304) `reblocks-ui2/tables/clickable-row:make-clickable-row-widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/TABLES/TABLE

<a id="x-28-23A-28-2825-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTABLES-2FTABLE-22-29-20PACKAGE-29"></a>

#### [package](4241) `reblocks-ui2/tables/table`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24COLUMN-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### COLUMN

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20CLASS-29"></a>

###### [class](f10b) `reblocks-ui2/tables/table:column` (widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACELL-MAKER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](9d77) `reblocks-ui2/tables/table:cell-maker` (column) (:cell-maker = #'create-widget-from)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-ALIGN-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](5480) `reblocks-ui2/tables/table:column-align` (column) (:align = :left)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CLASSES-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](ccc8) `reblocks-ui2/tables/table:column-classes` (column) (:classes = nil)

Additional `CSS` classes for column cells

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-IDX-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](a7c1) `reblocks-ui2/tables/table:column-idx` (column) (= nil)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-TITLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](51f0) `reblocks-ui2/tables/table:column-title` (column) (:title)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ADATA-GETTER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-29-29"></a>

###### [reader](ec87) `reblocks-ui2/tables/table:data-getter` (column) (:GETTER = (LAMBDA (ROW)
  (DECLARE (IGNORE ROW))
  (ERROR "Real getter should be provided to COLUMN function.")))

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-ROW-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-ROW

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-20CLASS-29"></a>

###### [class](4e18) `reblocks-ui2/tables/table:table-row` (widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-CELLS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](cc1f) `reblocks-ui2/tables/table:row-cells` (table-row) (:cells)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-OBJECT-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](4df2) `reblocks-ui2/tables/table:row-object` (table-row) (:object)

Original object, passed as a row to the [`make-table`][e390] function.

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AROW-TABLE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-29-29"></a>

###### [reader](6df2) `reblocks-ui2/tables/table:row-table` (table-row) (:table)

Reference it a table row belong to.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTABLES-2FTABLE-24TABLE-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TABLE-WIDGET

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-20CLASS-29"></a>

###### [class](aa7b) `reblocks-ui2/tables/table:table-widget` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-COLUMNS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](5765) `reblocks-ui2/tables/table:table-columns` (table-widget) (:columns)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROW-CLASS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](d04b) `reblocks-ui2/tables/table:table-row-class` (table-widget) (:row-class = 'table-row)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-ROWS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-UI2-2FTABLES-2FTABLE-3ATABLE-WIDGET-29-29"></a>

###### [reader](2d25) `reblocks-ui2/tables/table:table-rows` (table-widget) (:rows = nil)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AAPPEND-DATA-20GENERIC-FUNCTION-29"></a>

##### [generic-function](24a2) `reblocks-ui2/tables/table:append-data` widget data

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](2741) `reblocks-ui2/tables/table:column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AHEADER-COLUMN-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](e1a8) `reblocks-ui2/tables/table:header-column-css-classes` column theme

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTABLES-2FTABLE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACOLUMN-20FUNCTION-29"></a>

##### [function](aba0) `reblocks-ui2/tables/table:column` title &key (getter nil getter-given-p) (cell-maker nil cell-maker-p) (align :center) (classes nil clases-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-CELL-20FUNCTION-29"></a>

##### [function](573d) `reblocks-ui2/tables/table:current-cell`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-COLUMN-20FUNCTION-29"></a>

##### [function](b3c7) `reblocks-ui2/tables/table:current-column`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-ROW-20FUNCTION-29"></a>

##### [function](c8d2) `reblocks-ui2/tables/table:current-row`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ACURRENT-TABLE-20FUNCTION-29"></a>

##### [function](d8ba) `reblocks-ui2/tables/table:current-table`

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3AMAKE-TABLE-20FUNCTION-29"></a>

##### [function](34a1) `reblocks-ui2/tables/table:make-table` columns rows &key (table-class 'table-widget) (row-class nil row-class-given-p)

<a id="x-28REBLOCKS-UI2-2FTABLES-2FTABLE-3ARECALCULATE-CELLS-20FUNCTION-29"></a>

##### [function](134e) `reblocks-ui2/tables/table:recalculate-cells` row &key (update t)

Updates cell widgets using base object, stored in the `ROW`.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/API

<a id="x-28-23A-28-2823-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FAPI-22-29-20PACKAGE-29"></a>

#### [package](93b3) `reblocks-ui2/themes/api`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FAPI-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FAPI-3ACURRENT-THEME-20FUNCTION-29"></a>

##### [function](9b84) `reblocks-ui2/themes/api:current-theme`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/BASE

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FBASE-22-29-20PACKAGE-29"></a>

#### [package](4baf) `reblocks-ui2/themes/base`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FBASE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FBASE-24BASE-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### BASE-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FBASE-3ABASE-THEME-20CLASS-29"></a>

###### [class](3074) `reblocks-ui2/themes/base:base-theme` ()

A base theme class for all `Reblocks-UI2` themes.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FZURB-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/THEMES/ZURB

<a id="x-28-23A-28-2824-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FTHEMES-2FZURB-22-29-20PACKAGE-29"></a>

#### [package](c205) `reblocks-ui2/themes/zurb`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FZURB-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FTHEMES-2FZURB-24ZURB-THEME-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### ZURB-THEME

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FZURB-3AZURB-THEME-20CLASS-29"></a>

###### [class](212d) `reblocks-ui2/themes/zurb:zurb-theme` (base-theme)

A theme implementing all widgets using Zurb Foundation framework.

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FTHEMES-2FZURB-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-UI2-2FTHEMES-2FZURB-3AMAKE-ZURB-THEME-20FUNCTION-29"></a>

##### [function](4a60) `reblocks-ui2/themes/zurb:make-zurb-theme`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-UI2/WIDGET

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22REBLOCKS-UI2-2FWIDGET-22-29-20PACKAGE-29"></a>

#### [package](8082) `reblocks-ui2/widget`

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-40REBLOCKS-UI2-2FWIDGET-24UI-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### UI-WIDGET

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AUI-WIDGET-20CLASS-29"></a>

###### [class](7b5e) `reblocks-ui2/widget:ui-widget` (widget)

<a id="x-28REBLOCKS-UI2-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-UI2-2FWIDGET-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-CSS-CLASSES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](a4a2) `reblocks-ui2/widget:get-css-classes` widget theme

Returns a list of classes for the widget.

Default implementation returns class list and all it's parent names.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3AGET-DEPENDENCIES-20GENERIC-FUNCTION-29"></a>

##### [generic-function](deea) `reblocks-ui2/widget:get-dependencies` widget theme

Works like [`reblocks/dependencies:get-dependencies`][0fcf] generic-function, but
in context of current theme.

<a id="x-28REBLOCKS-UI2-2FWIDGET-3ARENDER-20GENERIC-FUNCTION-29"></a>

##### [generic-function](7d9d) `reblocks-ui2/widget:render` widget theme

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
[317f]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/buttons/button.lisp#L1
[24ce]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/buttons/button.lisp#L25
[7be5]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/buttons/button.lisp#L26
[67dd]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/buttons/button.lisp#L30
[8474]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/buttons/button.lisp#L33
[b5b5]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/buttons/button.lisp#L36
[5158]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/buttons/button.lisp#L39
[6c2c]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/buttons/button.lisp#L45
[09f2]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/containers/popup/widget.lisp#L1
[88bc]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/containers/popup/widget.lisp#L16
[2166]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/containers/popup/widget.lisp#L17
[8e05]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/containers/popup/widget.lisp#L27
[3f41]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/containers/popup/widget.lisp#L34
[ca82]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/containers/popup/widget.lisp#L41
[aa9e]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/clickable-row.lisp#L1
[261d]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/clickable-row.lisp#L24
[8304]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/clickable-row.lisp#L28
[4241]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L1
[ccc8]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L102
[34a1]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L140
[e1a8]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L155
[2741]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L162
[aba0]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L169
[d8ba]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L207
[c8d2]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L212
[b3c7]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L217
[573d]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L222
[134e]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L228
[24a2]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L236
[4e18]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L56
[cc1f]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L57
[6df2]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L60
[4df2]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L63
[aa7b]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L68
[5765]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L69
[2d25]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L71
[d04b]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L75
[f10b]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L81
[a7c1]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L82
[ec87]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L85
[9d77]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L91
[51f0]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L95
[5480]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/tables/table.lisp#L98
[93b3]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/themes/api.lisp#L1
[9b84]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/themes/api.lisp#L21
[4baf]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/themes/base.lisp#L1
[3074]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/themes/base.lisp#L7
[c205]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/themes/zurb.lisp#L1
[212d]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/themes/zurb.lisp#L10
[4a60]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/themes/zurb.lisp#L15
[8082]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/widget.lisp#L1
[7b5e]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/widget.lisp#L21
[7d9d]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/widget.lisp#L25
[a4a2]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/widget.lisp#L47
[deea]: https://github.com/40ants/reblocks-ui2/blob/795b8b336218ace379240df34d0fae8f99e9c94e/src/widget.lisp#L61
[9c4e]: https://github.com/40ants/reblocks-ui2/issues
[8236]: https://quickdocs.org/alexandria
[5dbf]: https://quickdocs.org/moptilities
[184b]: https://quickdocs.org/reblocks
[28e0]: https://quickdocs.org/reblocks-lass
[c41d]: https://quickdocs.org/serapeum

* * *
###### [generated by [40ANTS-DOC](https://40ants.com/doc/)]
