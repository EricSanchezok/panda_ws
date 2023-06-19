// Auto-generated. Do not edit!

// (in-package hand_roscv.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class control_srvRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.request_num = null;
    }
    else {
      if (initObj.hasOwnProperty('request_num')) {
        this.request_num = initObj.request_num
      }
      else {
        this.request_num = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type control_srvRequest
    // Serialize message field [request_num]
    bufferOffset = _serializer.int32(obj.request_num, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type control_srvRequest
    let len;
    let data = new control_srvRequest(null);
    // Deserialize message field [request_num]
    data.request_num = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'hand_roscv/control_srvRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2cf9d0857e1d98b81acfb4ddb2a95d3a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 客户端请求时发送的一个数字
    int32 request_num
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new control_srvRequest(null);
    if (msg.request_num !== undefined) {
      resolved.request_num = msg.request_num;
    }
    else {
      resolved.request_num = 0
    }

    return resolved;
    }
};

class control_srvResponse {
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
    // Serializes a message object of type control_srvResponse
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
    //deserializes a message object of type control_srvResponse
    let len;
    let data = new control_srvResponse(null);
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
    // Returns string type for a service object
    return 'hand_roscv/control_srvResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fb1c130019d7a0db5a1c68e6639b601b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 服务器响应发送的数据
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
    const resolved = new control_srvResponse(null);
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

module.exports = {
  Request: control_srvRequest,
  Response: control_srvResponse,
  md5sum() { return '983bd86bd8f878d29cc8c58c940fb25f'; },
  datatype() { return 'hand_roscv/control_srv'; }
};
