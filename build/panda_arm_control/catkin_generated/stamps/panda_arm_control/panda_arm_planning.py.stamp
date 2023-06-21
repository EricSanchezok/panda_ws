#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy, sys
import moveit_commander
from moveit_commander import MoveGroupCommander
from geometry_msgs.msg import Pose
from copy import deepcopy

from hand_roscv.srv import control_srv, control_srvResponse, control_srvRequest

import geometry_msgs.msg

import math, time



class panda_moveit:
    def __init__(self):
        # 初始化move_group的API
        moveit_commander.roscpp_initialize(sys.argv)

        # 初始化ROS节点
        rospy.init_node('moveit_cartesian', anonymous=True)

        # self.clt = rospy.ServiceProxy("control_service", control_srv)

        # self.clt.wait_for_service()

        self.request_num = 0

        print("panda_moveit init")
      
        # 初始化需要使用move group控制的机械臂中的arm group
        self.arm = MoveGroupCommander('panda_arm')
        self.robot = moveit_commander.RobotCommander()

        print("panda_moveit init 2")

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

        self.control_value = control_srvResponse()

        self.if_init_ready_pose = False
        self.panda_ready_pose = None

        self.task_init = False
        self.task_start_pose = None
        self.task_start_control_value = None

        self.last_task = None

        self.move_coff = 0.5

panda = panda_moveit()


def main():

    # 定义循环时间

    rate = rospy.Rate(10)

    while not rospy.is_shutdown():

        panda.panda_current_pose = panda.arm.get_current_pose(panda.end_effector_link).pose
        
        print("panda_current_pose: \r\n", panda.panda_current_pose)

        rate.sleep()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass