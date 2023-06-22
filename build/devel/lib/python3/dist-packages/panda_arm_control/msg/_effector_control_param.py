# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from panda_arm_control/effector_control_param.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class effector_control_param(genpy.Message):
  _md5sum = "3d06e5bea688509f1828a02e984cfc20"
  _type = "panda_arm_control/effector_control_param"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """string work_mode
string supplement
float32 x0
float32 y0
float32 z0
float32 x
float32 y
float32 z
float32 w
#moveit_msgs/RobotTrajectory path"""
  __slots__ = ['work_mode','supplement','x0','y0','z0','x','y','z','w']
  _slot_types = ['string','string','float32','float32','float32','float32','float32','float32','float32']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       work_mode,supplement,x0,y0,z0,x,y,z,w

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(effector_control_param, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.work_mode is None:
        self.work_mode = ''
      if self.supplement is None:
        self.supplement = ''
      if self.x0 is None:
        self.x0 = 0.
      if self.y0 is None:
        self.y0 = 0.
      if self.z0 is None:
        self.z0 = 0.
      if self.x is None:
        self.x = 0.
      if self.y is None:
        self.y = 0.
      if self.z is None:
        self.z = 0.
      if self.w is None:
        self.w = 0.
    else:
      self.work_mode = ''
      self.supplement = ''
      self.x0 = 0.
      self.y0 = 0.
      self.z0 = 0.
      self.x = 0.
      self.y = 0.
      self.z = 0.
      self.w = 0.

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self.work_mode
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self.supplement
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self
      buff.write(_get_struct_7f().pack(_x.x0, _x.y0, _x.z0, _x.x, _x.y, _x.z, _x.w))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.work_mode = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.work_mode = str[start:end]
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.supplement = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.supplement = str[start:end]
      _x = self
      start = end
      end += 28
      (_x.x0, _x.y0, _x.z0, _x.x, _x.y, _x.z, _x.w,) = _get_struct_7f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self.work_mode
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self.supplement
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self
      buff.write(_get_struct_7f().pack(_x.x0, _x.y0, _x.z0, _x.x, _x.y, _x.z, _x.w))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.work_mode = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.work_mode = str[start:end]
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.supplement = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.supplement = str[start:end]
      _x = self
      start = end
      end += 28
      (_x.x0, _x.y0, _x.z0, _x.x, _x.y, _x.z, _x.w,) = _get_struct_7f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_7f = None
def _get_struct_7f():
    global _struct_7f
    if _struct_7f is None:
        _struct_7f = struct.Struct("<7f")
    return _struct_7f