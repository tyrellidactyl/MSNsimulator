
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
leader = pioneerguidanceclass2();

% Initialize with the parameters - this will start running immediately.
leader.init(odom_topic,geonav_topic,navstatus_topic,twist_topic,[]);
leader.name='leader';


og = [0,0];

z = [og];

z = [z; 5,5; -5,5; -5,-5; 5,-5; og];


% Give it some waypoints
leader.dist_threshold = 0.1;

% Waypoints: Square Path
leader.set_waypoints(z);


% Pass the guidance function to the object as a function handle
leader.guidance_function = @pioneer_los2;

% Enable - this starts the publications
leader.enabled = 1;

% Register the cleanup function so that things exit gracefully
cleanupObj = onCleanup(@()rosshutdown);


while true
    leader.display_status();
    pause(1.0)
end