
for i = 1:6
    E{i} = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case"+num2str(i)+"/Test3/GAcase"+num2str(i)+"test3trial0error.mat");
    e{i} = E{i}.LocalizationError{1}.Values
    
    openfig("/home/ty/MSNsimulator/TestResults/PlumeCases/Case"+num2str(i)+"/Test3/GAcase"+num2str(i)+"test3trial0.fig");
    set(ans,'Visible','off');
    gcf = figure(ans(4).Number);
    set(gcf,'Visible','on');
    ax = gcf.CurrentAxes;
    D=get(gca,'Children'); %get the handle of the line object
    XData=get(D,'XData'); %get the x data
    YData=get(D,'YData'); %get the y data
    Data{i} = YData{1,1};
    %D{i} = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case"+num2str(i)+"/Test3/GAcase"+num2str(i)+"test3trial0.fig");
end

%%
f1 = figure(1);
clf;
set(f1,'Position',[1 1081 1920 445]);
hold on
grid on

%subplot(2,1,1)
for i = 1:6
    plot(e{i},'LineWidth',3)
end
legend('A','B','C','D','E','F','Location','southwest')
title('Gradient Ascent N8 - Stability Class Performance Error - Localization')
xlabel('Time [s]')
ylabel('Localization Error - [Displacement / InitialError]')

%%
f2 = figure(2);
clf;
set(f2,'Position',[1 1609 1920 445]);
hold on
grid on
%subplot(2,1,2)
for i = 1:6
    plot(Data{i},'LineWidth',3)
end
legend('A','B','C','D','E','F','Location','northwest')
title('Gradient Ascent N8 - Stability Class Performance Error - Source Strength')
xlabel('Time Steps [.001 s]')
ylabel('Strength Estimate - [Estimate / Actual]')

%%
path = "/home/ty/MSNsimulator/TestResults/GradientAscent/Test3";
h(1) = figure(1);
fig1 = path + 'StabilityClassLocalizationErrorsN8.png';
saveas(h(1),fig1);

h(2) = figure(2);
fig2 = path + 'StabilityClassStrengthErrorsN8.png';
saveas(h(2),fig2);

