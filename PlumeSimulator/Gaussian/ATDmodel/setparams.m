% SETPARAMS: Set up various physical parameters for the atmospheric
%    dispersion problem.

grav  = 9.8;          % gravitational acceleration (m/s^2)
mu    = 1.8e-5;       % dynamic viscosity of air (kg/m.s)

switch(gas)            
    case 'Zn'
rho   = 7.140;         % density of zinc (kg/m^3)
R     = 0.45e-6;      % diameter of zinc particles (m).  See Gatz (1975) 
Wdep  = 0.0062;       % Zn deposition velocity (m/s), in the range [5e-4,1e-2]  
Mzn   =  65.4e-3;     % molar mass of zinc (kg/mol)

    case 'CO2'
rho   = 1.842;          % density (kg/m^3)
R     = 3.34e-10;      % particle diameter (m).  
Wdep  = 0.005;       % deposition velocity (m/s), in the range [5e-4,1e-2]  
Mzn   =  44.01e-3;     % molar mass (kg/mol)
det   = 48.78;        % sensor resolution - minimum detectable concentration (mg/m^3)

    case 'CO'
rho   = 1.165;          % density (kg/m^3)
%R     = ;      % particle diameter (m).  
Wdep  = 0.001;       % deposition velocity (m/s), in the range [5e-4,1e-2]  
Mzn   =  28.01e-3;     % molar mass (kg/mol) 

    case 'Cl2'
rho   = 2.994;          % density (kg/m^3)
%R     = ;      % particle diameter (m).  
Wdep  = 0.001;       % deposition velocity (m/s), in the range [5e-4,1e-2]  
Mzn   =  70.906e-3;     % molar mass (kg/mol)  

    case 'He'
rho   = 0.1664;          % density (kg/m^3)
R     = 10e-15;      % particle diameter (m).  
Wdep  = 0.001;       % deposition velocity (m/s), in the range [5e-4,1e-2]  
Mzn   = 4.02e-3;     % molar mass (kg/mol)  
det   = 48.78;

    otherwise
        
end

% https://www.engineeringtoolbox.com/gas-density-d_158.html

Wset  = 2*rho*grav*R^2 / (9*mu); % settling velocity (m/s): Stokes law

% Stack emission source data:
source.n = 1;                         % # of sources
source.x = [ 0];     % x-location (m)
source.y = [ 0];     % y-location (m)
source.z = [ 0];     % height (m)
source.label=[' Source'];

% Set locations of receptors where deposition measurements are made:
dia   = 1;        % receptor diameter (m)
A     = pi*(dia/2)^2; % receptor area (m^2) 
recept.n = 9;                                                 % # of receptors
recept.x = [  60,  76, 267, 331, 514, 904, 1288, 1254, 972 ]; % x location (m)
recept.y = [ 130,  70, -21, 308, 182,  75,  116,  383, 507 ]; % y location (m)
recept.z = [   0,  10,  10,   1,  15,   2,    3,   12,  12 ]; % height (m)
recept.label=[ ' R1 '; ' R2 '; ' R3 '; ' R4 '; ' R5 '; ' R6 '; ...
               ' R7 '; ' R8 '; ' R9 ' ];