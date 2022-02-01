clear all; clc; clf;

for i = 3:13
openfig("/home/ty/MSNsimulator/TestResults/PlumeCases/Case1/Test4/GAcase1test4trial0N"+num2str(i)+".fig");
set(ans,'Visible','off');
gcf = figure(ans(4).Number);
set(gcf,'Visible','on');
ax = gcf.CurrentAxes;
D=get(gca,'Children'); %get the handle of the line object
XData=get(D,'XData'); %get the x data
YData=get(D,'YData'); %get the y data
%Data=[XData,YData]; %join the x and y data on one array 2xn
%close(gcf);
Data{i} = YData{1,1};
end

%%
%{
nums = find(Data(1,:)==1);
nums2 = size(nums); nums2 = nums2(2); 
nums3 = size(Data); nums3 = nums3(2) - nums2;
%axis([0 nums3 0 1]);
%}

%%
f1 = figure(1);
clf;
set(f1,'Position',[1 1081 1919 706]);
hold on
grid on

for i=3:13
    plot(Data{i},'LineWidth',3);
end
axis([0 20000 0 1]);

legend('3','4','5','6','7','8','9','10','11','12','13','Location','northwest')
title('Gradient Ascent Sensor Quantity Performance Error - Source Strength')
xlabel('Time Steps [.001 s]')
ylabel('Strength Estimation Error - [Estimate / Actual]')

