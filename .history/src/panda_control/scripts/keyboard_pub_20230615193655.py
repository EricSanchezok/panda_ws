#!/usr/bin/env python

import rospy
from std_msgs.msg import String
import sys
import select
import termios
import tty

def getKey():
    tty.setraw(sys.stdin.fileno())
    select.select([sys.stdin], [], [], 0)
    key = sys.stdin.read(1)
    termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)
    return key

if __name__ == '__main__':
    try:
        settings = termios.tcgetattr(sys.stdin)

        rospy.init_node('keyboard_input_node', anonymous=True)
        pub = rospy.Publisher('keyboard_input', String, queue_size=10)

        while not rospy.is_shutdown():
            # Read keyboard input
            user_input = getKey()

            # Publish keyboard input to 'keyboard_input' topic
            pub.publish(user_input)

    except rospy.ROSInterruptException:
        pass
    finally:
        termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)
