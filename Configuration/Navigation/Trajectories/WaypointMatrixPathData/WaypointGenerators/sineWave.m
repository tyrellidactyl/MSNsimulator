
function wpts_sineWave = sineWave();

og = [0,0]; % coordinate - gazebo origin
z = [og]; % waypoint coordinate matrix - initialized at the origin
b = [];


R = 0.34;
D = 0.68;
N = 10;
amp = 1.2;
spacing = 3*D;

x = [];
xp = [];

y = [];
yp = [];

start = 1;
finish = N;

source = N+R;

n = 1;
alt = [];

for i=start:spacing:finish
    
    x = [i];
   
    yp = [amp*x];
    
    alt = ((-1)^n)*yp;
     y = [alt;y];
     
    xp = [xp;x];

    n = n+1;
    
    b = [x,alt]; % Current iteration coordinate

    z = [b;z]; % add coordinate to waypoint matrix
    
end

x = 0;
xp = [x;xp];
y = [0;y];

xp = [xp;source];
y = [y;0];

wpts_sineWave = [og;z]; % update waypoint matrix
%wpts_sineWave = [0,0;0.68,7.14;2.04,-5.1;3.4,3.06;4.76,-1.02;0,source;og] % update waypoint matrix

%{

clf

plot(xp,y)
axis([-1 8 -10 10])
grid on
hold on

plot(xp,y, '-s', 'MarkerSize', 10, 'MarkerFaceColor',[0 .5 .5], 'MarkerEdgeColor', 'black')
%}

end


