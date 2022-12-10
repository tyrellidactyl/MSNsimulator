function [PlumeD,SigmaY,str] = GPlume(plumecase)
% Cases: Static Gaussian Plumes - 
%         Fixed Ground Source, 
%           Wind Velocity = [0,2,0], 
%             Diffusion constant: 0.5
% 1: Advection constant: 1  (l=3,L=10)
% 2: Advection constant: 2  (l=4,L=20)
% 3: Advection constant: 2.5  (l=5,L=25)
% 4-9: Stability Class Tests A-F

plumecase = num2str(plumecase);

    switch(plumecase)

    case '1'
        load('PlumeSimulator/Gaussian/CaseData/case1_C.mat');
        load('PlumeSimulator/Gaussian/CaseData/case1_u.mat');
        load('PlumeSimulator/Gaussian/CaseData/case1_v.mat');
        l = 3;
        L = 10;
        
    case '2'
        load('PlumeSimulator/Gaussian/CaseData/case2_C.mat');
        load('PlumeSimulator/Gaussian/CaseData/case2_u.mat');
        load('PlumeSimulator/Gaussian/CaseData/case2_v.mat');
        l = 3; % default: 4
        L = 15; % default: 20
        
    case '3'
        load('PlumeSimulator/Gaussian/CaseData/case3_C.mat');
        load('PlumeSimulator/Gaussian/CaseData/case3_u.mat');
        load('PlumeSimulator/Gaussian/CaseData/case3_v.mat');
        l = 3; % default: 5
        L = 20; % default: 25
        
    case '4'
        path = 'PlumeSimulator/Gaussian/ATDmodel/Models/';
        str = 'Q1-U3-ClassA-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');
        
   case '5'
        path = 'PlumeSimulator/Gaussian/ATDmodel/Models/';
        str = 'Q1-U3-ClassB-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');
   
   case '6'
        path = 'PlumeSimulator/Gaussian/ATDmodel/Models/';
        str = 'Q1-U3-ClassC-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');
        
   case '7'
        path = 'PlumeSimulator/Gaussian/ATDmodel/Models/';
        str = 'Q1-U3-ClassD-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');
   
   case '8'
        path = 'PlumeSimulator/Gaussian/ATDmodel/Models/';
        str = 'Q1-U3-ClassE-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');
        
   case '9'
        path = 'PlumeSimulator/Gaussian/ATDmodel/Models/';
        str = 'Q1-U3-ClassF-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');     

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