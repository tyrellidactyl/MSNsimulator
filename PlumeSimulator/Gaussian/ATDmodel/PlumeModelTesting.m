
x = 5;
c = 12.5;
d = 1.0857;
TH = 0.017453293 * (c - (d*log(x)));
sigy = 465.11628 * (x) * tan(TH);

a = 61.141;
b = 0.91465;
sigz = a*(x)^b;


ay = 0.34;  by = 0.82;  
az = 0.275; bz = 0.82;  
sigmay = ay*abs(x).^by .* (x > 0);
sigmaz = az*abs(x).^bz .* (x > 0);

%%
%C=gaussianPlume(500);
C=gaussianPlume(500, 5, 50, 'h_ref', 10, 'reflection', false, ...
'deposition', false, 'amb_pres', 1103, 'amb_temp', 22);
Plume = C(:,:,1);
%       Computes the steady-state Gaussian-distribution of an emission at a
%       rate of 500g/s with average wind speed of 5m/s at 10m from a
%       physical stack height of 50m. No plume rise, reflection, nor
%       deposition will be modeled. The data will be sampled in 100m
%       resolution across the downwind and crosswind axes from 1 to 5km and
%       1 to 1km in the vertical axis.
