;; Auto-generated. Do not edit!


(when (boundp 'hand_roscv::control_msg)
  (if (not (find-package "HAND_ROSCV"))
    (make-package "HAND_ROSCV"))
  (shadow 'control_msg (find-package "HAND_ROSCV")))
(unless (find-package "HAND_ROSCV::CONTROL_MSG")
  (make-package "HAND_ROSCV::CONTROL_MSG"))

(in-package "ROS")
;;//! \htmlinclude control_msg.msg.html


(defclass hand_roscv::control_msg
  :super ros::object
  :slots (_task _vector0 _vector1 _vector2 ))

(defmethod hand_roscv::control_msg
  (:init
   (&key
    ((:task __task) "")
    ((:vector0 __vector0) 0.0)
    ((:vector1 __vector1) 0.0)
    ((:vector2 __vector2) 0.0)
    )
   (send-super :init)
   (setq _task (string __task))
   (setq _vector0 (float __vector0))
   (setq _vector1 (float __vector1))
   (setq _vector2 (float __vector2))
   self)
  (:task
   (&optional __task)
   (if __task (setq _task __task)) _task)
  (:vector0
   (&optional __vector0)
   (if __vector0 (setq _vector0 __vector0)) _vector0)
  (:vector1
   (&optional __vector1)
   (if __vector1 (setq _vector1 __vector1)) _vector1)
  (:vector2
   (&optional __vector2)
   (if __vector2 (setq _vector2 __vector2)) _vector2)
  (:serialization-length
   ()
   (+
    ;; string _task
    4 (length _task)
    ;; float32 _vector0
    4
    ;; float32 _vector1
    4
    ;; float32 _vector2
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _task
       (write-long (length _task) s) (princ _task s)
     ;; float32 _vector0
       (sys::poke _vector0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vector1
       (sys::poke _vector1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vector2
       (sys::poke _vector2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _task
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _task (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _vector0
     (setq _vector0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vector1
     (setq _vector1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vector2
     (setq _vector2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get hand_roscv::control_msg :md5sum-) "fb1c130019d7a0db5a1c68e6639b601b")
(setf (get hand_roscv::control_msg :datatype-) "hand_roscv/control_msg")
(setf (get hand_roscv::control_msg :definition-)
      "string task
float32 vector0
float32 vector1
float32 vector2

")



(provide :hand_roscv/control_msg "fb1c130019d7a0db5a1c68e6639b601b")


