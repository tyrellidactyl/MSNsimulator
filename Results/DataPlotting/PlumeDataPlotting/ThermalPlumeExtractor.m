%% Thermal Plumes -- JESSE 
%% Clear WORKSPACE AND MEMORY
clearvars; clc
%{
clearvars; clc

%% Load Files
tic
Data_T = load('NBL_3D_T_F100.mat');
Data   = Data_T.data; clear Data_T
toc

%% Find the Average Statistics
tdata  = reshape(Data,45,45,700,541);
clear Data

%% Save Mat files

save('tdata','tdata','-v7.3')
csvwrite('testTemperature.dat',tdata)
save testTemperature.dat tdata -ascii
%}
gas = "Ammonia";
plumecase = "Case1";
%path = "/home/ty/MSNsimulator/TurbulentPlumeSimulator/"+gas+"/"+plumecase+"/";
%load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/CO2/Dense_Plume00/Tdata.mat');
%load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Helium/Helium_00/He_h00_01_T.mat')
Data_T = load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Ammonia/Case1/NBL_3D_T_F100.mat');
Data   = Data_T.data; clear Data_T
tdata  = reshape(Data,45,45,700,541);
clear Data

%% Remove small stuff
tdata(tdata< 0.0001)  = 0;

%%
Y_AvgTemp = nanmean(tdata,2);
Y_AvgTemp = squeeze(Y_AvgTemp);

%%
ndims = size(tdata);
nx = ndims(1);
ny = ndims(2);
nz = ndims(3);
nt = ndims(4);
dx = 10; % 40, 80
dz = 10; % 20, 20blank keyboard
dy = dx;
dt = 10;
H  = 7000;
W  = 400; 
x = -(nx/2-1)*dx:dx:(nx/2)*dx; x = x - dx/2;
y = 0:dy:(ny-1)*dy;
z = 0:dz:(nz-1)*dz;
time_N = 0:dt:(nt-1)*dt;
[X, Z] = meshgrid(x, z);
[X3, Y3, Z3] = meshgrid(x', y', z');

%% Plot plume transverse section
TempData = [];
for z = 1:700
    TempData = [TempData,tdata(:,23,z,:)];
end
c_max=max(max(max(TempData)));
TempData=abs(TempData./c_max);

%Plume = round(TempData*10000);
%Plume = [zeros(size(Plume,2),2)'; Plume; zeros(size(Plume,2),3)'];
Plume = round(TempData(:,:,:,541)*100000);
Plume = [zeros(size(Plume,2),2)'; Plume; zeros(size(Plume,2),3)'];
PlumeD = Plume;

%% Plot Plume

f1 = figure(1);
clf;
set(f1,'Position',[1 1421 1920 633]);
hold on
grid on
zmin = floor(min(Plume(:))); 
zmax = ceil(max(Plume(:)));
zinc = (zmax - zmin) / 20;
zindex = zmin:5:zmax;
zlevs = zmin:zinc:zmax;
contourf(Plume,zlevs)
colormap(jet)
hold on
contour(Plume,zindex,'LineWidth',2)
%colorbar('southoutside','Ticks',[0 250 500 750 1000],...
%         'TickLabels',{'0','250','500','750','1000'},'Direction','reverse');
title(gas + " - " + plumecase);

%%
for i = 1:50
    for j = 1:700
        if PlumeD(i,j) == 0
            PlumeD(i,j) = 1;
        end
    end
end

%%
%{
f2 = figure(2);
hold on

for t = 1:10:300
    PlumeT = round(TempData(:,:,:,t)*10000);
    PlumeD(:,:,t) = [zeros(size(PlumeT,2),2)'; PlumeT; zeros(size(PlumeT,2),3)'];

    Plume = PlumeD(:,:,t);
    contourf(Plume,10)
    colormap(jet)
    hold on

    drawnow
    fprintf('Time step - %s/%s\n',num2str(t),num2str(300));
end
%}

%% Save Plot


if save == 1
h(1) = figure(1);
fig1 = path + gas + "-" + plumecase + '.png';
saveas(h(1),fig1);
filename = path + 'PlumeD' + '.mat';
save(filename,'PlumeD');
end
