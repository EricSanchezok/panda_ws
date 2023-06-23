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



class panda_moveit:
    def __init__(self):
        # 初始化move_group的API
        moveit_commander.roscpp_initialize(sys.argv)

        # 初始化ROS节点
        rospy.init_node('moveit_cartesian', anonymous=True)

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
        self.arm.set_max_acceleration_scaling_factor(1.0)
        self.arm.set_max_velocity_scaling_factor(1.0)

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




def main():
    panda = panda_moveit()

    # 定义循环时间
    rate = rospy.Rate(10)

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


    panda.arm.set_joint_value_target(target_joints_value)

    
    # 根据目标关节空间位置，进行运动规划，规划出的轨迹保存在变量plan中
    traj = panda.arm.plan()
 
    print("规划点数：", dir(traj))

    # 打印前两个点的位置
    print("规划点:", traj.count)

    # while not rospy.is_shutdown():

    #     panda.panda_current_pose = panda.arm.get_current_pose(panda.end_effector_link).pose
        
    #     print("panda_current_pose: \r\n", panda.panda_current_pose)

    #     rate.sleep()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass