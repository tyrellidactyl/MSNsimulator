
sensors = "N10";
Cases = 3;
Test = 2;

[initX,initY,initAngle] = SpawnMSN(Test); % Initialize Spawn point and starting goal
distError = sqrt((initX^2)+(initY^2)); % Initial displacement

for i = 1:Cases
    E{i} = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case"+num2str(i)+"/Test" + Test + "/GAcase"+num2str(i)+"test" + Test + "trial0" + sensors + "error.mat");
    e{i} = E{i}.LocalizationError{1}.Values;
    
    P{i} = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case"+num2str(i)+"/Test" + Test + "/GAcase"+num2str(i)+"test" + Test + "trial0" + sensors + "poses.mat");
    p{i} = P{i}.gXoff;
    
    %{
    openfig("/home/ty/MSNsimulator/TestResults/PlumeCases/Case"+num2str(i)+"/Test" + Test + "/GAcase"+num2str(i)+"test" + Test + "trial0" + sensors + ".fig");
    set(ans,'Visible','off');
    gcf = figure(ans(4).Number);
    set(gcf,'Visible','off');
    ax = gcf.CurrentAxes;
    D=get(gca,'Children'); %get the handle of the line object
    XData=get(D,'XData'); %get the x data
    YData=get(D,'YData'); %get the y data
    Data{i} = YData{1,1};
    %}
    
end

%% Localization Error Plot
f1 = figure(1);
clf;
set(f1,'Position',[1 1081 1920 445]);
hold on
grid on

for i = 1:Cases
    plot(e{i} / distError,'LineWidth',3)
end
axis([0 120 0 1.25]);
%legend('A','B','C','D','E','F','Location','southwest')
legend('A','B','C','D','Location','southwest')
title('Gradient Ascent ' + sensors + ' - Stability Class Performance Error - Localization')
xlabel('Time [s]')
ylabel('Localization Error - [Displacement / InitialError]')

%% Strength Error Plot
f2 = figure(2);
clf;
set(f2,'Position',[1 1609 1920 445]);
hold on
grid on

for i = 1:Cases
    plot(Data{i},'LineWidth',3)
end
axis([0 12000 0 1]);
%legend('A','B','C','D','E','F','Location','northwest')
legend('A','Location','northwest')
title('Gradient Ascent ' + sensors + ' - Stability Class Performance Error - Source Strength')
xlabel('Time [s]')
ylabel('Strength Estimate - [Estimate / Actual]')

%%
f3 = figure(3);
clf;
set(f3,'Position',[1 1081 1920 445]);
hold on
grid on

for i = 1:Cases
    Poses = p{i};
    %plot(Poses(:,1)-500,Poses(:,2)-250,'LineWidth',3)
    scatter(Poses(:,1)-500,Poses(:,2)-250,'filled','o')
end
plot(0,0,'r*','MarkerSize',10,'LineWidth',3) % Source Location
plot(initX,initY,'ks','MarkerSize',15,'LineWidth',2) % Initial Position
%axis([0 120 0 1.25]);
%legend('A','B','C','D','E','F','Location','southwest')
legend('A','B','C','Source','Origin','Location','northwest')
title('Gradient Ascent ' + sensors + ' - Stability Class Performance - Vehicle Path')
xlabel('X [m]')
ylabel('Y - [m]')


%%
save = 0;

if save == 1
path = "/home/ty/MSNsimulator/TestResults/GradientAscent/Test" + Test;
h(1) = figure(1);
fig1 = path + 'StabilityClassLocalizationErrors' + sensors + '.png';
saveas(h(1),fig1);

h(2) = figure(2);
fig2 = path + 'StabilityClassStrengthErrors' + sensors + '.png';
saveas(h(2),fig2);

h(3) = figure(3);
fig3 = path + 'StabilityClassVehiclePath' + sensors + '.png';
saveas(h(3),fig3);
end
