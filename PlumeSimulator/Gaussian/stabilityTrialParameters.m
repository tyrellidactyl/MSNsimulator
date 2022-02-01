%clear; clc;    % cd('/home/ty/MSNsimulator/')

%% Simulation Parameter Configuration:
modelParameters;

N = 6; N2 = N; % total number of sensors
inc = (2*pi)/N; % sensor spacing

n = [];
for i = 0:(N-1)
    n = [n; i*(2*pi/N)];
end


%% Test Initialization:
plumecase = 1; % Plume Model case
testcase = 2; % Initial Position Test Iteration (1-5)
trial = 0; % Trials for each algorithm (trial 0 for default values)

algorithm = "GA"; % "GA" - "APS" - "Hybrid" - "PDE"
dynamicPlume = 0;
turbulence = 0;

path = "MSNsimulator/TestResults/PlumeCases/Case" + plumecase + "/Test" + testcase + "/";
str = algorithm + "case" + plumecase + "test" + testcase + "trial" + trial + "N" + N;

%% Plume Model Configuration:
%[l,L,PlumeD,WindX,WindD] = plumeShape(plumecase); % add T,Ts,Res to output for dynamic plumes
[PlumeD,SigmaY,Sclass] = GPlume(plumecase);
[T,ResX,ResY,OffsetX,OffsetY,gasMap] = GplumeParameters(plumecase,PlumeD);
MaxC = max(max(max(PlumeD)));

%% Spawn MSN:
[initX,initY,initAngle] = SpawnMSN(testcase); % Initialize Spawn point and starting goal
origin = [initX,initY]; % spawn point
goalpoints = origin; % initialize goalpoint
init = [initX - 5,initY];
distError = sqrt((initX^2)+(initY^2)); % Initial displacement

%% Gradient Ascent (GA):
[mag,sensorDist,distThresh] = GAmetrics(trial);
GAmetrics = [mag,sensorDist,distThresh,N];

%% Adaptive Peak Seeking (APS):
Expand = 2;   LimitSize = 3; 
%[waypoints,finalPoint] = initWaypoints(trial,init); % Path Selector
%[Expand,LimitSize] = APSmetrics(trial);
Shrink = 1/Expand;

%% Path Data Estimator (PDE): 
%[waypoints,finalPoint] = initPathPoints(trial,init); % Path Selector
%data = zeros(finalPoint,3);


%% Other
% Gazebo and Simulink plume origin coordinates
Area = 1000;      
Mid = Area/2; 
Res = 1;   
Offset = Mid;
x_g = 0;      x = (x_g+OffsetX);
y_g = 0;      y = (y_g+OffsetY);

ROSconfig;
gazeboPause;




