
%% figure 1: Robot Visualization
figure(1)
f1 = figure(1)
set(f1,'Position',[1 1269 1920 445]);
testtitle = "MSN Tracking Results: " + str;
hold on
plot(gX(:,1),gX(:,2),'co-','MarkerSize',1,'LineWidth',1) % Goal Points
grid on
%legend('Heading Angle','Mobile Robot','Path Trajectory','Waypoints','Goal Points')
xlabel('X [.25meters]')
title(testtitle)
axY = (3*l)+1;
%axis([-5 (initX) -axY axY])
axis([0 (500) -axY axY])
%ax = gca;
%ax.XTick = [-5:5:initX];
%ax.YTick = [-axY:2:axY];
hold off

%% figure 2: Plume Contour
f2 = figure(2)
set(f2,'Position',[1 1609 921 445]);
clf;
PlumeFinal = PlumeD(:,:,T/2);
casetitle = "Plume Contour: " + str;
hold on 
grid on
title(casetitle)
zmin = floor(min(PlumeFinal(:))); 
zmax = ceil(max(PlumeFinal(:)));
zinc = (zmax - zmin) / 20;
zindex = zmin:5:zmax;
zlevs = zmin:zinc:zmax;
contourf(PlumeFinal,zlevs)
colormap(jet)
hold on
contour(PlumeFinal,zindex,'LineWidth',2)
colorbar('southoutside','Ticks',[0 250 500 750 1000],...
         'TickLabels',{'0','250','500','750','1000'},'Direction','reverse');
plot(gXoff(:,1),gXoff(:,2),'wo-','MarkerSize',3,'LineWidth',2) % Detected Peaks

%axis([45 (50+initX+(L/2)) (51.5-(axY/1.5)) (51.5+(axY/1.5))])
axis([0 500 1 50]);
%ax = gca;
%ax.XTick = [45:2:(50+initX+(L/2))];
%ax.YTick = [(50-axY):1:(50+axY)];

%% figure 3: Localization Error
f3 = figure(3)
clf;
set(f3,'Position',[921 1462 1000 255]);
errortitle = "Localization Error: " + str;
plot(Error,'c','LineWidth',2)
grid on
title(errortitle)
ylabel('Distance Error [m]')
xlabel('Simulation Time [seconds]')
axis([0 Tmax 0 25])
ax = gca;
ax.XTick = [0:5:Tmax];
ax.YTick = [0:5:25];

%% figure 4: Strength Estimation Error
f4 = figure(4)
clf;
set(f4,'Position',[921 1799 1000 255]);
strengthtitle = "Strength Estimation Error: " + str;
plot(Cdet,'c:','LineWidth',2)
hold on
grid on
plot(Cmax,'r-','LineWidth',2)
plot(Qest,'m-','LineWidth',2.5)
title(strengthtitle)
ylabel('Concentration')
xlabel('Simulation Time [seconds]')
legend('Detected Concentrations','Maximum Concentration','Estimated Maximum','Location','northeastoutside')

axis([0 Tmax 0 1000])
ax = gca;
ax.XTick = [0:5:Tmax];
ax.YTick = [0:100:1000];



%% figure 5: Data Measurements
[windData,maxDataW] = dataEst(data,init,finalPoint);
[concData,maxDataC] = dataEst(dataC,init,finalPoint);
[vorData,maxDataV] = dataEst(dataVor,init,finalPoint);


f5 = figure(5)
set(f5,'Position',[73 1359 906 667]);
clf;
x = windData(:,1);
y = windData(:,2);
sz = windData(:,3);
szC = concData(:,3);
szV = vorData(:,3);

scatter(x,y,sz,'LineWidth',2)

hold on
mx = maxDataW(:,1);
my = maxDataW(:,2);
msz = maxDataW(:,3);
scatter(mx,my,msz,'filled')
line(mx,my,'Color','blue','LineWidth',1.5)

mxC = maxDataC(:,1);
myC = maxDataC(:,2);
mszC = maxDataC(:,3);
scatter(mxC,myC,mszC,'d','filled')
line(mxC,myC,'Color','red','LineWidth',1.5)

mxV = maxDataV(:,1);
myV = maxDataV(:,2);
mszV = maxDataV(:,3);
scatter(mxV,myV,mszV,'s','filled')
line(mxV,myV,'Color','green','LineWidth',1.5)

trueline = [-1,0;0,0];
line(trueline(1,:),trueline(2,:),'Color','black','LineWidth',1.5)

grid on
title('Path Data Measurements')
legend('Wind','MaxWind','Conc','MaxConc','Location','northeastoutside')
ylabel('Y')
xlabel('X')


%% path data plot
plotDataTest;

