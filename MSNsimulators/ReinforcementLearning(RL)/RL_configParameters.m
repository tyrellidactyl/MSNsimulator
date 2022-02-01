%clear all; clc; 

%% Simulation Parameter Configuration:
RL_modelParameters;

%% Test Initialization:
trial = 0; % Trials for each algorithm - GA: sensor quantity - APS: path shape
algorithm = "DDQN-Basic"; %  'BB" - "GA" - "GAv2" - "APS" - "Hybrid" - "PDE"
%path = "MSNsimulator/TestResults/PlumeCases/Case" + plumecase + "/Test" + testcase + "/";
%str = algorithm + "case" + plumecase + "test" + testcase + "trial" + trial + "N" + N + "metric" + metric;

%% Spawn MSN:
initX = 0;
initY = 0;
origin = [initX,initY]; % spawn point
domainSize = 5;
goalpoint = randi([-domainSize domainSize],1,2); %goalpoint = [10,10];
%[waypoints,finalPoint] = initPathPoints(trial,goalpoint,8); % Path Selector

%% Initialize Gazebo and create occupancy map
%{
load exampleMaps.mat
whos *Map*
% Create a ROS message from simpleMap using a binaryOccupancyMap object. 
% Write the OccupancyGrid message using writeBinaryOccupancyGrid.
bogMap = binaryOccupancyMap(double(simpleMap));
mapMsg = rosmessage('nav_msgs/OccupancyGrid');
writeBinaryOccupancyGrid(mapMsg,bogMap)
mapMsg
% Use readBinaryOccupancyGrid to convert the ROS message to a binaryOccupancyMap object. 
% Use the object function show to display the map.
bogMap2 = readBinaryOccupancyGrid(mapMsg);
show(bogMap2);
% Create Gazebo object and Pause Gazebo simulation
%ROSconfig;
%gazeboPause;
%}
