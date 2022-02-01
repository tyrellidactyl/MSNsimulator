
%%
clear all; clc; clf;


openfig("/home/ty/MSNsimulator/TestResults/PlumeCases/Case1/Test4/GAcase1test4trial0N"+num2str(8)+".fig");
set(ans,'Visible','off');
gcf = figure(ans(4).Number);
set(gcf,'Visible','on');
ax = gcf.CurrentAxes;
D=get(gca,'Children'); %get the handle of the line object
XData=get(D,'XData'); %get the x data
YData=get(D,'YData'); %get the y data
%Data=[XData,YData]; %join the x and y data on one array 2xn
%close(gcf);
Data = YData{1,1};

nums = find(Data(1,:)==1);
nums2 = size(nums); nums2 = nums2(2); 
nums3 = size(Data); nums3 = nums3(2) - nums2;


%%
f1 = figure(1);
clf;
set(f1,'Position',[1 1081 1919 706]);
hold on
grid on

plot(Data);
axis([0 nums3 0 1]);

