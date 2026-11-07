(uiop:define-package #:reblocks-ui2-demo/pages/crud
  (:use #:cl)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:serapeum
                #:fmt)
  (:import-from #:reblocks-ui2/widget
                #:render
                #:ui-widget)
  (:import-from #:reblocks-ui2/tables/crud
                #:make-crud-table)
  (:import-from #:reblocks-ui2/tables/table
                #:column)
  (:import-from #:reblocks-ui2/form
                #:form)
  (:import-from #:reblocks-ui2/inputs/text-input
                #:input)
  (:import-from #:reblocks-ui2/buttons/button
                #:button)
  (:import-from #:reblocks-ui2/modal
                #:modal-hide)
  (:import-from #:reblocks-ui2/html
                #:html)
  (:export #:make-crud-page))
(in-package #:reblocks-ui2-demo/pages/crud)


(defclass demo-task ()
  ((id :initarg :id
       :reader demo-task-id)
   (title :initarg :title
          :initform ""
          :accessor demo-task-title)))


(defparameter *demo-tasks* nil
  "An in-memory list of tasks shown by the demo CRUD table.")

(defparameter *next-task-id* 1
  "A counter used to generate identifiers for new tasks.")


(defun make-demo-task (title)
  "Returns a new task and advances the identifier counter."
  (let ((task (make-instance 'demo-task
                             :id *next-task-id*
                             :title title)))
    (incf *next-task-id*)
    (values task)))


(defun reset-demo-tasks ()
  "Seeds the demo task list, so that each page visit starts from the same state."
  (setf *next-task-id* 1
        *demo-tasks* (list (make-demo-task "Buy milk")
                           (make-demo-task "Call mom")
                           (make-demo-task "Ship the release"))))


(defun add-demo-task (title)
  (setf *demo-tasks*
        (append *demo-tasks*
                (list (make-demo-task title))))
  (values))


(defun delete-demo-task (task)
  (setf *demo-tasks*
        (remove task *demo-tasks*))
  (values))


(defun make-tasks-form (modal title &key on-save)
  "Returns a form with a single \"title\" input prefilled with the TITLE.

ON-SAVE is called with the entered title when the form is submitted
by the Save button. The modal is hidden after any submission, exactly
like in the donor application's forms."
  (form
   (html ((:div :class "flex flex-col gap-4"
                (:table
                 (:tr
                  (:td (:p "Title"))
                  (:td (input :name "title"
                              :value title
                              :placeholder "Task title"))))
                (:div :class "flex gap-4 flex-row-reverse"
                      (button "Save"
                              :name "button"
                              :value "submit"
                              :type "submit"
                              :view :action)
                      (button "Cancel"
                              :name "button"
                              :value "cancel"
                              :type "submit")))))
   :on-submit (lambda (form &key button title)
                (declare (ignore form))
                (when (string-equal button "submit")
                  (funcall on-save title))
                (modal-hide modal))))


(defun make-task-add-form (crud-widget modal)
  "Returns the form shown in the modal when the Add button is pressed."
  (declare (ignore crud-widget))
  (make-tasks-form modal ""
                   :on-save #'add-demo-task))


(defun make-task-edit-form (modal task)
  "Returns the form shown in the modal when the row's Edit button is pressed."
  (make-tasks-form modal
                   (demo-task-title task)
                   :on-save (lambda (title)
                              (setf (demo-task-title task)
                                    title))))


(defwidget crud-page (ui-widget)
  ((crud :initarg :crud
         :reader page-crud)))


(defun make-crud-page ()
  (reset-demo-tasks)
  (make-instance 'crud-page
                 :crud (make-crud-table
                        (list (column "Title"
                                      :getter #'demo-task-title))
                        (lambda (&rest args)
                          (declare (ignore args))
                          (values (copy-list *demo-tasks*)))
                        :add-form-maker #'make-task-add-form
                        :edit-form-maker #'make-task-edit-form
                        :on-delete #'delete-demo-task
                        :delete-question (lambda (task)
                                           (fmt "Delete \"~A\"?"
                                                (demo-task-title task)))
                        :edit-header (html ("Task editing"))
                        :delete-header (html ("Task deletion"))
                        :add-header (html ("New task")))))


(defmethod render ((widget crud-page) (theme t))
  (with-html ()
    (:h2 :class "text-xl my-4"
         "CRUD table")
    (:p :class "text-slate-500 my-4"
        "Create, edit and delete tasks. All data is kept in an in-memory list, "
        "no database is involved.")
    (render (page-crud widget)
            theme)))
