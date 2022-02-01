clear all; clc;

%%
plumecase = 7;
testcase = 7; % 7,6,5,13,10

eval = "Case" + num2str(plumecase) + "Test" + num2str(testcase);
[initX,initY,initAngle,Tmax] = SpawnMSN(testcase);
[PlumeD,SigmaY,Sclass] = GPlume(plumecase);

for i = 3:12
    str = "/GAcase" + num2str(plumecase) + "test" + num2str(testcase) ...
        + "trial" + num2str(0) + "N" + num2str(i) + "error.mat"; %metric0
    
    str2 = "/GAcase" + num2str(plumecase) + "test" + num2str(testcase) ...
        + "trial" + num2str(0) + "N" + num2str(i) + "poses.mat";
    
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
hold on
grid on
m = [];
for i = 3:7
    for j = 1:100:size(n{i}.Data,3)
        o = [n{i}.Time(j),n{i}.Data(1,1,j)];
        m = [m;o];
    end
    plot(m(:,1),m(:,2),'LineWidth',2.5)
    m = [];
end

for i = 8:12
    for j = 1:100:size(n{i}.Data,3)
        o = [n{i}.Time(j),n{i}.Data(1,1,j)];
        m = [m;o];
    end
    plot(m(:,1),m(:,2),'-x','LineWidth',1.5)    
    %plot(n{i},'-o','MarkerIndices',1:5:length(y))
    m = [];
end

legend('3','4','5','6','7','8','9','10','11','12','Location','southwest')
title('Gradient Ascent - Performance Error Comparison - Sensor Quantity '+eval)

xlabel('Time [s]')
ylabel('Localization Error - [Displacement]')
axis([0 (initX) 0 (1.25*initX)])

%%
f2 = figure(2);
clf;
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

for i = 3:7
    poses = p{i};
    h{i} = plot(poses(1:2:end,1),poses(1:2:end,2),'-d','MarkerFaceColor','white');
end

startline = [initX, initX; 0, (25+initY)];
centerline = [0, initX; (25+initY), (25+initY)];
line(startline(1,:),startline(2,:),'Color','white','LineStyle','--');
line(centerline(1,:),centerline(2,:),'Color','white','LineStyle','--');

legend([h{3},h{4},h{5},h{6},h{7}],'3','4','5','6','7');
title('Gradient Ascent - Trajectory Comparison - Lower Sensor Quantity ' + eval);

xlabel('X [m]')
ylabel('Y [m]')
axis([1 250 1 50])

%%
f3 = figure(3);
clf;
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

for i = 8:12
    poses = p{i};
    h{i} = plot(poses(1:2:end,1),poses(1:2:end,2),'-d','MarkerFaceColor','white');
end

startline = [initX, initX; 0, (25+initY)];
centerline = [0, initX; (25+initY), (25+initY)];
line(startline(1,:),startline(2,:),'Color','white','LineStyle','--');
line(centerline(1,:),centerline(2,:),'Color','white','LineStyle','--');

legend([h{8},h{9},h{10},h{11},h{12}],'8','9','10','11','12');
title('Gradient Ascent - Trajectory Comparison - Upper Sensor Quantity ' + eval);

xlabel('X [m]')
ylabel('Y [m]')
axis([1 250 1 50])

%%
path = "/home/ty/MSNsimulator/TestResults/GradientAscent/PlumeCases/Case" + num2str(plumecase) ...
    + "/FullSQTests/";
fig1 = path + eval + 'FullSQErrorComparison.png';
fig2 = path + eval + 'LowerSQTrajectoryComparison.png';
fig3 = path + eval + 'UpperSQTrajectoryComparison.png';
saveas(f1,fig1);
saveas(f2,fig2);
saveas(f3,fig3);