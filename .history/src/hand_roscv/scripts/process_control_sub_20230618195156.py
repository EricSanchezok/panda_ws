#! /usr/bin/env python
"""
    订阅方:
        订阅消息

"""
import rospy
from hand_roscv.msg import control_msg

def doControl_msg(msg):
    rospy.loginfo("接收到的控制信息:%s, %.3f, %.3f, %.3f", msg.task, msg.vector0, msg.vector1, msg.vector2)


if __name__ == "__main__":
    #1.初始化节点
    rospy.init_node("process_control_subtest_node")
    #2.创建订阅者对象
    sub = rospy.Subscriber("chatter_person",Person,doPerson,queue_size=10)
    rospy.spin() #4.循环
