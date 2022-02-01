clear all; clc;

%%
plumecase = 7;
testcase = 5;
trial = 1;

str = "APScase" + num2str(plumecase) + "test" + num2str(testcase) ...
        + "trial" + num2str(trial);

cMap0 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial1N8" + "metric" + num2str(0) + "cMap.mat");

%{
cMap1 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial1N8" + "metric" + num2str(5) + "cMap.mat");
cMap2 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial1N8" + "metric" + num2str(6) + "cMap.mat");
cMap3 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial1N8" + "metric" + num2str(7) + "cMap.mat");

cMap4 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial1N8" + "metric" + num2str(4) + "cMap.mat");
%}
cMap5 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial1N8" + "metric" + num2str(5) + "cMap.mat");
cMap6 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial1N8" + "metric" + num2str(6) + "cMap.mat");
cMap7 = load("/home/ty/MSNsimulator/TestResults/PlumeCases/Case" + num2str(plumecase) + ...
    "/Test" + num2str(testcase) + "/APScase" + num2str(plumecase) + ...
    "test" + num2str(testcase) + "trial1N8" + "metric" + num2str(7) + "cMap.mat");

load('/home/ty/MSNsimulator/TurbulentPlumeSimulator/Ammonia/Case1/PlumeD.mat');

% " + "metric" + num2str(metric) + "
%{
cMap1 = load('/home/ty/MSNsimulator/TestResults/PlumeCases/Case7/Test5/APScase7test5trial1N8cMap.mat');
%}

cMap0 = cMap0.cMap(:,:,end);
%{
cMap1 = cMap1.cMap(:,:,end);
cMap2 = cMap2.cMap(:,:,end);
cMap3 = cMap3.cMap(:,:,end);
cMap4 = cMap4.cMap(:,:,end);
%}
cMap5 = cMap5.cMap(:,:,end);
cMap6 = cMap6.cMap(:,:,end);
cMap7 = cMap7.cMap(:,:,end);

%%
maxC = max(max(PlumeD)); % maximum plume concentration

maxC0 = max(max(cMap0));
%maxC1 = max(max(cMap1));
%maxC2 = max(max(cMap2));
%maxC3 = max(max(cMap3));
%maxC4 = max(max(cMap4));
maxC5 = max(max(cMap5));
maxC6 = max(max(cMap6));
maxC7 = max(max(cMap7));

%cScores = [maxC1; maxC2; maxC0; maxC3; maxC4] / maxC;
cScores = [maxC5; maxC0; maxC6; maxC7] / maxC;

%%
searchArea = 50*700; % total search space square meters
filledArea = size(find(PlumeD >= maxC/1000),1); % total area of plume dispersion above .001 threshold
coverage = filledArea / searchArea;

scan0 = size(find(cMap0 > 0),1); % total square meters of plume scanned
%{
scan1 = size(find(cMap1 > 0),1); % total square meters of plume scanned
scan2 = size(find(cMap2 > 0),1); % total square meters of plume scanned
scan3 = size(find(cMap3 > 0),1); % total square meters of plume scanned
scan4 = size(find(cMap4 > 0),1); % total square meters of plume scanned
%}
scan5 = size(find(cMap5 > 0),1); % total square meters of plume scanned
scan6 = size(find(cMap6 > 0),1); % total square meters of plume scanned
scan7 = size(find(cMap7 > 0),1); % total square meters of plume scanned

%scanScores = [scan1; scan2; scan0; scan3; scan4] / filledArea;
scanScores = [scan5; scan0; scan6; scan7] / filledArea;

%%
scores = [];
for i=1:size(cScores,1)
    score = [scanScores(i), cScores(i)];
    scores = [scores; score];
end
%labels = categorical({'M1','M2','M0','M3','M4'});
%labels = categorical({'M5','M0','M6','M7'});
labels = categorical({'7.5','10.0','12.5','15.0'});
%labels = reordercats(labels,{'M1','M2','M0','M3','M4'});
labels = reordercats(labels,{'7.5','10.0','12.5','15.0'});

%%
f = figure(1);
clf;

hold on

%histogram(cScores)

b = bar(labels,scores,'FaceColor','flat');

b(1).FaceColor = [0 .5 .5]; b(1).EdgeColor = [0 .9 .9]; b(1).LineWidth = 1.5;
b(2).FaceColor = [.75 0 .25]; b(2).EdgeColor = [.75 0 .75]; b(2).LineWidth = 1.5;

maptitle = "Concentration Map Occupancy Scan Comparison (Initial Size Metric): " + str;
title(maptitle)
xlabel('Initial Size [m]')
ylabel('Fraction of Plume Information Scanned')
%legend('PlumeAreaScanned','MaximumConcentrationScanned','Location','best');
legend('PlumeAreaScanned','MaximumScannedConcentration','Location','northwest');

%%
path = "/home/ty/MSNsimulator/TestResults/AdaptiveSS/";
fig1 = path + str + 'ConcMapScanInitSizeMetricsComparison.png';
saveas(f,fig1);



