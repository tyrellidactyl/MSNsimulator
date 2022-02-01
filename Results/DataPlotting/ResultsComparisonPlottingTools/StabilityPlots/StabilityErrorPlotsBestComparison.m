clear; clc;

%%
%sensors = "N6";
%Sclass = 3;
Test = 2;

[initX,initY,initAngle] = SpawnMSN(Test); % Initialize Spawn point and starting goal
distError = sqrt((initX^2)+(initY^2)); % Initial displacement

[eN6,pN6,strengthN6] = GetData(2,Test,6);
[eN7,pN7,strengthN7] = GetData(3,Test,7);
[eN8,pN8,strengthN8] = GetData(1,Test,8);
[eN9,pN9,strengthN9] = GetData(1,Test,9);
[eN10,pN10,strengthN10] = GetData(1,Test,10);
[eN11,pN11,strengthN11] = GetData(1,Test,11);
%[eN12,pN12,strengthN12] = GetData(1,Test,12);



%% Localization Error Plot
f1 = figure(1);
clf;
set(f1,'Position',[1 1081 1920 445]);
hold on
grid on

plot(eN6 / distError,'LineWidth',3)
plot(eN7 / distError,'LineWidth',3)
plot(eN8 / distError,'LineWidth',3)
plot(eN9 / distError,'LineWidth',3)
plot(eN10 / distError,'LineWidth',3)
plot(eN11 / distError,'LineWidth',3)
%plot(eN12 / distError,'LineWidth',3)

axis([0 200 0 1.25]);
%legend('A','B','C','D','E','F','Location','southwest')
legend('N6B','N7C','N8A','N9A','N10A','N11A','Location','southwest')
title('Gradient Ascent - Stability Class Performance Error Comparison - Localization')
xlabel('Time [s]')
ylabel('Localization Error - [Displacement / InitialError]')

%% Strength Error Plot
f2 = figure(2);
clf;
set(f2,'Position',[1 1609 1920 445]);
hold on
grid on

plot(strengthN6,'LineWidth',3)
plot(strengthN7,'LineWidth',3)
plot(strengthN8,'LineWidth',3)
plot(strengthN9,'LineWidth',3)
plot(strengthN10,'LineWidth',3)
plot(strengthN11,'LineWidth',3)
%plot(strengthN12,'LineWidth',3)

axis([0 20000 0 1.25]);
%legend('A','B','C','D','E','F','Location','southwest')
legend('N6B','N7C','N8A','N9A','N10A','N11A','Location','southwest')
title('Gradient Ascent - Stability Class Performance Error Comparison - Localization')
xlabel('Time [s]')
ylabel('Strength Estimate - [Estimate / Actual]')

%%
f3 = figure(3);
clf;
set(f3,'Position',[1 1081 1920 445]);
hold on
grid on

plot(pN6(:,1)-500,pN6(:,2)-250,'LineWidth',3)
plot(pN7(:,1)-500,pN7(:,2)-250,'LineWidth',3)
plot(pN8(:,1)-500,pN8(:,2)-250,'LineWidth',3)
plot(pN9(:,1)-500,pN9(:,2)-250,'LineWidth',3)
plot(pN10(:,1)-500,pN10(:,2)-250,'LineWidth',3)
%{
for i = 150:2:434
    scatter(pN11(i,1)-500,pN11(i,2)-250,'LineWidth',3)
end
%plot(pN12(:,1)-500,pN12(:,2)-250,'LineWidth',3)
%}
plot(0,0,'r*','MarkerSize',10,'LineWidth',3) % Source Location
plot(initX,initY,'ks','MarkerSize',15,'LineWidth',2) % Initial Position

legend('N6B','N7C','N8A','N9A','N10A','Source','Origin','Location','northwest')
title('Gradient Ascent - Stability Class Performance Error Comparison - Localization')
xlabel('X [m]')
ylabel('Y [m]')


%%
save = 1;

if save == 1
path = "/home/ty/MSNsimulator/TestResults/GradientAscent/Test" + Test;
h(1) = figure(1);
fig1 = path + 'StabilityClassLocalizationErrorComparison.png';
saveas(h(1),fig1);

h(2) = figure(2);
fig2 = path + 'StabilityClassStrengthErrorComparison.png';
saveas(h(2),fig2);

h(3) = figure(3);
fig3 = path + 'StabilityClassVehiclePathComparison.png';
saveas(h(3),fig3);
end
