function [initX,initY,initAngle,init] = initSpawn(i,l,L)

delX = 5;
iter = num2str(i);

    switch(iter)

    case '1'
            % Initialize Spawn point and starting goal
            initX = L + delX;
            initY = 0;
            initAngle = 0; % Yaw angle, default: pi/2, offset from gazebo: pi
            init = [initX - delX, initY]; % initial goal point
            
    case '2'
            initX = L + delX;
            initY = l*(1/2);
            initAngle = 0; % Yaw angle, default: pi/2, offset from gazebo: pi
            init = [initX - delX, initY]; % initial goal point
            
    case '3'
            initX = L + delX;
            initY = l;
            initAngle = 0; % Yaw angle, default: pi/2, offset from gazebo: pi
            init = [L, initY]; % initial goal point
            
    case '4'
            initX = (L + delX) - l*(1/2);
            initY = l*(3/2);
            initAngle = pi/4; % Yaw angle, default: pi/2, offset from gazebo: pi
            
    case '5'
            initX = (L + delX) - l;
            initY = l*(2);
            initAngle = pi/2; % Yaw angle, default: pi/2, offset from gazebo: pi
            
    case '6'
            initX = L + delX;
            initY = 0;
            initAngle = 0; % Yaw angle, default: pi/2, offset from gazebo: pi
            
        otherwise
        
    end
    
end

