function [error,poses,strength] = GetData(Sclass,Test,sensors)

E{Sclass} = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case"+num2str(Sclass)+"/Test" + Test + "/GAcase"+num2str(Sclass)+"test" + Test + "trial0N" + num2str(sensors) + "error.mat");
error = E{Sclass}.LocalizationError{1}.Values;
    
P{Sclass} = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case"+num2str(Sclass)+"/Test" + Test + "/GAcase"+num2str(Sclass)+"test" + Test + "trial0N" + num2str(sensors) + "poses.mat");
poses = P{Sclass}.gXoff;
    

openfig("/home/ty/MSNsimulator/TestResults/PlumeCases/Case"+num2str(Sclass)+"/Test" + Test + "/GAcase"+num2str(Sclass)+"test" + Test + "trial0N" + num2str(sensors) + ".fig");
set(ans,'Visible','off');
gcf = figure(ans(4).Number);
set(gcf,'Visible','off');
ax = gcf.CurrentAxes;
D=get(gca,'Children'); %get the handle of the line object
XData=get(D,'XData'); %get the x data
YData=get(D,'YData'); %get the y data
strength = YData{1,1};

end