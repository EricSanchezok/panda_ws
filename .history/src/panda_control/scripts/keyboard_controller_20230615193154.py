#!/usr/bin/env python

import rospy
from std_msgs.msg import String

def keyboard_input():
    rospy.init_node('keyboard_input_node', anonymous=True)
    pub = rospy.Publisher('keyboard_input', String, queue_size=10)

    while not rospy.is_shutdown():
        # 读取键盘输入
        user_input = raw_input("Enter a command: ")

        # 发布键盘输入到 'keyboard_input' 话题
        pub.publish(user_input)

if __name__ == '__main__':
    try:
        keyboard_input()
    except rospy.ROSInterruptException:
        pass
