
clear

clf(figure(1)) % Reset figure plots


% Try to start ROS - if it is already started, restart
try
    rosinit
catch
    rosshutdown
    rosinit
end

% Setup parameters to pass to the object
robot='p0';
odom_topic = sprintf('/%s/my_p3at/pose',robot);
geonav_topic = sprintf('/%s/geonav_odom',robot);
navstatus_topic = sprintf('/%s/nav/status',robot);
twist_topic = sprintf('/%s/my_p3at/cmd_vel',robot);

leader = pioneerwaypointclass2(); % Instatiate the object

% Initialize UGV simulation parameters
leader.init(odom_topic,geonav_topic,navstatus_topic,twist_topic,[]);
leader.name='leader';


%assign odometry data to shorter variable names
c_x = leader.x_odom;
c_y = leader.y_odom;
c_v = leader.msg_twist.Linear.X;


og = [0,0]; % coordinate - gazebo origin

z = [og]; % waypoint coordinate matrix - initialized at the origin

% Create coordinate arrays
xp = [];
yp = [];

% declare starting angle and final angle for polar function (degrees)
angle_1 = 15;
angle_2 = 108;


% select an (x,y) coordinate every 10 degrees along spiral function
for i=angle_1:angle_2

    % spiral function parameters
    r = 0.002*((i)^1.8); % Spiral radius as a function of the angle
    
    x1=r*cosd(10*i);
    y1=r*sind(10*i);

    b = [x1,y1]; % Current iteration coordinate

    z = [z;b]; % add coordinate to waypoint matrix

    % Update coordinate arrays
    xp = [xp,x1];
    yp = [yp,y1];

end

z = [z;og]; % update waypoint matrix



leader.dist_threshold = 0.5;

leader.set_waypoints(og); % assign initial waypoint at the origin

leader.enabled = 1; % Enable - this starts the publications

cleanupObj = onCleanup(@()rosshutdown); % Register the cleanup function


% Subplot 1 - Initialize plot of coordinate positions along desired path
ax1 = subplot(1,2,1);

plot(ax1,xp,yp)
axis([-10 10 -10 10])
ax1.PlotBoxAspectRatio = [1 1 1];
ax1.XTick = [-10 -5 0 5 10];
ax1.YTick = [-10 -5 0 5 10];
grid on
hold on

title(ax1,{'Position';'[meters]'})
xlabel(ax1,{'x';''})
ylabel(ax1,{'y';''})


% Subplot 2 - Initialize plot of UGV velocity
ax2 = subplot(1,2,2);
ax2.PlotBoxAspectRatio = [1 .5 1];

t = 180; % time (seconds) to record velocity

vl = zeros(t,1); % Initialize recorded velocity matrix

bar(ax2,vl,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',.8)
axis([0 t 0 0.7])
grid on
hold on

title(ax2,{'Velocity';'[meters/second]'})
xlabel(ax2,'time')
ylabel(ax2,'velocity')

k = 1; % Variable to allow the program to continue running

while (k == 1)

    if (c_v == 0) % UGV must be resting at the origin before following the set path

        tic; % Start timer

        leader.set_waypoints(z); % Set path function waypoints

        n = size(leader.waypoints,1);

        while (leader.wpt_index ~= n)

            leader.display_status();

            c_x = leader.x_odom;
            c_y = leader.y_odom;
            c_v = leader.msg_twist.Linear.X;

            if (leader.wpt_index > 1) % Begin plotting data

                toc;
                elapsedTime = toc;
                
                vl(leader.wpt_index) = [c_v]; % Update velocity matrix

                % Update plots
                plot(ax1,c_x,c_y, '-s', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'black')
                bar(ax2,vl,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',.8)
                
            end

            pause(1.0)

        end
        
        k = 0; % End while loop

    end

    % Show odometry data in command window while the UGV goes to the origin
    leader.display_status();
    pause(1.0)

end
