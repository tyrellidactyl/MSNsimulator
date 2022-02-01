cmdpub = rospublisher('/sim_p3at/cmd_vel');
cmdmsg = rosmessage('geometry_msgs/Twist');
cmdmsg.Linear.X = 0;
cmdmsg.Angular.Z = 0;
send(cmdpub,cmdmsg);