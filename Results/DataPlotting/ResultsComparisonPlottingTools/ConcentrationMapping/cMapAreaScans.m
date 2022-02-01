clear all; clc;

%%
plumecase = 7;
testcase = 5;
metric = 0;

str = "APScase" + num2str(plumecase) + "test" + num2str(testcase) ...
        + "metric" + num2str(metric);

cMap1 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial1N8" + "metric" + num2str(metric) + "cMap.mat");
cMap2 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial2N8" + "metric" + num2str(metric) + "cMap.mat");
cMap3 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial3N8" + "metric" + num2str(metric) + "cMap.mat");
cMap4 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial4N8cMap.mat");
cMap5 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial5N8cMap.mat");
cMap6 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial6N8" + "metric" + num2str(metric) + "cMap.mat");
cMap7 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial7N8cMap.mat");
%cMap1 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
%    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
%    "test" + num2str(testcase) + "trial" + num2str(trial) + "N8" + "metric" + num2str(metric) + ".fig");


load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Ammonia/Case1/PlumeD.mat');

%{
cMap1 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial1N8cMap.mat');
cMap2 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial2N8cMap.mat');
cMap3 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial3N8cMap.mat');
cMap4 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial4N8cMap.mat');
cMap5 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial5N8cMap.mat');
cMap6 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial6N8cMap.mat');
cMap7 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial7N8cMap.mat');
cMap8 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial12N8cMap.mat');
cMap9 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial13N8cMap.mat');
cMap10 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial14N8cMap.mat');
%}

cMap1 = cMap1.cMap(:,:,end);
cMap2 = cMap2.cMap(:,:,end);
cMap3 = cMap3.cMap(:,:,end);
cMap4 = cMap4.cMap(:,:,end);
cMap5 = cMap5.cMap(:,:,end);
cMap6 = cMap6.cMap(:,:,end);
cMap7 = cMap7.cMap(:,:,end);
%cMap8 = cMap8.cMap(:,:,end);
%cMap9 = cMap9.cMap(:,:,end);
%cMap10 = cMap10.cMap(:,:,end);

%%
maxC = max(max(PlumeD)); % maximum plume concentration

maxC1 = max(max(cMap1));
maxC2 = max(max(cMap2));
maxC3 = max(max(cMap3));
maxC4 = max(max(cMap4));
maxC5 = max(max(cMap5));
maxC6 = max(max(cMap6));
maxC7 = max(max(cMap7));
%maxC8 = max(max(cMap8));
%maxC9 = max(max(cMap9));
%maxC10 = max(max(cMap10));

%cScores = [maxC1; maxC2; maxC3; maxC4; maxC5; maxC6; maxC7; maxC8; maxC9; maxC10] / maxC;
cScores = [maxC1; maxC2; maxC3; maxC4; maxC5; maxC6; maxC7] / maxC;

%%
searchArea = 50*700; % total search space square meters
filledArea = size(find(PlumeD >= maxC/1000),1); % total area of plume dispersion above .001 threshold
coverage = filledArea / searchArea;

scan1 = size(find(cMap1 > 0),1); % total square meters of plume scanned
scan2 = size(find(cMap2 > 0),1); % total square meters of plume scanned
scan3 = size(find(cMap3 > 0),1); % total square meters of plume scanned
scan4 = size(find(cMap4 > 0),1); % total square meters of plume scanned
scan5 = size(find(cMap5 > 0),1); % total square meters of plume scanned
scan6 = size(find(cMap6 > 0),1); % total square meters of plume scanned
scan7 = size(find(cMap7 > 0),1); % total square meters of plume scanned
%scan8 = size(find(cMap8 > 0),1); % total square meters of plume scanned
%scan9 = size(find(cMap9 > 0),1); % total square meters of plume scanned
%scan10 = size(find(cMap10 > 0),1); % total square meters of plume scanned

%scanScores = [scan1; scan2; scan3; scan4; scan5; scan6; scan7; scan8; scan9; scan10] / filledArea;
scanScores = [scan1; scan2; scan3; scan4; scan5; scan6; scan7] / filledArea;

%%
scores = [];
for i=1:size(cScores,1)
    score = [scanScores(i), cScores(i)];
    scores = [scores; score];
end
labels = categorical({'Circle','Square','Line','Local','Area','Spiral','Octagon'});
labels = reordercats(labels,{'Circle','Square','Line','Local','Area','Spiral','Octagon'});

%labels = ['Circle','Local','Area','Octagon','SmallCircle','SmallLocal','SmallArea','SmallOctagon','LargeCircle','XLargeCircle'];
%labels = [Trial1 Trial4 Trial5 Trial7 Trial8 Trial10 Trial11 Trial12 Trial13 Trial14];
%labels = {'Circle';'Local';'Area';'Octagon';'SmallCircle';'SmallLocal';'SmallArea';'SmallOctagon';'LargeCircle';'XLargeCircle'};

%T = table(labels,cScores,scanScores);
%summary(T)

%%
f = figure(1);
clf;

hold on

%histogram(cScores)

b = bar(labels,scores,'FaceColor','flat');

b(1).FaceColor = [0 .5 .5]; b(1).EdgeColor = [0 .9 .9]; b(1).LineWidth = 1.5;
b(2).FaceColor = [.75 0 .25]; b(2).EdgeColor = [.75 0 .75]; b(2).LineWidth = 1.5;

maptitle = "Concentration Map Occupancy Scan Comparison: " + str;
title(maptitle)
xlabel('APS Path Trial')
ylabel('Fraction of Plume Information Scanned')
legend('PlumeAreaScanned','MaximumConcentrationScanned','Location','best');
%legend('PlumeAreaScanned','MaximumScannedConcentration','Location','northwestoutside');

%%
path = "/home/ty/MSNsimulator/TestResults/AdaptiveSS/";
fig1 = path + str + 'ConcMapScanComparison.png';
saveas(f,fig1);

%%
%{
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
%}



