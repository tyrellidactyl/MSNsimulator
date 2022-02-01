clear all; clc;

%%
plumecase = 7;
testcase = 10;
metric = 0;

str = "APScase" + num2str(plumecase) + "test" + num2str(testcase) ...
        + "metric" + num2str(metric);

cMap1 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial1N8cMap.mat");
cMap2 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial4N8cMap.mat");
cMap3 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial5N8cMap.mat");
cMap4 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial7N8cMap.mat");

load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Ammonia/Case1/PlumeD.mat');

% " + "metric" + num2str(metric) + "
%{
cMap1 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial1N8cMap.mat');
%}

cMap1 = cMap1.cMap(:,:,end);
cMap2 = cMap2.cMap(:,:,end);
cMap3 = cMap3.cMap(:,:,end);
cMap4 = cMap4.cMap(:,:,end);

%%
maxC = max(max(PlumeD)); % maximum plume concentration

maxC1 = max(max(cMap1));
maxC2 = max(max(cMap2));
maxC3 = max(max(cMap3));
maxC4 = max(max(cMap4));

cScores = [maxC1; maxC2; maxC3; maxC4] / maxC;

%%
searchArea = 50*700; % total search space square meters
filledArea = size(find(PlumeD >= maxC/1000),1); % total area of plume dispersion above .001 threshold
coverage = filledArea / searchArea;

scan1 = size(find(cMap1 > 0),1); % total square meters of plume scanned
scan2 = size(find(cMap2 > 0),1); % total square meters of plume scanned
scan3 = size(find(cMap3 > 0),1); % total square meters of plume scanned
scan4 = size(find(cMap4 > 0),1); % total square meters of plume scanned

scanScores = [scan1; scan2; scan3; scan4] / filledArea;

%%
scores = [];
for i=1:size(cScores,1)
    score = [scanScores(i), cScores(i)];
    scores = [scores; score];
end
labels = categorical({'Circle','Local','Area','Octagon'});
labels = reordercats(labels,{'Circle','Local','Area','Octagon'});

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

maptitle = "Concentration Map Occupancy Scan Comparison (Best Trials): " + str;
title(maptitle)
xlabel('APS Path Trial')
ylabel('Fraction of Plume Information Scanned')
legend('PlumeAreaScanned','MaximumConcentrationScanned','Location','best');
%legend('PlumeAreaScanned','MaximumScannedConcentration','Location','northwestoutside');

%%
path = "/home/ty/MSNsimulator/TestResults/AdaptiveSS/";
fig1 = path + str + 'ConcMapScanComparisonBestTrials.png';
saveas(f,fig1);



