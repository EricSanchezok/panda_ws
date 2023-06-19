
(cl:in-package :asdf)

(defsystem "hand_roscv-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "control_srv" :depends-on ("_package_control_srv"))
    (:file "_package_control_srv" :depends-on ("_package"))
  ))