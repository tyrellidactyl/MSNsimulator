function [initX,initY,initAngle,Tmax] = SpawnMSN(i)
            
% Initialize Spawn point and starting goal
% Yaw angle, default: pi/2, offset from gazebo: pi
            
iter = num2str(i);

    switch(iter)
        
    case '0'
            initX = 100;
            initY = 0; 
            initAngle = 0; 
            Tmax = 200;

    case '1'
            initX = 100;
            initY = 100;
            initAngle = 0;
            Tmax = 200;
            
    case '2'
            initX = 150;
            initY = 50;
            initAngle = 0; 
            Tmax = 300;
            
    case '3'
            initX = 300;
            initY = 50;
            initAngle = 0; 
            Tmax = 500;
            
    case '4'
            initX = 500;
            initY = 50;
            initAngle = 0;
            Tmax = 500;
            
    case '5'
            initX = 150;
            initY = 0;
            initAngle = 0;
            Tmax = 400;
            
    case '6'
            initX = 100;
            initY = 0;
            initAngle = 0;
            Tmax = 300;
            
    case '7'
            initX = 50;
            initY = 0;
            initAngle = 0;
            Tmax = 150;
            
    case '8'
            initX = 150;
            initY = -5;
            initAngle = 0;
            Tmax = 400;
            
    case '9'
            initX = 150;
            initY = 5;
            initAngle = 0; 
            Tmax = 400;

    case '10'
            initX = 250;
            initY = 0;
            initAngle = 0;
            Tmax = 500;
            
    case '11'
            initX = 250;
            initY = -5;
            initAngle = 0;
            Tmax = 500;
            
    case '12'
            initX = 250;
            initY = 5;
            initAngle = 0;
            Tmax = 500;
            
    case '13'
            initX = 200;
            initY = 0;
            initAngle = 0;
            Tmax = 450;
            
    case '14'
            initX = 200;
            initY = -5;
            initAngle = 0;
            Tmax = 450;
            
    case '15'
            initX = 200;
            initY = 5;
            initAngle = 0;
            Tmax = 450;
            
    case '16'
            initX = 300;
            initY = 0;
            initAngle = 0;
            Tmax = 150;
            
        otherwise
        
    end
    
end

