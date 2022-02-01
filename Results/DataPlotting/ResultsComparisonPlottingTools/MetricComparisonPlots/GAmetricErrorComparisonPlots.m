clear all; clc;

%%
plumecase = 7;
testcase = 5;
N = 8;

load("home/ty/MSNsimulator/TurbulentPlumeSimulator/Ammonia/Case1/PlumeD.mat");

default = "/GAcase" + num2str(plumecase) + "test" + num2str(testcase) ...
        + "trial" + num2str(0) + "N" + num2str(N) + "error.mat";
    
default2 = "/GAcase" + num2str(plumecase) + "test" + num2str(testcase) ...
        + "trial" + num2str(0) + "N" + num2str(N) + "poses.mat";
    
load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + ...
         num2str(plumecase) + "/Test" + num2str(testcase) + default);
     
load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + ...
         num2str(plumecase) + "/Test" + num2str(testcase) + default2);
     
n{7} = LocalizationError{1}.Values;

p{7} = [gXoff(:,1)-350,gXoff(:,2)];

for i = 1:6
    str = "/GAcase" + num2str(plumecase) + "test" + num2str(testcase) ...
        + "trial" + num2str(i+12) + "N" + num2str(N) + "metric0error.mat";
    
    str2 = "/GAcase" + num2str(plumecase) + "test" + num2str(testcase) ...
        + "trial" + num2str(i+12) + "N" + num2str(N) + "metric0poses.mat";
    
    load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + ...
         num2str(plumecase) + "/Test" + num2str(testcase) + str);
     
    load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + ...
         num2str(plumecase) + "/Test" + num2str(testcase) + str2);
    
    n{i} = LocalizationError{1}.Values
    p{i} = [gXoff(:,1)-350,gXoff(:,2)];
end

%%
f1 = figure(1);
clf;
%set(f1,'Position',[1 1081 1919 706]);
hold on
grid on

for i = 1:3
    plot(n{i},'LineWidth',2.5)
end

plot(n{7},'LineWidth',2.5)

for i = 4:6
    plot(n{i},'LineWidth',2.5)
end


% mag:        .5, 1, 1.5, 2, 2.5, 3, 3.5
% sensorDist: .25, .5, .75, 1, 1.25, 1.5, 1.75
% distThresh: .125,.25, .375, .5, .625, .75, .875

%legend('1: 0.5','2: 1','3: 1.5','0: 2','4: 2.5','5: 3','6: 3.5','Location','southwest')
%title('Gradient Ascent - Performance Error Comparison - Update Magnitude Metric')
%legend('1: 0.25','2: 0.5','3: 0.75','0: 1','4: 1.25','5: 1.5','6: 1.75','Location','southwest')
%title('Gradient Ascent - Performance Error Comparison - Sensor Distance Metric')
legend('1: 0.125','2: 0.25','3: 0.375','0: 0.5','4: 0.625','5: 0.75','6: 0.875','Location','southwest')
title('Gradient Ascent - Performance Error Comparison - Distance Threshold Metric')

xlabel('Time [s]')
ylabel('Localization Error - [Displacement]')
axis([0 150 0 175])

%%
f2 = figure(2);
clf;
%set(f1,'Position',[1 1081 1919 706]);
hold on
grid on

PlumeFinal = PlumeD(:,:);

zmin = floor(min(PlumeFinal(:))); 
zmax = ceil(max(PlumeFinal(:)));
zinc = (zmax - zmin) / 30;
zindex = zmin:5:zmax;
zlevs = zmin:zinc:zmax;
contourf(PlumeFinal,zlevs)
colormap(jet)
hold on
contour(PlumeFinal,zindex,'LineWidth',2)

for i = 1:3
    poses = p{i};
    scatter(poses(:,1),poses(:,2),25,'filled','<','MarkerEdgeColor','white')
end

poses = p{7};
scatter(poses(:,1),poses(:,2),100,'filled','h','MarkerEdgeColor','white','MarkerFaceColor','magenta')

for i = 4:6
    poses = p{i};
    scatter(poses(:,1),poses(:,2),25,'filled','>','MarkerEdgeColor','white')
end

%legend('PlumeContour','PlumeContour','1: 0.5','2: 1','3: 1.5','0: 2','4: 2.5','5: 3','6: 3.5','Location','southwest')
%title('Gradient Ascent - Trajectory Comparison - Update Magnitude Metric')
%legend('PlumeContour','PlumeContour','1: 0.25','2: 0.5','3: 0.75','0: 1','4: 1.25','5: 1.5','6: 1.75','Location','southwest')
%title('Gradient Ascent - Trajectory Comparison - Sensor Distance Metric')
legend('PlumeContour','PlumeContour','1: 0.125','2: 0.25','3: 0.375','0: 0.5','4: 0.625','5: 0.75','6: 0.875','Location','southwest')
title('Gradient Ascent - Trajectory Comparison - Distance Threshold Metric')

xlabel('X [m]')
ylabel('Y [m]')
axis([1 175 1 50])

%%
path = "/home/ty/MSNsimulator/TestResults/GradientAscent/";
str = "case" + num2str(plumecase) + "test" + num2str(testcase) ...
      + "N" + num2str(N) + "DistThresh";
fig1 = path + str + 'MetricErrorComparison.png';
fig2 = path + str + 'MetricTrajectoryComparison.png';
saveas(f1,fig1);
saveas(f2,fig2);