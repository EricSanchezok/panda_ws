
(cl:in-package :asdf)

(defsystem "panda_arm_control-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :trajectory_msgs-msg
)
  :components ((:file "_package")
    (:file "effector_control_param" :depends-on ("_package_effector_control_param"))
    (:file "_package_effector_control_param" :depends-on ("_package"))
  ))