(uiop:define-package #:reblocks-ui2-demo/main
  (:use #:cl)
  (:import-from #:defmain
                #:defmain)
  (:import-from #:reblocks-ui2-demo/server
                #:start)
  (:import-from #:40ants-slynk
                #:start-slynk-if-needed))
(in-package #:reblocks-ui2-demo/main)


(defmain (main) ((debug "If given, then application will be started in debug mode."
                        :flag t)
                 (port "HTTP port to listen on."
                       :default 8080
                       :env-var "PORT")
                 (interface "Network interface to listen on."
                            :default "localhost"
                            :env-var "INTERFACE")
                 (wait-ide "Start slynk server and wait for IDE connection before starting the main server. Useful for debugging failures on server start."
                           :flag t))
  
  (start-slynk-if-needed)

  (when wait-ide
    (loop while (null 40ants-slynk:*connections*)
          do (format nil "Waiting for SLY connection...~%")
             (sleep 1) ))
  
  (start :port port
         :interface interface
         :debug debug)

  (loop do (format nil "Server is running...~%")
           (sleep 10)))
