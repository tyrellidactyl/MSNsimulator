
function waypoints = AreaScan(d,x,y)

%% Generate Waypoints

waypoints = [];

h = d/2;

og = [x,y]; % coordinate - gazebo origin

w = [og]; % waypoint coordinate matrix - initialized at the origin

%b = [h,0; d,d; 0,h; -d,d; -h,0; -d,-d; 0,-h; d,-d; h,0]; % waypoint coordinates
b = [0,h; -d,d; -h,0; -d,-d; 0,-h; d,-d; h,0; d,d; 0,h];

b(:,1) = b(:,1) + x;
b(:,2) = b(:,2) + y;


waypoints = [w;b;og]; % update waypoint matrix

end