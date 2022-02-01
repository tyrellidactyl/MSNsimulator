
plumecase = 3;
caseF = int2str(plumecase);

[l,L,PlumeD,WindX,WindY] = plumeShape(plumecase);

Plume = PlumeD(:,:,end);


%% Plot plume transverse section
f1 = figure(1)
clf;
axY = (4*l)+5;
%set(f1,'Position',[1 1609 1920 445]);
set(f1,'Position',[1 1081 1920 750]);
hold on
grid on
zmin = floor(min(Plume(:))); 
zmax = ceil(max(Plume(:)));
zinc = (zmax - zmin) / 50;
zindex = zmin:4:zmax;
zlevs = zmin:zinc:zmax;
contourf(Plume,zlevs)
colormap(jet)
hold on
contour(Plume,zindex,'LineWidth',2)
colorbar('southoutside','Ticks',[0 250 500 750 1000],...
         'TickLabels',{'0','250','500','750','1000'},'Direction','reverse');
title("Case" + caseF + " Conc. Data");

axis([45 (50 + 2*L) (51.5-(axY/1.5)) (51.5+(axY/1.5))])
ax = gca;
ax.XTick = [45:2:(50+2*L)];
ax.YTick = [(50-axY):1:(50+axY)];


%% save results
path = "MSNsimulator/GaussianPlumeSimulator/CaseData/";


h(1) = figure(1);
%h(2) = figure(2);

fig1 = path + 'plumeCase' + plumecase + '.png';
%fig2 = path + 'windTest.png';
saveas(h(1),fig1);
%saveas(h(2),fig2);


