#include <panda_arm_control/effector_cartesian_controller.h>

#include <cmath>

#include <controller_interface/controller_base.h>
#include <hardware_interface/hardware_interface.h>
#include <hardware_interface/joint_command_interface.h>
#include <pluginlib/class_list_macros.h>
#include <ros/ros.h>

#include "panda_arm_control/effector_control_param.h"

namespace panda_arm_control {

bool EffectorCartesianController::init(hardware_interface::RobotHW* robot_hardware,
                                          ros::NodeHandle& node_handle) {

  //sub_effector_control_param_ = node_handle.subscribe<panda_arm_control::effector_control_param>("effector_control_param_node",20,&EffectorCartesianController::controlParamCallback);

  sub_effector_control_param_ = node_handle.subscribe(
      "effector_control_param_node", 20, &EffectorCartesianController::controlParamCallback, this,
      ros::TransportHints().reliable().tcpNoDelay());

  velocity_joint_interface_ = robot_hardware->get<hardware_interface::VelocityJointInterface>();
  if (velocity_joint_interface_ == nullptr) {
    ROS_ERROR("EffectorCartesianController: Error getting velocity joint interface from hardware!");
    return false;
  }


  std::string arm_id;
  if (!node_handle.getParam("arm_id", arm_id)) {
    ROS_ERROR("EffectorCartesianController: Unable to get parameter arm_id");
    return false;
  }

  std::vector<std::string> joint_names;
  if (!node_handle.getParam("joint_names", joint_names)) {
    ROS_ERROR("EffectorCartesianController: Unable to resolve joint name");
  }
  if (joint_names.size() != 7) {
    ROS_ERROR_STREAM("EffectorCartesianController: 错误的关节名称数量，实际得到 "
                     << joint_names.size() << " 个名称，而不是 7 个！");
    return false;
  }
  velocity_joint_handles_.resize(7);
  for (size_t i = 0; i < 7; ++i) {
    try {
      velocity_joint_handles_[i] = velocity_joint_interface_->getHandle(joint_names[i]);
    } catch (const hardware_interface::HardwareInterfaceException& ex) {
      ROS_ERROR_STREAM(
          "EffectorCartesianController: 获取关节句柄时发生异常：" << ex.what());
      return false;
    }
  }

  auto state_interface = robot_hardware->get<franka_hw::FrankaStateInterface>();
  if (state_interface == nullptr) {
    ROS_ERROR("EffectorCartesianController: 无法从硬件中获取状态接口");
    return false;
  }

  try {
    auto state_handle = state_interface->getHandle(arm_id + "_robot");

    std::array<double, 7> q_start{{0, -M_PI_4, 0, -3 * M_PI_4, 0, M_PI_2, M_PI_4}};
    for (size_t i = 0; i < q_start.size(); i++) {
      if (std::abs(state_handle.getRobotState().q_d[i] - q_start[i]) > 0.1) {
        ROS_ERROR_STREAM(
            "EffectorCartesianController: 机器人不处于预期的起始位置，无法运行此示例。请先运行 `roslaunch franka_example_controllers move_to_start.launch "
            "robot_ip:=<robot-ip> load_gripper:=<has-attached-gripper>`。");
        return false;
      }
    }
  } catch (const hardware_interface::HardwareInterfaceException& e) {
    ROS_ERROR_STREAM(
        "EffectorCartesianController: 获取状态句柄时发生异常：" << e.what());
    return false;
  }

  return true;
}

void EffectorCartesianController::starting(const ros::Time& /* time */) {
  elapsed_time_ = ros::Duration(0.0);
}

void EffectorCartesianController::update(const ros::Time& /* time */,
                                            const ros::Duration& period) {

  for(int i=0;i<7;i++){
    velocity_joint_handles_[i].setCommand(0.1);
  }
}

void EffectorCartesianController::stopping(const ros::Time& /*time*/) {
  // 警告：在此处不要发送零速度命令，因为在运动中中止时，将命令跳转到零会给机器人带来很大的负载。
  // 让默认的内置停止行为来减慢机器人。
}

void EffectorCartesianController::controlParamCallback(const panda_arm_control::effector_control_param::ConstPtr& msg) {
  // 在这里处理接收到的消息
  // 可以使用msg->字段名来访问消息中的字段值
}


}  // namespace panda_arm_control



PLUGINLIB_EXPORT_CLASS(panda_arm_control::EffectorCartesianController,
                       controller_interface::ControllerBase)
