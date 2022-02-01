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
%% halfwidth
tstart = 1;   %10;org
tend   = 90;   %50;org

W_mean = mean(W2(:,:,:,tstart:tend),4);
Wc=squeeze(W_mean(23,23,:));

zstart=1;
Threshold=1/exp(1);
zstop=nz;
for zi=zstart:nz
    if W_mean(nx,ycenter,zi)>= (Threshold*Wc(zi))
        l(zi)=x(nx);
        ltest(zi)=x(nx);
        if zi<zstop
           zstop=zi;
        end
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
      p=polyfit(z(zstart:zstop),l(zstart:zstop),1);
      p1=polyfit(l(zstart:zstop),z(zstart:zstop),1);
for zi=1:nz
   if zi<zstart
       l_adj(zi)=l(zstart);
   else if zi<zstop
           l_adj(zi)=l(zi);
       else
           l_adj(zi)=p(1)*(z(zi))+p(2);
       end
   end
end


%% omega
clear W2
eps=0;
tic
for t = 1:nt
   %calculate nondim. UVW 
     U_nd = U.data(:,:,:,t);
     V_nd = V.data(:,:,:,t);
     W_nd = W.data(:,:,:,t);
   for zi=1:nz
     U_nd(:,:,zi) = U_nd(:,:,zi)/Wc(zi);
     V_nd(:,:,zi) = V_nd(:,:,zi)/Wc(zi);
     W_nd(:,:,zi) = W_nd(:,:,zi)/Wc(zi);
   end
   for zi=1:nz
        [dUdx(:,:,zi),dUdy(:,:,zi)] = gradient(squeeze(U_nd(:,:,zi)),dx/ltest(zi),dy/ltest(zi));
        [dVdx(:,:,zi),dVdy(:,:,zi)] = gradient(squeeze(V_nd(:,:,zi)),dx/ltest(zi),dy/ltest(zi));
        [dWdx(:,:,zi),dWdy(:,:,zi)] = gradient(squeeze(W_nd(:,:,zi)),dx/ltest(zi),dy/ltest(zi));
   end
   
   [BdUdx,BdUdy,dUdz] = gradient(U_nd,dx,dy,dz/D);
   [BdVdx,BdVdy,dVdz] = gradient(V_nd,dx,dy,dz/D);
   [BdWdx,BdWdy,dWdz] = gradient(W_nd,dx,dy,dz/D);
   %BdUdx etc are not used for any calculations (should be relased if memory is running out 
  for  v=1:2
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
            
            %Vorticity_x(i,j,k,t) = dwdy - dvdz;
            %Vorticity_y(i,j,k,t) = dudz - dwdx;
            %Vorticity_z(i,j,k,t) = dvdx - dudy;
           
            GradU=[dudx;dudy;dudz];
            GradV=[dvdx;dvdy;dvdz];
            GradW=[dwdx;dwdy;dwdz];
          
            for d=1:3
                    GradVel(d,:)=[squeeze(GradU(d,1));squeeze(GradV(d,1));squeeze(GradW(d,1))];
                    T_GradVel(:,d)=[squeeze(GradU(d,1));squeeze(GradV(d,1));squeeze(GradW(d,1))];
            end
            
            SymGradVel=0.5*(GradVel+T_GradVel);
            SkewGradVel=0.5*(GradVel-T_GradVel);
            T_SymGradVel=permute(SymGradVel,[2 1]);
            T_SkewGradVel=permute(SkewGradVel,[2 1]);
            %Permute here is not needed (tranpose will work) for forloop code, needed for
            %vectoriezed script
           b=trace(T_SkewGradVel(:,:)*SkewGradVel(:,:));
           a=trace(T_SymGradVel(:,:)*SymGradVel(:,:));  
            if v==1
                %to get eps we need to find its b-a max for all spatial loops
                %then calcualte omega for all spatial points
                new_eps=b-a;
                if new_eps>eps
                   eps=new_eps;
                end
            else
                eps=0.001*eps;
                omega(i,j,k,t)=b/(a+b+eps);  
            end
     
        end %i
    end %j
   end %k
 
  end %v
  disp(t);
end %t
  toc
    
      
    
