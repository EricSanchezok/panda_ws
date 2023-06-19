; Auto-generated. Do not edit!


(cl:in-package hand_roscv-srv)


;//! \htmlinclude control_srv-request.msg.html

(cl:defclass <control_srv-request> (roslisp-msg-protocol:ros-message)
  ((request_num
    :reader request_num
    :initarg :request_num
    :type cl:integer
    :initform 0))
)

(cl:defclass control_srv-request (<control_srv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <control_srv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'control_srv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hand_roscv-srv:<control_srv-request> is deprecated: use hand_roscv-srv:control_srv-request instead.")))

(cl:ensure-generic-function 'request_num-val :lambda-list '(m))
(cl:defmethod request_num-val ((m <control_srv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hand_roscv-srv:request_num-val is deprecated.  Use hand_roscv-srv:request_num instead.")
  (request_num m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <control_srv-request>) ostream)
  "Serializes a message object of type '<control_srv-request>"
  (cl:let* ((signed (cl:slot-value msg 'request_num)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <control_srv-request>) istream)
  "Deserializes a message object of type '<control_srv-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'request_num) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<control_srv-request>)))
  "Returns string type for a service object of type '<control_srv-request>"
  "hand_roscv/control_srvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'control_srv-request)))
  "Returns string type for a service object of type 'control_srv-request"
  "hand_roscv/control_srvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<control_srv-request>)))
  "Returns md5sum for a message object of type '<control_srv-request>"
  "983bd86bd8f878d29cc8c58c940fb25f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'control_srv-request)))
  "Returns md5sum for a message object of type 'control_srv-request"
  "983bd86bd8f878d29cc8c58c940fb25f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<control_srv-request>)))
  "Returns full string definition for message of type '<control_srv-request>"
  (cl:format cl:nil "# 客户端请求时发送的一个数字~%int32 request_num~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'control_srv-request)))
  "Returns full string definition for message of type 'control_srv-request"
  (cl:format cl:nil "# 客户端请求时发送的一个数字~%int32 request_num~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <control_srv-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <control_srv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'control_srv-request
    (cl:cons ':request_num (request_num msg))
))
;//! \htmlinclude control_srv-response.msg.html

(cl:defclass <control_srv-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass control_srv-response (<control_srv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <control_srv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'control_srv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hand_roscv-srv:<control_srv-response> is deprecated: use hand_roscv-srv:control_srv-response instead.")))

(cl:ensure-generic-function 'task-val :lambda-list '(m))
(cl:defmethod task-val ((m <control_srv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hand_roscv-srv:task-val is deprecated.  Use hand_roscv-srv:task instead.")
  (task m))

(cl:ensure-generic-function 'vector0-val :lambda-list '(m))
(cl:defmethod vector0-val ((m <control_srv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hand_roscv-srv:vector0-val is deprecated.  Use hand_roscv-srv:vector0 instead.")
  (vector0 m))

(cl:ensure-generic-function 'vector1-val :lambda-list '(m))
(cl:defmethod vector1-val ((m <control_srv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hand_roscv-srv:vector1-val is deprecated.  Use hand_roscv-srv:vector1 instead.")
  (vector1 m))

(cl:ensure-generic-function 'vector2-val :lambda-list '(m))
(cl:defmethod vector2-val ((m <control_srv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hand_roscv-srv:vector2-val is deprecated.  Use hand_roscv-srv:vector2 instead.")
  (vector2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <control_srv-response>) ostream)
  "Serializes a message object of type '<control_srv-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <control_srv-response>) istream)
  "Deserializes a message object of type '<control_srv-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<control_srv-response>)))
  "Returns string type for a service object of type '<control_srv-response>"
  "hand_roscv/control_srvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'control_srv-response)))
  "Returns string type for a service object of type 'control_srv-response"
  "hand_roscv/control_srvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<control_srv-response>)))
  "Returns md5sum for a message object of type '<control_srv-response>"
  "983bd86bd8f878d29cc8c58c940fb25f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'control_srv-response)))
  "Returns md5sum for a message object of type 'control_srv-response"
  "983bd86bd8f878d29cc8c58c940fb25f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<control_srv-response>)))
  "Returns full string definition for message of type '<control_srv-response>"
  (cl:format cl:nil "# 服务器响应发送的数据~%string task~%float32 vector0~%float32 vector1~%float32 vector2~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'control_srv-response)))
  "Returns full string definition for message of type 'control_srv-response"
  (cl:format cl:nil "# 服务器响应发送的数据~%string task~%float32 vector0~%float32 vector1~%float32 vector2~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <control_srv-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'task))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <control_srv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'control_srv-response
    (cl:cons ':task (task msg))
    (cl:cons ':vector0 (vector0 msg))
    (cl:cons ':vector1 (vector1 msg))
    (cl:cons ':vector2 (vector2 msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'control_srv)))
  'control_srv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'control_srv)))
  'control_srv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'control_srv)))
  "Returns string type for a service object of type '<control_srv>"
  "hand_roscv/control_srv")