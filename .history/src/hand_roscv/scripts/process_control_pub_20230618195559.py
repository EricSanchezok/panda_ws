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

import cv2


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
     
    rospy.init_node('process_control_pub_node', anonymous=True)
     
    rate = rospy.Rate(30)
     
    msg = control_msg()
 
    while not rospy.is_shutdown():
      
        aligned_depth_frame, color_frame = L515.get_frame()

        if not aligned_depth_frame or not color_frame:
            continue

        ori_color_image = np.asanyarray(color_frame.get_data())

        show_color_image = ori_color_image.copy()

        points, results = hand_detector.get_world_points(show_color_image, drawPoints=True)

        dt = fps.showFPS(show_color_image, printFPS=False)

        angle_list = pg.cal_finger_angle(results, show_color_image)

        pred_index = pg.get_pred(model, points, angle_list, IsPrint=False)

        cv2.namedWindow('ResaultWindow', cv2.WINDOW_AUTOSIZE)

        if saveMode:
            #左右翻转
            flip_show_color_image = cv2.flip(ori_color_image, 1)
            flip_points, flip_results = flip_hand_detector.get_world_points(flip_show_color_image, drawPoints=True)

            # 拼接图像
            show_image = np.hstack((show_color_image, flip_show_color_image))
            # 图像尺寸减半
            show_image = cv2.resize(show_image, (0, 0), fx=0.5, fy=0.5)      
            
            

            cv2.imshow('ResaultWindow', show_image)

        else:

            fliter_point, target_image = pp.point_proccessing(pred_index, results, ori_color_image, aligned_depth_frame, L515, dt)

            cv2.imshow('ResaultWindow', show_color_image)

            task_distributor.process_action_signal(pred_index)

            task_distributor.process_current_index(fliter_point)


            # if fliter_point is not None:
            #     value = []
            #     value.append(fliter_point[0])
            #     vs2Dvalue.draw_2Dvalue(value)
                
            # if target_image is not None:
            #     cv2.imshow('ResaultWindow', target_image)
                        
            # else:
            #     cv2.imshow('ResaultWindow', show_color_image)

        fliter_point, target_image = pp.point_proccessing(pred_index, results, ori_color_image, aligned_depth_frame, L515, dt)

        task_distributor.process_action_signal(pred_index)

        task_distributor.process_current_index(fliter_point)

        if fliter_point is not None:

          msg.task = task_distributor.work_mode
          msg.vector0 = fliter_point[0]
          msg.vector1 = fliter_point[1]
          msg.vector2 = fliter_point[2]
      
          rospy.loginfo('publishing control message')
                  
          pub.publish(msg)

          if fliter_point is not None:
              value = []
              value.append(fliter_point[0])
              vs2Dvalue.draw_2Dvalue(value)
              
          if target_image is not None:
              cv2.imshow('ResaultWindow', target_image)
                      
          else:
              cv2.imshow('ResaultWindow', show_color_image)
        
        rate.sleep()
         
if __name__ == '__main__':
  try:
    publish_message()
  except rospy.ROSInterruptException:
    pass