(uiop:define-package #:reblocks-ui2-demo/app
  (:use #:cl)
  (:import-from #:reblocks-navigation-widget
                #:defroutes)
  (:import-from #:reblocks/app
                #:defapp)
  (:import-from #:reblocks/page
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
                #:make-text-input-page))
(in-package #:reblocks-ui2-demo/app)


(defapp app
  :prefix "/reblocks-ui2")


(defroutes routes
    ("/reblocks-ui2/text-input" (wrap-with-frame
                                 (make-text-input-page)))
  ("/reblocks-ui2/containers" (wrap-with-frame
                                 (make-containers-page)))
  ("/reblocks-ui2" (wrap-with-frame
                    (make-buttons-page))))


(defmethod init-page ((app app) url-path expire-at)
  (make-routes))


;; TODO: I need to do something with routing and it's dependency on reblocks-ui and Foundation.js
(defmethod reblocks/dependencies:get-dependencies ((widget routes))
  ;; To prevent Foundation dependencies appear on the page
  ;; we replace them with Tailwind
  nil)


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

