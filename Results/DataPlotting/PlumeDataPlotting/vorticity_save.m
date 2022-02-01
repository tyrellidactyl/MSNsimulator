
%% CLEAR MEMORY
clearvars;clc;
format long;
%% DATA

% Load the velocities data
% Make sure all the velocities have same dimensions
varstr='NBL_3D_F050' ;
U = load('NBL_3D_U_F050');U=U.data;
V = load('NBL_3D_V_F050');V=V.data;
W = load('NBL_3D_W_F050');W=W.data;
 
%% 
% Get the dimensions of the velocity fields

ndims = size(U);
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
 
% Generate cartesian grid from the axis created
[X,Y,Z] = meshgrid(x,y,z);

%% Instabilities

clear Q_* L2 L2N trace_check

%%
for t = 1:nt
    
%U = udata(:,:,:,t);
%V = vdata(:,:,:,t);
%W = wdata(:,:,:,t);

U2 = U(:,:,:,t);
V2 = V(:,:,:,t);
W2 = W(:,:,:,t);

%[dUdx,dUdy,dUdz] = gradient(U,dx,dy,dz);
%[dVdx,dVdy,dVdz] = gradient(V,dx,dy,dz);
%[dWdx,dWdy,dWdz] = gradient(W,dx,dy,dz);

[dUdx,dUdy,dUdz] = gradient(U2,dx,dy,dz);
[dVdx,dVdy,dVdz] = gradient(V2,dx,dy,dz);
[dWdx,dWdy,dWdz] = gradient(W2,dx,dy,dz);


for i = 1:size(U,1)
    for j = 1:size(U,2)
        for k = 1:size(U,3)

            % Trace check
          %  trace_check(i,j,k) = (dUdx(i,j,k)+dVdy(i,j,k)+dWdz(i,j,k))/3;
            
            dudx=dUdx(i,j,k);
            dudy=dUdy(i,j,k);
            dudz=dUdz(i,j,k);
            dvdx=dVdx(i,j,k);
            dvdy=dVdy(i,j,k);
            dvdz=dVdz(i,j,k);
            dwdx=dWdx(i,j,k);
            dwdy=dWdy(i,j,k);
            dwdz=dWdz(i,j,k);
            
           Vorticity_x(i,j,k,t) = dwdy - dvdz;
           Vorticity_y(i,j,k,t) = dudz - dwdx;
           Vorticity_z(i,j,k,t) = dvdx - dudy;
            
        end
    end
end
disp(t);
end

%% save vorticity
save(strcat(varstr,'_VORTY'),'Vorticity_y','-v7.3');