
function wpts_square = SquareScan(d,x,y)

%% Generate Waypoints

wpts_square = [];


og = [x,y]; % coordinate - gazebo origin

w = [og]; % waypoint coordinate matrix - initialized at the origin

a = d/4;
b = d/2;
c = 3*a;

%b = [0,d; d,d; d,0; d,-d; 0,-d; -d,-d; -d,0; -d,d; 0,d]; % waypoint coordinates
g = [0,a; 0,b; 0,c; 0,d; a,d; b,d; c,d; d,d; 
     d,a; d,b; d,c; d,0; d,-a; d,-b; d,-c; d,-d; 
     c,-d; b,-d; a,-d; 0,-d; -a,-d; -b,-d; -c,-d; -d,-d; 
     -d,-c; -d,-b; -d,-a; -d,0; -d,a; -d,b; -d,c; -d,d; 
     -c,d; -b,d; -a,d; 0,d];
 
g(:,1) = g(:,1) + x;
g(:,2) = g(:,2) + y;

wpts_square = [w;g;og]; % update waypoint matrix

end