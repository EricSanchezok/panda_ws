#!/usr/bin/env python

import rospy
import moveit_commander
import geometry_msgs.msg
import math
import sys
import tf

from std_msgs.msg import String

from hand_roscv.msg import control_msg

# 初始位置
init_pose = geometry_msgs.msg.Pose()
init_pose.position.x = 0.30691096167070825
init_pose.position.y = 0
init_pose.position.z = 0.5902933382353311
init_pose.orientation.x = 0.9238795334199068
init_pose.orientation.y = -0.38268343017148676
init_pose.orientation.z = 0
init_pose.orientation.w = 0


if_init = False

control_value = control_msg()


def doControl_msg(msg):

    #rospy.loginfo("接收到的控制信息:%s, %.3f, %.3f, %.3f", msg.task, msg.vector0, msg.vector1, msg.vector2)

    global control_value

    control_value = msg



def go_to(group, target_pose, isWait=True):

    # 设置机械臂当前的状态作为运动初始状态
    group.set_start_state_to_current_state()

    # 设置机械臂终端运动的目标位姿
    group.set_pose_target(target_pose)

    # 进行运动规划
    plan = group.plan()

    # wait=False 异步运动
    group.execute(plan[1], wait=isWait)




def moveit_control():
    # 初始化ROS节点
    rospy.init_node('moveit_control', anonymous=True)

    sub = rospy.Subscriber("control_messages", control_msg, doControl_msg, queue_size=30)

    # 初始化MoveIt
    moveit_commander.roscpp_initialize(sys.argv)
    robot = moveit_commander.RobotCommander()
    group = moveit_commander.MoveGroupCommander("panda_arm")


    # 获取初始化位置
    init_position = group.get_current_pose().pose.position
    init_orientation_q = group.get_current_pose().pose.orientation

    print("init_position:", init_position, "init_orientation_q:", init_orientation_q)

    print(type(init_position), type(init_orientation_q))


    # 设置机械臂的允许误差值
    group.set_goal_position_tolerance(0.01)
    group.set_goal_orientation_tolerance(0.01)

    # 设置机械臂最大速度
    group.set_max_velocity_scaling_factor(0.1)

    # 设置机械臂最大加速度
    group.set_max_acceleration_scaling_factor(0.1)

    # 设置机械臂允许的最大关节角速度
    group.set_max_velocity_scaling_factor(0.1)

    # 设置机械臂允许的最大关节角加速度
    group.set_max_acceleration_scaling_factor(0.1)




    global if_init, current_position

    while not rospy.is_shutdown():

        if if_init == False:
            group.set_planning_time(5)

            # 运动到目标位置
            go_to(group, init_pose, isWait=True)

            if_init = True

        else:

            if control_value.task == "position":
                group.set_planning_time(0.5)

                # 获取机械臂末端的当前位置
                end_effector_pose = group.get_current_pose().pose

                target_pose = geometry_msgs.msg.Pose()
                target_pose.position.x = end_effector_pose.position.x + control_value.vector0
                target_pose.position.y = end_effector_pose.position.y + control_value.vector1
                target_pose.position.z = end_effector_pose.position.z + control_value.vector2

                target_pose.orientation = end_effector_pose.orientation

                # 运动到目标位置
                go_to(group, target_pose, isWait=True)

            if control_value.task == "return":
                if_init = False





    # rospy.spin()


if __name__ == '__main__':
    try:
        moveit_control()
    except rospy.ROSInterruptException:
        pass
