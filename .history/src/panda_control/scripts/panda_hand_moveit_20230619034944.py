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

        self.control_value = control_srv()
        self.if_init = False

        self.start_pose = None

        self.if_task_init = False
        self.task_start_pose = None


panda = panda_moveit()



def main():


    while not rospy.is_shutdown():

        num = control_srvRequest()
        num.request_num = panda.request_num

        panda.control_value = panda.clt.call(num)

        print("panda.control_value:", panda.control_value)

        if panda.if_init == False:
            panda.arm.set_named_target('ready')
            panda.arm.go()
            panda.if_init = True
            print("正在初始化机械臂")

            rospy.sleep(3)
            # 获取当前位姿数据最为机械臂运动的起始位姿
            panda.start_pose = panda.arm.get_current_pose(panda.end_effector_link).pose

            print("机械臂初始化完成")

        else:

            if panda.control_value.task == "position":
                if panda.if_task_init == False:
                    panda.task_start_pose = panda.arm.get_current_pose(panda.end_effector_link).pose
                    panda.if_task_init = True

                # 获取机械臂末端的当前位置作为运动初始位置
                start_pose = panda.arm.get_current_pose(panda.end_effector_link).pose

                target_pose = geometry_msgs.msg.Pose()
                target_pose.position.x = panda.task_start_pose.position.x + panda.control_value.vector0
                target_pose.position.y = panda.task_start_pose.position.y + panda.control_value.vector1
                target_pose.position.z = panda.task_start_pose.position.z + panda.control_value.vector2

                target_pose.orientation = panda.task_start_pose.orientation

                waypoints = []
                waypoints.append(deepcopy(start_pose))
                waypoints.append(deepcopy(target_pose))

                fraction = 0.0   #路径规划覆盖率
                maxtries = 100   #最大尝试规划次数
                attempts = 0     #已经尝试规划次数
                
                # 设置机器臂当前的状态作为运动初始状态
                panda.arm.set_start_state_to_current_state()
            
                # 尝试规划一条笛卡尔空间下的路径，依次通过所有路点
                while fraction < 1.0 and attempts < maxtries:
                    (plan, fraction) = panda.arm.compute_cartesian_path (
                                    waypoints,   # waypoint poses，路点列表
                                    0.01,        # eef_step，终端步进值
                                    0.0,         # jump_threshold，跳跃阈值
                                    True)        # avoid_collisions，避障规划
                    
                    # 尝试次数累加
                    attempts += 1
                    
                    # 打印运动规划进程
                    if attempts % 10 == 0:
                        rospy.loginfo("Still trying after " + str(attempts) + " attempts...")
                                
                # 如果路径规划成功（覆盖率100%）,则开始控制机械臂运动
                if fraction == 1.0:
                    rospy.loginfo("Path computed successfully. Moving the arm.")
                    panda.arm.execute(plan)
                    rospy.loginfo("Path execution complete.")
                # 如果路径规划失败，则打印失败信息
                else:
                    rospy.loginfo("Path planning failed with only " + str(fraction) + " success after " + str(maxtries) + " attempts.")  


            if panda.control_value.task == "return":
                panda.if_init = False

            

        


if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass



