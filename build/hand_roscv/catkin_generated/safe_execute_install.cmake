execute_process(COMMAND "/home/ericsanchez/ros/ros1/panda_ws/build/hand_roscv/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/ericsanchez/ros/ros1/panda_ws/build/hand_roscv/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
