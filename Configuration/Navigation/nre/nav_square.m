
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

leader = pioneerwaypointclass(); % Instatiate the object

% Initialize UGV simulation parameters
leader.init(odom_topic,geonav_topic,navstatus_topic,twist_topic,[]);
leader.name='leader';
leader.dist_threshold = 0.5;


%assign odometry data to shorter variable names
c_x = leader.x_odom;
c_y = leader.y_odom;
c_v = leader.msg_twist.Linear.X;
c_w = leader.msg_twist.Angular.Z;


%c_v = Simulink.Signal;
%c_w = Simulink.Signal;


og = [0,0]; % coordinate - gazebo origin

z = [og]; % waypoint coordinate matrix - initialized at the origin

% Create coordinate arrays
xp = [0 0 5 5 -5 -5 0];
yp = [0 5 5 -5 -5 5 5];

b = [0,5; 5,5; 5,-5; -5,-5; -5,5; 0,5]; % waypoint coordinates

z = [z;b;og]; % update waypoint matrix



leader.set_waypoints(og); % assign initial waypoint at the origin

leader.enabled = 1; % Enable - start publications

cleanupObj = onCleanup(@()rosshutdown); % Register the cleanup function


% Subplot 1 - Initialize plot of coordinate positions along desired path
ax1 = subplot(1,2,1);
sz = 80;

scatter(ax1,xp,yp,sz,'filled','d')
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
ax2.PlotBoxAspectRatio = [1 1 1];

t = 90; % time (seconds) to record velocity

vl = zeros(t,1); % Initialize recorded velocity matrix

bar(ax2,vl,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',.8)
axis([0 t 0 1])
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
        
        tl = 1;

        while (leader.wpt_index ~= n)

            leader.display_status();

            c_x = leader.x_odom;
            c_y = leader.y_odom;
            c_v = leader.msg_twist.Linear.X;

            if (leader.wpt_index > 1) % Begin plotting data

                toc;
                elapsedTime = toc;
                
                vl(tl) = [c_v]; % Update velocity matrix

                % Update plots
                plot(ax1,c_x,c_y, '-s', 'MarkerSize', 10, 'MarkerFaceColor',[0 .5 .5], 'MarkerEdgeColor', 'black')
                bar(ax2,vl,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',.8)
                
            end

            tl = tl + 1;
            pause(1.0)

        end
        
        k = 0; % End while loop

    end

    % Show odometry data in command window while the UGV goes to the origin
    leader.display_status();
    pause(1.0)

end
