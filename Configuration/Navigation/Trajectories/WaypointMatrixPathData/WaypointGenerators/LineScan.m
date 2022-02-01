
function waypoints = LineScan(d,x,y);

e = .75*d;
f = .5*d;
g = .25*d;

waypoints = [];

og = [x,y]; % coordinate - gazebo origin

w = [og]; % waypoint coordinate matrix - initialized at the origin

b = [0,g; 0,f; 0,e; 0,d; ...
     0,-g; 0,-f; 0,-e; 0,-d; ...
     0,0; g,0; f,0; e,0; d,0; ...
     -g,0; -f,0; -e,0; -d,0]; % waypoint coordinates
 
b(:,1) = b(:,1) + x;
b(:,2) = b(:,2) + y;

waypoints = [w;b;og]; % update waypoint matrix

end
