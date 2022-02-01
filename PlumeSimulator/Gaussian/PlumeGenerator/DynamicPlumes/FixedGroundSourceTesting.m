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
L = 50; B = 50; H = 10;

% Simulation time (s)
T = 5;
Res = 0.5;

% Grid sizes (m) & time step (s) 
dx=Res; dy=Res; dz=Res; dt = 0.01;

% Initial concentration value (units)
C_0 = 1000;

% Diffusion constant (m2/s) how quickly it spreads
c_diff = .8;

% Advection velocity values (m/s)
ux = 0;
uy = 2;
uz = 0.2;

% Advection constant
a_c = 1;

% Source term parameters
src_amp = 0;     % Source term amplitude (affects pulse)
src_freq = 2;    % Source term frequency

PlumeD = [];
glog = [];

%% Output check

% Ask user whether to save the data files or not

UIControl_FontSize_default = get(0, 'DefaultUIControlFontSize');
set(0, 'DefaultUIControlFontSize', 16);
options.Interpreter = 'Tex';
options.Default     = 'No';
qstring             = '\fontsize {18} Save 3D data files ??';
string1             = 'Data Output';
choice              = 'No';

switch choice
    case 'Yes'
        c_sv = 1;
    case 'No'
        c_sv = 0;
end
set(0, 'DefaultUIControlFontSize', UIControl_FontSize_default);

%% Initializations

% Generate domain
x_min=0; x_max=L;
y_min=0; y_max=B;
z_min=0; z_max=H;


x_num = round(1+((x_max-x_min)/dx)); % Number of grid indices in X
y_num = round(1+((y_max-y_min)/dy)); % Number of grid indices in Y
z_num = round(1+((z_max-z_min)/dz)); % Number of grid indices in Z

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

%{
x_loc = 10;
y_loc = 25;
z_loc = 2;
%}
x_loc = round(x_num/2);
y_loc = round(y_num/2);
z_loc = round(z_num/3);


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
    
    %{
    g = 3 + log((3/t*dt)^(0.6)); % Time varying fluctuation
    Iz = 0.15 * ((z_loc / 20) ^ (-0.125)); % Turbulence intensity
    G = 1 + g * Iz; % Gust Factor
    %}
    
    % Interior points
    for i=3:y_num-2
        for j=3:x_num-2
            for k=3:z_num-2
                
                %Store the velocity fields
                U(i,j,k,t) = ux;
                V(i,j,k,t) = uy;
                W(i,j,k,t) = uz;
                
                %{
                U(i,j,k,t) = ux * G;
                V(i,j,k,t) = uy * G;
                W(i,j,k,t) = uz * G;
                %}
                
               %glog = [glog;g];
                
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
    C_nn(:,:,:,t+1)=C_res(:,:,:);
    
    %PlumeD(:,:,t) = round(C_res(:,:,z_loc+1/Res) * 1000); 
    PlumeD(:,:,t) = round(C_res(:,:,z_loc) * 1000); 
    
    %WindX(:,:,t) = U(:,:,z_loc+1/Res,t);
    %WindY(:,:,t) = V(:,:,z_loc+1/Res,t);
    WindX(:,:,t) = U(:,:,z_loc,t);
    WindY(:,:,t) = V(:,:,z_loc,t);
    
    % FTCS is done for one time step, proceed to next time level
    fprintf('Time step - %s/%s\n',num2str(t),num2str(t_num-1));
    
end

PlumeStart = PlumeD(:,:,10);
PlumeFinal = PlumeD(:,:,T/dt);

M = max(max(PlumeFinal(:)));

%% Plots
%----------------------%
% Plotting the results %
%----------------------%

% Time intervals for plotting the data
t_p=1:25:t;

% Choose the slices where the data should be plotted
xslice = L/2;
yslice = B/2;
zslice = H/3;
%zslice = z_loc;

[x,y,z] = meshgrid (linspace(x_min,x_max,x_num),...
                    linspace(y_min,y_max,y_num),...
                    linspace(z_min,z_max,z_num));


fig_1 = figure(1);

clf; 
sz = 15;

%set(gcf, 'Position', [200 30 650 500]);
%set(gcf,'Color',[1 1 1]);
%clc;

xl = sprintf('X (m)');
yl = sprintf('Y (m)');
zl = sprintf('Z (m)');
cl = sprintf('Concentration (units)');

for i = 1:length(t_p)
    
    t=t_p(i);
    clf;
    
    C_r(:,:,:) = C_nn(:,:,:,t);
    U_r(:,:,:) = U(:,:,:,t);
    V_r(:,:,:) = V(:,:,:,t);
    W_r(:,:,:) = W(:,:,:,t);
        
    slice(x,y,z,C_r,xslice,yslice,zslice);
    
    shading interp
    
%     ch_t=sprintf('Time step = %d, Run time = %d sec,  dt = %.3f sec',t-1,t_max,dt);
%     title(ch_t,'fontweight','bold','fontsize',sz);
    
    title(strcat('Time step= ',num2str(t-1),'$,\ $','Run time= ',num2str(t_max),'$s,\ $','dt=',num2str(dt),'$s$'),'fontweight','bold','fontsize',sz,'interpreter','latex');
    
    c=colorbar;
    c.TickLabelInterpreter = 'latex';
    ylabel(c,cl,'fontweight','bold','fontsize',sz,'interpreter','latex');
    colormap(jet);
    box on;
    
    xlabel(xl,'fontsize',sz,'interpreter','latex');
    ylabel(yl,'fontsize',sz,'interpreter','latex');
    zlabel(zl,'fontsize',sz,'interpreter','latex');
    set(gca,'TickLabelInterpreter','latex','fontsize',sz);
    
    view(0,90);
    drawnow

end

