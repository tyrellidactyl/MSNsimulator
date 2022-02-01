load('Omega.mat');

Oslice = [];
Oslices = [];
Otimesteps = [];
for z = 1:500
    Oslice = [Oslice,omega(:,23,z,45)];
    Otimesteps = [Otimesteps,omega(:,23,z,:)];
end

for t = 1:90
    Oslices(:,:,t) = Otimesteps(:,:,:,t);
end

Oslice = [zeros(size(Oslice,2),2)'; Oslice; zeros(size(Oslice,2),3)'];

%%
f3 = figure(3);
clf;
hold on
grid on


contourf(Oslice,20);
colormap(jet);
colorbar('southoutside');
%}

%{
zmin = floor(min(Oslice(:))); 
zmax = max(Oslice(:)); %ceil(max(L2slice(:)));
zinc = (zmax - zmin) / 50;
zindex = zmin:2:zmax;
zlevs = zmin:zinc:zmax;
contourf(Oslice,zlevs)
colormap(hsv)
hold on
contour(Oslice,zindex,'LineWidth',2);
colorbar('southoutside');
%}

title('CaseF050 Omega');
xlabel('X');
ylabel('Y');

%% Plot over time
f5 = figure(5);
hold on
grid on

for t = 1:10:90
    O = Oslices(:,:,t);
    contourf(O,10)
    colormap(hsv)
    hold on

    drawnow
    fprintf('Time step - %s/%s\n',num2str(t),num2str(90));
end

%%
path = "MSNsimulator/TurbulentPlumeSimulator/Case_F050/";

filename = path + 'Oslice' + '.mat';
save(filename,'Oslice');

filename2 = path + 'Oslices' + '.mat';
save(filename2,'Oslices');

figname = path + 'Omega.png';
saveas(f3,figname);