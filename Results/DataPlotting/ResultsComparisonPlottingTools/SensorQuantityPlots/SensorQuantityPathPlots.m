clear all; clc;

%% Load Figure Files & Data
openfig("/home/ty/MSNsimulator/TestResults/PlumeCases/Case1/Test4/GAcase1test4trial0N"+num2str(3)+".fig");
set(ans,'Visible','off');
gcf1 = figure(ans(2).Number);
%set(gcf1,'Visible','on','Position',[1 1081 1919 706]);
ax1 = gcf1.CurrentAxes;
D1=get(gca,'Children'); %get the handle of the line object
XD1=get(D1,'XData'); %get the x data
YD1=get(D1,'YData'); %get the y data
XData1 = XD1(5:(end-1));
YData1 = YD1(5:(end-1));
Data1 = [XData1,YData1];
Data1 = cell2mat(Data1);

%%
openfig("/home/ty/MSNsimulator/TestResults/PlumeCases/Case1/Test4/GAcase1test4trial0N"+num2str(4)+".fig");
set(ans,'Visible','off');
gcf2 = figure(ans(2).Number);
ax2 = gcf2.CurrentAxes;
D2=get(gca,'Children'); %get the handle of the line object
XD2=get(D2,'XData'); %get the x data
YD2=get(D2,'YData'); %get the y data
XData2 = XD2(5:(end-1));
YData2 = YD2(5:(end-1));
Data2 = [XData2,YData2];
Data2 = cell2mat(Data2);


%%
%names = {'3','4','5','6','7','8','9','10','11','12','13'};
names = {'3','4','5'};
%{
for ind = 1:length(names)
  s.(names{ind}) = magic(length(names{ind}));
end
%}

for i = 3:5  
    openfig("/home/ty/MSNsimulator/TestResults/PlumeCases/Case1/Test4/GAcase1test4trial0N"+num2str(i)+".fig");
    set(ans,'Visible','off');
    gcf = figure(ans(2).Number);
    set(gcf,'Visible','off');
    ax = gcf.CurrentAxes;
    D=get(gca,'Children'); %get the handle of the line object
    XD=get(D,'XData'); %get the x data
    YD=get(D,'YData'); %get the y data
    XData = XD(5:(end-1));
    YData = YD(5:(end-1));
    Data = [XData,YData];
    Data = cell2mat(Data);
    %Data{i} = Data;
    Data.(names{i}) = Data;
end

%%
f1 = figure(1);
clf;
set(f1,'Position',[1 1081 1919 706]);
hold on
grid on
plot(Data1(:,1),Data1(:,2));
plot(Data2(:,1),Data2(:,2));

%%
for i = 3:13
    plot(Data{i},'LineWidth',3)
end

%%
legend('3','4','5','6','7','8','9','10','11','12','13','Location','southwest')
title('Gradient Ascent - Sensor Quantity Performance Error - Stability Class A')
xlabel('Time [s]')
ylabel('Localization Error - [Displacement / InitialError]')

%%
path = "/home/ty/MSNsimulator/TestResults/GradientAscent/";
h(1) = figure(1);
fig1 = path + 'SensorQuantityErrors.png';
saveas(h(1),fig1);