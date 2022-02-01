%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program loads the Eulerian velocity data in Cartesian grid and
% calculates the instabilities based on Lambda-2 and Q-criterion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CLEAR MEMORY
clearvars;clc;
format long;
%% DATA

% Load the velocities data
% Make sure all the velocities have same dimensions

udata = load('NBL_3D_U_F050.mat');udata=udata.data;
vdata = load('NBL_3D_V_F050.mat');vdata=vdata.data;
wdata = load('NBL_3D_W_F050.mat');wdata=wdata.data;
varstr='NBL_3D_F050' ;
%{
udata = readmatrix('He_h01_01_U.csv');
udata=reshape(udata,45,45,700,541);
vdata = readmatrix('He_h01_01_V.csv');
vdata=reshape(vdata,45,45,700,541);
wdata = readmatrix('He_h01_01_W.csv');
wdata=reshape(wdata,45,45,700,541);
%}
%% 
% Get the dimensions of the velocity fields

ndims = size(udata);
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
    
U = udata(:,:,:,t);
V = vdata(:,:,:,t);
W = wdata(:,:,:,t);


[dUdx,dUdy,dUdz] = gradient(U,dx,dy,dz);
[dVdx,dVdy,dVdz] = gradient(V,dx,dy,dz);
[dWdx,dWdy,dWdz] = gradient(W,dx,dy,dz);

%

for i = 1:size(U,1)
    for j = 1:size(U,2)
        for k = 1:size(U,3)

            % Trace check
            trace_check(i,j,k) = (dUdx(i,j,k)+dVdy(i,j,k)+dWdz(i,j,k))/3;
            
            dudx=dUdx(i,j,k);
            dudy=dUdy(i,j,k);
            dudz=dUdz(i,j,k);
            dvdx=dVdx(i,j,k);
            dvdy=dVdy(i,j,k);
            dvdz=dVdz(i,j,k);
            dwdx=dWdx(i,j,k);
            dwdy=dWdy(i,j,k);
            dwdz=dWdz(i,j,k);
            
           % Vorticity_x(i,j,k,t) = dwdy - dvdz;
           % Vorticity_y(i,j,k,t) = dudz - dwdx;
           % Vorticity_z(i,j,k,t) = dvdx - dudy;
            
           %{
            Omega(i,j,k) = (0.5*(dudy-dvdx))^2 + ...
                           (0.5*(dudz-dwdx))^2 + ...
                           (0.5*(dvdx-dudy))^2 + ...
                           (0.5*(dvdz-dwdy))^2 + ...
                           (0.5*(dwdx-dudz))^2 + ...
                           (0.5*(dwdy-dvdz))^2;
            
            Strain_rate(i,j,k) = (dudx-trace_check(i,j,k))^2 + ...
                                 (dvdy-trace_check(i,j,k))^2 + ...
                                 (dwdz-trace_check(i,j,k))^2 + ...
                                 (0.5*(dudy+dvdx))^2 + ...
                                 (0.5*(dudz+dwdx))^2 + ...
                                 (0.5*(dvdx+dudy))^2 + ...
                                 (0.5*(dvdz+dwdy))^2 + ...
                                 (0.5*(dwdx+dudz))^2 + ...
                                 (0.5*(dwdy+dvdz))^2 ;
            %}
           
            Om = 0.5*[    0     dudy-dvdx dudz-dwdx;
                      dvdx-dudy     0     dvdz-dwdy;
                      dwdx-dudz dwdy-dvdz     0   ];
                  
            S  = 0.5*[ 2*dudx    dudy+dvdx  dudz+dwdx;
                      dvdx+dudy   2*dvdy    dvdz+dwdy;
                      dwdx+dudz  dwdy+dvdz   2*dwdz  ];
                 
            Lambda_matrix = S^2 + Om^2;
            
            Lambda_eig_vals = eig(Lambda_matrix);
            Lambda_eig_vals_sorted = sort(Lambda_eig_vals,'descend');
            
            if Lambda_eig_vals_sorted(2)<0
                L2(i,j,k,t) = Lambda_eig_vals_sorted(2);
            else
                L2(i,j,k,t) = 0;
            end
            
            %Q_D(i,j,k,t) = 0.5.*(Omega(i,j,k)-Strain_rate(i,j,k));
            %Q_M(i,j,k,t) = 0.5.*(Omega(i,j,k)-(3/2)*Strain_rate(i,j,k));
 
        end
    end
end

%Q_D_max(t,1) = max(max(max(Q_D(:,:,:,t))));
%Q_D_min(t,1) = min(min(min(Q_D(:,:,:,t))));

%Q_D_pos = Q_D(:,:,:,t);
%Q_D_pos(Q_D_pos<=0)=0;
%Q_D_neg = Q_D(:,:,:,t);
%Q_D_neg(Q_D_neg>=0)=0;

%Q_D_pos_norm = Q_D_pos./Q_D_max(t,1);
%Q_D_neg_norm = Q_D_neg./abs(Q_D_min(t,1));

%Q_D_norm(:,:,:,t) = Q_D_pos_norm + Q_D_neg_norm;
disp(t);
end

%% save l2
save L2HN.mat L2 -v7.3 