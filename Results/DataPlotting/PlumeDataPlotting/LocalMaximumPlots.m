%{
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Vxslice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Vyslice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Vzslice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Oslice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/L2slice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/Hslice.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/PlumeD.mat');
%}
%%
T = 45;
Plume = PlumeD(:,:,T);
param = Plume;
paramName = 'Conc';

Max = max(max(param));
Min = min(min(param));

localMaximums = zeros(size(param));
sensitivity = .1;

for i = 1:size(param,1)
    for j = 1:size(param,2)
        if param(i,j) < 0
            param(i,j) = round(-1000 * (param(i,j) / Min));
        else
            param(i,j) = round(1000 * (param(i,j) / Max));
        end
        if abs(param(i,j)) > (sensitivity * 1000)
            localMaximums(i,j) = param(i,j);
        end
    end
end

%%
J = gradient(Plume);
J2 = gradient(J);

x = linspace(1,1,500);
[pks,locs] = findpeaks(Plume,x)

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

title("CaseF050 Scaled " + paramName + " Time: " + T);
xlabel('X');
ylabel('Y');

%%
f7 = figure(7);
clf;
hold on

contour(localMaximums);
%{
zmin = floor(min(param(:))); 
zmax = max(param(:));
zinc = (zmax - zmin) / 50;
zindex = zmin:2:zmax;
zlevs = zmin:zinc:zmax;
contourf(param,zlevs)
colormap(jet)
hold on
contour(param,zindex,'LineWidth',2);
%}
colorbar('eastoutside');

title("CaseF050 Scaled Local Maximums (" + paramName + ") Sensitivity: " + sensitivity);
xlabel('X');
ylabel('Y');

%%
path = "MSNsimulator/TurbulentPlumeSimulator/Case_F050/";

filename = path + 'LocalMaximums' + paramName + 'slice' + T + '.mat';
save(filename,'localMaximums');

figname = path + 'Plume' + paramName + 'T' + T + '.png';
saveas(f6,figname);

figname2 = path + 'LocalMaximums' + paramName + 'Sens' + sensitivity + 'T' + T + '.png';
saveas(f7,figname2);
