;; Auto-generated. Do not edit!


(when (boundp 'hand_roscv::control_srv)
  (if (not (find-package "HAND_ROSCV"))
    (make-package "HAND_ROSCV"))
  (shadow 'control_srv (find-package "HAND_ROSCV")))
(unless (find-package "HAND_ROSCV::CONTROL_SRV")
  (make-package "HAND_ROSCV::CONTROL_SRV"))
(unless (find-package "HAND_ROSCV::CONTROL_SRVREQUEST")
  (make-package "HAND_ROSCV::CONTROL_SRVREQUEST"))
(unless (find-package "HAND_ROSCV::CONTROL_SRVRESPONSE")
  (make-package "HAND_ROSCV::CONTROL_SRVRESPONSE"))

(in-package "ROS")





(defclass hand_roscv::control_srvRequest
  :super ros::object
  :slots (_request_num ))

(defmethod hand_roscv::control_srvRequest
  (:init
   (&key
    ((:request_num __request_num) 0)
    )
   (send-super :init)
   (setq _request_num (round __request_num))
   self)
  (:request_num
   (&optional __request_num)
   (if __request_num (setq _request_num __request_num)) _request_num)
  (:serialization-length
   ()
   (+
    ;; int32 _request_num
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _request_num
       (write-long _request_num s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _request_num
     (setq _request_num (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass hand_roscv::control_srvResponse
  :super ros::object
  :slots (_task _vector0 _vector1 _vector2 ))

(defmethod hand_roscv::control_srvResponse
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

(defclass hand_roscv::control_srv
  :super ros::object
  :slots ())

(setf (get hand_roscv::control_srv :md5sum-) "983bd86bd8f878d29cc8c58c940fb25f")
(setf (get hand_roscv::control_srv :datatype-) "hand_roscv/control_srv")
(setf (get hand_roscv::control_srv :request) hand_roscv::control_srvRequest)
(setf (get hand_roscv::control_srv :response) hand_roscv::control_srvResponse)

(defmethod hand_roscv::control_srvRequest
  (:response () (instance hand_roscv::control_srvResponse :init)))

(setf (get hand_roscv::control_srvRequest :md5sum-) "983bd86bd8f878d29cc8c58c940fb25f")
(setf (get hand_roscv::control_srvRequest :datatype-) "hand_roscv/control_srvRequest")
(setf (get hand_roscv::control_srvRequest :definition-)
      "# 客户端请求时发送的一个数字
int32 request_num
---
# 服务器响应发送的数据
string task
float32 vector0
float32 vector1
float32 vector2

")

(setf (get hand_roscv::control_srvResponse :md5sum-) "983bd86bd8f878d29cc8c58c940fb25f")
(setf (get hand_roscv::control_srvResponse :datatype-) "hand_roscv/control_srvResponse")
(setf (get hand_roscv::control_srvResponse :definition-)
      "# 客户端请求时发送的一个数字
int32 request_num
---
# 服务器响应发送的数据
string task
float32 vector0
float32 vector1
float32 vector2

")



(provide :hand_roscv/control_srv "983bd86bd8f878d29cc8c58c940fb25f")


