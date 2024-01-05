(uiop:define-package #:reblocks-ui2-demo/server
  (:use #:cl)
  (:import-from #:reblocks/server)
  (:import-from #:reblocks/debug)
  (:import-from #:reblocks/variables)
  (:import-from #:40ants-logging)
  (:import-from #:40ants-slynk)
  (:import-from #:reblocks-ui2-demo/app
                #:app)
  (:import-from #:reblocks-ui2/themes/api
                #:*current-theme*)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:make-tailwind-theme)
  (:shadow #:restart)
  (:export #:start
           #:restart
           #:stop))
(in-package #:reblocks-ui2-demo/server)


(defparameter *default-port* "8080")
(defparameter *default-interface* "localhost")

(defvar *arguments* nil
  "Here we remember arguments given to START to apply them when restarting the server.")


(defun start (&rest args
              &key
                (port (parse-integer
                       (or (uiop:getenv "PORT")
                           *default-port*)))
	        (interface *default-interface*)
                (debug nil))
  "This function does not block and can be started in REPL."
  
  (when (probe-file ".local-config.lisp")
    (load (probe-file ".local-config.lisp")))
  
  ;; Just to suppres debug logs to TTY from Reblocks.
  ;; I'll need to fix Reblocks to prohibit it from
  ;; configure logging if they are already configured.
  (40ants-logging:setup-for-backend :level (if debug
                                               :debug
                                               :warn))
  (40ants-slynk:start-slynk-if-needed)
  
  (setf reblocks/variables:*pages-expire-in* (* 10 60))
  (setf reblocks/variables:*max-pages-per-session* 10)

  (setf *current-theme*
        (make-tailwind-theme))

  (reblocks/server:start :port port
			 :interface interface
                         :apps 'app
                         :server-type :hunchentoot
                         :debug debug)

  (log:info "Server started")
  (setf *arguments* args)
  ;; To suppress debugger on missing actions
  (setf reblocks/variables:*ignore-missing-actions* t)
  (values))


(defun start-server-in-production ()
  ;; Entry point for webapp, started in the Docker
  (start :port (parse-integer (or (uiop:getenv "APP_PORT")
                                  *default-port*))
	 :interface (or (uiop:getenv "APP_INTERFACE")
                        *default-interface*))
  (loop do (sleep 5)))


(defun stop ()
  (reblocks/server:stop (getf *arguments* :interface)
                        (getf *arguments* :port))
  (values))


(defun restart (&key (reset-latest-session t))
  (stop)
  (apply #'start *arguments*)
  (when (and reset-latest-session
             (reblocks/debug:status))
    (with-simple-restart (ignore "Ignore and continue")
      (reblocks/debug:reset-latest-session)))
  (values))
