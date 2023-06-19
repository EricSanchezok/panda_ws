#!/usr/bin/env python

# import rospy
# from std_msgs.msg import String
# import sys
# import select
# import termios
# import tty

# def getKey():
#     tty.setraw(sys.stdin.fileno())
#     select.select([sys.stdin], [], [], 0)
#     key = sys.stdin.read(1)
#     termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)
#     return key

# if __name__ == '__main__':
#     try:
#         settings = termios.tcgetattr(sys.stdin)

#         rospy.init_node('keyboard_input_node', anonymous=True)
#         pub = rospy.Publisher('keyboard_input', String, queue_size=10)

#         while not rospy.is_shutdown():
#             # Read keyboard input
#             user_input = getKey()

#             # Publish keyboard input to 'keyboard_input' topic
#             pub.publish(user_input)

#     except rospy.ROSInterruptException:
#         pass
#     finally:
#         termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)


import rospy
import sys, select, tty, termios
from std_msgs.msg import String

import torch
if __name__ == '__main__':
	rospy.init_node('keyboard_input_node')
	pub = rospy.Publisher('keyboard_input',String,queue_size = 1)
	rate = rospy.Rate(100)     #设置发布频率
	old_attr = termios.tcgetattr(sys.stdin)     #备份终端属性
	tty.setcbreak(sys.stdin.fileno())     #设置属性
	print('Please input keys, press Ctrl + C to quit')
	while not rospy.is_shutdown():
		if select.select([sys.stdin], [], [], 0)[0] == [sys.stdin]:     #设置超时参数为0，防止阻塞
			pub.publish(sys.stdin.read(1))
		rate.sleep()     #使用sleep()函数消耗剩余时间
	termios.tcsetattr(sys.stdin, termios.TCSADRAIN, old_attr)     #设置为原先的标准模式
