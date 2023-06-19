; Auto-generated. Do not edit!


(cl:in-package hand_roscv-msg)


;//! \htmlinclude control_msg.msg.html

(cl:defclass <control_msg> (roslisp-msg-protocol:ros-message)
  ((task
    :reader task
    :initarg :task
    :type cl:string
    :initform "")
   (vector0
    :reader vector0
    :initarg :vector0
    :type cl:float
    :initform 0.0)
   (vector1
    :reader vector1
    :initarg :vector1
    :type cl:float
    :initform 0.0)
   (vector2
    :reader vector2
    :initarg :vector2
    :type cl:float
    :initform 0.0))
)

(cl:defclass control_msg (<control_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <control_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'control_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hand_roscv-msg:<control_msg> is deprecated: use hand_roscv-msg:control_msg instead.")))

(cl:ensure-generic-function 'task-val :lambda-list '(m))
(cl:defmethod task-val ((m <control_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hand_roscv-msg:task-val is deprecated.  Use hand_roscv-msg:task instead.")
  (task m))

(cl:ensure-generic-function 'vector0-val :lambda-list '(m))
(cl:defmethod vector0-val ((m <control_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hand_roscv-msg:vector0-val is deprecated.  Use hand_roscv-msg:vector0 instead.")
  (vector0 m))

(cl:ensure-generic-function 'vector1-val :lambda-list '(m))
(cl:defmethod vector1-val ((m <control_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hand_roscv-msg:vector1-val is deprecated.  Use hand_roscv-msg:vector1 instead.")
  (vector1 m))

(cl:ensure-generic-function 'vector2-val :lambda-list '(m))
(cl:defmethod vector2-val ((m <control_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hand_roscv-msg:vector2-val is deprecated.  Use hand_roscv-msg:vector2 instead.")
  (vector2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <control_msg>) ostream)
  "Serializes a message object of type '<control_msg>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'task))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'task))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vector0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vector1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vector2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <control_msg>) istream)
  "Deserializes a message object of type '<control_msg>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'task) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'task) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vector0) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vector1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vector2) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<control_msg>)))
  "Returns string type for a message object of type '<control_msg>"
  "hand_roscv/control_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'control_msg)))
  "Returns string type for a message object of type 'control_msg"
  "hand_roscv/control_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<control_msg>)))
  "Returns md5sum for a message object of type '<control_msg>"
  "fb1c130019d7a0db5a1c68e6639b601b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'control_msg)))
  "Returns md5sum for a message object of type 'control_msg"
  "fb1c130019d7a0db5a1c68e6639b601b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<control_msg>)))
  "Returns full string definition for message of type '<control_msg>"
  (cl:format cl:nil "string task~%float32 vector0~%float32 vector1~%float32 vector2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'control_msg)))
  "Returns full string definition for message of type 'control_msg"
  (cl:format cl:nil "string task~%float32 vector0~%float32 vector1~%float32 vector2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <control_msg>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'task))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <control_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'control_msg
    (cl:cons ':task (task msg))
    (cl:cons ':vector0 (vector0 msg))
    (cl:cons ':vector1 (vector1 msg))
    (cl:cons ':vector2 (vector2 msg))
))
