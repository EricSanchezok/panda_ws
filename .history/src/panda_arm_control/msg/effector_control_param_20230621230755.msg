string work_mode
string supplement
float32 x0
float32 y0
float32 z0
float32 x
float32 y
float32 z
float32 w
moveit_msgs/RobotTrajectory path

from geometry_msgs.msg import Pose, PoseStamped
from moveit_msgs.msg import (
    RobotTrajectory,
    Grasp,
    PlaceLocation,
    Constraints,
    RobotState,
)