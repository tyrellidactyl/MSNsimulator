function [metrics] = algorithmSelector(alg)


%alg = num2str(path);

    switch(alg)

            
    case 'APS'
    %% Adaptive Peak Seeking (APS):
    Expand = 2;    LimitSize = 3;   Shrink = 1/Expand;
    %[waypoints,finalPoint] = initWaypoints(trial,init); % Path Selector
    %[Expand,LimitSize] = APSmetrics(trial);
    [waypoints,finalPoint] = initPathPoints(trial,init); % Path Selector
    metrics = [Expand,LimitSize];
            
    case 'GA'
    %% Gradient Ascent (GA):
    %[mag,sensorDist,distThresh] = GradientAscentMetrics(trial);
    [mag,sensorDist,distThresh] = GradientAscentMetrics(0);
    metrics = [mag,sensorDist,distThresh,N];
            
    case 'GAv2'
    %% Gradient Ascent Variable Sensor Array (GAv2):
    %[mag,sensorDist,distThresh] = GradientAscentMetrics(trial);
    [mag,sensorDist,distThresh] = GradientAscentMetrics(0);
    metrics = [mag,sensorDist,distThresh,N];
            
    case 'PDE'
    %% Path Data Estimator (PDE): 
    %[waypoints,finalPoint] = initPathPoints(trial,init); % Path Selector
    %data = zeros(finalPoint,3);
        
    
    case 'Hybrid'
 
            
        otherwise
            
      
    end
    
    
end