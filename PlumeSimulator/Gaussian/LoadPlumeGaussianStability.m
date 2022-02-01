function [PlumeD,SigmaY,str] = LoadPlumeGaussianStability(plumecase)
% Fixed: Static Gaussian Plumes - 
%         Fixed Ground Source, 
%           Wind Velocity = [0,2,0], 
%             Diffusion constant: 0.5

plumecase = num2str(plumecase);

    switch(plumecase)
        
   case '1'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q10-U3-ClassA-rural-CO2';
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassA-rural-CO2PlumeD.mat");
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassA-rural-CO2SigmaY.mat");
        
   case '2'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q10-U3-ClassB-rural-CO2';
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassB-rural-CO2PlumeD.mat");
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassB-rural-CO2SigmaY.mat");
   
   case '3'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q10-U3-ClassC-rural-CO2';
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassC-rural-CO2PlumeD.mat");
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassC-rural-CO2SigmaY.mat");
        
   case '4'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q10-U3-ClassD-rural-CO2';
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassD-rural-CO2PlumeD.mat");
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassD-rural-CO2SigmaY.mat");
   
   case '5'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q10-U3-ClassE-rural-CO2';
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassE-rural-CO2PlumeD.mat");
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassE-rural-CO2SigmaY.mat");
        
   case '6'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q10-U3-ClassF-rural-CO2';
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassF-rural-CO2PlumeD.mat");
        load("/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassF-rural-CO2SigmaY.mat");
        
        
        otherwise
            
    end
    PlumeFinal = flipud(PlumeD(:,:)); 
    Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
    T = 5;          
    Area = 1000;            Mid = Area/2;       
    ResX = 1;            ResY = 1;
    OffsetX = Mid/ResX;   OffsetY = 250;
    gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
    gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
end