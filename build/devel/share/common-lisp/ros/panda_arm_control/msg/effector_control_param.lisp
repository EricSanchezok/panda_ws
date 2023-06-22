; Auto-generated. Do not edit!


(cl:in-package panda_arm_control-msg)


;//! \htmlinclude effector_control_param.msg.html

(cl:defclass <effector_control_param> (roslisp-msg-protocol:ros-message)
  ((work_mode
    :reader work_mode
    :initarg :work_mode
    :type cl:string
    :initform "")
   (supplement
    :reader supplement
    :initarg :supplement
    :type cl:string
    :initform "")
   (x0
    :reader x0
    :initarg :x0
    :type cl:float
    :initform 0.0)
   (y0
    :reader y0
    :initarg :y0
    :type cl:float
    :initform 0.0)
   (z0
    :reader z0
    :initarg :z0
    :type cl:float
    :initform 0.0)
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (z
    :reader z
    :initarg :z
    :type cl:float
    :initform 0.0)
   (w
    :reader w
    :initarg :w
    :type cl:float
    :initform 0.0))
)

(cl:defclass effector_control_param (<effector_control_param>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <effector_control_param>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'effector_control_param)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name panda_arm_control-msg:<effector_control_param> is deprecated: use panda_arm_control-msg:effector_control_param instead.")))

(cl:ensure-generic-function 'work_mode-val :lambda-list '(m))
(cl:defmethod work_mode-val ((m <effector_control_param>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_arm_control-msg:work_mode-val is deprecated.  Use panda_arm_control-msg:work_mode instead.")
  (work_mode m))

(cl:ensure-generic-function 'supplement-val :lambda-list '(m))
(cl:defmethod supplement-val ((m <effector_control_param>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_arm_control-msg:supplement-val is deprecated.  Use panda_arm_control-msg:supplement instead.")
  (supplement m))

(cl:ensure-generic-function 'x0-val :lambda-list '(m))
(cl:defmethod x0-val ((m <effector_control_param>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_arm_control-msg:x0-val is deprecated.  Use panda_arm_control-msg:x0 instead.")
  (x0 m))

(cl:ensure-generic-function 'y0-val :lambda-list '(m))
(cl:defmethod y0-val ((m <effector_control_param>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_arm_control-msg:y0-val is deprecated.  Use panda_arm_control-msg:y0 instead.")
  (y0 m))

(cl:ensure-generic-function 'z0-val :lambda-list '(m))
(cl:defmethod z0-val ((m <effector_control_param>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_arm_control-msg:z0-val is deprecated.  Use panda_arm_control-msg:z0 instead.")
  (z0 m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <effector_control_param>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_arm_control-msg:x-val is deprecated.  Use panda_arm_control-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <effector_control_param>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_arm_control-msg:y-val is deprecated.  Use panda_arm_control-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'z-val :lambda-list '(m))
(cl:defmethod z-val ((m <effector_control_param>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_arm_control-msg:z-val is deprecated.  Use panda_arm_control-msg:z instead.")
  (z m))

(cl:ensure-generic-function 'w-val :lambda-list '(m))
(cl:defmethod w-val ((m <effector_control_param>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_arm_control-msg:w-val is deprecated.  Use panda_arm_control-msg:w instead.")
  (w m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <effector_control_param>) ostream)
  "Serializes a message object of type '<effector_control_param>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'work_mode))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'work_mode))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'supplement))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'supplement))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'w))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <effector_control_param>) istream)
  "Deserializes a message object of type '<effector_control_param>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'work_mode) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'work_mode) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'supplement) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'supplement) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x0) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y0) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z0) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'w) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<effector_control_param>)))
  "Returns string type for a message object of type '<effector_control_param>"
  "panda_arm_control/effector_control_param")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'effector_control_param)))
  "Returns string type for a message object of type 'effector_control_param"
  "panda_arm_control/effector_control_param")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<effector_control_param>)))
  "Returns md5sum for a message object of type '<effector_control_param>"
  "3d06e5bea688509f1828a02e984cfc20")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'effector_control_param)))
  "Returns md5sum for a message object of type 'effector_control_param"
  "3d06e5bea688509f1828a02e984cfc20")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<effector_control_param>)))
  "Returns full string definition for message of type '<effector_control_param>"
  (cl:format cl:nil "string work_mode~%string supplement~%float32 x0~%float32 y0~%float32 z0~%float32 x~%float32 y~%float32 z~%float32 w~%#moveit_msgs/RobotTrajectory path~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'effector_control_param)))
  "Returns full string definition for message of type 'effector_control_param"
  (cl:format cl:nil "string work_mode~%string supplement~%float32 x0~%float32 y0~%float32 z0~%float32 x~%float32 y~%float32 z~%float32 w~%#moveit_msgs/RobotTrajectory path~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <effector_control_param>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'work_mode))
     4 (cl:length (cl:slot-value msg 'supplement))
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <effector_control_param>))
  "Converts a ROS message object to a list"
  (cl:list 'effector_control_param
    (cl:cons ':work_mode (work_mode msg))
    (cl:cons ':supplement (supplement msg))
    (cl:cons ':x0 (x0 msg))
    (cl:cons ':y0 (y0 msg))
    (cl:cons ':z0 (z0 msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':z (z msg))
    (cl:cons ':w (w msg))
))
