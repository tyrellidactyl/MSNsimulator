%% Generate Waypoints

og = [0,0]; % coordinate - gazebo origin

z = 1; 

w = [og];
c = [];

R = 0.34;
D = 0.68;
N = 5;
amp = 1.5;

x = [];
xp = [];

y = [];
yp = [];
y2 = [];

start = D;
finish = N;

source = N+R;

n = 1;
alt = [];

for i=start:D:finish
    
    x = [i];
   
    yp = [amp*x];
    
    alt = ((-1)^n);
    m = alt*yp;
    
     y = [m;y];
     

     
    
     
    xp = [xp;x];

    b = [n,m]; % Current iteration coordinate

    w = [w;b]; % add coordinate to waypoint matrix
    
    %g = [x;m];
    
    c = [c;b];
   
    n = n+1;
    
end

x = 0;
xp = [x;xp];
y = [0;y];

xp = [xp;source];
y = [y;0];

g = [];

num = size(w,1);

num2 = size(xp,1);

num3 = size(y2,1);




wpts_sineWave = [w;og] % update waypoint matrix

for i=1:num2
    c = [(i-1),y(i)];
    g = [g;c];
end

disp(g)


clf
plot(xp,y)
axis([-1 8 -10 10])
grid on
hold on

plot(xp,y, '-s', 'MarkerSize', 10, 'MarkerFaceColor',[0 .5 .5], 'MarkerEdgeColor', 'black')
