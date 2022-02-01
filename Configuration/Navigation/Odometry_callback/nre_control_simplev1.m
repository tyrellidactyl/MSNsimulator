%clear
%clc

% Try to start ROS - if it is already started, restart
try
    rosinit
catch
    rosshutdown
    rosinit
end

goal = [3,3];  % Goal position in x/y
% Setup publisher
cmdpub = rospublisher('/sim_p3at/cmd_vel');
cmdmsg = rosmessage('geometry_msgs/Twist');
% Setup subscription - which implemets our controller.
% We pass the publisher, the message to publish and the goal as
% additional parameters to the callback function.
odomsub = rossubscriber('/sim_p3at/odom',{@OdomCallback_v1,cmdpub,cmdmsg,goal});