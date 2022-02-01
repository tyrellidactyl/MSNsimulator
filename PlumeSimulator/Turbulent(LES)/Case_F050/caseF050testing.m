clear; clc;
% Import Data
loadF050;
caseF = "F050";

% Define Constants
H = 0.50; % Heat flux
D = 400; % Source diameter
% Define domain
dx = 40;
dy = 40;
dz = 10;
dt = 60;
T = 90;


%% temp data (static)
TempData = [];
for z = 1:500
    TempData = [TempData,Case_dataT(:,23,z,45)];
end

c_max=max(max(max(TempData)));
TempData=abs(TempData./c_max);
Plume = round(TempData*1000);
Plume = [zeros(size(Plume,2),2)'; Plume; zeros(size(Plume,2),3)'];


%% wind data (static)
wData = [];     vData = [];     R = [];

for z = 1:500
    wData = [wData,Case_dataW(:,23,z,45)];
    vData = [vData,Case_dataV(:,23,z,45)];
end
w_max=max(max(max(wData)));     v_max=max(max(max(vData)));
wData=abs(wData./w_max);        vData=abs(vData./v_max);
W = round(wData*1000);          V = round(vData*1000);
W = [zeros(size(W,2),2)'; W; zeros(size(W,2),3)'];
V = [zeros(size(V,2),2)'; V; zeros(size(V,2),3)'];

for j=1:500
    for i=1:50
        R(i,j) = sqrt(W(i,j)^2+V(i,j)^2);
    end
end

[px py] = gradient(R);
%%
for j=2:499
    for i=2:49
        W2 = W(i+1,j-1)+W(i+1,j)+W(i+1,j+1)+...
             W(i,j-1)+W(i,j)+W(i,j+1)+...
             W(i-1,j-1)+W(i-1,j)+W(i-1,j+1);
        V2 = V(i+1,j-1)+V(i+1,j)+V(i+1,j+1)+...
             V(i,j-1)+V(i,j)+V(i,j+1)+...
             V(i-1,j-1)+V(i-1,j)+V(i-1,j+1);
        R2(i,j) = sqrt(W2^2+V2^2);
    end
end
[px2 py2] = gradient(R2);
%% Plot plume transverse section
f1 = figure(1)
clf;
set(f1,'Position',[1 1609 1920 445]);
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
colorbar('southoutside','Ticks',[0 250 500 750 1000],...
         'TickLabels',{'0','250','500','750','1000'},'Direction','reverse');
title("Case" + caseF + " Temp. Data");

%%
f2 = figure(2)
clf;
set(f2,'Position',[1 1081 1920 445]);
quiver(px,py);
title("Case" + caseF + " Wind Data");
hold on 
quiver(px2,py2);

%% Store data over time
TempData = [];      wData = [];      vData = [];
PlumeD = [];    WD = [];     VD = [];
WindD = [];

for z = 1:500
    TempData = [TempData,Case_dataT(:,23,z,:)];
    wData = [wData,Case_dataW(:,23,z,:)];
    vData = [vData,Case_dataV(:,23,z,:)];
end

c_max=max(max(max(TempData)));
TempData=abs(TempData./c_max);

w_max=max(max(max(wData)));     v_max=max(max(max(vData)));
wData=abs(wData./w_max);        vData=abs(vData./v_max);

for t = 1:T
    PlumeT = round(TempData(:,:,:,t)*1000);
    WT = round(wData(:,:,:,t)*1000);          
    VT = round(vData(:,:,:,t)*1000);
    
    PlumeD(:,:,t) = [zeros(size(PlumeT,2),2)'; PlumeT; zeros(size(PlumeT,2),3)'];
    WD(:,:,t) = [zeros(size(WT,2),2)'; WT; zeros(size(WT,2),3)'];
    VD(:,:,t) = [zeros(size(VT,2),2)'; VT; zeros(size(VT,2),3)'];
end

for t = 1:T
    for j=1:500
        for i=1:50
            WindD(i,j,t) = sqrt(WD(i,j,t)^2+VD(i,j,t)^2);
        end
    end
    fprintf('Time step - %s/%s\n',num2str(t),num2str(T));
end

%% save results
path = "MSNsimulator/TurbulentPlumeSimulator/Case_" + caseF + "/";

filename = path + 'PlumeTest' + '.mat';
filename2 = path + 'PlumeDtest' + '.mat';
filename3 = path + 'WindDtest' + '.mat';
save(filename,'Plume');
save(filename2,'PlumeD');
save(filename3,'WindD');

h(1) = figure(1);
h(2) = figure(2);

fig1 = path + 'plumeTest.png';
fig2 = path + 'windTest.png';
saveas(h(1),fig1);
saveas(h(2),fig2);


%% Plot over time
%{
figure(2)
hold on
grid on


for t = 1:30
    Plume = PlumeD(:,:,t);
    contourf(Plume,10)
    colormap(jet)
    hold on

    drawnow
    fprintf('Time step - %s/%s\n',num2str(t),num2str(30));
end

zmin = floor(min(PlumeD(:))); 
zmax = ceil(max(PlumeD(:)));
zinc = (zmax - zmin) / 20;
zindex = zmin:5:zmax;
zlevs = zmin:zinc:zmax;

    contour(Plume,zindex,'LineWidth',2)

%}

%wPose = W(25,3);    vPose = V(25,3);
%R = sqrt(wPose^2 + vPose^2);    a = acos(wPose/R);
