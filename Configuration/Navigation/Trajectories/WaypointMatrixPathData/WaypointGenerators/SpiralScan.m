function waypoints = SpiralScan(InitSize,x,y)


og = [x,y]; % coordinate - gazebo origin

w = [og]; % waypoint coordinate matrix - initialized at the origin

% Create coordinate arrays
xp = [];
yp = [];

% declare starting angle and final angle for polar function (degrees)
angle_1 = 45; % default: 45
angle_2 = 108 + (3*3); % default: 108

% select an (x,y) coordinate every 10 degrees along spiral function
for i=angle_1:3:angle_2

    % spiral function parameters
    %R = 0.002*((i)^1.8); % Spiral radius as a function of the angle
    R = (0.0002 * InitSize) * ((i)^1.8);
    
    x1=R*cosd(10*i) + x;
    y1=R*sind(10*i) + y;

    b = [x1,y1]; % Current iteration coordinate

    w = [w;b]; % add coordinate to waypoint matrix

    % Update coordinate arrays
    xp = [xp,x1];
    yp = [yp,y1];

end

waypoints = [w;og]; % update waypoint matrix

end

%{
figure(1)
clf;
plot(xp,yp)
%axis([-10 10 -10 10])
grid on
hold on
scatter(xp,yp,20)
%}