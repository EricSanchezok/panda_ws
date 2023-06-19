#!/usr/bin/env python3
import numpy as np


import hand_roscv.process_gesture as pg
import hand_roscv.process_point as pp
import hand_roscv.process_hand as ph
import hand_roscv.process_task as pt
import hand_roscv.pointnet_model as pm

import hand_roscv.realSenseInit as rs
import hand_roscv.visualization as vs

from hand_roscv.msg import control_msg

# import pointnet_model as pm
# import process_point as pp
# import process_hand as ph
# import process_task as pt
# import process_gesture as pg

# import realSenseInit as rs
# import visualization as vs

import rospy 
from sensor_msgs.msg import Image
from cv_bridge import CvBridge 

import torch
import os


hand_detector = ph.mediaPipeHand()

fps = vs.FPS()

vs2Dvalue = vs.plot_2D(1)
task_distributor = pt.task_distributor()


# 加载模型
model = pm.get_model(num_classes=10, global_feat=True, feature_transform=False, channel=3)

model_dir = os.path.join(os.path.abspath(os.path.dirname(os.path.dirname(__file__))), 'scripts/model/model.pth')

model.load_state_dict(torch.load(model_dir))

L515 = rs.realSense()
  
def publish_message():
 
    pub = rospy.Publisher('control_messages', control_msg, queue_size=30)
     
    rospy.init_node('process_control', anonymous=True)
     
    rate = rospy.Rate(30)
     
    br = CvBridge()
 
    while not rospy.is_shutdown():
      
        aligned_depth_frame, color_frame = L515.get_frame()

        if not aligned_depth_frame or not color_frame:
            continue

        #ori_depth_image = np.asanyarray(aligned_depth_frame.get_data())
        ori_color_image = np.asanyarray(color_frame.get_data())

        show_color_image = ori_color_image.copy()

        points, results = hand_detector.get_world_points(show_color_image, drawPoints=True)

        dt = fps.showFPS(show_color_image, printFPS=False)

        angle_list = pg.cal_finger_angle(results, show_color_image)

        pred_index = pg.get_pred(model, points, angle_list, IsPrint=False)

        fliter_point, target_image = pp.point_proccessing(pred_index, results, ori_color_image, aligned_depth_frame, L515, dt)

        task_distributor.process_action_signal(pred_index)

        task_distributor.process_current_index(fliter_point)
     
        rospy.loginfo('publishing show_color_image')
                
        pub.publish(br.cv2_to_imgmsg(show_color_image))
        
        rate.sleep()
         
if __name__ == '__main__':
  try:
    publish_message()
  except rospy.ROSInterruptException:
    pass
