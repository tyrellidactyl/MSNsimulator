# MSNsimulator
 
First, clone the following ros package in your catkin workspace, then build it:
https://github.com/tyrellidactyl/msn.git

Dependencies:
amr_robots_description
gazebo_ros

1) source your workspace and run roscore in a terminal shell
2) within catkin_ws/src/msn/scripts, run ./msn.sh
This script restarts ros and launches the pioneer ugv in an empty Gazebo world.