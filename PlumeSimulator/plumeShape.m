function [l,L,PlumeD,WindX,WindD] = plumeShape(plumecase)

% Cases: Turbulent Axisymmetric Plumes - 
% 4: Heat Flux: 0.50
% 5: Heat Flux: 1.50
% 6: Heat Flux: 2.50


plumecase = num2str(plumecase);

    switch(plumecase)
    
    case '1'
        load('PlumeSimulator/Turbulent/Case_F050/Plume.mat');
        load('PlumeSimulator/Turbulent/Case_F050/PlumeD.mat');
        load('PlumeSimulator/Turbulent/Case_F050/WindD.mat');
        load('PlumeSimulator/Turbulent/Case_F050/WindX.mat');    
        l = 5; % Source Radius (default: 5)
        L = 60; % Dispersion Length (default: 90)
        
    case '2'
        load('PlumeSimulator/Turbulent/Case_F150/Plume.mat');
        load('PlumeSimulator/Turbulent/Case_F150/PlumeD.mat');
        load('PlumeSimulator/Turbulent/Case_F150/WindD.mat');    
        l = 5; % default: 5
        L = 90; % default: 25
        
    case '3'
        load('PlumeSimulator/Turbulent/Case_F250/Plume.mat');
        load('PlumeSimulator/Turbulent/Case_F250/PlumeD.mat');
        load('PlumeSimulator/Turbulent/Case_F250/WindD.mat');
        l = 5; % default: 5
        L = 90; % default: 25
        
    case '4' % plume characteristics estimation (far field)
        load('PlumeSimulator/Turbulent/Case_F050/Plume.mat');
        load('PlumeSimulator/Turbulent/Case_F050/PlumeD.mat');
        load('PlumeSimulator/Turbulent/Case_F050/WindD.mat');
        load('PlumeSimulator/Turbulent/Case_F050/WindX.mat');     
        l = 5; % Source Radius (default: 5)
        L = 90; % Dispersion Length (default: 90)
        
    case '5' % plume characteristics estimation (mid field)
        load('PlumeSimulator/Turbulent/Case_F050/Plume.mat');
        load('PlumeSimulator/Turbulent/Case_F050/PlumeD.mat');
        load('PlumeSimulator/Turbulent/Case_F050/WindD.mat');
        load('PlumeSimulator/Turbulent/Case_F050/WindX.mat');     
        l = 5; % Source Radius (default: 5)
        L = 55; % Dispersion Length (default: 55)
        
    case '6' % plume characteristics estimation (close field)
        load('PlumeSimulator/Turbulent/Case_F050/Plume.mat');
        load('PlumeSimulator/Turbulent/Case_F050/PlumeD.mat');
        load('PlumeSimulator/Turbulent/Case_F050/WindD.mat');
        load('PlumeSimulator/Turbulent/Case_F050/WindX.mat');     
        l = 5; % Source Radius (default: 5)
        L = 20; % Dispersion Length (default: 20)
        
        
        otherwise
            
    end
    
end