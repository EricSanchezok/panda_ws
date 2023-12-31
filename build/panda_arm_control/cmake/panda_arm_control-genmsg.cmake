# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "panda_arm_control: 1 messages, 0 services")

set(MSG_I_FLAGS "-Ipanda_arm_control:/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Imoveit_msgs:/opt/ros/noetic/share/moveit_msgs/cmake/../msg;-Itrajectory_msgs:/opt/ros/noetic/share/trajectory_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Ishape_msgs:/opt/ros/noetic/share/shape_msgs/cmake/../msg;-Iobject_recognition_msgs:/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg;-Ioctomap_msgs:/opt/ros/noetic/share/octomap_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(panda_arm_control_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg" NAME_WE)
add_custom_target(_panda_arm_control_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "panda_arm_control" "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg" "trajectory_msgs/JointTrajectoryPoint:std_msgs/Header:trajectory_msgs/JointTrajectory"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(panda_arm_control
  "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/panda_arm_control
)

### Generating Services

### Generating Module File
_generate_module_cpp(panda_arm_control
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/panda_arm_control
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(panda_arm_control_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(panda_arm_control_generate_messages panda_arm_control_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg" NAME_WE)
add_dependencies(panda_arm_control_generate_messages_cpp _panda_arm_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(panda_arm_control_gencpp)
add_dependencies(panda_arm_control_gencpp panda_arm_control_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS panda_arm_control_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(panda_arm_control
  "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/panda_arm_control
)

### Generating Services

### Generating Module File
_generate_module_eus(panda_arm_control
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/panda_arm_control
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(panda_arm_control_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(panda_arm_control_generate_messages panda_arm_control_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg" NAME_WE)
add_dependencies(panda_arm_control_generate_messages_eus _panda_arm_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(panda_arm_control_geneus)
add_dependencies(panda_arm_control_geneus panda_arm_control_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS panda_arm_control_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(panda_arm_control
  "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/panda_arm_control
)

### Generating Services

### Generating Module File
_generate_module_lisp(panda_arm_control
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/panda_arm_control
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(panda_arm_control_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(panda_arm_control_generate_messages panda_arm_control_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg" NAME_WE)
add_dependencies(panda_arm_control_generate_messages_lisp _panda_arm_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(panda_arm_control_genlisp)
add_dependencies(panda_arm_control_genlisp panda_arm_control_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS panda_arm_control_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(panda_arm_control
  "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/panda_arm_control
)

### Generating Services

### Generating Module File
_generate_module_nodejs(panda_arm_control
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/panda_arm_control
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(panda_arm_control_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(panda_arm_control_generate_messages panda_arm_control_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg" NAME_WE)
add_dependencies(panda_arm_control_generate_messages_nodejs _panda_arm_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(panda_arm_control_gennodejs)
add_dependencies(panda_arm_control_gennodejs panda_arm_control_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS panda_arm_control_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(panda_arm_control
  "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/panda_arm_control
)

### Generating Services

### Generating Module File
_generate_module_py(panda_arm_control
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/panda_arm_control
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(panda_arm_control_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(panda_arm_control_generate_messages panda_arm_control_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ericsanchez/ros/ros1/panda_ws/src/panda_arm_control/msg/effector_control_param.msg" NAME_WE)
add_dependencies(panda_arm_control_generate_messages_py _panda_arm_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(panda_arm_control_genpy)
add_dependencies(panda_arm_control_genpy panda_arm_control_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS panda_arm_control_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/panda_arm_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/panda_arm_control
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(panda_arm_control_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET moveit_msgs_generate_messages_cpp)
  add_dependencies(panda_arm_control_generate_messages_cpp moveit_msgs_generate_messages_cpp)
endif()
if(TARGET trajectory_msgs_generate_messages_cpp)
  add_dependencies(panda_arm_control_generate_messages_cpp trajectory_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/panda_arm_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/panda_arm_control
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(panda_arm_control_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET moveit_msgs_generate_messages_eus)
  add_dependencies(panda_arm_control_generate_messages_eus moveit_msgs_generate_messages_eus)
endif()
if(TARGET trajectory_msgs_generate_messages_eus)
  add_dependencies(panda_arm_control_generate_messages_eus trajectory_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/panda_arm_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/panda_arm_control
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(panda_arm_control_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET moveit_msgs_generate_messages_lisp)
  add_dependencies(panda_arm_control_generate_messages_lisp moveit_msgs_generate_messages_lisp)
endif()
if(TARGET trajectory_msgs_generate_messages_lisp)
  add_dependencies(panda_arm_control_generate_messages_lisp trajectory_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/panda_arm_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/panda_arm_control
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(panda_arm_control_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET moveit_msgs_generate_messages_nodejs)
  add_dependencies(panda_arm_control_generate_messages_nodejs moveit_msgs_generate_messages_nodejs)
endif()
if(TARGET trajectory_msgs_generate_messages_nodejs)
  add_dependencies(panda_arm_control_generate_messages_nodejs trajectory_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/panda_arm_control)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/panda_arm_control\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/panda_arm_control
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(panda_arm_control_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET moveit_msgs_generate_messages_py)
  add_dependencies(panda_arm_control_generate_messages_py moveit_msgs_generate_messages_py)
endif()
if(TARGET trajectory_msgs_generate_messages_py)
  add_dependencies(panda_arm_control_generate_messages_py trajectory_msgs_generate_messages_py)
endif()
