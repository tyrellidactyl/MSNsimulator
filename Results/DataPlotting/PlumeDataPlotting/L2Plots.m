load('L2HN.mat');
load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Case_F050/PlumeD.mat');

L2slice = [];
L2slices = [];
L2timesteps = [];
time = 45;
for z = 1:500
    L2slice = [L2slice,L2(:,23,z,time)];
    L2timesteps = [L2timesteps,L2(:,23,z,:)];
end

for t = 1:90
    L2slices(:,:,t) = L2timesteps(:,:,:,t);
end

L2slice = [zeros(size(L2slice,2),2)'; L2slice; zeros(size(L2slice,2),3)'];
L2slice = abs(L2slice);

Plume = PlumeD(:,:,time);

%%
f1 = figure(1);
clf;
hold on
grid on

%{
contourf(L2slice,20);
colormap(hsv);
colorbar('southoutside');
%}

zmin = floor(min(L2slice(:))); 
zmax = max(L2slice(:)); %ceil(max(L2slice(:)));
zinc = (zmax - zmin) / 50;
zindex = zmin:2:zmax;
zlevs = zmin:zinc:zmax;
contourf(L2slice,zlevs)
colormap(hsv)
hold on
contour(L2slice,zindex,'LineWidth',2);
colorbar('southoutside');
%}

title('CaseF050 L2');
xlabel('X');
ylabel('Y');

%%
f4 = figure(4);
clf;
hold on
grid on

%contourf(Plume,50);
%colormap(hsv)


zmin = floor(min(Plume(:))); 
zmax = ceil(max(Plume(:)));
zinc = (zmax - zmin) / 50;
zindex = zmin:2:zmax;
zlevs = zmin:zinc:zmax;
contourf(Plume,zlevs)
colormap(jet)
hold on
contour(Plume,zindex,'LineWidth',2);
colorbar('southoutside');
%}

title('CaseF050 Concentration');
xlabel('X');
ylabel('Y');

%% Plot over time
f5 = figure(5);
hold on
grid on

for t = 1:90
    L = L2slices(:,:,t);
    contourf(L,10)
    colormap(hsv)
    hold on

    drawnow
    fprintf('Time step - %s/%s\n',num2str(t),num2str(90));
end

%%
path = "MSNsimulator/TurbulentPlumeSimulator/Case_F050/";

filename = path + 'L2slice' + '.mat';
save(filename,'L2slice');

filename2 = path + 'L2slices' + '.mat';
save(filename2,'L2slices');

figname = path + 'L2.png';
saveas(f1,figname);

figname2 = path + 'Plume.png';
saveas(f4,figname2);