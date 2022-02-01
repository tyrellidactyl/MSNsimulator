clear all; clc;

str = "Q10-U3-ClassA-rural-CO2";
param = "SigmaZ";

load('/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassA-rural-CO2sigmay.mat')
load('/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/Q10-U3-ClassA-rural-CO2sigmaz.mat')
SigmaY = sigmay(501);
SigmaZ = sigmaz(501);
distError = sqrt((50^2)+(500^2));

%%
for i = 3:13
    N{i} = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case1/Test4/GAcase1test4trial0N"+num2str(i)+"error.mat");
    n{i} = N{i}.LocalizationError{1}.Values * distError / SigmaZ;
end

%%
f1 = figure(1);
clf;
set(f1,'Position',[1 1081 1919 706]);
hold on
grid on

for i = 3:13
    plot(n{i},'LineWidth',3)
end

%%
legend('3','4','5','6','7','8','9','10','11','12','13','Location','southwest')
title('Gradient Ascent - Sensor Quantity Performance Error - ' + str)
xlabel('Time [s]')
ylabel('Localization Error - [Displacement / ' + param + ']')

%%
save = 1;

if save==1
path = "/home/ty/MSNsimulator/TestResults/GradientAscent/";
h(1) = figure(1);
fig1 = path + 'SensorQuantityErrors' + str + param + '.png';
saveas(h(1),fig1);
end