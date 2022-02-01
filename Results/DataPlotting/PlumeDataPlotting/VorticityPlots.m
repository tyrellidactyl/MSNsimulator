clear all; clc

plumecase = "F050";
path = pwd + "\MSNsimulator\PlumeSimulator\Turbulent(LES)\Case_" + plumecase + "\PlumeData\";

load(path + 'VorticityData\Vorticity_x.mat');
load(path + 'VorticityData\Vorticity_y.mat');
load(path + 'VorticityData\Vorticity_z.mat');
load(path + 'PlumeD.mat');

Vxslice = [];
Vyslice = [];
Vzslice = [];
Vxslices = [];
Vyslices = [];
Vzslices = [];
Vxtimesteps = [];
Vytimesteps = [];
Vztimesteps = [];
time = 45;

for z = 1:500
    Vxslice = [Vxslice,Vorticity_x(:,23,z,time)];
    Vyslice = [Vyslice,Vorticity_y(:,23,z,time)];
    Vzslice = [Vzslice,Vorticity_z(:,23,z,time)];
    Vxtimesteps = [Vxtimesteps,Vorticity_x(:,23,z,:)];
    Vytimesteps = [Vytimesteps,Vorticity_y(:,23,z,:)];
    Vztimesteps = [Vztimesteps,Vorticity_z(:,23,z,:)];
end

for t = 1:90
    Vxslices(:,:,t) = Vxtimesteps(:,:,:,t);
    Vyslices(:,:,t) = Vytimesteps(:,:,:,t);
    Vzslices(:,:,t) = Vztimesteps(:,:,:,t);
end

Vxslice = [zeros(size(Vxslice,2),2)'; Vxslice; zeros(size(Vxslice,2),3)'];
Vyslice = [zeros(size(Vyslice,2),2)'; Vyslice; zeros(size(Vyslice,2),3)'];
Vzslice = [zeros(size(Vzslice,2),2)'; Vzslice; zeros(size(Vzslice,2),3)'];

Plume = PlumeD(:,:,time);

%%
time = 30;
Vxslice = Vxslices(:,:,time);

f6 = figure(6);
clf;
hold on
grid on
contourf(Vxslice,20);
colormap(hsv);
colorbar('southoutside');
title("CaseF050 Vx - Time: " + num2str(time) + " min");
xlabel('X');
ylabel('Y');

figname = path + 'VxContour' + num2str(time) + 'min.png';
saveas(f6,figname);

%%
f7 = figure(7);
clf;
hold on
grid on
contourf(Vyslice,20);
colormap(hsv);
colorbar('southoutside');
title('CaseF050 Vy');
xlabel('X');
ylabel('Y');

%%
f8 = figure(8);
clf;
hold on
grid on
contourf(Vzslice,20);
colormap(hsv);
colorbar('southoutside');
title('CaseF050 Vz');
xlabel('X');
ylabel('Y');

%% Save data
path = "MSNsimulator/TurbulentPlumeSimulator/Case_F050/";

filename = path + 'Vxslice' + '.mat';
save(filename,'Vxslice');

filename2 = path + 'Vxslices' + '.mat';
save(filename2,'Vxslices');

filename3 = path + 'Vyslice' + '.mat';
save(filename3,'Vyslice');

filename4 = path + 'Vyslices' + '.mat';
save(filename4,'Vyslices');

filename5 = path + 'Vzslice' + '.mat';
save(filename5,'Vzslice');

filename6 = path + 'Vzslices' + '.mat';
save(filename6,'Vzslices');

figname = path + 'Vx.png';
saveas(f6,figname);

figname2 = path + 'Vy.png';
saveas(f7,figname2);

figname3 = path + 'Vz.png';
saveas(f8,figname3);