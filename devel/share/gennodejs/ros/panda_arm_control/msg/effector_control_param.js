// Auto-generated. Do not edit!

// (in-package panda_arm_control.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let trajectory_msgs = _finder('trajectory_msgs');

//-----------------------------------------------------------

class effector_control_param {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.work_mode = null;
      this.supplement = null;
      this.x0 = null;
      this.y0 = null;
      this.z0 = null;
      this.x = null;
      this.y = null;
      this.z = null;
      this.w = null;
      this.traj = null;
    }
    else {
      if (initObj.hasOwnProperty('work_mode')) {
        this.work_mode = initObj.work_mode
      }
      else {
        this.work_mode = '';
      }
      if (initObj.hasOwnProperty('supplement')) {
        this.supplement = initObj.supplement
      }
      else {
        this.supplement = '';
      }
      if (initObj.hasOwnProperty('x0')) {
        this.x0 = initObj.x0
      }
      else {
        this.x0 = 0.0;
      }
      if (initObj.hasOwnProperty('y0')) {
        this.y0 = initObj.y0
      }
      else {
        this.y0 = 0.0;
      }
      if (initObj.hasOwnProperty('z0')) {
        this.z0 = initObj.z0
      }
      else {
        this.z0 = 0.0;
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = 0.0;
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = 0.0;
      }
      if (initObj.hasOwnProperty('z')) {
        this.z = initObj.z
      }
      else {
        this.z = 0.0;
      }
      if (initObj.hasOwnProperty('w')) {
        this.w = initObj.w
      }
      else {
        this.w = 0.0;
      }
      if (initObj.hasOwnProperty('traj')) {
        this.traj = initObj.traj
      }
      else {
        this.traj = new trajectory_msgs.msg.JointTrajectory();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type effector_control_param
    // Serialize message field [work_mode]
    bufferOffset = _serializer.string(obj.work_mode, buffer, bufferOffset);
    // Serialize message field [supplement]
    bufferOffset = _serializer.string(obj.supplement, buffer, bufferOffset);
    // Serialize message field [x0]
    bufferOffset = _serializer.float32(obj.x0, buffer, bufferOffset);
    // Serialize message field [y0]
    bufferOffset = _serializer.float32(obj.y0, buffer, bufferOffset);
    // Serialize message field [z0]
    bufferOffset = _serializer.float32(obj.z0, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.float32(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.float32(obj.y, buffer, bufferOffset);
    // Serialize message field [z]
    bufferOffset = _serializer.float32(obj.z, buffer, bufferOffset);
    // Serialize message field [w]
    bufferOffset = _serializer.float32(obj.w, buffer, bufferOffset);
    // Serialize message field [traj]
    bufferOffset = trajectory_msgs.msg.JointTrajectory.serialize(obj.traj, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type effector_control_param
    let len;
    let data = new effector_control_param(null);
    // Deserialize message field [work_mode]
    data.work_mode = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [supplement]
    data.supplement = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [x0]
    data.x0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y0]
    data.y0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [z0]
    data.z0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [z]
    data.z = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [w]
    data.w = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [traj]
    data.traj = trajectory_msgs.msg.JointTrajectory.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.work_mode);
    length += _getByteLength(object.supplement);
    length += trajectory_msgs.msg.JointTrajectory.getMessageSize(object.traj);
    return length + 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'panda_arm_control/effector_control_param';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5215bcd504493e63651b35034e0fe1c3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string work_mode
    string supplement
    float32 x0
    float32 y0
    float32 z0
    float32 x
    float32 y
    float32 z
    float32 w
    trajectory_msgs/JointTrajectory traj
    ================================================================================
    MSG: trajectory_msgs/JointTrajectory
    Header header
    string[] joint_names
    JointTrajectoryPoint[] points
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: trajectory_msgs/JointTrajectoryPoint
    # Each trajectory point specifies either positions[, velocities[, accelerations]]
    # or positions[, effort] for the trajectory to be executed.
    # All specified values are in the same order as the joint names in JointTrajectory.msg
    
    float64[] positions
    float64[] velocities
    float64[] accelerations
    float64[] effort
    duration time_from_start
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new effector_control_param(null);
    if (msg.work_mode !== undefined) {
      resolved.work_mode = msg.work_mode;
    }
    else {
      resolved.work_mode = ''
    }

    if (msg.supplement !== undefined) {
      resolved.supplement = msg.supplement;
    }
    else {
      resolved.supplement = ''
    }

    if (msg.x0 !== undefined) {
      resolved.x0 = msg.x0;
    }
    else {
      resolved.x0 = 0.0
    }

    if (msg.y0 !== undefined) {
      resolved.y0 = msg.y0;
    }
    else {
      resolved.y0 = 0.0
    }

    if (msg.z0 !== undefined) {
      resolved.z0 = msg.z0;
    }
    else {
      resolved.z0 = 0.0
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = 0.0
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = 0.0
    }

    if (msg.z !== undefined) {
      resolved.z = msg.z;
    }
    else {
      resolved.z = 0.0
    }

    if (msg.w !== undefined) {
      resolved.w = msg.w;
    }
    else {
      resolved.w = 0.0
    }

    if (msg.traj !== undefined) {
      resolved.traj = trajectory_msgs.msg.JointTrajectory.Resolve(msg.traj)
    }
    else {
      resolved.traj = new trajectory_msgs.msg.JointTrajectory()
    }

    return resolved;
    }
};

module.exports = effector_control_param;
