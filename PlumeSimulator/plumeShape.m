function [l,L,PlumeD,WindX,WindD] = plumeShape(plumecase)
% Cases: Static Gaussian Plumes - 
%         Fixed Ground Source, 
%           Wind Velocity = [0,2,0], 
%             Diffusion constant: 0.5
% 1: Advection constant: 1  (l=3,L=10)
% 2: Advection constant: 2  (l=4,L=20)
% 3: Advection constant: 2.5  (l=5,L=25)
%
% Cases: Turbulent Axisymmetric Plumes - 
% 4: Heat Flux: 0.50
% 5: Heat Flux: 1.50
% 6: Heat Flux: 2.50
% Cases: 

plumecase = num2str(plumecase);

    switch(plumecase)

    case '1'
        load('home/ty/MSNsimulator/GaussianPlumeSimulator/CaseData/case1_C.mat');
        load('home/ty/MSNsimulator/GaussianPlumeSimulator/CaseData/case1_u.mat');
        load('home/ty/MSNsimulator/GaussianPlumeSimulator/CaseData/case1_v.mat');
        l = 3;
        L = 10;
        
    case '2'
        load('home/ty/MSNsimulator/GaussianPlumeSimulator/CaseData/case2_C.mat');
        load('home/ty/MSNsimulator/GaussianPlumeSimulator/CaseData/case2_u.mat');
        load('home/ty/MSNsimulator/GaussianPlumeSimulator/CaseData/case2_v.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindX.mat');
        l = 3; % default: 4
        L = 15; % default: 20
        
    case '3'
        load('home/ty/MSNsimulator/GaussianPlumeSimulator/CaseData/case3_C.mat');
        load('home/ty/MSNsimulator/GaussianPlumeSimulator/CaseData/case3_u.mat');
        load('home/ty/MSNsimulator/GaussianPlumeSimulator/CaseData/case3_v.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindX.mat');
        l = 3; % default: 5
        L = 20; % default: 25
    
    case '4'
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Plume.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/PlumeD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindX.mat');    
        l = 5; % Source Radius (default: 5)
        L = 60; % Dispersion Length (default: 90)
        
    case '5'
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F150/Plume.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F150/PlumeD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F150/WindD.mat');    
        l = 5; % default: 5
        L = 90; % default: 25
        
    case '6'
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F250/Plume.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F250/PlumeD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F250/WindD.mat');
        l = 5; % default: 5
        L = 90; % default: 25
        
    case '7' % plume characteristics estimation (far field)
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Plume.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/PlumeD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindX.mat');     
        l = 5; % Source Radius (default: 5)
        L = 90; % Dispersion Length (default: 90)
        
    case '8' % plume characteristics estimation (mid field)
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Plume.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/PlumeD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindX.mat');     
        l = 5; % Source Radius (default: 5)
        L = 55; % Dispersion Length (default: 55)
        
    case '9' % plume characteristics estimation (close field)
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Plume.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/PlumeD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindD.mat');
        load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/WindX.mat');     
        l = 5; % Source Radius (default: 5)
        L = 20; % Dispersion Length (default: 20)
        
   case '10'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q1-U3-ClassA-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');
        
   case '11'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q1-U3-ClassB-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');
   
   case '12'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q1-U3-ClassC-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');
        
   case '13'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q1-U3-ClassD-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');
   
   case '14'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q1-U3-ClassE-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');
        
   case '15'
        path = 'home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
        str = 'Q1-U3-ClassF-rural-CO2';
        load(path+str+'PlumeD.mat');
        load(path+str+'SigmaY.mat');     
        
        
        otherwise
            
    end
    
end