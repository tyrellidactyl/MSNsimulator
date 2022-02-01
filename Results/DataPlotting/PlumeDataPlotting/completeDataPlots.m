clear all; clc;

plumecase = "F050";
path = pwd + "\MSNsimulator\PlumeSimulator\Turbulent(LES)\Case_" + plumecase + "\PlumeData\";
load(path+'PlumeD.mat');
load(path+'WindD.mat');
load(path + 'Slices\Vxslice.mat');
%load(path + 'VorticityData\Vorticity_y.mat');
%load(path + 'VorticityData\Vorticity_z.mat');

PlumeFinal = PlumeD(:,:,end);
Wind = WindD(:,:,end);

%% figure 2: Plume Contour
f2 = figure(2);
%set(f2,'Position',[1 1081 1920 973]);
clf;

casetitle = "Plume Centerline Case " + plumecase;
hold on 
grid on
title(casetitle)
zmin = floor(min(PlumeFinal(:))); 
zmax = ceil(max(PlumeFinal(:)));
zinc = (zmax - zmin) / 20; % 20 default
zindex = zmin:5:zmax;
zlevs = zmin:zinc:zmax;
contourf(PlumeFinal,zlevs)
colormap(jet) % jet
hold on
contour(PlumeFinal,zindex,'LineWidth',2)
%colorbar('southoutside','Ticks',[0 250 500 750 1000],...
%         'TickLabels',{'0','250','500','750','1000'},'Direction','reverse');

% centerline
Uline = [];
Cline = [];

hold on 
for i = 1:500
    Umax = max(Wind(:,i));
    U = find(Wind(:,i) == Umax);
    %plot(i, U, 'cs', 'LineWidth',1, 'MarkerSize',3,'MarkerEdgeColor','b')
    Uxy = [i,U]; % (U-2) for F150 and F250
    Uline = [Uline; Uxy];
    
    Cmax = max(PlumeFinal(:,i));
    C = find(PlumeFinal(:,i) == Cmax);
    if size(C,1) > 1
        C = C(1);
    end
    %plot(i, C, 'rd', 'MarkerSize',1,'LineWidth',1)
    Cxy = [i,C];
    Cline = [Cline; Cxy];
    
end

plot(Uline(:,1), Uline(:,2), '--c*', 'LineWidth',1, 'MarkerSize',3,'MarkerEdgeColor','c')
plot(Cline(:,1), Cline(:,2), '--m*', 'LineWidth',1, 'MarkerSize',3,'MarkerEdgeColor','m')
%legend('Maximum Wind Speed','Maximum Concentration','Location','best')
xlabel('X [m]')
ylabel('Y [m]')

%%
f6 = figure(6);
clf;
hold on
grid on
contourf(Vxslice,20);
colormap(hsv);
colorbar('southoutside');
title("CaseF050 Vx");
xlabel('X');
ylabel('Y');

%%
%fig = '/home/ty/MSNsimulator/TestResults/DataPlotting/centerlineF250.png';
%saveas(f2,fig);
    