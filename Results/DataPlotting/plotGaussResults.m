
Length = 1.5*initX;

%% figure 1: Robot Visualization
figure(1);
f1 = figure(1);
set(f1,'Position',[974 1081 947 445]);
testtitle = "MSN Tracking Results: " + str + " " + Sclass;
hold on

for i = 1:goalcount(1)
    plot(gX(i,1),gX(i,2),'co-','MarkerSize',1,'LineWidth',1) % Goal Points
end

grid on
legend('Heading Angle','Mobile Robot','Path Trajectory','Waypoints','Goal Points')
xlabel('X [meters]')
title(testtitle)
%axY = (3*l)+1;
axY = initY+50;
axis([0 550 -axY axY])
ax = gca;
ax.XTick = [0:50:(550)];
ax.YTick = [-axY:(initY/5):axY];
hold off

%% figure 2: Plume Contour
f2 = figure(2);
set(f2,'Position',[1 1081 1403 738]);
clf;
PlumeFinal = PlumeD(:,:);
hold on 
grid on
title(Sclass + " " +str)

Area = 1000;
Res = 1;
xlim = [  0, Area];
ylim = [-OffsetY,  OffsetY];
nx = Res*xlim(2);
ny = Res*(2*ylim(2));
x0 = xlim(1) + [0:nx]/nx * (xlim(2)-xlim(1)); % distance along wind direction (m)
y0 = ylim(1) + [0:ny]/ny * (ylim(2)-ylim(1)); % cross-wind distance (m)
[xmesh, ymesh] = meshgrid( x0, y0 );          % mesh points for contour plot

%[sigmay,sigmaz] = stabilityClass(stability,terrain,x0);

clist = [100 1000 10000 100000 1000000];
%clist = [MaxC/10000 MaxC/1000 MaxC/100 MaxC/10 MaxC];

%contourf(PlumeFinal)
[c2, h2] = contourf( xmesh, ymesh, PlumeFinal, clist );
smallfont = 14;
clabel(c2, h2, 'FontSize', smallfont-6 )
colormap(1-winter)  % These colors make the labels more readable
colorbar
set(gca, 'XLim', xlim ), set(gca, 'YLim', ylim )
xlabel('x (m)'), ylabel('y (m)')

for i = 1:goalcount(1)
    plot(gXoff(i,1)-OffsetX,gXoff(i,2)-OffsetY,'ks','MarkerSize',2,'LineWidth',1) % Goal Updates
end

%plot(gXoff(1,1)-OffsetX,gXoff(1,2)-OffsetY,'kx','MarkerSize',15,'LineWidth',3) % Final Estimate
plot(0,0,'r*','MarkerSize',10,'LineWidth',3) % Source Location
plot(gXoff(end,1)-OffsetX,gXoff(end,2)-OffsetY,'ks','MarkerSize',15,'LineWidth',2) % Initial Position

cline = [0,1000; 0,0];
line(cline(1,:),cline(2,:),'Color','black','LineWidth',1,'LineStyle','--')

%text( initX, 10, num2str(initX) + "m", 'FontSize', smallfont - 4, 'FontWeight','bold' );

%% figure 3: Localization Error
f3 = figure(3)
clf;
%set(f3,'Position',[921 1462 1000 255]);
errortitle = "Localization Error: " + str + " _ " + Sclass + " _ Time: " + Time + "s";
plot(Error,'c','LineWidth',2)
grid on
title(errortitle)
ylabel('Distance Error [m]')
xlabel('Simulation Time [seconds]')
axis([0 round(Time+1) 0 (1.1*distError)])
ax = gca;
%ax.XTick = [0:5:Tmax];
%ax.YTick = [0:5:];

%% figure 4: Strength Estimation Error
f4 = figure(4)
clf;
%set(f4,'Position',[921 1799 1000 255]);
strengthtitle = "Strength Estimation Error: " + str + " " + Sclass;
%plot(Cdet,'c:','LineWidth',2)
hold on
grid on
%plot(Cmax/MaxC,'k--','LineWidth',1)
plot(Qest,'m-','LineWidth',2.5)
title(strengthtitle)
ylabel('Concentration')
xlabel('Simulation Time [seconds]')
%legend('Detected Concentrations','Maximum Concentration','Estimated Maximum','Location','northeastoutside')

axis([0 round(Time+1) 0 1])
ax = gca;
%ax.XTick = [0:5:Tmax];
%ax.YTick = [0:100:1000000];



%% figure 5: Data Measurements
%{
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
%}
