%% Vehicle Model Parameters
r = .110; % wheel radius [m]
b = .393; % chassis width [m]
swingRadius = 0.34; % Minimum turning radius  [m]

%% PID Motion Controller Parameters
Tu = 5;
Ku = .1;
Kp = 1.5*Ku;
Ki = 1.2*(Ku/Tu);
Kd = (3/40)*(Ku*Tu);

wgain = 2.5; % Gain for the angular velocity [rad/s / rad]
vmax =0.7; % Linear velocity when far away [m/s] (default: 0.5, maximum: 0.7)
angmax = 1.5; % [rad/s] Maximum Suggested: 2.4 rad/s = 140 deg/s

%% Plume Simulation Parameters
Ts = 0.01;     
PlumeUpdateRate = 0.1;
Cthresh = 1;    
sourceAccuracy = 1.5;   
concDetectionAccuracy = 0.9;

