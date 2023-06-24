#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy, sys
import moveit_commander
from moveit_commander import MoveGroupCommander
from geometry_msgs.msg import PoseStamped, Pose
from copy import deepcopy

from hand_roscv.srv import control_srv, control_srvResponse, control_srvRequest

import geometry_msgs.msg

import math
import time as tm

import random

from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint

from panda_arm_control.msg import effector_control_param

import numpy as np
from scipy.interpolate import interp1d

def interpolate_trajectory(original_trajectory, num_points):
    interpolated_trajectory = JointTrajectory()
    interpolated_trajectory.joint_names = original_trajectory.joint_names

    interp_functions = []
    for i in range(len(original_trajectory.joint_names)):
        positions = [p.positions[i] for p in original_trajectory.points]
        times = [p.time_from_start.to_sec() for p in original_trajectory.points]
        interp_func = interp1d(times, positions, kind='linear')
        interp_functions.append(interp_func)

    times_interp = np.linspace(times[0], times[-1], num_points)
    for t in times_interp:
        positions_interp = [func(t) for func in interp_functions]
        point_interp = JointTrajectoryPoint(positions=positions_interp, time_from_start=rospy.Duration(t))
        interpolated_trajectory.points.append(point_interp)

    return interpolated_trajectory




class panda_moveit:
    def __init__(self):

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
    robot_trajectory = traj

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


# 判断control_value是否为0
def is_zero(control_value):
    if control_value.vector0 == 0 and control_value.vector1 == 0 and control_value.vector2 == 0:
        return True
    else:
        return False



def main():

    # 初始化move_group的API
    moveit_commander.roscpp_initialize(sys.argv)

    # 初始化ROS节点
    rospy.init_node('moveit_cartesian', anonymous=True)

    panda = panda_moveit()

    pub = rospy.Publisher("/effector_cartesian_controller/effector_control_param_node", effector_control_param, queue_size=20)

    # clt = rospy.ServiceProxy("control_service", control_srv)

    # clt.wait_for_service()

    # 定义循环时间
    rate = rospy.Rate(30)



    # while not rospy.is_shutdown():

    #     if panda.if_init_ready_pose == False:
    #         print("正在初始化机械臂")

    #         current_joints_value = panda.arm.get_current_joint_values()
    #         target_joints_value = deepcopy(current_joints_value)

    #         # 设置ready位置为目标位置
    #         for i in range(1, 8):
    #             target_joints_value[i-1] = panda.ready_joints_value["panda_joint" + str(i)]

    #         panda.arm.set_joint_value_target(target_joints_value)

    #         traj = panda.arm.plan()

    #         joint_trajectory = get_joint_trajectory(traj[1])
   
    #         control_param = effector_control_param()
    #         control_param.work_mode = 'trajectory'
    #         control_param.traj = joint_trajectory

    #         pub.publish(control_param)

    #         # 获取joint_trajectory的时间长度
    #         trajectory_time = joint_trajectory.points[-1].time_from_start
    #         rospy.sleep(trajectory_time)

    #         print("机械臂初始化完成")
    #         num = control_srvRequest()
    #         num.request_num = 1
    #         panda.control_value = clt.call(num)

    #         panda.if_init_ready_pose = True

    #     else:

    #         num = control_srvRequest()
    #         num.request_num = panda.request_num

    #         panda.last_task = panda.control_value.task
    #         panda.control_value = clt.call(num)


    #         if panda.last_task != panda.control_value.task or is_zero(panda.control_value) == True:
    #             panda.task_init = False

    #         if panda.control_value.task == "position" and is_zero(panda.control_value) == False:

    #             if panda.task_init == False:
    #                 panda.task_start_pose = panda.arm.get_current_pose(panda.end_effector_link).pose
    #                 panda.task_start_control_value = panda.control_value
    #                 panda.task_init = True
    #                 continue

    #             # 获取机械臂末端的当前位置作为运动初始位置
    #             start_pose = panda.arm.get_current_pose(panda.end_effector_link).pose

    #             target_pose = geometry_msgs.msg.Pose()
    #             target_pose.position.x = panda.task_start_pose.position.x + (panda.control_value.vector0 - panda.task_start_control_value.vector0) * panda.move_coff
    #             target_pose.position.y = panda.task_start_pose.position.y + (panda.control_value.vector1 - panda.task_start_control_value.vector1) * panda.move_coff
    #             target_pose.position.z = panda.task_start_pose.position.z + (panda.control_value.vector2 - panda.task_start_control_value.vector2) * panda.move_coff
                
    #             # 计算本次移动距离
    #             distance = math.sqrt(
    #                                 (target_pose.position.x - start_pose.position.x) * (target_pose.position.x - start_pose.position.x) +
    #                                 (target_pose.position.y - start_pose.position.y) * (target_pose.position.y - start_pose.position.y) +
    #                                 (target_pose.position.z - start_pose.position.z) * (target_pose.position.z - start_pose.position.z))
                
    #             if distance < 0.001:
    #                 continue

    #             time_start = tm.time()

    #             target_pose.orientation = start_pose.orientation

    #             waypoints = []
    #             waypoints.append(deepcopy(start_pose))
    #             waypoints.append(deepcopy(target_pose))

    #             fraction = 0.0   #路径规划覆盖率
    #             maxtries = 100   #最大尝试规划次数
    #             attempts = 0     #已经尝试规划次数
                
    #             # 设置机器臂当前的状态作为运动初始状态
    #             panda.arm.set_start_state_to_current_state()
    #             # 设置执行时间限制为1秒
    #             panda.arm.set_planning_time(0.1)
            
    #             # 尝试规划一条笛卡尔空间下的路径，依次通过所有路点
    #             while fraction < 1.0 and attempts < maxtries:
    #                 (plan, fraction) = panda.arm.compute_cartesian_path (
    #                                 waypoints,   # waypoint poses，路点列表
    #                                 0.0001,        # eef_step，终端步进值
    #                                 0.0,         # jump_threshold，跳跃阈值
    #                                 True)        # avoid_collisions，避障规划
                    
    #                 # 尝试次数累加
    #                 attempts += 1

    #             time_middle = tm.time()
                                
    #             # 如果路径规划成功（覆盖率100%）,则开始控制机械臂运动
    #             if fraction == 1.0:

    #                 joint_trajectory = get_joint_trajectory(plan)
        
    #                 control_param = effector_control_param()
    #                 control_param.work_mode = 'trajectory'
    #                 control_param.traj = joint_trajectory

    #                 pub.publish(control_param)

    #                 # 获取joint_trajectory的时间长度
    #                 time = joint_trajectory.points[-1].time_from_start
    #                 rospy.sleep(time)

    #             # 如果路径规划失败，则打印失败信息
    #             else:
    #                 rospy.loginfo("Path planning failed with only " + str(fraction) + " success after " + str(maxtries) + " attempts.")  

    #             time_end = tm.time()
    #             print("time_middle: ", time_middle - time_start, "time_end: ", time_end - time_start)

    #         if panda.control_value.task == "return":
    #             panda.if_init_ready_pose = False

    #     rate.sleep()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass