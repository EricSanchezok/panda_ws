#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy, sys
import moveit_commander
from moveit_commander import MoveGroupCommander
from geometry_msgs.msg import Pose
from copy import deepcopy

from hand_roscv.msg import control_msg



class panda_moveit:
    def __init__(self):
        # 初始化move_group的API
        moveit_commander.roscpp_initialize(sys.argv)

        # 初始化ROS节点
        rospy.init_node('moveit_cartesian', anonymous=True)
      
        # 初始化需要使用move group控制的机械臂中的arm group
        self.arm = MoveGroupCommander('panda_arm')
        # 当运动规划失败后，允许重新规划
        self.arm.allow_replanning(True)
        
        # 设置目标位置所使用的参考坐标系
        self.arm.set_pose_reference_frame('base_link')
                
        # 设置位置(单位：米)和姿态（单位：弧度）的允许误差
        self.arm.set_goal_position_tolerance(0.001)
        self.arm.set_goal_orientation_tolerance(0.001)

        # 设置允许的最大速度和加速度
        self.arm.set_max_acceleration_scaling_factor(0.5)
        self.arm.set_max_velocity_scaling_factor(0.5)
        
        # 获取终端link的名称
        self.end_effector_link = self.arm.get_end_effector_link()

        self.control_value = control_msg()
        self.if_init = False


panda = panda_moveit()


def doControl_msg(msg):

    rospy.loginfo("接收到的控制信息:%s, %.3f, %.3f, %.3f", msg.task, msg.vector0, msg.vector1, msg.vector2)

    panda.control_value = msg

def main():


    sub = rospy.Subscriber("control_messages", control_msg, doControl_msg, queue_size=30)

    while not rospy.is_shutdown():
        
        if panda.if_init == False:
            panda.arm.set_named_target('home')
            panda.arm.go()
            rospy.sleep(1)



