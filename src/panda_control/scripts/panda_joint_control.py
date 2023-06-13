import rospy
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint

def control_joint_velocity():
    rospy.init_node('joint_velocity_control_example', anonymous=True)
    pub = rospy.Publisher('/panda/joint_trajectory_controller/command', JointTrajectory, queue_size=10)
    rate = rospy.Rate(10)  # 发布频率为10Hz

    print("1")

    # 创建 JointTrajectory 消息
    trajectory = JointTrajectory()
    trajectory.joint_names = ['panda_joint7']  # 指定要控制的关节

    print("2")

    # 创建一个 JointTrajectoryPoint，设置速度为0.1弧度/秒
    point = JointTrajectoryPoint()
    point.velocities = [0.1]  # 设置速度
    point.time_from_start = rospy.Duration(1.0)  # 设置运行时间为1秒
    trajectory.points.append(point)

    print("3")

    while not rospy.is_shutdown():
        pub.publish(trajectory)  # 发布关节轨迹消息
        rate.sleep()

if __name__ == '__main__':
    try:
        print("fuck")
        control_joint_velocity()
    except rospy.ROSInterruptException:
        pass
