load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Vxslice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Vyslice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Vzslice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Oslice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/L2slice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Hslice.mat');

%%
param = VxsliceT20;
paramName = 'Vx';

Max = max(max(param));
Min = min(min(param));

for i = 1:size(param,1)
    for j = 1:size(param,2)
        if param(i,j) < 0
            param(i,j) = round(-1000 * (param(i,j) / Min));
        else
            param(i,j) = round(1000 * (param(i,j) / Max));
        end
    end
end

VxsliceT20 = abs(param);

%%
f6 = figure(6);
clf;
hold on
grid on

zmin = floor(min(param(:))); 
zmax = max(param(:));
zinc = (zmax - zmin) / 50;
zindex = zmin:2:zmax;
zlevs = zmin:zinc:zmax;
contourf(param,zlevs)
colormap(hsv)
hold on
contour(param,zindex,'LineWidth',2);
colorbar('eastoutside');

title("CaseF050 Scaled " + paramName);
xlabel('X');
ylabel('Y');

%%
f7 = figure(7);
clf;
hold on
grid on

zmin = floor(min(param(:))); 
zmax = max(param(:));
zinc = (zmax - zmin) / 50;
zindex = zmin:2:zmax;
zlevs = zmin:zinc:zmax;
contourf(param,zlevs)
colormap(jet)
hold on
contour(param,zindex,'LineWidth',2);
colorbar('eastoutside');

title("CaseF050 Scaled " + paramName);
xlabel('X');
ylabel('Y');

%%
path = "MSNsimulator/TurbulentPlumeSimulator/Case_F050/";

filename = path + 'Scaled' + paramName + 'slice' + '.mat';
save(filename,'param');

figname = path + 'Scaled' + paramName + '.png';
saveas(f6,figname);

figname2 = path + 'Scaled' + paramName + '2.png';
saveas(f7,figname2);
