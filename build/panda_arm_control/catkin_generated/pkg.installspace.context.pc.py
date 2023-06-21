# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include;/usr/include".split(';') if "${prefix}/include;/usr/include" != "" else []
PROJECT_CATKIN_DEPENDS = "roscpp;rospy;std_msgs;controller_interface;hardware_interface;franka_hw;pluginlib;message_runtime".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lpanda_arm_control;/usr/lib/libfranka.so.0.9.2".split(';') if "-lpanda_arm_control;/usr/lib/libfranka.so.0.9.2" != "" else []
PROJECT_NAME = "panda_arm_control"
PROJECT_SPACE_DIR = "/home/ericsanchez/ros/ros1/panda_ws/install"
PROJECT_VERSION = "0.0.0"
