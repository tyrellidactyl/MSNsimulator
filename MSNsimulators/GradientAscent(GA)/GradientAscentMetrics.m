function [mag,sensorDist,distThresh] = GradientAscentMetrics(trial)

trial = num2str(trial);

switch(trial)

    % Case 0: Default test
    case '0'
        mag = 2; 
        sensorDist = 1; 
        distThresh = 0.5;
        
    % mag:        .5, 1, 1.5, 2, 2.5, 3, 3.5
    % sensorDist: .25, .5, .75, 1, 1.25, 1.5, 1.75
    % distThresh: .125,.25, .375, .5, .625, .75, .875
        
    % Cases 1-6: mag tests
    case '1'
        mag = .5; % Magnitude of goal update direction vector (default: 2)
        sensorDist = 1; % Offset distance of gas sensor positions from vehicle center (default: 1.0)
        distThresh = 0.5; % Distance treshold between waypoints [m] (default: 0.5)
    
    case '2'
        mag = 1; 
        sensorDist = 1; 
        distThresh = 0.5; 
        
    case '3'
        mag = 1.5; 
        sensorDist = 1; 
        distThresh = 0.5;
        
    case '4'
        mag = 2.5; 
        sensorDist = 1; 
        distThresh = 0.5;
        
    case '5'
        mag = 3; 
        sensorDist = 1; 
        distThresh = 0.5;
       
    case '6'
        mag = 3.5; 
        sensorDist = 1; 
        distThresh = 0.5;
     
    % Cases 7-1: sensorDist tests
    case '7'
        mag = 2; 
        sensorDist = .25; 
        distThresh = 0.5;
        
    case '8'
        mag = 2; 
        sensorDist = .5; 
        distThresh = 0.5;
        
    case '9'
        mag = 2; 
        sensorDist = .75; 
        distThresh = 0.5;
        
    case '10'
        mag = 2; 
        sensorDist = 1.25; 
        distThresh = 0.5;

    case '11'
        mag = 2; 
        sensorDist = 1.5; 
        distThresh = 0.5;
        
    case '12'
        mag = 2; 
        sensorDist = 1.75; 
        distThresh = 0.5;
    
    % Cases 13-18: distThresh tests
    case '13'
        mag = 2; 
        sensorDist = 1; 
        distThresh = 0.125;
        
    case '14'
        mag = 2; 
        sensorDist = 1; 
        distThresh = 0.25;    
        
    case '15'
        mag = 2; 
        sensorDist = 1; 
        distThresh = 0.375;
        
    case '16'
        mag = 2; 
        sensorDist = 1; 
        distThresh = 0.625;
        
    case '17'
        mag = 2; 
        sensorDist = 1; 
        distThresh = 0.75;
        
    case '18'
        mag = 2; 
        sensorDist = 1; 
        distThresh = .875;
        
    otherwise
        
end

end