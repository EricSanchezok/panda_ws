#!/usr/bin/env python

import rospy
from std_msgs.msg import String

def keyboard_input():
    rospy.init_node('keyboard_input_node', anonymous=True)
    pub = rospy.Publisher('keyboard_input', String, queue_size=10)

    while not rospy.is_shutdown():
        # Read keyboard input
        user_input = input("Enter a command: ")

        # Publish keyboard input to 'keyboard_input' topic
        pub.publish(user_input)

if __name__ == '__main__':
    try:
        keyboard_input()
    except rospy.ROSInterruptException:
        pass
