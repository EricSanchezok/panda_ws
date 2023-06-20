#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy, sys
import moveit_commander
from moveit_commander import MoveGroupCommander
from geometry_msgs.msg import Pose
from copy import deepcopy

from hand_roscv.msg import control_msg
from hand_roscv.srv import control_srv, control_srvResponse, control_srvRequest

import geometry_msgs.msg

import math, time



class panda_moveit:
    def __init__(self):
        # 初始化move_group的API
        moveit_commander.roscpp_initialize(sys.argv)

        # 初始化ROS节点
        rospy.init_node('moveit_cartesian', anonymous=True)

        self.clt = rospy.ServiceProxy("control_service", control_srv)

        self.clt.wait_for_service()

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

        self.control_value = control_srvResponse()

        self.if_init_ready_pose = False
        self.panda_ready_pose = None

        self.task_init = False
        self.task_start_pose = None
        self.task_start_control_value = None

        self.last_task = None

        self.move_coff = 0.5


# 判断control_value是否为0
def is_zero(control_value):
    if control_value.vector0 == 0 and control_value.vector1 == 0 and control_value.vector2 == 0:
        return True
    else:
        return False


panda = panda_moveit()



def main():


    while not rospy.is_shutdown():


        if panda.if_init_ready_pose == False:
            print("正在初始化机械臂")
            panda.arm.set_named_target('ready')
            panda.arm.go()
            panda.if_init_ready_pose = True
            # 获取当前位姿数据最为机械臂运动的起始位姿
            panda.panda_ready_pose = panda.arm.get_current_pose(panda.end_effector_link).pose
            print("机械臂初始化完成")
            num = control_srvRequest()
            num.request_num = 1
            panda.control_value = panda.clt.call(num)

        else:

            num = control_srvRequest()
            num.request_num = panda.request_num

            panda.last_task = panda.control_value.task
            panda.control_value = panda.clt.call(num)


            if panda.last_task != panda.control_value.task or is_zero(panda.control_value) == True:
                panda.task_init = False

            if panda.control_value.task == "position" and is_zero(panda.control_value) == False:

                if panda.task_init == False:
                    panda.task_start_pose = panda.arm.get_current_pose(panda.end_effector_link).pose
                    panda.task_start_control_value = panda.control_value
                    panda.task_init = True
                    continue

                # 获取机械臂末端的当前位置作为运动初始位置
                start_pose = panda.arm.get_current_pose(panda.end_effector_link).pose

                target_pose = geometry_msgs.msg.Pose()
                target_pose.position.x = panda.task_start_pose.position.x + (panda.control_value.vector0 - panda.task_start_control_value.vector0) * panda.move_coff
                target_pose.position.y = panda.task_start_pose.position.y + (panda.control_value.vector1 - panda.task_start_control_value.vector1) * panda.move_coff
                target_pose.position.z = panda.task_start_pose.position.z + (panda.control_value.vector2 - panda.task_start_control_value.vector2) * panda.move_coff
                
                # 计算本次移动距离
                distance = math.sqrt(
                                    (target_pose.position.x - start_pose.position.x) * (target_pose.position.x - start_pose.position.x) +
                                    (target_pose.position.y - start_pose.position.y) * (target_pose.position.y - start_pose.position.y) +
                                    (target_pose.position.z - start_pose.position.z) * (target_pose.position.z - start_pose.position.z))
                
                # print("distance: ", distance)
                # print("初始位置:", panda.task_start_control_value)
                # print("当前位置：", panda.control_value)

                if distance < 0.001:
                    continue

                time_start = time.time()

                target_pose.orientation = start_pose.orientation

                waypoints = []
                waypoints.append(deepcopy(start_pose))
                waypoints.append(deepcopy(target_pose))

                fraction = 0.0   #路径规划覆盖率
                maxtries = 100   #最大尝试规划次数
                attempts = 0     #已经尝试规划次数
                
                # 设置机器臂当前的状态作为运动初始状态
                panda.arm.set_start_state_to_current_state()
                # 设置执行时间限制为1秒
                panda.arm.set_planning_time(0.1)
            
                # 尝试规划一条笛卡尔空间下的路径，依次通过所有路点
                while fraction < 1.0 and attempts < maxtries:
                    (plan, fraction) = panda.arm.compute_cartesian_path (
                                    waypoints,   # waypoint poses，路点列表
                                    0.0001,        # eef_step，终端步进值
                                    0.0,         # jump_threshold，跳跃阈值
                                    True)        # avoid_collisions，避障规划
                    
                    # 尝试次数累加
                    attempts += 1

                time_middle = time.time()
                                
                # 如果路径规划成功（覆盖率100%）,则开始控制机械臂运动
                if fraction == 1.0:
                    print("规划距离:", "规划点数量:", len(plan.joint_trajectory.points))
                    panda.arm.execute(plan, wait=True)
                # 如果路径规划失败，则打印失败信息
                else:
                    rospy.loginfo("Path planning failed with only " + str(fraction) + " success after " + str(maxtries) + " attempts.")  

                time_end = time.time()
                print("time_middle: ", time_middle - time_start, "time_end: ", time_end - time_start)

            if panda.control_value.task == "return":
                panda.if_init_ready_pose = False

        rospy.sleep(0.05)

            

        


if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass



