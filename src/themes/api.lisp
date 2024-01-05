(uiop:define-package #:reblocks-ui2/themes/api
  (:use #:cl)
  (:import-from #:serapeum
                #:->
                #:defvar-unbound)
  (:import-from #:reblocks-ui2/themes/base
                #:base-theme)
  (:export #:current-theme
           #:*current-theme*))
(in-package #:reblocks-ui2/themes/api)


(defvar-unbound *current-theme*
  "Set this variable to a UI theme object made with a function like REBLOCKS-UI2/THEMES/TAILWIND:MAKE-TAILWIND-THEME.

   Set it during a Reblocks server startup.

   Use SETF on REBLOCKS-UI2/THEMES/API:CURRENT-THEME function.")


(-> current-theme ()
    (values base-theme &optional))

(defun current-theme ()
  (unless (boundp '*current-theme*)
    (error "Load theme system like reblocks-ui2/themes/tailwind and set current theme using SETF on REBLOCKS-UI2/THEMES/API:CURRENT-THEME function."))
  *current-theme*)


(-> (setf current-theme) (base-theme)
    (values base-theme &optional))

(defun (setf current-theme) (new-theme)
  (setf *current-theme*
        new-theme))


