#!/bin/bash

export ROS_IP=$(ifconfig wlp3s0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')

sudo killall rosmaster
sudo killall gzserver
sudo killall gzclient
roslaunch nre_p3at p3at.gazebo.launch initX:=0.0 initY:=0.0 initYaw:=3.1415

