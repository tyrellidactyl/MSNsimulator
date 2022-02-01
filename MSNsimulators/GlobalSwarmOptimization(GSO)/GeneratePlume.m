gas = 'CO2'; % Zn, CO2, CO, Cl, He

setparams;   % read parameters from a file

% Other parameters:
Q = 10; % emission rate (g/s)
tpy2kgps = 1.0 / 31536; % conversion factor (tonne/yr to kg/s)
%source.Q = [Q] * tpy2kgps; % emission rate (kg/s)
source.Q = Q/1000; % emission rate (kg/s)

% stability class:
stability = 'A'; % A,B,C,D,E,F from most unstable to most stable
terrain = 'rural'; % rural or urban
Uwind = 3;   % wind speed (m/s) 


% Set plotting parameters.
Res = 1;
xlim = [  0, 1000];
ylim = [-250,  250];
nx = Res*xlim(2);
ny = Res*(2*ylim(2));
x0 = xlim(1) + [0:nx]/nx * (xlim(2)-xlim(1)); % distance along wind direction (m)
y0 = ylim(1) + [0:ny]/ny * (ylim(2)-ylim(1)); % cross-wind distance (m)
[xmesh, ymesh] = meshgrid( x0, y0 );          % mesh points for contour plot

glc = 0;

glc = glc + gplume( xmesh-source.x, ymesh-source.y, 0.0, ...
                      source.z, source.Q, Uwind, stability, terrain );
                  
[sigmay,sigmaz] = stabilityClass(stability,terrain,x0);
                  
glc2 = glc*1e6;  % convert concentration to mg/m^3