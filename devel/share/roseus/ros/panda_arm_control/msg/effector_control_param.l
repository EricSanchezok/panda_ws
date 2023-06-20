;; Auto-generated. Do not edit!


(when (boundp 'panda_arm_control::effector_control_param)
  (if (not (find-package "PANDA_ARM_CONTROL"))
    (make-package "PANDA_ARM_CONTROL"))
  (shadow 'effector_control_param (find-package "PANDA_ARM_CONTROL")))
(unless (find-package "PANDA_ARM_CONTROL::EFFECTOR_CONTROL_PARAM")
  (make-package "PANDA_ARM_CONTROL::EFFECTOR_CONTROL_PARAM"))

(in-package "ROS")
;;//! \htmlinclude effector_control_param.msg.html


(defclass panda_arm_control::effector_control_param
  :super ros::object
  :slots (_type _x0 _y0 _z0 _x _y _z _w ))

(defmethod panda_arm_control::effector_control_param
  (:init
   (&key
    ((:type __type) "")
    ((:x0 __x0) 0.0)
    ((:y0 __y0) 0.0)
    ((:z0 __z0) 0.0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    ((:w __w) 0.0)
    )
   (send-super :init)
   (setq _type (string __type))
   (setq _x0 (float __x0))
   (setq _y0 (float __y0))
   (setq _z0 (float __z0))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
   (setq _w (float __w))
   self)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:x0
   (&optional __x0)
   (if __x0 (setq _x0 __x0)) _x0)
  (:y0
   (&optional __y0)
   (if __y0 (setq _y0 __y0)) _y0)
  (:z0
   (&optional __z0)
   (if __z0 (setq _z0 __z0)) _z0)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:w
   (&optional __w)
   (if __w (setq _w __w)) _w)
  (:serialization-length
   ()
   (+
    ;; string _type
    4 (length _type)
    ;; float32 _x0
    4
    ;; float32 _y0
    4
    ;; float32 _z0
    4
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _z
    4
    ;; float32 _w
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; float32 _x0
       (sys::poke _x0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y0
       (sys::poke _y0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z0
       (sys::poke _z0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z
       (sys::poke _z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _w
       (sys::poke _w (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _x0
     (setq _x0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y0
     (setq _y0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z0
     (setq _z0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z
     (setq _z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _w
     (setq _w (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get panda_arm_control::effector_control_param :md5sum-) "67ada03f2ea0b0c7f0ae00ddfff182e8")
(setf (get panda_arm_control::effector_control_param :datatype-) "panda_arm_control/effector_control_param")
(setf (get panda_arm_control::effector_control_param :definition-)
      "string type
float32 x0
float32 y0
float32 z0
float32 x
float32 y
float32 z
float32 w
")



(provide :panda_arm_control/effector_control_param "67ada03f2ea0b0c7f0ae00ddfff182e8")


