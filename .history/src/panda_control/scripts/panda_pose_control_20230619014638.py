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
init_position = [0.30691096167070825, 0, 0.5902933382353311]
init_orientation_q = [-0.9238583246496421, 0.382734626020104, 0, 0]
init_orientation = tf.transformations.euler_from_quaternion(init_orientation_q)


if_init = False

control_value = control_msg()


def doControl_msg(msg):

    #rospy.loginfo("接收到的控制信息:%s, %.3f, %.3f, %.3f", msg.task, msg.vector0, msg.vector1, msg.vector2)

    global control_value

    control_value = msg


def get_target_pose(position:geometry_msgs.msg._Point.Point, orientation:geometry_msgs.msg._Quaternion.Quaternion):

    # 设置目标位置e
    target_pose = geometry_msgs.msg.Pose()
    
    target_pose.position = position

    target_pose.orientation = orientation

    return target_pose


def go_to(group, target_pose, end_effector_pose):

    # 计算当前位姿与目标位姿之间的差值
    delta_x = target_pose.position.x - end_effector_pose.position.x
    delta_y = target_pose.position.y - end_effector_pose.position.y
    delta_z = target_pose.position.z - end_effector_pose.position.z

    print("delta_x:", delta_x, "delta_y:", delta_y, "delta_z:", delta_z)

    delta_orientation = tf.transformations.euler_from_quaternion([target_pose.orientation.x - end_effector_pose.orientation.x,
                                                                     target_pose.orientation.y - end_effector_pose.orientation.y,
                                                                        target_pose.orientation.z - end_effector_pose.orientation.z,
                                                                            target_pose.orientation.w - end_effector_pose.orientation.w])
    print("delta_orientation:", delta_orientation)

    # 设置机械臂当前的状态作为运动初始状态
    group.set_start_state_to_current_state()

    # 设置机械臂终端运动的目标位姿
    group.set_pose_target(target_pose)

    # 进行运动规划
    plan = group.plan()

    # wait=False 异步运动
    group.execute(plan[1], wait=True)




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
            # 设置目标位置
            target_pose = get_target_pose(init_position, init_orientation_q)
            # 运动到目标位置
            go_to(group, target_pose, end_effector_pose)

            if_init = True

        else:

            if control_value.task == "position":
                group.set_planning_time(0.5)

                # 获取机械臂末端的当前位置
                end_effector_pose = group.get_current_pose().pose

                target_pose = geometry_msgs.msg.Pose()
                target_pose.position.x = 
                    
                # 设置目标位置
                target_position = [control_value.vector0, control_value.vector1, control_value.vector2]
                target_pose = get_target_pose(target_position, init_orientation_q)

                # 运动到目标位置
                go_to(group, target_pose, end_effector_pose)

            if control_value.task == "return":
                if_init = False





    # rospy.spin()


if __name__ == '__main__':
    try:
        moveit_control()
    except rospy.ROSInterruptException:
        pass
