#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy, sys
import moveit_commander
from moveit_commander import MoveGroupCommander
from geometry_msgs.msg import PoseStamped, Pose
from copy import deepcopy

from hand_roscv.srv import control_srv, control_srvResponse, control_srvRequest

import geometry_msgs.msg

import math, time

import random

from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint

from panda_arm_control.msg import effector_control_param




class panda_moveit:
    def __init__(self):

        # self.clt = rospy.ServiceProxy("control_service", control_srv)

        # self.clt.wait_for_service()

        self.request_num = 0
      
        # 初始化需要使用move group控制的机械臂中的arm group
        self.arm = MoveGroupCommander('panda_arm')
        self.robot = moveit_commander.RobotCommander()

        # 当运动规划失败后，允许重新规划
        self.arm.allow_replanning(True)
        
        # 设置目标位置所使用的参考坐标系
        self.arm.set_pose_reference_frame('panda_link0')
                
        # 设置位置(单位：米)和姿态（单位：弧度）的允许误差
        self.arm.set_goal_position_tolerance(0.001)
        self.arm.set_goal_orientation_tolerance(0.001)

        # 设置允许的最大速度和加速度
        self.arm.set_max_acceleration_scaling_factor(0.1)
        self.arm.set_max_velocity_scaling_factor(0.1)

        # 获取终端link的名称
        self.end_effector_link = self.arm.get_end_effector_link()

        self.ready_joints_value = self.arm.get_named_target_values("ready")

        self.control_value = control_srvResponse()

        self.if_init_ready_pose = False
        self.panda_ready_pose = None

        self.task_init = False
        self.task_start_pose = None
        self.task_start_control_value = None

        self.last_task = None

        self.move_coff = 0.5


def get_joint_trajectory(traj):

    # traj 是一个元组，其中第二个变量是 RobotTrajectory
    robot_trajectory = traj[1]

    # 创建一个空的 JointTrajectory 对象
    joint_trajectory = JointTrajectory()

    # 设置 JointTrajectory 的 joint_names 属性
    joint_trajectory.joint_names = robot_trajectory.joint_trajectory.joint_names

    # 遍历轨迹中的每个时间点
    for point in robot_trajectory.joint_trajectory.points:
        # 创建一个 JointTrajectoryPoint 对象
        joint_point = JointTrajectoryPoint()

        # 设置 JointTrajectoryPoint 的 positions 和 velocities 属性
        joint_point.positions = point.positions
        joint_point.velocities = point.velocities

        # 设置 JointTrajectoryPoint 的时间戳
        joint_point.time_from_start = point.time_from_start

        # 将 JointTrajectoryPoint 添加到 JointTrajectory 中
        joint_trajectory.points.append(joint_point)
    
    return joint_trajectory



def main():

    # 初始化move_group的API
    moveit_commander.roscpp_initialize(sys.argv)

    # 初始化ROS节点
    rospy.init_node('moveit_cartesian', anonymous=True)

    panda = panda_moveit()

    pub = rospy.Publisher("/effector_cartesian_controller/effector_control_param_node", effector_control_param, queue_size=20)

    # 定义循环时间
    rate = rospy.Rate(30)

    current_joints_value = panda.arm.get_current_joint_values()

    print("current_joints_value: \r\n", current_joints_value)

    # 在关节限制范围内，随机生成目标关节空间位置
    target_joints_value = deepcopy(current_joints_value)
    target_joints_value[0] = random.uniform(-2.8973, 2.8973)
    target_joints_value[1] = random.uniform(-1.7628, 1.7628)
    target_joints_value[2] = random.uniform(-2.8973, 2.8973)
    target_joints_value[3] = random.uniform(-3.0718, -0.0698)
    target_joints_value[4] = random.uniform(-2.8973, 2.8973)
    target_joints_value[5] = random.uniform(-0.0175, 3.7525)
    target_joints_value[6] = random.uniform(-2.8973, 2.8973)

    # target_joints_value = panda.ready_joints_value


    panda.arm.set_joint_value_target(target_joints_value)

    
    # 根据目标关节空间位置，进行运动规划，规划出的轨迹保存在变量plan中
    traj = panda.arm.plan()

    joint_trajectory = get_joint_trajectory(traj)


    control_param = effector_control_param()
    control_param.work_mode = 'trajectory'
    control_param.traj = joint_trajectory

    pub.publish(control_param)

    # while True:
    #     current_joints_value = panda.arm.get_current_joint_values()

    #     # 计算当前关节角度和目标关节角度的差值
    #     diff = [current_joints_value[i] - target_joints_value[i] for i in range(len(current_joints_value))]
    #     print("diff: \r\n", diff)

    #     rate.sleep()



    # print(traj[1])

    # while not rospy.is_shutdown():

    #     panda.panda_current_pose = panda.arm.get_current_pose(panda.end_effector_link).pose
        
    #     print("panda_current_pose: \r\n", panda.panda_current_pose)

    #     rate.sleep()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass