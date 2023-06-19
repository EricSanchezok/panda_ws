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
from hand_roscv.srv import control_srv


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
model = pm.get_model(num_classes=11, global_feat=True, feature_transform=False, channel=3)

model_dir = os.path.join(os.path.abspath(os.path.dirname(os.path.dirname(__file__))), 'scripts/model/model.pth')

model.load_state_dict(torch.load(model_dir))

L515 = rs.realSense()
  
def doReq():
 
 
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


        fliter_point, target_image = pp.point_proccessing(pred_index, results, ori_color_image, aligned_depth_frame, L515, dt)

        cv2.imshow('ResaultWindow', show_color_image)

        msg_value = task_distributor.handle_all_process(pred_index, fliter_point)


        if fliter_point is not None:
            value = []
            value.append(fliter_point[0])
            vs2Dvalue.draw_2Dvalue(value)
            
        if target_image is not None:
            cv2.imshow('ResaultWindow', target_image)
                    
        else:
            cv2.imshow('ResaultWindow', show_color_image)


        key = cv2.waitKey(1)

        if key & 0xFF == ord('q') or key == 27:
            cv2.destroyAllWindows()
            break

def main():
   
     
    rospy.init_node('process_control_service_node', anonymous=True)
   
    server = rospy.Service("control_messages",control_srv,doReq)

         
if __name__ == '__main__':
  try:
    publish_message()
  except rospy.ROSInterruptException:
    pass

  finally:
    L515.pipeline.stop()
