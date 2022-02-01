%
% gpplot.m: Plot the Gaussian plume solution with constant eddy diffusivity.
%
%
clear all; clc;

Q = 1;     % source emission rate (kg/s)
U = 1;     % wind speed (m/s)
K = 1;     % eddy diffusion coefficient (m^2/s)
H = 0;     % source height (m)

path = '/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
str = "Q"+num2str(Q)+"U"+num2str(U)+"K"+num2str(K);

rmax = 50;  % size of domain in r (m)
xmax = rmax*U/K;
ymax = 50;  % size of domain in y (m)
zmax = 20; % size of domain in z (m)
N = 1000;   % number of plotting points

% Ground-level maximum concentration:
x0 = U*H^2/(4*K);           % x coordinate 
c0 = 2*Q/(pi*U*H^2*exp(1)); % concentration value


%% Plot the ground-level concentration (z=0);
[rr,yy] = meshgrid( [1:N]*rmax/N, [-N:N]*ymax/N );
xx = rr*U/K;
cc = 2 * Q./(4*pi*U*rr) .* exp(-yy.^2./(4*rr)) .* ...
     exp(-H^2./(4*rr));
 
% Normalizing results
C_norm = cc;
c_max=max(max(max(cc)));
C_norm=abs(C_norm./c_max);

clist = [1e-5, 1e-4, 1e-3, 1e-2, .0025, .005, .01, 0.025, 0.05, 0.1];
vlist = [1e-5, 1e-4, 1e-3, 1e-2, .01, 0.1];

% Rounded conc values
%PlumeD(:,:) = round(C_norm(:,:) * 1); 
PlumeD = C_norm;
%clist2 = [1, 10, 50, 100, 250];

% Plot results
f1 = figure(1);
clf;
set(f1,'Position',[514 1081 1407 973]);

%{
zmin = floor(min(PlumeD(:))); 
zmax = ceil(max(PlumeD(:)));
zinc = (zmax - zmin) / 20;
zindex = zmin:5:zmax;
zlevs = zmin:zinc:zmax;
contourf(PlumeD,zlevs)
colormap(jet)
hold on
%contour(PlumeD,zindex,'LineWidth',2)
%}

%[cs,ch] = contourf( xx, yy, cc, clist );
[cs,ch] = contourf( xx, yy, C_norm, clist );
clabel(cs,ch,vlist)
xlabel('x'), ylabel('y')
title('plume concentration contour '+str);
hold on
grid on
plot(x0+eps, 0+eps, 'ko')
plot(0+eps,  0+eps, 'rs')
%arrow( [0.02*xmax, 0.7*ymax], [0.15*xmax,0.7*ymax], 'Width', 2 )  
%text( 0.02*xmax, 0.85*ymax, 'wind' )
hold off
set(gca,'XLim', [-0.01,1]*xmax)
%colorbar
colormap(parula)
shg
print -djpeg 'gplume2.jpg'
print -depsc 'gplume2.eps'


%% Plot results
f2 = figure(2);
clf;
set(f2,'Position',[1 1609 960 445]);
%[cs,ch] = contourf( xx, yy, cc, clist );
[cs,ch] = contourf( xx, yy, C_norm, clist );
clabel(cs)
xlabel('x'), ylabel('y')
title('plume concentration contour '+str);
hold on
grid on
plot(x0+eps, 0+eps, 'ko')
plot(0+eps,  0+eps, 'rs')
%arrow( [0.02*xmax, 0.7*ymax], [0.15*xmax,0.7*ymax], 'Width', 2 )  
%text( 0.02*xmax, 0.85*ymax, 'wind' )
hold off
%set(gca,'XLim', [-0.01,1]*xmax)
colormap(jet)

axis([0 20 -10 10])
ax = gca;
ax.XTick = [0:5:20];
ax.YTick = [-10:2:10];


%% Plot the centerline concentration (y=0):
%{
f3 = figure(3);
clf;
set(f3,'Position',[1 1081 1920 445]);
[rr,zz] = meshgrid( [1:N]*rmax/N, [1:N]*zmax/N );
xx = rr*U/K;
cc = Q./(4*pi*U*rr) .* ...
     ( exp(-(zz-H).^2./(4*rr)) + exp(-(zz+H).^2./(4*rr)) ); 
clist = [1e-5, 1e-4, 1e-3, 1e-2, 0.025, 0.05, 0.1];
[cs,ch] = contourf( xx, zz, cc, clist );
colormap jet 
clabel(cs)
xlabel('x'), ylabel('z')
title('centerline concentration');
hold on 
plot(x0+eps, 0+eps, 'ko')
plot(0+eps,  H+eps, 'rs')
%annotation('arrow', [0.05*xmax, 0.8*zmax], [0.2*xmax,0.8*zmax], 'Width', 2 )  
%text( 0.05*xmax, 0.88*zmax, 'wind' )
hold off
set(gca,'XLim', xmax*[-0.01,1])
shg
print -djpeg 'gplume1.jpg'
print -depsc 'gplume1.eps'

%}

%% Save Test Data:
metrics = [Q,U,K];

filename = path + str + 'PlumeD' + '.mat';
save(filename,'PlumeD');

%% Save Figures to main file:
h(1) = figure(1);
h(2) = figure(2);
%h(3) = figure(3);

figname = path + str + '.fig';
savefig(h,figname)

fig1 = path + str + 'plume.png';
fig2 = path + str + 'plumeZoom.png';
%fig3 = path + str + 'centerline.png';

saveas(h(1),fig1);
saveas(h(2),fig2);
%saveas(h(3),fig3);
