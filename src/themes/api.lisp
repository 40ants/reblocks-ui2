(uiop:define-package #:reblocks-ui2/themes/api
  (:use #:cl)
  (:import-from #:serapeum
                #:intersperse)
  (:import-from #:alexandria
                #:length=
                #:symbolicate)
  (:import-from #:anaphora
                #:it
                #:acond)
  (:import-from #:closer-mop
                #:class-precedence-list)
  (:export #:current-theme
           #:*current-theme*
           #:deftheme
           #:theme))
(in-package #:reblocks-ui2/themes/api)


(defvar *current-theme*)
(setf (documentation '*current-theme* 'variable)
      "A theme to use for UI.

       Set it during a Reblocks server startup.")


(defun current-theme ()
  (unless (boundp '*current-theme*)
    (error "Load theme system like reblocks-ui2/themes/zurb and set variable REBLOCKS-UI2/THEMES/API:*CURRENT-THEME* to a needed theme object"))
  *current-theme*)


(defclass theme ()
  ((overrided-vars :initform (make-hash-table :test 'equal)
                   :initarg :overridden-vars
                   :reader overrided-vars)))


(defun get-by-path (hash var-path)
  (loop with result = hash
        for item in (mapcar
                     ;; Here we need to cast path items to strings,
                     ;; because theme vars may be overriden in other package
                     ;; and macro make-some-theme will capture symbols
                     ;; of this another package.
                     #'string-downcase
                     var-path)
        while result
        do (setf result
                 (gethash item result))
        finally (return result)))


(defun search-in-class-vars (theme-class var-path)
  (let* ((class-name (class-name theme-class))
         (theme-vars (get class-name 'theme-vars)))
    (acond
      ((and theme-vars
            (get-by-path theme-vars var-path))
       (typecase it
         (theme-variable
          (values (theme-variable-value it)
                  :theme-value
                  theme-class
                  ;; Variable definition.
                  ;; Can be useful to show documentation
                  ;; or controls for playing with theme settings.
                  it))
         ;; This could be a case, when we found an intermediate
         ;; hash instead of the leaf variable:
         (t
          (values nil
                  :not-found))))
      (t
       (closer-mop:ensure-finalized theme-class)
       
       (let ((parent-classes (cdr (class-precedence-list theme-class))))
         (if parent-classes
             (search-in-class-vars (car parent-classes)
                                   var-path)
             (values nil
                     :not-found)))))))


(defgeneric get-variable (theme var-path)
  (:method ((theme theme) var-path)
    (acond
      ((get-by-path (overrided-vars theme)
                    var-path)
       (values it
               :overriden))
      (t
       (search-in-class-vars (class-of theme)
                             var-path)))))


(eval-when (:compile-toplevel :load-toplevel :execute)
  (defclass theme-variable ()
    ((type :initarg :type
           :initform t
           :reader theme-variable-type)
     (value :initarg :value
            :initform nil
            :reader theme-variable-value)
     (documentation :initarg :documentation
                    :initform nil
                    :reader theme-variable-documentation)))

  (defun make-theme-var (&key (type t) value documentation)
    (make-instance 'theme-variable
                   :type type
                   :value value
                   :documentation documentation))
  
  
  (defun variable-params-p (params-or-subitems)
    (typep (car params-or-subitems)
           'keyword))

  (defun quote-type-param (var-params)
    (loop for (name value) on var-params by #'cddr
          append (list name
                       (case name
                         (:type (list 'quote value))
                         (otherwise value)))))
  
  (defun make-properties-hash (var-forms)
    (alexandria:with-gensyms (result-var)
      `(let ((,result-var (make-hash-table :test 'equal)))
         ,@(loop for (name . params-or-subitems) in var-forms
                 collect `(setf (gethash ,(string-downcase name)
                                         ,result-var)
                                ,(if (variable-params-p params-or-subitems)
                                     `(make-theme-var ,@(quote-type-param params-or-subitems))
                                     (make-properties-hash params-or-subitems))))
         (values ,result-var))))

  (defun make-overriden-vars-hash (class-name var-forms &optional path)
    "Difference with make-properties-hash: here we dont put instances of THEME-VARIABLE as
     leafs of the tree, but put real values instead."
    (alexandria:with-gensyms (result-var)
      (let ((hash-updates
              (loop for (name . value-or-subitems) in var-forms
                    for new-path = (append path
                                           (list name))
                    collect `(setf (gethash ,(string-downcase name) ,result-var)
                                   ,(multiple-value-bind (_1 search-status _2 variable)
                                        (search-in-class-vars (find-class class-name)
                                                              new-path)
                                      (declare (ignore _1 _2))
                                      
                                      (case search-status
                                        (:theme-value
                                         (unless (length= 1 value-or-subitems)
                                           (error "Value at path ~A should have only one value. Instead it is: ~A."
                                                  new-path
                                                  value-or-subitems))
                                         `(let ((value ,(car value-or-subitems))
                                                (var-type ',(theme-variable-type variable)))
                                           ;; Now we need to validate type of the
                                           ;; variable:
                                           (unless (typep value var-type)
                                             (error "Value at path ~A is not of type ~A: ~A"
                                                    ',new-path
                                                    var-type
                                                    value))
                                           value))
                                        (t
                                         (make-overriden-vars-hash class-name
                                                                   value-or-subitems
                                                                   new-path))))))))
        `(let ((,result-var (make-hash-table :test 'equal)))
           ,@hash-updates
           (values ,result-var)))))
  
  (defun make-var-method (class-name var-path)
    (let ((method-name (apply #'symbolicate
                              (intersperse '- var-path))))
      `((defmethod ,method-name ((theme ,class-name))
          (get-variable theme ',var-path))
        (export ',method-name))))
  
  (defun make-var-methods (class-name var-forms)
    (labels ((recurse (path var-forms)
               (loop for (name . params-or-subitems) in var-forms
                     for new-path =  (append path
                                             (list name))
                     if (variable-params-p params-or-subitems)
                       append (make-var-method class-name
                                               new-path)
                     else
                       append (recurse new-path
                                       params-or-subitems))))
      (recurse nil var-forms))))


(defmacro deftheme (name bases &rest var-forms)
  (let ((var-forms-expanded (make-properties-hash var-forms))
        (var-methods (make-var-methods name var-forms))
        (make-macro-name (symbolicate "MAKE-" name))
        (bases (or bases
                   (list 'theme))))
    `(progn
       (defclass ,name (,@bases)
         ())

       (setf (get ',name 'theme-vars)
             ,var-forms-expanded)
       
       (defmacro ,make-macro-name (&rest overriden-var-forms)
         (let* ((class-name ',name)
                (vars (make-overriden-vars-hash class-name overriden-var-forms)))
           `(make-instance ',class-name
                           :overridden-vars ,vars)))

       ,@var-methods
       
       (values ',name))))
