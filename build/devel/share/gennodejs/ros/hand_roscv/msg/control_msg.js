// Auto-generated. Do not edit!

// (in-package hand_roscv.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class control_msg {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.task = null;
      this.vector0 = null;
      this.vector1 = null;
      this.vector2 = null;
    }
    else {
      if (initObj.hasOwnProperty('task')) {
        this.task = initObj.task
      }
      else {
        this.task = '';
      }
      if (initObj.hasOwnProperty('vector0')) {
        this.vector0 = initObj.vector0
      }
      else {
        this.vector0 = 0.0;
      }
      if (initObj.hasOwnProperty('vector1')) {
        this.vector1 = initObj.vector1
      }
      else {
        this.vector1 = 0.0;
      }
      if (initObj.hasOwnProperty('vector2')) {
        this.vector2 = initObj.vector2
      }
      else {
        this.vector2 = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type control_msg
    // Serialize message field [task]
    bufferOffset = _serializer.string(obj.task, buffer, bufferOffset);
    // Serialize message field [vector0]
    bufferOffset = _serializer.float32(obj.vector0, buffer, bufferOffset);
    // Serialize message field [vector1]
    bufferOffset = _serializer.float32(obj.vector1, buffer, bufferOffset);
    // Serialize message field [vector2]
    bufferOffset = _serializer.float32(obj.vector2, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type control_msg
    let len;
    let data = new control_msg(null);
    // Deserialize message field [task]
    data.task = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [vector0]
    data.vector0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vector1]
    data.vector1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vector2]
    data.vector2 = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.task);
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'hand_roscv/control_msg';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fb1c130019d7a0db5a1c68e6639b601b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string task
    float32 vector0
    float32 vector1
    float32 vector2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new control_msg(null);
    if (msg.task !== undefined) {
      resolved.task = msg.task;
    }
    else {
      resolved.task = ''
    }

    if (msg.vector0 !== undefined) {
      resolved.vector0 = msg.vector0;
    }
    else {
      resolved.vector0 = 0.0
    }

    if (msg.vector1 !== undefined) {
      resolved.vector1 = msg.vector1;
    }
    else {
      resolved.vector1 = 0.0
    }

    if (msg.vector2 !== undefined) {
      resolved.vector2 = msg.vector2;
    }
    else {
      resolved.vector2 = 0.0
    }

    return resolved;
    }
};

module.exports = control_msg;
