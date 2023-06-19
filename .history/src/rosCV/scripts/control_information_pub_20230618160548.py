#!/usr/bin/env python3

import numpy as np
import cv2
import os

import process_gesture as pg
import process_point as pp
import process_hand as hd
import process_task as pt

import realSenseInit as rs
import visualization as vs

import rospy 
from sensor_msgs.msg import Image
from cv_bridge import CvBridge 


hand_detector = hd.mediaPipeHand()

fps = vs.FPS()

vs2Dvalue = vs.plot_2D(1)
task_distributor = pt.task_distributor()

L515 = rs.realSense()
  
def publish_message():
 
  pub = rospy.Publisher('video_frames', Image, queue_size=30)
     
  rospy.init_node('video_pub_py', anonymous=True)
     
  rate = rospy.Rate(30)
     
  cap = cv2.VideoCapture(0)
     
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

    pred_index = pg.get_pred(points, angle_list, IsPrint=False)
     
      ret, frame = cap.read()
         
      if ret == True:
        rospy.loginfo('publishing video frame')
             
        pub.publish(br.cv2_to_imgmsg(frame))
        
      rate.sleep()
         
if __name__ == '__main__':
  try:
    publish_message()
  except rospy.ROSInterruptException:
    pass
