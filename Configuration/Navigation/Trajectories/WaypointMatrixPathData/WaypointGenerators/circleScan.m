

function wpts_circle = circleScan(R,x,y)

%% Spawn New Waypoint Models

wpts_circle = [];

og = [x,y]; % coordinate - gazebo origin

w = [og]; % waypoint coordinate matrix - initialized at the origin

% declare starting angle and final angle for polar function (degrees)
angle_1 = 180;
angle_2 = angle_1 + 360;
ang = 15; % default: 30 

% select an (x,y) coordinate every 10 degrees along circle function
for i=angle_1:ang:angle_2
    
    x1=R*cosd(i);
    y1=R*sind(i);

    %b = [x1,y1];
    b = [x1+x,y1+y]; % Current iteration coordinate

    w = [w;b]; % add coordinate to waypoint matrix

end

wpts_circle = [w; og]; % update waypoint matrix

end

