function C = puffplume( x, y, z, H, Q, U, stability, terrain )
% GPLUME: Compute contaminant concentration (kg/m^3) at a given 
%   set of receptor locations using the standard Gaussian plume
%   solution.  This code handles a single source (located at the
%   origin) and multiple receptors.
%
% Input parameters:
%
%     x - receptor locations: distance along the wind direction, with
%         the source at x=0 (m) 
%     y - receptor locations: cross-wind direction (m)
%     z - receptor locations: vertical height (m)
%     H - source height (m)
%     Q - contaminant emission rate (kg/s)
%     U - wind velocity (m/s)
%
% Output:
%
%     C - contaminant concentration (kg/m^3)
%

% First, define the cut-off velocity, below which concentration = 0.
Umin      = 0.0;

%{
% Determine the sigma coefficients based on stability class C --
% slightly unstable (3-5 m/s). 
ay = 0.34;  by = 0.82;  
az = 0.275; bz = 0.82;  
sigmay = ay*abs(x).^by .* (x > 0);
sigmaz = az*abs(x).^bz .* (x > 0);
disp(sigmay)
%}

%stability = 'B';
%terrain = 'rural';
%[sigmay,sigmaz] = stabilityClass(stability,terrain,x);
% neutral puff
sigmay = 0.06 * (x).^0.92;
sigmaz = 0.15 * (x).^0.70;
sigmax = sigmay;

% Calculate the contaminant concentration (kg/m^3) using Ermak's formula.
if U < Umin,
  C = 0 * z;
else
    
  C  = (Q ./ (((2*pi)^1.5)*sigmay.*sigmaz)) .* ...
         exp( -0.5*y.^2./sigmay.^2 ) .* exp( -0.5*x.^2./sigmax.^2 ) .* ...
       ( exp( -0.5*(z-H).^2./sigmaz.^2 ) + exp( -0.5*(z+H).^2./sigmaz.^2 ) );
   
  ii = find(isnan(C) | isinf(C));
  C(ii) = 0;   % Set all NaN or inf values to zero.
end