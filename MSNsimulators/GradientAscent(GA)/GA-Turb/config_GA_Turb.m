clear; clc;    % cd('/home/ty/MSNsimulator/')

%% Simulation Parameter Configuration:
modelParameters;

N = 8; %total number of sensors
n = [];
for i = 0:(N-1)
    n = [n; i*(2*pi/N)];
end
%m = [0;0;1.2566;2.5133;3.7699;5.0265];

%% Test Initialization:
algorithm = "GA"; %  "GA" - "GAv2" - "GA-w"
plumecase = 9; % Plume Model case
testcase = 5; % Initial Position Test Iteration (0-12)
trial = 0; % Trials for each algorithm - GA: sensor quantity
metric = 0; % Metric test cases (trial 0 for default values)
dynamicPlume = 0;
turbulence = 1;

path = "MSNsimulator/MSNsimulators/GradientAscent(GA)/GA-Turb/Case" + plumecase + "/Test" + testcase + "/";
str = algorithm + "case" + plumecase + "test" + testcase + "trial" + trial + "N" + N + "metric" + metric;

%% Plume Model Configuration:
%[l,L,PlumeD,WindX,WindD] = plumeShape(plumecase); % add T,Ts,Res to output for dynamic plumes
%[PlumeD,SigmaY,Sclass] = GPlume(plumecase);
[PlumeD,MaxC,T,ResX,ResY,OffsetX,OffsetY,gasMap,plumeType] = LoadPlumeTurbVorticity(plumecase);
%MaxC = max(max(max(PlumeD)));

%% Spawn MSN:
% add Tmax to spawnmsn
[initX,initY,initAngle,Tmax] = SpawnMSN(testcase); % Initialize Spawn point and starting goal
origin = [initX,initY]; % spawn point
goalpoints = origin; % initialize goalpoint
init = [initX - 5,initY];
distError = sqrt((initX^2)+(initY^2)); % Initial displacement

%% Gradient Ascent (GA):
[mag,sensorDist,distThresh] = GradientAscentMetrics(trial); % 0 default
GAmetrics = [mag,sensorDist,distThresh,N];

%% Other
% Gazebo and Simulink plume origin coordinates
Area = 1000;      
Mid = Area/2; 
Res = 1;   
Offset = [OffsetX,OffsetY]; %Offset = Mid;
x_g = 0;      x = (x_g+OffsetX);
y_g = 0;      y = (y_g+OffsetY);

gazeboPause;
