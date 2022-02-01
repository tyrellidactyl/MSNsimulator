
%% Load Graphical Data
%gX = unique( goalpoints(:,:), 'rows');
%gX = cat(1,gX,origin);
%gXoff = gX + Offset;
%goalcount = size(gXoff(:,1));

%Time = Tm(end);

%clear goalpoints Tm tout

%% Plot Results


%{
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
%metrics = APSmetrics;

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
%}



