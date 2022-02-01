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
path = "MSNsimulator/TestResults/PlumeCases/Case" + plumecase + "/Test" + testcase + "/";
str = algorithm + "case" + plumecase + "test" + testcase + "trial" + trial + "N" + N + "metric" + metric;




%% Plume Model Configuration:
dynamicPlume = 0; % plume concentration updates over time?
turbulence = 1; % is turbulence included? for visualizing results after trial
%[l,L,PlumeD,WindX,WindD] = plumeShape(plumecase); % add T,Ts,Res to output for dynamic plumes
[PlumeD,SigmaY,Sclass] = GPlume(plumecase);
[T,ResX,ResY,OffsetX,OffsetY,gasMap] = GplumeParameters(plumecase,PlumeD);
MaxC = max(max(max(PlumeD)));

%% Spawn MSN:
% add Tmax to spawnmsn
[initX,initY,initAngle,Tmax] = SpawnMSN(testcase); % Initialize Spawn point and starting goal
origin = [initX,initY]; % spawn point
goalpoints = origin; % initialize goalpoint
init = [initX - 5,initY];
distError = sqrt((initX^2)+(initY^2)); % Initial displacement

%% Gradient Ascent (GA):
[mag,sensorDist,distThresh] = GradientAscentMetrics(trial);
%GAmetrics = [mag,sensorDist,distThresh,N];

%% Adaptive Peak Seeking (APS):
% add initSize metric
[Expand,LimitSize,InitSize] = APSmetrics(metric);
%Expand = 2;    LimitSize = 3;   
Shrink = 1/Expand;
[waypoints,finalPoint] = initPathPoints(trial,init,InitSize); % Path Selector
%APSmetrics = [Expand,LimitSize];

pathUpdates = [];

%[waypoints,finalPoint] = initWaypoints(trial,init); % Path Selector
%[Expand,LimitSize] = APSmetrics(trial);

%% Other
% Gazebo and Simulink plume origin coordinates
Area = 1000;      
Mid = Area/2; 
Res = 1;   
Offset = [OffsetX,OffsetY];
%x_g = 0;      x = (x_g+OffsetX);
%y_g = 0;      y = (y_g+OffsetY);

gazeboPause;
