
clear all; clc;

%%
plumecase = 7;
testcase = 5;
trial = 7;
metric = 0;

str = "APScase" + num2str(plumecase) + "test" + num2str(testcase) + "trial" + num2str(trial) ...
        + "metric" + num2str(metric);

openfig("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial" + num2str(trial) + "N8.fig");

%openfig("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
%    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
%    "test" + num2str(testcase) + "trial" + num2str(trial) + "N8" + "metric" + num2str(metric) + ".fig");

set(ans,'Visible','off');
gcf = figure(ans(3).Number);
set(gcf,'Visible','off');
ax = gcf.CurrentAxes;
D=get(gca,'Children'); %get the handle of the line object
XData=get(D,'XData'); %get the x data
YData=get(D,'YData'); %get the y data
Data=[XData;YData]; %join the x and y data on one array 2xn

%%
for i = 1:10000
    if Data(2,i) > 0.9
        Data(2,i) = 0;
    end
end

%%
ReducedData = [];
Time = [];
for i = 1:size(Data,2)
    if Data(2,i) > 0
        ReData = [Data(1,i),Data(2,i)];
        ReducedData = [ReducedData;ReData];
    end
    if Data(2,i) == 1
        Time = [Time;Data(1,i)];
    end
end
ReducedData = ReducedData';
RDataX = ReducedData(1,:);
RDataY = ReducedData(2,:);
Time = [Time;400];
Time = Time(1);

%%
format long
b1 = RDataX' \ RDataY';
yCalc1 = b1*Data(1,:);

%% figure: Strength Estimation Error
f = figure(6);
clf;
%set(f4,'Position',[921 1799 1000 255]);
strengthtitle = "Strength Estimation Error Regression Plot: " + str;
hold on
plot(Data(1,:),Data(2,:),'m-','LineWidth',2.5)
plot(Data(1,:),yCalc1,'r','LineWidth',2.5)
plot([0,Time],[0,1],'k--','LineWidth',2)

txt = ['Slope: ',num2str(b1)];
txt2 = ['Time: ',num2str(Time),' (s)'];
text(10,0.65,txt,'Color','red','FontSize',14)
text(10,0.55,txt2,'Color','black','FontSize',14)

sz = 15;
scatter(ReducedData(1,:),ReducedData(2,:),sz,'d','filled',...
              'MarkerEdgeColor','r',...
              'MarkerFaceColor','m',...
              'LineWidth',1)

title(strengthtitle)
ylabel('Normalized Concentration Data')
xlabel('Simulation Time Steps [seconds]')
axis([0 round((size(Data,2)/100)+1) 0 1])
ax = gca;

%%
path = "/home/ty/MSNsimulator/TestResults/AdaptiveSS/";
fig1 = path + str + 'RegressionStrengthErrors.png';
saveas(f,fig1);

filename1 = path + str + 'slope' + '.mat';
filename2 = path + str + 'time' + '.mat';
save(filename1,'b1');
save(filename2,'Time');