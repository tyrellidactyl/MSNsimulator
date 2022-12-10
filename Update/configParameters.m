clear; clc;    % cd('/MSNsimulator/')

%% Simulation Parameter Configuration:
modelParameters;

N = 8; % total number of concentration sensors
% initialize the sensor positions in a circular array around the ugv center
n = [];
for i = 0:(N-1)
    n = [n; i*(2*pi/N)];
end

%% Test Initialization:
plumecase = 9; % Plume Model case
testcase = 5; % Initial Position Test Iteration (0-12)
trial = 0; % Trials for each algorithm - GA: sensor quantity - APS: path shape
metric = 0; % Metric test cases (trial 0 for default values)
algorithm = "GA"; %  'BB" - "GA" - "GAv2" - "APS" - "Hybrid" - "PDE"

% path to save results in:
path = "MSNsimulator/Results/PlumeCases/Case" + plumecase + "/Test" + testcase + "/";
str = algorithm + "case" + plumecase + "test" + testcase + "trial" + trial + "N" + N + "metric" + metric;

%% Plume Model Configuration:
dynamicPlume = 0; % plume concentration moves over time?
turbulence = 1; % is turbulence included? 

if turbulence == 1
    [l,L,PlumeD,WindX,WindD] = plumeShape(plumecase); % add T,Ts,Res to output for dynamic plumes
else
    [PlumeD,SigmaY,Sclass] = GPlume(plumecase);
end

[T,ResX,ResY,OffsetX,OffsetY,gasMap] = GplumeParameters(plumecase,PlumeD);
MaxC = max(max(max(PlumeD))); % max concentration

%% Spawn MSN:
% add Tmax to spawnmsn
[initX,initY,initAngle,Tmax] = SpawnMSN(testcase); % Initialize Spawn point and starting goal
origin = [initX,initY]; % spawn point
goalpoints = origin; % initialize goalpoint at origin
init = [initX - 5,initY]; % vehicle spawn position (offset 5 meters)
distError = sqrt((initX^2)+(initY^2)); % Initial displacement from source

if algorithm == 'GA'
    [mag,sensorDist,distThresh] = GradientAscentMetrics(trial);
    %GAmetrics = [mag,sensorDist,distThresh,N];
else if algorithm == 'APS'
    [Expand,LimitSize,InitSize] = APSmetrics(metric); 
    Shrink = 1/Expand;
    [waypoints,finalPoint] = initPathPoints(trial,init,InitSize); % Path Selector
    %APSmetrics = [Expand,LimitSize];
    pathUpdates = [];
else
    %
end

%% Domain parameters
Area = 1000;      
Mid = Area/2; 
Res = 1;   
Offset = [OffsetX,OffsetY];

% Gazebo and Simulink plume origin coordinates
%x_g = 0;      x = (x_g+OffsetX);
%y_g = 0;      y = (y_g+OffsetY);
gazeboPause;
