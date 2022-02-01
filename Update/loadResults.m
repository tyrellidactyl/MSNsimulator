
%% Load Graphical Data

%{
load('PeakPoses.mat')
load('RunningPoses.mat')
Peaks = scanPeaks(PeakPoses,RunningPose);
load('TruePeaks.mat')   % ActualPeaks
load('EstimatedPeaks.mat') % EstimatedPeaks
Actual = ActualPeaks(2:3,:)';
Estimated = EstimatedPeaks(2:3,:)';
%A = unique( Actual(:,:), 'rows');
%B = unique( Estimated(:,:), 'rows');
%Aoff = A + Offset;
%Boff = B + Offset;

%clear Actual ActualPeaks Estimated EstimatedPeaks
%}

gX = unique( goalpoints(:,:), 'rows');
gX = cat(1,gX,origin);
gXoff = gX + Offset;
goalcount = size(gXoff(:,1));

Time = Tm(end);

clear goalpoints Tm tout

%% Plot Results
if turbulence == 1
    plotTurbResults;
else
    plotGaussResults;
end
%plotPeaksTurb;

%% Load Skill Scores:
SkillL = unique( ScoreL(:,:), 'rows');
SkillQ = unique( ScoreQ(:,:), 'rows');
ST = Time/(2*Tmax);
SL = SkillL(1); % Source location score
SQ = SkillQ(1); % Source strength score
SA = (SL+SQ)/2; % Source term score average
%ST = SkillT(end); % Time score   %SR = 
Stotal = SL+SQ+ST;
scores = [SL,SQ,SA,ST,Stotal];

clear ScoreL ScoreQ SkillL SkillQ


%% Save Test Data:
trials = [plumecase,testcase,trial];

filename1 = path + 'testresults.txt';
filename2 = path + str + 'scores' + '.txt';
filename3 = path + str + 'error' + '.mat';
filename4 = path + str + 'poses' + '.mat';
filename5 = path + str + 'cMap' + '.mat';
save(filename1,'trials','metric','scores','Time','-ascii','-append')
save(filename2,'trials','metric','scores','Time','-ascii','-append') %type(filename2)
save(filename3,'LocalizationError');
save(filename4,'gXoff');
save(filename5,'cMap');

clear filename1 filename2 filename3 filename4

%% Save Figures to main file:

h=[f1;f3;f4];

figname = path + str;
savefig(h,figname)

fig1 = path + str + 'robot.png';
fig2 = path + str + 'plume.png';
fig3 = path + str + 'error.png';
fig4 = path + str + 'conc.png';
fig5 = path + str + 'concMap.png';

saveas(f1,fig1);
saveas(f2,fig2);
saveas(f3,fig3);
saveas(f4,fig4);
saveas(f5,fig5);

clear fig1 fig2 fig3 fig4 fig5

%% Save pics to backup folder:
%{
img = getframe(gcf);
nowstr = datestr(now, 'yyyymmddHHMM');
folder = "MSNsimulator/TestResults/AllResults/";

fig1b = folder + nowstr + 'robot.png';
fig2b = folder + nowstr + 'plume.png';
fig3b = folder + nowstr + 'error.png';
fig4b = folder + nowstr + 'conc.png';

saveas(h(1),fig1b);
saveas(h(2),fig2b);
saveas(h(3),fig3b);
saveas(h(4),fig4b);

%}

%% Save Figures to main file:
%{

if turbulence = 1:

h(5) = figure(5);
h(6) = figure(6);
h(7) = figure(7);

figname = path + str + '.fig';
savefig(h,figname)

fig5 = path + str + 'pathData.png';
fig6 = path + str + 'pathData2.png';
fig7 = path + str + 'pathData3.png';

saveas(h(5),fig5);
saveas(h(6),fig6);
saveas(h(7),fig7);

%% Save pics to backup folder:
img = getframe(gcf);
nowstr = datestr(now, 'yyyymmddHHMM');
folder = "MSNsimulator/TestResults/AllResults/Hybrid/";

fig5b = folder + nowstr + 'pathData.png';
fig6b = folder + nowstr + 'pathData2.png';
fig7b = folder + nowstr + 'pathData3.png';

saveas(h(5),fig5b);
saveas(h(6),fig6b);
saveas(h(7),fig7b);
%}


