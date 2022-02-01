function OdomCallback_v1(~,message,pub,msg,goal)
% Implementation of proportional position control
% For comparison to Simulink implementation
% Tunable parameters
wgain = 5; % Gain for the angular velocity [rad/s / rad]
vconst = .5; % Linear velocity when far away [m/s]
distThresh = 0.5; % Distance treshold [m]
% Generate a simplified pose
pos = message.Pose.Pose;
quat = pos.Orientation;
% From quaternion to Euler
angles = quat2eul([quat.W quat.X quat.Y quat.Z]);
theta = angles(1);
pose = [pos.Position.X, pos.Position.Y, theta];  % X, Y, Theta
% Proportional Controller
v = 0; % default linear velocity
w = 0; % default angluar velocity
distance = sqrt((pose(1)-goal(1))^2+(pose(2)-goal(2))^2);
if (distance > distThresh)
    v = vconst;
    desireYaw = atan2(goal(2)-pose(2),goal(1)-pose(1));
    u = desireYaw-theta;
    bound = atan2(sin(u),cos(u));
    w = min(0.5 , max(-0.5, wgain*bound));
end
% Publish
msg.Linear.X = v;
msg.Angular.Z = w;
send(pub,msg);
fprintf('OdomCallback_v1: x=%4.1f,y=%4.1f dist=%4.2f, cmd.v=%4.2f, cmd.w=%4.2f\n', ...
    pose(1),pose(2),distance, v, w);
end