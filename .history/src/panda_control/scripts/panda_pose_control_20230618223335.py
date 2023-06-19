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
init_position = [0.5, 0.0, 0.4]
init_orientation = [1.0, 0.0, 0.0]

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

    global if_init

    while not rospy.is_shutdown():

        if if_init == False:
            # 设置目标位置
            target_pose = get_target_pose(init_position, init_orientation)
            # 运动到目标位置
            go_to(group, target_pose)

            if_init = True



    # rospy.spin()


if __name__ == '__main__':
    try:
        moveit_control()
    except rospy.ROSInterruptException:
        pass
