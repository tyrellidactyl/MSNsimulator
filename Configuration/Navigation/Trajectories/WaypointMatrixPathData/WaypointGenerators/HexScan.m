
function wpts_hex = HexScan(d,x,y)

%% Generate Waypoints

wpts_hex = [];


og = [x,y]; % coordinate - gazebo origin

w = [og]; % waypoint coordinate matrix - initialized at the origin

a = d/4;
b = d/2;
c = 3*a;

%b = [0,d; d,d; d,0; d,-d; 0,-d; -d,-d; -d,0; -d,d; 0,d]; % waypoint coordinates
g = [0,d; b,d;  
     d,b; d,-b; 
     b,-d; -b,-d; 
     -d,-b; -d,b; 
     -b,d; 0,d];
 
g(:,1) = g(:,1) + x;
g(:,2) = g(:,2) + y;

wpts_hex = [w;g;og]; % update waypoint matrix

end