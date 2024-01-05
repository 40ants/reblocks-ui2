(uiop:define-package #:reblocks-ui2/themes/api
  (:use #:cl)
  (:import-from #:serapeum
                #:defvar-unbound)
  (:export #:current-theme
           #:*current-theme*))
(in-package #:reblocks-ui2/themes/api)


(defvar-unbound *current-theme*
  "A theme to use for UI.

   Set it during a Reblocks server startup.")


(defun current-theme ()
  (unless (boundp '*current-theme*)
    (error "Load theme system like reblocks-ui2/themes/zurb and set variable REBLOCKS-UI2/THEMES/API:*CURRENT-THEME* to a needed theme object"))
  *current-theme*)


