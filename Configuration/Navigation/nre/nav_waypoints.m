
% Example of using Pioneer Waypoint Class for single robot waypoint
% guidance

clear

% Try to start ROS - if it is already started, restart
try
    rosinit
catch
    rosshutdown
    rosinit
end

% Setup the parameters to pass to the object
robot='p0';
odom_topic = sprintf('/%s/my_p3at/pose',robot);
geonav_topic = sprintf('/%s/geonav_odom',robot);
navstatus_topic = sprintf('/%s/nav/status',robot);
twist_topic = sprintf('/%s/my_p3at/cmd_vel',robot);

% Instatiate the object
leader = pioneerwaypointclass();

% Initialize with the parameters - this will start running immediately.
leader.init(odom_topic,geonav_topic,navstatus_topic,twist_topic,[]);
leader.name='leader';

% Give it some waypoints
leader.dist_threshold = 0.5;


og = [0,0];

z = [og];


for i=1:36
      
    
    x1=5*cosd(10*i);
    y1=5*sind(10*i);
    
    b = [x1,y1];
    
    z = [z;b];



end

z = [z;og];

leader.set_waypoints(z);


% Enable - this starts the publications
leader.enabled = 1;

   
% Register the cleanup function so that things exit gracefully
cleanupObj = onCleanup(@()rosshutdown);

while true
    leader.display_status();
    pause(1.0)
end
