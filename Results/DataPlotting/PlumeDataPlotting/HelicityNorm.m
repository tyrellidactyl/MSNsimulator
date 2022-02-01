%% CLEAR MEMORY
clearvars;clc;
format long;
%% DATA

% Load the velocities data
% Make sure all the velocities have same dimensions
varstr='NBL_3D_U_F050';
U= load('NBL_3D_U_F050'); 
V= load('NBL_3D_V_F050');
W= load('NBL_3D_W_F050'); 
W2=W.data;
%% Get the dimensions of the velocity fields

ndims = size(W2);
nx  = ndims(1);
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

%declare ceneter of plume
xcenter=23;
ycenter=23;
%% H

for t = 1:nt
   %calculate nondim. UVW 
     U_nd = U.data(:,:,:,t);
     V_nd = V.data(:,:,:,t);
     W_nd = W.data(:,:,:,t);
  
  
        [dUdx,dUdy,dUdz] = gradient(U_nd,dx,dy,dz);
        [dVdx,dVdy,dVdz] = gradient(V_nd,dx,dy,dz);
        [dWdx,dWdy,dWdz] = gradient(W_nd,dx,dy,dz);
  
   
   %BdUdx etc are not used for any calculations (should be relased if memory is running out 
  
   for i = 1:nx
    for j = 1:ny
        for k = 1:nz
            dudx=dUdx(i,j,k);
            dudy=dUdy(i,j,k);
            dudz=dUdz(i,j,k);
            dvdx=dVdx(i,j,k);
            dvdy=dVdy(i,j,k);
            dvdz=dVdz(i,j,k);
            dwdx=dWdx(i,j,k);  
            dwdy=dWdy(i,j,k);
            dwdz=dWdz(i,j,k);
            u=U_nd(i,j,k);
            v=V_nd(i,j,k);
            w=W_nd(i,j,k);
            Vorticity_x= dwdy - dvdz;
            Vorticity_y= dudz - dwdx;
            Vorticity_z= dvdx - dudy;
            H_n(i,j,k,t)=(u*Vorticity_x+v*Vorticity_y+w*Vorticity_z)/(sqrt(u^2+v^2+w^2)*sqrt(Vorticity_x^2+Vorticity_y^2+Vorticity_z^2));
            H(i,j,k,t)=(u*Vorticity_x+v*Vorticity_y+w*Vorticity_z);
          
        end %i
    end %j
   end %k
disp(t);
end %t
  %% save
  save(strcat(varstr,'_H'),'H','-v7.3');
  save(strcat(varstr,'_H_nd'),'H_n','-v7.3');