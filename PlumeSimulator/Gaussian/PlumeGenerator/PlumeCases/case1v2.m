%% Case 1: Diffusion - Constant Source strength
%-------------------------------------------------------------------------%
% A simple Forward in Time and Central in Space algorithm for solving the
% Gaussian Concentration 
%-------------------------------------------------------------------------%

%% Clear things
% Clear workspace and variables
clc;  clearvars;  clf;

%% User Inputs

% Domain dimensions (m) Length - L, Breadth - B, Height - H
L = 50; B = 50; H = 6;

% Simulation time (s)
T = 5;
Res = 0.5;

% Grid sizes (m) & time step (s) 
dx=Res; dy=Res; dz=Res; dt = 0.01;

% Initial concentration value (units)
C_0 = 1000;

% Diffusion constant (m2/s) how quickly it spreads; 
% Smaller values: +L, -l 
c_diff = 0.5;

% Advection velocity values (m/s);
ux = 0; % actually y
uy = 3; % actually x
uz = 0;

% Advection constant;
% Larger values: +L
a_c = 1.25;

% Source term parameters
src_amp = 1;     % Source term amplitude (affects pulse)
src_freq = 1;    % Source term frequency

plumecase = 5; % 1: a_c (0.5-2), 2: c_diff (0.25-1.5), 3: src_amp (1-5), 4: src_freq (1-5), 5: U (1-4)

path = '/home/ty/MSNsimulator/GaussianPlumeSimulator/PlumeGenerator/PlumeCases/';
str = "Case"+num2str(plumecase)+"Adv"+num2str(a_c)+"Diff"+...
       num2str(c_diff)+"Amp"+num2str(src_amp)+"Freq"+num2str(src_freq)+"U"+num2str(uy);
   
PlumeD = [];

%% Initializations

% Generate domain
x_min=0; x_max=L;
y_min=0; y_max=B;
z_min=0; z_max=H;


x_num = round(((x_max-x_min)/dx)); % Number of grid indices in X
y_num = round(((y_max-y_min)/dy)); % Number of grid indices in Y
z_num = round(((z_max-z_min)/dz)); % Number of grid indices in Z

% Time domain
t_min = 0; t_max = T;

%t_num = round(t_max/dt)+1;
t_num = round(t_max/dt);

% Initializing the matrices required for the calculations
C_n1(y_num,x_num,z_num)         = zeros;
C_n(y_num,x_num,z_num)          = zeros;
C_nn(y_num,x_num,z_num,t_num+1) = zeros;
src(y_num,x_num,z_num,t_num+1)  = zeros;
C_res(y_num,x_num,z_num)        = zeros;

U(y_num,x_num,z_num,t_num) = zeros;
V(y_num,x_num,z_num,t_num) = zeros;
W(y_num,x_num,z_num,t_num) = zeros;

%% Location of the source

x_loc = round(x_num/2);
y_loc = round(y_num/2);
z_loc = round(z_num/2);


%% Initial Conditions
% If background concentration is present it can be initialized here
C_n1(:,:,:) = 0; % becomes min c value

C_n1(y_loc+1,x_loc+1,z_loc) = C_0;
C_n1(y_loc,x_loc,z_loc)     = C_0;
C_n1(y_loc+1,x_loc,z_loc)   = C_0;
C_n1(y_loc,x_loc+1,z_loc)   = C_0;

C_nn(:,:,:,1) = C_n1(:,:,:);
%% Constants

alpha_x = c_diff;
alpha_y = c_diff;
alpha_z = c_diff;

sx=(alpha_x*dt)/(dx*dx);
sy=(alpha_y*dt)/(dy*dy);
sz=(alpha_z*dt)/(dz*dz);

% Transport ratio
t_r = c_diff/a_c;
%% Source term generation
for t = 1:t_num
    % Source term
    for i=1:y_num
        for j=1:x_num
            for k=1:z_num
                if (i==y_loc+1) && (j==x_loc+1) && (k==z_loc)
                    src(i,j,k,t) = C_0+(src_amp * sin(src_freq*pi*(t/t_num)));
                elseif (i==y_loc) && (j==x_loc) && (k==z_loc)
                    src(i,j,k,t) = C_0+(src_amp * sin(src_freq*pi*(t/t_num)));
                elseif (i==y_loc+1) && (j==x_loc) && (k==z_loc)
                    src(i,j,k,t) = C_0+(src_amp * sin(src_freq*pi*(t/t_num)));
                elseif (i==y_loc) && (j==x_loc+1) && (k==z_loc)
                    src(i,j,k,t) = C_0+(src_amp * sin(src_freq*pi*(t/t_num)));
                end
            end
        end
    end
end
%% Main Time loop

for t = 1:t_num
        
    % Re-initialize the source location (continous source)
    C_n = C_n1;
    
    % Interior points
    for i=3:y_num-2
        for j=3:x_num-2
            for k=3:z_num-2
                
                %Store the velocity fields
                U(i,j,k,t) = ux;
                V(i,j,k,t) = uy;
                W(i,j,k,t) = uz;
                
                % Calculate CFLs
                cx = (a_c*ux*dt)/(dx);
                cy = (a_c*uy*dt)/(dy);
                cz = (a_c*uz*dt)/(dz);
                
                ax = (1/12)*((-C_n(i-2,j,k)*(sx+cx))+...
                    (C_n(i-1,j,k)*((16*sx)+(8*cx)))+...
                    (C_n(i+1,j,k)*((16*sx)-(8*cx)))+...
                    (-C_n(i+2,j,k)*(sx-cx)));
                
                ay = (1/12)*((-C_n(i,j-2,k)*(sy+cy))+...
                    (C_n(i,j-1,k)*((16*sy)+(8*cy)))+...
                    (C_n(i,j+1,k)*((16*sy)-(8*cy)))+...
                    (-C_n(i,j+2,k)*(sy-cy)));
                
                az = (1/12)*((-C_n(i,j,k-2)*(sz+cz))+...
                    (C_n(i,j,k-1)*((16*sz)+(8*cz)))+...
                    (C_n(i,j,k+1)*((16*sz)-(8*cz)))+...
                    (-C_n(i,j,k+2)*(sz-cz)));
                
                axyz = -(30/12)*(C_n(i,j,k)*(sx+sy+sz));
                
                a = ax + ay + az + axyz;
                
                C_n1(i,j,k) = round((a) + C_n(i,j,k) + (dt * src(i,j,k,t)),4);
                
                if isnan(a)
                    disp('Error - NaN encountered - Try reducing time step');
                    return
                end
            end
        end
    end
    
    % Boundary Points
    
    for k=[1 2 z_num-1 z_num]
        for i=1:y_num
            for j=1:x_num
                
                U(i,j,k,t) = ux;
                V(i,j,k,t) = uy;
                W(i,j,k,t) = uz;
                
                C_n1(i,j,k) = 0;
                
            end
        end
    end
    for j=[1 2 x_num-1 x_num]
        for i=1:y_num
            for k=1:z_num
                
                U(i,j,k,t) = ux;
                V(i,j,k,t) = uy;
                W(i,j,k,t) = uz;
                
                C_n1(i,j,k) = 0;
                
            end
        end
    end
    for i=[1 2 y_num-1 y_num]
        for j=1:x_num
            for k=1:z_num
                
                U(i,j,k,t) = ux;
                V(i,j,k,t) = uy;
                W(i,j,k,t) = uz;
                
                C_n1(i,j,k) = 0;
                
            end
        end
    end
    
    % Store the calculated concentration values
    C_res(:,:,:)=C_n1(:,:,:);
    
    % Normalizing results
    c_max=max(max(max(C_res)));
    C_res=abs(C_res./c_max);
    
    %Store the data at each time step into 4D array
    %C_nn(:,:,:,t+1)=C_res(:,:,:);
    
    %PlumeD(:,:,t) = round(C_res(:,:,z_loc+1/Res) * 1000); 
    PlumeD(:,:,t) = round(C_res(:,:,z_loc) * 1000); 
    
    %WindX(:,:,t) = U(:,:,z_loc+1/Res,t);
    %WindY(:,:,t) = V(:,:,z_loc+1/Res,t);
    
    % FTCS is done for one time step, proceed to next time level
    fprintf('Time step - %s/%s\n',num2str(t),num2str(t_num-1));
    
end

%PlumeStart = PlumeD(:,:,10);
PlumeFinal = PlumeD(:,:,end);

M = max(max(PlumeFinal(:)));

%% Determine plume halfwidth and dispersion length (1/100th the concentration value)
centerline = PlumeFinal(51,51:end);
length = find(centerline<=(M/100));
length = length(1);

for i = 1:50
    widthline = PlumeFinal(100-i,51:end);
    widthmax = max(max(widthline(:)));
    if widthmax >= M/100
        width = 50.5 - i;
        break
    end
end

%% Plots
%----------------------%
% Plotting the results %
%----------------------%
f1 = figure(6);
clf;
hold on

zmin = floor(min(PlumeFinal(:))); 
zmax = ceil(max(PlumeFinal(:)));
zinc = (zmax - zmin) / 50;
zindex = zmin:2:zmax;
zlevs = zmin:zinc:zmax;
contourf(PlumeFinal,zlevs)
colormap(jet)
hold on
contour(PlumeFinal,zindex,'LineWidth',2.5)

colorbar
xlabel('x (m)'), ylabel('y (m)')
title('Gaussian Plume ' + str)

centerline = [0,100; 50.5,50.5];
centerline2 = [51,51; 0,100];
lengthline = [length+50,length+50; 0,100];
widthline = [51,length+50; 50+width,50+width];
line(centerline(1,:),centerline(2,:),'Color','white','LineWidth',1.5)
line(centerline2(1,:),centerline2(2,:),'Color','white','LineWidth',1.5)
line(lengthline(1,:),lengthline(2,:),'Color','white','LineWidth',1,'LineStyle','--')
line(widthline(1,:),widthline(2,:),'Color','white','LineWidth',1,'LineStyle','--')
text( length + 50.5, 49, num2str(length*Res) + "m", 'FontSize', 14, 'FontWeight','bold','Color','white');
text( length/2 + 50.5, width + 50.5, num2str(width*Res) + "m", 'FontSize', 14, 'FontWeight','bold','Color','white');

axis([45 100 40 60])
xticks([45 50 55 60 65 70 75 80 85 90 95 100])
xticklabels({'22.5','25','27.5','30','32.5','35','37.5','40','42.5','45','47.5','50'})
yticks([40 45 50 55 60])
yticklabels({'20','22.5','25','27.5','30'})

%%
fig1 = path + str + 'plume.png';
saveas(f1,fig1);

