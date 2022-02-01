
function waypoints = LocalScan(s,x,y)

%% Generate Waypoints

%{
s = 5;
x = 0;
y = 0;
%}

m = s;
n = .5*s;
o = .375*s;
p = .625*s;

waypoints = [];

og = [x,y]; % coordinate - gazebo origin

b = [x,y+p;   x-n,y+m; x-m,y+n; ...
     x-m,y-n; x-n,y-m; x+n,y-m; ...
     x+m,y-n; x+m,y+o; x+n,y+m; ...
     x+o,y+o; x+o,y-o; x,y-p; ...
     x-o,y-o; x-o,y+o];

waypoints = [og;b]; % update waypoint matrix

end