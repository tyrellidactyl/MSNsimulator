clear all; clc;

%%
plumecase = 8;
N = 10;

[PlumeD,SigmaY,Sclass] = GPlume(plumecase);
eval = "Case" + num2str(plumecase) + "N" + num2str(N);

for i = [5,6,7,10,13]
    str = "/GAcase" + num2str(plumecase) + "test" + num2str(i) ...
        + "trial" + num2str(0) + "N" + num2str(N) + "metric0error.mat"; %metric0
    
    str2 = "/GAcase" + num2str(plumecase) + "test" + num2str(i) ...
        + "trial" + num2str(0) + "N" + num2str(N) + "metric0poses.mat";
    
    load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + ...
         num2str(plumecase) + "/Test" + num2str(i) + str);
     
    load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + ...
         num2str(plumecase) + "/Test" + num2str(i) + str2);
    
    n{i} = LocalizationError{1}.Values;
    p{i} = [gXoff(:,1)-350,gXoff(:,2)];
end

%%
f1 = figure(1);
clf;
hold on

m = [];
for i = [5,6,7,10,13]
    for j = 1:100:size(n{i}.Data,3)
        o = [n{i}.Time(j),n{i}.Data(1,1,j)];
        m = [m;o];
    end
    h1{i} = plot(m(:,1),m(:,2),'LineWidth',2.5);
    m = [];
end

legend([h1{7},h1{6},h1{5},h1{13},h1{10}],'50m','100m','150m','200m','250m','Location','northeast')
title('Gradient Ascent - Performance Error Comparison - Range Tests ' + eval)

xlabel('Time [s]')
ylabel('Localization Error - [Displacement]')
axis([0 250 0 275])

%%
f2 = figure(2);
clf;
hold on

PlumeFinal = PlumeD(:,:);
%contour(PlumeFinal);

zmin = floor(min(PlumeFinal(:))); 
zmax = ceil(max(PlumeFinal(:)));
zinc = (zmax - zmin) / 30;
zindex = zmin:5:zmax;
zlevs = zmin:zinc:zmax;
contourf(PlumeFinal,zlevs);
colormap(jet)
hold on
contour(PlumeFinal,zindex,'LineWidth',2);

for i = [5,6,7,10,13]
    poses = p{i};
    h{i} = plot(poses(1:2:end,1),poses(1:2:end,2),'-p','MarkerFaceColor','white');
end

startline = [50, 50; 0, 25];
startline2 = [100, 100; 0, 25];
startline3 = [150, 150; 0, 25];
startline4 = [200, 200; 0, 25];
startline5 = [250, 250; 0, 25];
centerline = [0, 300; 25, 25];
line(startline(1,:),startline(2,:),'Color','white','LineStyle','--');
line(startline2(1,:),startline2(2,:),'Color','white','LineStyle','--');
line(startline3(1,:),startline3(2,:),'Color','white','LineStyle','--');
line(startline4(1,:),startline4(2,:),'Color','white','LineStyle','--');
line(startline5(1,:),startline5(2,:),'Color','white','LineStyle','--');
line(centerline(1,:),centerline(2,:),'Color','white','LineStyle','--');

legend([h{7},h{6},h{5},h{13},h{10}],'50m','100m','150m','200m','250m')
title('Gradient Ascent - Trajectory Comparison - Range Tests ' + eval)
xlabel('X [m]')
ylabel('Y [m]')
axis([1 300 1 50])

%%
path = "/home/ty/MSNsimulator/TestResults/GradientAscent/PlumeCases/Case" + num2str(plumecase) ...
    + "/RangeTests/";
fig1 = path + eval + 'RestrictedRangeErrorComparison.png';
fig2 = path + eval + 'RestrictedRangeTrajectoryComparison.png';
saveas(f1,fig1);
saveas(f2,fig2);