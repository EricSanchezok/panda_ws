// Copyright (c) 2017 Franka Emika GmbH
// Use of this source code is governed by the Apache-2.0 license, see LICENSE
#pragma once

#include <string>
#include <vector>

#include <controller_interface/multi_interface_controller.h>
#include <franka_hw/franka_model_interface.h>
#include <franka_hw/franka_state_interface.h>
#include <hardware_interface/joint_command_interface.h>
#include <hardware_interface/robot_hw.h>
#include <ros/node_handle.h>
#include <ros/time.h>

#include <trajectory_msgs/JointTrajectory.h>


#include "panda_arm_control/effector_control_param.h"

namespace panda_arm_control {

class EffectorCartesianController : public controller_interface::MultiInterfaceController<
                                           hardware_interface::VelocityJointInterface,
                                           franka_hw::FrankaModelInterface,
                                           franka_hw::FrankaStateInterface> {
 public:
  bool init(hardware_interface::RobotHW* robot_hardware, ros::NodeHandle& node_handle) override;
  void update(const ros::Time&, const ros::Duration& period) override;
  void starting(const ros::Time&) override;
  void stopping(const ros::Time&) override;

 private:

  hardware_interface::VelocityJointInterface* velocity_joint_interface_;
  std::vector<hardware_interface::JointHandle> velocity_joint_handles_;

  std::unique_ptr<franka_hw::FrankaStateHandle> state_handle_;
  std::unique_ptr<franka_hw::FrankaModelHandle> model_handle_;

  ros::Duration elapsed_time_;
  std::array<double, 7> initial_pose_{};

  trajectory_msgs::JointTrajectory trajectory_;

  ros::Duration trajectory_elapsed_time_;

  ros::Subscriber sub_effector_control_param_;

  panda_arm_control::effector_control_param control_param;

  void controlParamCallback(const panda_arm_control::effector_control_param::ConstPtr& msg);
};

}  // namespace panda_arm_control