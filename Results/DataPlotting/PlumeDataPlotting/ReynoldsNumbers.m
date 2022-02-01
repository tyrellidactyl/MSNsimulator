clear; clc

%%
Case_W = load('MSNsimulator/TurbulentPlumeSimulator/Ammonia/Case1/NBL_3D_W_F100_600_Hot_Buoyant.mat'); 
wdata = Case_W.data;

clear Case_W

%% Get the dimensions of the velocity fields

ndims = size(wdata);
nx = ndims(1);
ny = ndims(2);
nz = ndims(3);
nt = ndims(4);

% Specify the grid size used
dx = 40; dy = 40; dz = 10; % m

% Source diameter
D = 400; % m
 
% Generate axis with center as (0,0,0)
x    = -(nx/2-1)*dx:dx:(nx/2)*dx; x = x - dx/2;
y    = x;
z    = 0:dz:(nz-1)*dz;

%info on center of plume
xcenter=23;
ycenter=23;

% Generate cartesian grid from the axis created
[X,Y,Z] = meshgrid(x,y,z);
%% Means

tstart =1;   %10;org
tend   =90;   %50;org

W_mean = mean(wdata(:,:,:,tstart:tend),4);
Wc=squeeze(W_mean(23,23,:));
%% Plume half width

%for now just setting the start of the self gov. region
zstart=1;
Threshold=1/exp(1);

for zi=zstart:nz
    if W_mean(nx,ycenter,zi)>= (Threshold*Wc(zi))
        l(zi)=x(nx);
        ltest(zi)=x(nx);
    else
        for xi=xcenter:nx
            if W_mean(xi,ycenter,zi)>=(Threshold*Wc(zi))
                c=(W_mean(xi,ycenter,zi)-(Threshold*Wc(zi)))/(W_mean(xi,ycenter,zi)-W_mean(xi+1,ycenter,zi));
                l(zi)=x(xi)+c*dx;
                ltest(zi)=x(xi);
            end
        end
    end
end
      c_confirm=(l-ltest)/dx;
     

 nu = 1.57e-5;

W_Centerline = squeeze(wdata(23,23,:,:));
%W_cmax       = max(squeeze(mean(W_Centerline,2)))
MeanCenterline_W = squeeze(mean(W_Centerline,2));
[WcMax, I]   = max(MeanCenterline_W)
nu = 1.57e-5;
Re = (WcMax .* l(I).* 400)./nu

