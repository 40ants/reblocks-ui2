(uiop:define-package #:reblocks-ui2/themes/api
  (:use #:cl)
  (:export #:current-theme))
(in-package #:reblocks-ui2/themes/api)


(defvar *current-theme*)


(defun current-theme ()
  (unless (boundp '*current-theme*)
    (error "Load theme system like reblocks-ui2/themes/zurb and set variable REBLOCKS-UI2/THEMES/API:*CURRENT-THEME* to a needed theme object"))
  *current-theme*)


