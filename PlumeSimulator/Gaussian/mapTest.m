PlumeFinal = flipud(PlumeD(:,:)); 
PlumeFinal = PlumeFinal(
Vf = PlumeFinal/(1.0e+03);  % Normalized starting and ending plume visual
Vf = round(Vf);
Vf = Vf/1000000;

%%
T = 5;          
Area = 1000;            Mid = Area/2;       
ResX = 1;            ResY = 1;
OffsetX = Mid/ResX;   OffsetY = 250;
gasMap = robotics.OccupancyGrid(Vf);      
gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
%gasMap.FreeThreshold = 0.0000001;
%gasMap.OccupiedThreshold = 0.0000001;
inflate(gasMap,100);
gasMap.show

%%
%f2 = figure(2)
%contour(Vf)