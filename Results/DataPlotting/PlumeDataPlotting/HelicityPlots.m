load('Helicity_normalized.mat');

Hslice = [];
Hslices = [];
Htimesteps = [];
for z = 1:500
    Hslice = [Hslice,H_n(:,23,z,45)];
    Htimesteps = [Htimesteps,H_n(:,23,z,:)];
end

for t = 1:90
    Hslices(:,:,t) = Htimesteps(:,:,:,t);
end

Hslice = [zeros(size(Hslice,2),2)'; Hslice; zeros(size(Hslice,2),3)'];
Hslice = abs(Hslice);

%%
f2 = figure(2);
clf;
hold on
grid on


contourf(Hslice,20);
colormap(hsv);
colorbar('southoutside');
%}

%{
zmin = floor(min(Hslice(:))); 
zmax = max(Hslice(:));
zinc = (zmax - zmin) / 20;
zindex = zmin:2:zmax;
zlevs = zmin:zinc:zmax;
contourf(Hslice,zlevs)
colormap(hsv)
hold on
contour(Hslice,zindex,'LineWidth',2)
colorbar('southoutside');
%}

title('CaseF050 Helicity');
xlabel('X');
ylabel('Y');

%% Plot over time
f5 = figure(5);
hold on
grid on

for t = 1:10:90
    H = Hslices(:,:,t);
    contourf(H,10)
    colormap(hsv)
    hold on

    drawnow
    fprintf('Time step - %s/%s\n',num2str(t),num2str(90));
end

%%
path = "MSNsimulator/TurbulentPlumeSimulator/Case_F050/";

filename = path + 'Hslice' + '.mat';
save(filename,'Hslice');

filename2 = path + 'Hslices' + '.mat';
save(filename2,'Hslices');

figname = path + 'Helicity.png';
saveas(f2,figname);