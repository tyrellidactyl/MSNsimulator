% FORWARD: Solve the forward atmospheric dispersion problem using the
%    **standard Gaussian plume solution**.  That is, given the source
%    emission rates for Zn (in kg/s), calculate and plot the
%    ground-level Zn concentration (in mg/m^3). 
clear all; clc;

gas = 'He'; % Zn, CO2, CO, Cl, He

setparams;   % read parameters from a file

% Other parameters:
Q = 10; % emission rate (g/s)
tpy2kgps = 1.0 / 31536; % conversion factor (tonne/yr to kg/s)
%source.Q = [Q] * tpy2kgps; % emission rate (kg/s)
source.Q = Q/1000; % emission rate (kg/s)

% stability class:
stability = 'A'; % A,B,C,D,E,F from most unstable to most stable
terrain = 'rural'; % rural or urban
Uwind = 3;   % wind speed (m/s) 

path = '/home/ty/MSNsimulator/GaussianPlumeSimulator/ATDmodel/Models/';
str = "Q"+num2str(Q)+"-U"+num2str(Uwind)+"-Class"+stability+"-"+terrain+"-"+gas;

% Set plotting parameters.
Res = 1;
xlim = [  0, 1000];
ylim = [-250,  250];
nx = Res*xlim(2);
ny = Res*(2*ylim(2));
x0 = xlim(1) + [0:nx]/nx * (xlim(2)-xlim(1)); % distance along wind direction (m)
y0 = ylim(1) + [0:ny]/ny * (ylim(2)-ylim(1)); % cross-wind distance (m)
[xmesh, ymesh] = meshgrid( x0, y0 );          % mesh points for contour plot

glc = 0;

glc = glc + gplume( xmesh-source.x, ymesh-source.y, 0.0, ...
                      source.z, source.Q, Uwind, stability, terrain );
                  
[sigmay,sigmaz] = stabilityClass(stability,terrain,x0);
                  
glc2 = glc*1e6;  % convert concentration to mg/m^3

c_max=max(max(max(glc2)));
maxppm = round((c_max*24.45)/(Mzn*1000)); % conversion to ppm

centerline = glc2(251,2:end);
length = find(centerline<(det)); % centerline distance from source to detectable concentration level
length = length(1);

%% Normalizing results

C_norm = glc2;
C_norm=abs(C_norm./c_max);
c_min = min(setdiff(C_norm(:),min(C_norm(:))));
PlumeD(:,:) = round(C_norm(:,:) * 1000000000); % parts per million
PlumePPM(:,:) = round((glc2*24.45)/(Mzn*1000)); % conversion to ppm
p_max=max(max(max(PlumeD)));
p_min = min(setdiff(PlumeD(:),min(PlumeD(:))));

%SigmaY = sigmay(end);

%{
centerline = PlumeD(101,2:end);
length = find(centerline<(p_max/10000000));
%length = length(1)
widthline = PlumeD(1:end,length);
%width = find(widthline>sigma_y);
%width = width(1)
%}




%% Plot contours of ground-level gas concentration.
f3 = figure(3);
set(f3,'Position',[1 1081 1920 973]);

clist = [ 0.001, 0.01, 0.02, 0.05, 0.1, 0.5 ];

[c2, h2] = contourf( xmesh, ymesh, glc2, clist );
% axis equal     % (for plots in paper)
smallfont = 14;
clabel(c2, h2, 'FontSize', smallfont-6 )
colormap(1-winter)  % These colors make the labels more readable
%colorbar
set(gca, 'XLim', xlim ), set(gca, 'YLim', ylim )
xlabel('x (m)'), ylabel('y (m)')
title("Gaussian "+['Concentration, max = ', sprintf('%5.2f', round(max(glc2(:))))]+"(mg/m^3) = " ...
    + maxppm + "ppm, " +str)
grid on

% Draw and label the source locations.
hold on
%plot( source.x, source.y, 'ro', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r' )
%text( source.x, source.y, gas, 'FontSize', smallfont, 'FontWeight','bold' );
%cline = [0,length; 0,0];
cline = [0,1000; 0,0];
line(cline(1,:),cline(2,:),'Color','black','LineWidth',2,'LineStyle','--')
%wline = [length,length; width,0]; %wx = [length length]; %wy = [width 0];
detline = [length,length; -250,250];
line(detline(1,:),detline(2,:),'Color','black','LineWidth',2)
text( length + 10, 175, num2str(length) + "m", 'FontSize', smallfont, 'FontWeight','bold' );
for i = 100:100:1000
    text( 30, 15, "SigmaY", 'FontSize', smallfont, 'FontWeight','bold' );
    text( 30, -15, "SigmaZ", 'FontSize', smallfont, 'FontWeight','bold' );
    
    wline = [i,i; sigmay(i),0];
    line(wline(1,:),wline(2,:),'Color','black','LineWidth',2,'LineStyle','--')
    text( i + 10, sigmay(i), num2str(sigmay(i)) + "m", 'FontSize', smallfont, 'FontWeight','bold' );
    
    hline = [i,i; -25,0];
    line(hline(1,:),hline(2,:),'Color','black','LineWidth',2,'LineStyle','--')
    text( i + 10, -15, num2str(sigmaz(i)) + "m", 'FontSize', smallfont, 'FontWeight','bold' );
end

hold off
shg
print -djpeg 'glc.jpg'

%% Save Test Data:
%metrics = [Q,U,K];

saveData = 1;

if saveData == 1
    filename = path + str + 'PlumeD' + '.mat';
    filename2 = path + str + 'sigmay' + '.mat';
    filename3 = path + str + 'sigmaz' + '.mat';
    filename4 = path + str + 'PlumePPM' + '.mat';
    save(filename,'PlumeD');
    save(filename2,'sigmay');
    save(filename3,'sigmaz');
    save(filename4,'PlumePPM');

% Save Figures to main file:
%h(1) = figure(1);
%h(2) = figure(2);
    h(3) = figure(3);

    figname = path + str + '.fig';
    savefig(h(3),figname)

    fig3 = path + str + 'plume.png';
%fig2 = path + str + 'plumeZoom.png';
%fig3 = path + str + 'centerline.png';

%saveas(h(1),fig1);
%saveas(h(2),fig2);
    saveas(h(3),fig3);
end
