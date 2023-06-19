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
init_position = [0.30691096167070825, 1.1206712491293856e-05, 0.5902933382353311]
init_orientation_q = [0.9238732550170593, -0.3826985843211034, 4.5769895296965384e-05, 1.1310341694220348e-05]
init_orientation = tf.transformations.euler_from_quaternion(init_orientation_q)

print("初始位置：", init_position, "初始朝向：", init_orientation)

if_init = False

control_value = control_msg()


def doControl_msg(msg):

    rospy.loginfo("接收到的控制信息:%s, %.3f, %.3f, %.3f", msg.task, msg.vector0, msg.vector1, msg.vector2)

    global control_value

    control_value = msg


def get_target_pose(position, orientation):

    # 设置目标位置e
    target_pose = geometry_msgs.msg.Pose()
    target_pose.position.x = position[0]
    target_pose.position.y = position[1]
    target_pose.position.z = position[2]

    # 设置目标朝向
    end_effector_orientation = tf.transformations.unit_vector([orientation[0], orientation[1], orientation[2]])  # 假设朝向为 x 轴方向

    # 欧拉角转四元数
    target_quaternion = tf.transformations.quaternion_from_euler(orientation)

    target_quaternion = tf.transformations.quaternion_about_axis(math.pi, end_effector_orientation)

    target_pose.orientation.x = target_quaternion[0]
    target_pose.orientation.y = target_quaternion[1]
    target_pose.orientation.z = target_quaternion[2]
    target_pose.orientation.w = target_quaternion[3]

    return target_pose


def go_to(group, target_pose):

    # 设置目标姿态为末端执行器当前姿态
    group.set_pose_target(target_pose)

    # 进行运动规划
    plan = group.plan()

    # 执行运动
    group.execute(plan[1], wait=True)




def moveit_control():
    # 初始化ROS节点
    rospy.init_node('moveit_control', anonymous=True)

    sub = rospy.Subscriber("control_messages", control_msg, doControl_msg, queue_size=30)

    # 初始化MoveIt
    moveit_commander.roscpp_initialize(sys.argv)
    robot = moveit_commander.RobotCommander()
    group = moveit_commander.MoveGroupCommander("panda_arm")

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

    # 获取机械臂末端的当前位置
    end_effector_pose = group.get_current_pose().pose


    global if_init, current_position

    while not rospy.is_shutdown():

        if if_init == False:
            # 设置目标位置
            target_pose = get_target_pose(init_position, init_orientation)
            # 运动到目标位置
            go_to(group, target_pose)

            if_init = True

        else:

            if control_value.task == "position":
                    
                # 设置目标位置
                target_position = [control_value.vector0, control_value.vector1, control_value.vector2]
                target_pose = get_target_pose(target_position, init_orientation)

                # 运动到目标位置
                go_to(group, target_pose)

            if control_value.task == "return":
                if_init = False





    # rospy.spin()


if __name__ == '__main__':
    try:
        moveit_control()
    except rospy.ROSInterruptException:
        pass
