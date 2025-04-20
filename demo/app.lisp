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
                #:make-tabs-page))
(in-package #:reblocks-ui2-demo/app)


(macrolet ((route ((path &key name) &body body)
             `(40ants-routes/defroutes:get (,path :name ,name)
                (wrap-with-frame
                 ,@body))))
  (defapp app
    :prefix "/reblocks-ui2"
    :routes ((route ("/form" :name "form")
                    (make-form-page))
             (route ("/card" :name "card")
                    (make-cards-page))
             (route ("/text-input" :name "text-input")
                    (make-text-input-page))
             (route ("/containers" :name "containers")
                    (make-containers-page))
             (route ("/button" :name "button")
                    (make-buttons-page))
             (route ("/tabs" :name "tabs")
                    (make-tabs-page))
             (route ("/" :name "index")
                    (make-landing-page)))))


;; (defmethod init-page ((app app) url-path expire-at)
;;   (make-routes))


(defmethod body-classes ((app app))
  (join-css-classes *current-theme*
                    (colors-bg-normal *current-theme*))
  ;; "bg-white dark:bg-stone-950"
  )


;; TODO: I need to do something with routing and it's dependency on reblocks-ui and Foundation.js
;; (defmethod reblocks/dependencies:get-dependencies ((widget routes))
;;   ;; To prevent Foundation dependencies appear on the page
;;   ;; we replace them with Tailwind
;;   nil)


;; (defmethod reblocks/dependencies:get-dependencies ((app app))
;;   "Whole application stylesheet"
;;   (list*
;;    ;; (make-dependency
;;    ;;   "https://cdn.tailwindcss.com/3.3.5"
;;    ;;   ;; "https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"
;;    ;;   :type :js)
;;    ;; (make-dependency
;;    ;;   "https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"
;;    ;;   :type :js
;;    ;;   :defer t)
;;    (call-next-method)))

