#include <panda_arm_control/effector_cartesian_controller.h>

#include <cmath>

#include <controller_interface/controller_base.h>
#include <hardware_interface/hardware_interface.h>
#include <hardware_interface/joint_command_interface.h>
#include <pluginlib/class_list_macros.h>
#include <ros/ros.h>


#include <trajectory_msgs/JointTrajectory.h>

#include "panda_arm_control/effector_control_param.h"

namespace panda_arm_control {

bool EffectorCartesianController::init(hardware_interface::RobotHW* robot_hardware,
                                          ros::NodeHandle& node_handle) {

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
    ROS_ERROR_STREAM("EffectorCartesianController: 001错误的关节名称数量，实际得到 "
                     << joint_names.size() << " 个名称，而不是 7 个！");
    return false;
  }

  velocity_joint_handles_.resize(7);
  for (size_t i = 0; i < 7; ++i) {
    try {
      velocity_joint_handles_[i] = velocity_joint_interface_->getHandle(joint_names[i]);
    } catch (const hardware_interface::HardwareInterfaceException& ex) {
      ROS_ERROR_STREAM(
          "EffectorCartesianController: 002获取关节句柄时发生异常：" << ex.what());
      return false;
    }
  }


  auto* model_interface = robot_hardware->get<franka_hw::FrankaModelInterface>();
  if (model_interface == nullptr) {
    ROS_ERROR_STREAM(
        "CartesianImpedanceExampleController: Error getting model interface from hardware");
    return false;
  }
  try {
    model_handle_ = std::make_unique<franka_hw::FrankaModelHandle>(
        model_interface->getHandle(arm_id + "_model"));
  } catch (hardware_interface::HardwareInterfaceException& ex) {
    ROS_ERROR_STREAM(
        "CartesianImpedanceExampleController: Exception getting model handle from interface: "
        << ex.what());
    return false;
  }

  auto* state_interface = robot_hardware->get<franka_hw::FrankaStateInterface>();
  if (state_interface == nullptr) {
    ROS_ERROR_STREAM(
        "CartesianImpedanceExampleController: Error getting state interface from hardware");
    return false;
  }
  try {
    state_handle_ = std::make_unique<franka_hw::FrankaStateHandle>(
        state_interface->getHandle(arm_id + "_robot"));
  } catch (hardware_interface::HardwareInterfaceException& ex) {
    ROS_ERROR_STREAM(
        "CartesianImpedanceExampleController: Exception getting state handle from interface: "
        << ex.what());
    return false;
  }


  return true;
}

void EffectorCartesianController::starting(const ros::Time& /* time */) {

    elapsed_time_ = ros::Duration(0.0);

}

void EffectorCartesianController::update(const ros::Time& /* time */,
                                            const ros::Duration& period) {

    // get state variables
    franka::RobotState robot_state = state_handle_->getRobotState();
    std::array<double, 7> coriolis_array = model_handle_->getCoriolis();
    std::array<double, 42> jacobian_array =
        model_handle_->getZeroJacobian(franka::Frame::kEndEffector);


    // 检查是否有待执行的轨迹
    if (trajectory_.points.empty()) {
        // 打印提示信息
        // ROS_INFO_STREAM("No trajectory to execute.");
        // 打印间隔时间
        // ROS_INFO_STREAM("period: " << period.toSec());
        return;
    }

    // 如果当前轨迹已经执行完毕，则清除轨迹并返回
    if (trajectory_elapsed_time_ >= trajectory_.points.back().time_from_start)
    {
      trajectory_.points.clear();
      return;
    }

    // 查找当前时间点所在的轨迹段
    size_t segment_index = 0;
    while (segment_index < trajectory_.points.size() &&
          trajectory_elapsed_time_ >= trajectory_.points[segment_index].time_from_start)
    {
      segment_index++;
    }
    
    // 打印当前索引占总长度的比例
    ROS_INFO_STREAM("elpased_time: " << trajectory_elapsed_time_ << "/"
                    << segment_index << "/" << trajectory_.points.size()-1);

    
    // 获取当前轨迹段的关节位置和速度
    const trajectory_msgs::JointTrajectoryPoint& current_segment = trajectory_.points[segment_index - 1];
    const trajectory_msgs::JointTrajectoryPoint& next_segment = trajectory_.points[segment_index];

    std::vector<double> current_positions = current_segment.positions;
    std::vector<double> current_velocities = current_segment.velocities;
    std::vector<double> current_accelerations = current_segment.accelerations;

    std::vector<double> next_positions = next_segment.positions;
    std::vector<double> next_velocities = next_segment.velocities;
    std::vector<double> next_accelerations = next_segment.accelerations;

    double segment_duration = (next_segment.time_from_start - current_segment.time_from_start).toSec();

    // 计算当前时间点在当前轨迹段中的时间偏移
    double segment_time_offset = (trajectory_elapsed_time_ - current_segment.time_from_start).toSec();

    // 计算当前时间点在当前轨迹段中的比例
    double segment_completion = segment_time_offset / segment_duration;

    // 根据比例插值计算当前时间点的关节位置
    std::vector<double> current_velocities;
    for (size_t i = 0; i < 7; ++i)
    {
      double position = positions[i];
      double velocity = velocities[i];
      double acceleration = accelerations[i];


      current_velocities.push_back(current_velocity);
    }

    for (size_t i = 0; i < 7; ++i) {
      velocity_joint_handles_[i].setCommand(current_velocities[i]);
    }

    // 更新累积时间
    trajectory_elapsed_time_ += period;


}

void EffectorCartesianController::stopping(const ros::Time& /*time*/) {
  // 警告：在此处不要发送零速度命令，因为在运动中中止时，将命令跳转到零会给机器人带来很大的负载。
  // 让默认的内置停止行为来减慢机器人。
}

void EffectorCartesianController::controlParamCallback(const panda_arm_control::effector_control_param::ConstPtr& msg) {
    // 在这里处理接收到的消息
    // 可以使用msg->字段名来访问消息中的字段值
    trajectory_elapsed_time_ = ros::Duration(0.0);
    control_param = *msg;
    trajectory_ = control_param.traj;
    ROS_INFO_STREAM("EffectorCartesianController: 接收到的消息为："
                    << control_param);

}


}  // namespace panda_arm_control



PLUGINLIB_EXPORT_CLASS(panda_arm_control::EffectorCartesianController,
                       controller_interface::ControllerBase)