(uiop:define-package #:reblocks-ui2-demo/app
  (:use #:cl)
  (:import-from #:reblocks-navigation-widget
                #:defroutes)
  (:import-from #:reblocks/app
                #:defapp)
  (:import-from #:reblocks/page
                #:body-classes
                #:init-page)
  (:import-from #:reblocks-ui2-demo/pages/frame
                #:wrap-with-frame)
  (:import-from #:reblocks/dependencies
                #:make-dependency)
  (:import-from #:reblocks-ui2-demo/pages/buttons
                #:make-buttons-page)
  (:import-from #:reblocks-ui2-demo/pages/containers
                #:make-containers-page)
  (:import-from #:reblocks-ui2-demo/pages/text-input
                #:make-text-input-page)
  (:import-from #:reblocks-ui2-demo/pages/form
                #:make-form-page)
  (:import-from #:reblocks-ui2-demo/pages/cards
                #:make-cards-page)
  (:import-from #:reblocks-ui2-demo/pages/landing
                #:make-landing-page)
  (:import-from #:reblocks-ui2/themes/api
                #:*current-theme*)
  (:import-from #:reblocks-ui2/themes/tailwind
                #:colors-bg-normal)
  (:import-from #:reblocks-ui2/themes/styling
                #:join-css-classes)
  (:import-from #:reblocks-ui2-demo/pages/tabs
                #:make-tabs-page)
  (:import-from #:reblocks-prometheus
                #:prometheus-app-mixin)
  (:import-from #:reblocks-prometheus/app
                #:metrics)
  (:import-from #:serapeum
                #:eval-always)
  (:import-from #:reblocks-file-server
                #:file-server)
  (:import-from #:reblocks/routes
                #:page)
  (:shadowing-import-from #:40ants-routes/defroutes
                          #:get))
(in-package #:reblocks-ui2-demo/app)


(eval-always
  (defvar *load-average*
    (prometheus:make-gauge :name "test_load_average"
                           :help "Test load average"
                           :registry nil))

  (defvar *num-users*
    (prometheus:make-counter :name "test_num_users_created"
                             :help "Test num users created after the last metrics collection"
                             :registry nil))

  (defvar *user-metrics*
    (list *load-average*
          *num-users*)))


(defapp app
  :prefix "/"
  :page-constructor #'wrap-with-frame
  :routes ((page ("/form" :name "form")
             (make-form-page))
           (page ("/card" :name "card")
             (make-cards-page))
           (page ("/text-input" :name "text-input")
             (make-text-input-page))
           (page ("/containers" :name "containers")
             (make-containers-page))
           (page ("/button" :name "button")
             (make-buttons-page))
           (page ("/tabs" :name "tabs")
             (make-tabs-page))
           (page ("/" :name "index")
             (make-landing-page))
           ;; Prometheus metrics
           (metrics ("/metrics" :user-metrics *user-metrics*))
           
           ;; Sources
           ;; (file-server "/sources/"
           ;;              :name "sources"
           ;;              :root (asdf:system-relative-pathname :reblocks-ui2-demo
           ;;                                                   (make-pathname :directory '(:relative "demo")))
           ;;              :filter "(\\.lisp|\\.asd)$")
           
           ;; Static files
           (reblocks/routes:static-file "/favicon.ico"
             (asdf:system-relative-pathname :reblocks-ui2-demo "demo/favicons/favicon.ico")
             :content-type "image/x-icon")

           ;; Alternative way
           ;; (get ("/favicon.ico")
           ;;   (list 200
           ;;         (list :content-type "image/x-icon")
           ;;         (asdf:system-relative-pathname :reblocks-ui2-demo "demo/favicons/favicon.ico")))
           
           (get ("/robots.txt")
             "User-agent: *")))


(defmethod body-classes ((app app))
  (join-css-classes *current-theme*
                    (colors-bg-normal *current-theme*)))


(defmethod reblocks/server:handle-http-request :around ((server t) env)
  (let ((request-id (princ-to-string
                     (uuid:make-v4-uuid))))
    (reblocks/response:add-header :x-request-id
                                  request-id)
    (log4cl-extras/context:with-fields (:request-id request-id)
      (call-next-method))))
