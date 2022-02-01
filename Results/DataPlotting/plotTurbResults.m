
%% figure 1: Robot Visualization
%figure(1);
f1 = figure(1);
%set(f1,'Position',[974 1081 947 445]);
testtitle = "MSN Tracking Results: " + str + " " + Sclass;
hold on

for i = 1:goalcount(1)
    plot(gX(i,1),gX(i,2),'co-','MarkerSize',1,'LineWidth',1) % Goal Points
end

grid on
legend('Heading Angle','Mobile Robot','Path Trajectory','Waypoints','Goal Points')
xlabel('X [meters]')
title(testtitle)

Length = 1.5*initX;
%axY = (3*l)+1;
axY = initY+50;
axis([0 Length -axY axY])
ax = gca;
ax.XTick = [0:50:(Length)];
ax.YTick = [-axY:(initY/5):axY];
hold off

%% figure 2: Plume Contour
f2 = figure(2);
%set(f2,'Position',[1 181 1440 738]);
clf;
PlumeFinal = PlumeD(:,:);
hold on 
grid on
title(Sclass + " " + str)

zmin = floor(min(PlumeFinal(:))); 
zmax = ceil(max(PlumeFinal(:)));
zinc = (zmax - zmin) / 30;
zindex = zmin:5:zmax;
zlevs = zmin:zinc:zmax;
contourf(PlumeFinal,zlevs)
colormap(jet)
hold on
contour(PlumeFinal,zindex,'LineWidth',2)

colorbar
xlabel('x (m)'), ylabel('y (m)')


%{
for i = 1:2:goalcount(1)
    plot(gXoff(i,1)-OffsetX,gXoff(i,2),'ws','MarkerSize',2,'LineWidth',1) % Goal Updates
end
%}

for i = 1:goalcount(1)
    plot(gXoff(i,1)-OffsetX,gXoff(i,2),'ws','MarkerSize',2,'LineWidth',1) % Goal Updates
end

%{
goals = unique( pathUpdates(:,:), 'rows');
goalcount2 = size(goals(:,1));
for i = 1:goalcount2(1)
    plot(goals(i,1),goals(i,2)+OffsetY,'wx','MarkerSize',15,'LineWidth',1) % Goal Updates
end
%}

plot(0,OffsetY,'r*','MarkerSize',10,'LineWidth',3) % Source Location
plot(gXoff(end,1)-OffsetX,gXoff(end,2),'ws','MarkerSize',15,'LineWidth',2) % Initial Position

cline = [0,Length; OffsetY,OffsetY];
line(cline(1,:),cline(2,:),'Color','black','LineWidth',1,'LineStyle','--')
%text( initX, 10, num2str(initX) + "m", 'FontSize', smallfont - 4, 'FontWeight','bold' );
%axis([1 Length 1 50])
axis([1 250 1 50])

%% figure 3: Localization Error
f3 = figure(3);
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
f4 = figure(4);
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

%% figure 5: Concentration Map
f5 = figure(5);
%set(f5,'Position',[1 2 1383 489]);
clf;

hold on
title(Sclass + " " + str + " Concentration Map")

%{
zmin = 0; 
zmax = MaxC;
zinc = (zmax - zmin) / 50;
zindex = zmin:5:zmax;
zlevs = zmin:zinc:zmax;
contourf(concMap,zlevs)
%contourf(concMap)
colormap(jet)
hold on
contour(PlumeFinal,zindex,'LineWidth',2)
%contour(PlumeFinal)
%}

concMap = cMap(:,:,end);

zmin = 0; 
zmax = ceil(max(concMap(:)));
zinc = (zmax - zmin) / 50;
zindex = zmin:5:zmax;
zlevs = zmin:zinc:zmax;
contourf(concMap,zlevs)
%contourf(concMap)
colormap(jet)
hold on
colorbar
xlabel('x (m)'), ylabel('y (m)')
contour(concMap,zindex,'LineWidth',2)
%contour(PlumeFinal,zindex,'LineWidth',2)
%}
%surf(concMap)

axis([1 Length 1 50]);

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




