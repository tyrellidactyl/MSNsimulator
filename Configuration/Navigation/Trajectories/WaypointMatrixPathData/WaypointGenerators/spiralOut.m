%clear 
%clc

function wpts_spiralOut = spiralOut();
%clf

og = [0,0]; % coordinate - gazebo origin

z = [og]; % waypoint coordinate matrix - initialized at the origin


%threshold = [];

% Create coordinate arrays
xp = [];
yp = [];

%w = [];

% declare starting angle and final angle for polar function (degrees)
angle_1 = 45;
angle_2 = 108;


% select an (x,y) coordinate every 10 degrees along spiral function
for i=angle_1:3:angle_2

    % spiral function parameters
    R = 0.002*((i)^1.8); % Spiral radius as a function of the angle
    
    x1=R*cosd(10*i);
    y1=R*sind(10*i);

    b = [x1,y1]; % Current iteration coordinate

    z = [z;b]; % add coordinate to waypoint matrix

    %dist = sqrt((xp-x1)^2+(yp-y1)^2);
    
    %dist = w. - b.;
    
    %threshold = [threshold,dist];
    
    % Update coordinate arrays
    xp = [xp,x1];
    yp = [yp,y1];
    
    

end

%threshold = [threshold,dist];

wpts_spiralOut = [z;og]; % update waypoint matrix


%plot(xp,yp)
%axis([-10 10 -10 10])
%grid on
%hold on

end


