function [PlumeD,MaxC,T,ResX,ResY,OffsetX,OffsetY,gasMap,str] = LoadPlumeTurbVorticity(plumecase)

plumecase = num2str(plumecase);

    switch(plumecase)

   case '1'
        path = 'home/ty/MSNsimulator/TurbulentPlumeSimulator/CO2/Dense_Plume/';
        str = 'CO2-DensePlume';
        load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/CO2/Dense_Plume/PlumeF100.mat');
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassF-rural-CO2SigmaY.mat");
        PlumeD = Plume;
        
   case '2' % vorticity
        path = 'home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/';
        str = 'CaseF050-VxT20';
        load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/VxsliceT20.mat');
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassF-rural-CO2SigmaY.mat");
        PlumeD = VxsliceT20;
        
   case '3'
        path = 'home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/';
        str = 'VorticityX';
        load("home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/ScaledVxslice.mat");
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassF-rural-CO2SigmaY.mat");
        
   case '4'
        path = 'home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/';
        str = 'VorticityY';
        load("home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/ScaledVyslice.mat");
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassF-rural-CO2SigmaY.mat");
        
   case '5'
        path = 'home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/';
        str = 'VorticityZ';
        load("home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/ScaledVzslice.mat");
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassF-rural-CO2SigmaY.mat");
        
   
        
        otherwise
            
    end
    MaxC = max(max(max(PlumeD)));
    PlumeFinal = flipud(PlumeD(:,:)); 
    Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
    T = 5;          
    Area = 700;           Mid = Area/2;       
    ResX = 1;             ResY = 1;
    OffsetX = Mid/ResX;   OffsetY = 25;
    gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
    gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
end