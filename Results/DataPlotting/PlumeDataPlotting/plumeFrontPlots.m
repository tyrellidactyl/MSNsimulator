clear all; clc;

%% 1D Front vs. Time Plots
%loadF050;
%wdata = Case_dataW;
%tdata = Case_dataT;

Case_T        = load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/NBL_3D_T_F050.mat'); 
Case_W        = load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/NBL_3D_W_F050.mat'); 
Case_T2        = load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F150/NBL_3D_T_F150.mat'); 
Case_W2        = load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F150/NBL_3D_W_F150.mat'); 
Case_T3        = load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F250/NBL_3D_T_F250.mat'); 
Case_W3        = load('home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F250/NBL_3D_W_F250.mat'); 

tdata   = Case_T.data; % <- Temperature difference
wdata   = Case_W.data;
tdata2   = Case_T2.data; % <- Temperature difference
wdata2   = Case_W2.data;
tdata3   = Case_T3.data; % <- Temperature difference
wdata3   = Case_W3.data;

clear Case_T Case_W Case_T2 Case_W2 Case_T3 Case_W3
%clear Case_dataU Case_dataV Case_dataW Case_dataT Case_data Case_T Case_U Case_V Case_W

%%

dx = 40;
dy = 40;
dz = 10;
dt = 10; %sec
D = 400;
W = 400;
ndims = size(wdata);
nx    = ndims(1);
ny    = ndims(2);
nz    = ndims(3);
nt    = ndims(4);
clc;
x     = -(nx/2-1)*dx:dx:(nx/2)*dx; x = x - dx/2;
y     = -(ny/2-1)*dy:dy:(ny/2)*dy; y = y - dy/2;
z     = 0:dz:(nz-1)*dz;

[X,Z] = meshgrid(x,z);

X = X';
Z = Z';

 
%%
lfx_centerline = squeeze(wdata(23,23,:,:));
lfx_centerline2 = squeeze(wdata2(23,23,:,:));
lfx_centerline3 = squeeze(wdata3(23,23,:,:));

clear wdata wdata2 wdata3

threshold = 0.1;

nt = size(lfx_centerline,2);
nz = size(lfx_centerline,1);

for t = 1:nt
    for j = nz:-1:1
        if (lfx_centerline(j,t) > threshold)
            plume_height_h1(t,1) = j;
            break;
        end
    end
end

for t = 1:nt
    for j = nz:-1:1
        if (lfx_centerline2(j,t) > threshold)
            plume_height_h1_2(t,1) = j;
            break;
        end
    end
end

for t = 1:nt
    for j = nz:-1:1
        if (lfx_centerline3(j,t) > threshold)
            plume_height_h1_3(t,1) = j;
            break;
        end
    end
end

%Uf = gradient(plume_height_h1*D,dt);
%Uf2 = gradient(plume_height_h1_2*D,dt);
%Uf3 = gradient(plume_height_h1_3*D,dt);

%%
T0=1.25;

gPcase1  = tdata.*(9.81/300);
gPcaseN1 = gPcase1./max(max(max(max(gPcase1))));
gPcase1(gPcaseN1<0.0001) = nan;
gPsum = squeeze(nansum(squeeze(nansum(gPcase1,1)),1));
clear tdata gPcase1 gPcaseN1

gPcase2  = tdata2.*(9.81/300);
gPcaseN2 = gPcase2./max(max(max(max(gPcase2))));
gPcase2(gPcaseN2<0.0001) = nan;
gPsum2 = squeeze(nansum(squeeze(nansum(gPcase2,1)),1));
clear tdata2 gPcase2 gPcaseN2

gPcase3  = tdata3.*(9.81/300);
gPcaseN3 = gPcase3./max(max(max(max(gPcase3))));
gPcase3(gPcaseN3<0.0001) = nan;
gPsum3 = squeeze(nansum(squeeze(nansum(gPcase3,1)),1));
clear tdata3 gPcase3 gPcaseN3


for t= 1:nt
    for j=nz:-1:1
        if (gPsum(j,t)> 0 )
            plume_height_h2_1(t,1) = j;
            break;
        end
    end
end

for t= 1:nt
    for j=nz:-1:1
        if (gPsum2(j,t)> 0 )
            plume_height_h2_2(t,1) = j;
            break;
        end
    end
end

for t= 1:nt
    for j=nz:-1:1
        if (gPsum3(j,t)> 0 )
            plume_height_h2_3(t,1) = j;
            break;
        end
    end
end

%%
f8 = figure(8);
clf;
hold on

plot(plume_height_h1,'-o');
plot(plume_height_h1_2,'-s');
plot(plume_height_h1_3,'-p');

title('CO2 Plume Front for Various Heat Flux (h1)')
legend('F050','F150','F250','location','northwest')
xlabel('T Time Elapsed [min]')
ylabel('x Plume Front [m]')

%%
f9 = figure(9);
clf;
hold on

plot(plume_height_h2_1,'-o');
plot(plume_height_h2_2,'-s');
plot(plume_height_h2_3,'-p');

for i = 5:5:30
    line([i i],[0 plume_height_h2_1(i,1)]);
    text(i+1,plume_height_h2_1(i,1)-10,num2str(plume_height_h2_1(i,1)));
end

title('CO2 Plume Front for Various Heat Flux (h2)')
legend('F050','F150','F250','location','northwest')
xlabel('T Time Elapsed [min]')
ylabel('x Plume Front [m]')

%%
path = "MSNsimulator/TurbulentPlumeSimulator/";

%{
filename = path + 'Case_F050/PlumeFrontH2_1.mat';
filename2 = path + 'Case_F050/PlumeFrontH2_2.mat';
filename3 = path + 'Case_F050/PlumeFrontH2_3.mat';

save(filename,'plume_height_h2_1');
save(filename2,'plume_height_h2_2');
save(filename3,'plume_height_h2_3');

figname = path + 'PlumeFrontsCO2H1.png';
saveas(f8,figname);

figname2 = path + 'PlumeFrontsCO2H2.png';
saveas(f9,figname2);
%}
