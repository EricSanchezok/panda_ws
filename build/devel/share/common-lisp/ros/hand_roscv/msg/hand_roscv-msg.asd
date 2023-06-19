
(cl:in-package :asdf)

(defsystem "hand_roscv-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "control_msg" :depends-on ("_package_control_msg"))
    (:file "_package_control_msg" :depends-on ("_package"))
  ))