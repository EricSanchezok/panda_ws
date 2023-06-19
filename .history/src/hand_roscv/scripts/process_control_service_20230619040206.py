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
from hand_roscv.srv import control_srv, control_srvResponse, control_srvRequest


import rospy 
from sensor_msgs.msg import Image
from cv_bridge import CvBridge 

import torch
import os

import cv2


class server:
    def __init__(self) -> None:
        self.hand_detector = ph.mediaPipeHand()
        self.fps = vs.FPS()

        self.task_distributor = pt.task_distributor()

        # 加载模型
        self.model = pm.get_model(num_classes=11, global_feat=True, feature_transform=False, channel=3)

        self.model_dir = os.path.join(os.path.abspath(os.path.dirname(os.path.dirname(__file__))), 'scripts/model/model.pth')

        self.model.load_state_dict(torch.load(self.model_dir))

        self.L515 = rs.realSense()

        self.fliter_point = None

    def server_get_frame(self):
        self.aligned_depth_frame, self.color_frame = self.L515.get_frame()

        if not self.aligned_depth_frame or not self.color_frame:
            return False
        
        self.ori_color_image = np.asanyarray(self.color_frame.get_data())

        self.show_color_image = self.ori_color_image.copy()

        self.dt = self.fps.showFPS(self.show_color_image, printFPS=False)

    def server_process_frame(self):

        self.points, self.results = self.hand_detector.get_world_points(self.show_color_image, drawPoints=True)

        self.angle_list = pg.cal_finger_angle(self.results, self.show_color_image)

        self.pred_index = pg.get_pred(self.model, self.points, self.angle_list, IsPrint=False)

        self.fliter_point, self.target_image = pp.point_proccessing(self.pred_index, self.results, self.ori_color_image, self.aligned_depth_frame, self.L515, self.dt)

        self.task_distributor.srv_value = self.task_distributor.handle_all_process(self.pred_index, self.fliter_point)
            
        if self.target_image is not None:
            cv2.imshow('ResaultWindow', self.target_image)
                    

    def server_show_frame(self):

        cv2.namedWindow('ResaultWindow', cv2.WINDOW_AUTOSIZE)
        cv2.imshow('ResaultWindow', self.show_color_image)


server = server()
        
  
def doReq(req):

    value = control_srvResponse()

    # 解析提交的数据
    if req.request_num == 0:
        if server.task_distributor.srv_value is None:
            return value
        
        value.task = server.task_distributor.work_mode
        value.vector0 = server.task_distributor.srv_value[0]
        value.vector1 = server.task_distributor.srv_value[1]
        value.vector2 = server.task_distributor.srv_value[2]    

        return value
    
    return value


def main():
   
    rospy.init_node('process_control_service_node', anonymous=True)
   
    srv = rospy.Service("control_service", control_srv, doReq)

    while not rospy.is_shutdown():
      
        server.server_get_frame()

        server.server_process_frame()

        server.server_show_frame()

        key = cv2.waitKey(1)

        if key & 0xFF == ord('q') or key == 27:
            cv2.destroyAllWindows()
            break

         
if __name__ == '__main__':
  try:
    main()
  except rospy.ROSInterruptException:
    pass

  finally:
    server.L515.pipeline.stop()
