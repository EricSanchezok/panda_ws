#!/usr/bin/env python

import rospy
import moveit_commander
import geometry_msgs.msg
import math
import sys
import tf


def moveit_control_example():
    # 初始化ROS节点
    rospy.init_node('moveit_control_example', anonymous=True)

    # 初始化MoveIt
    moveit_commander.roscpp_initialize(sys.argv)
    robot = moveit_commander.RobotCommander()
    group = moveit_commander.MoveGroupCommander("panda_arm")

    # 设置目标位置
    target_pose = geometry_msgs.msg.Pose()
    target_pose.position.x = 0.5
    target_pose.position.y = 0.0
    target_pose.position.z = 0.4

    # 设置目标朝向
    end_effector_orientation = tf.transformations.unit_vector([1, 0, 0])  # 假设朝向为 x 轴方向

    target_quaternion = tf.transformations.quaternion_about_axis(math.pi, end_effector_orientation)

    print("target_quaternion: ", target_quaternion)
          
    target_pose.orientation.x = target_quaternion[0]
    target_pose.orientation.y = target_quaternion[1]
    target_pose.orientation.z = target_quaternion[2]
    target_pose.orientation.w = target_quaternion[3]

    # 设置目标姿态为末端执行器当前姿态
    group.set_pose_target(target_pose)

    # 进行运动规划
    plan = group.plan()
    print("type(plan): ", type(plan))

    # 执行运动
    group.execute(plan[1], wait=True)


if __name__ == '__main__':
    try:
        moveit_control_example()
    except rospy.ROSInterruptException:
        pass
