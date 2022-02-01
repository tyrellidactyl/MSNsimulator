function [T,ResX,ResY,OffsetX,OffsetY,gasMap] = GplumeParameters(plumecase,PlumeD)
  
% Each case defines a Gaussian Plume for each stability class (A-F)

plumecase = num2str(plumecase);
MaxC = max(max(max(PlumeD)));

switch(plumecase)

    case '1'
        PlumeFinal = flipud(PlumeD(:,:)); 
        Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
        T = 5;          
        Area = 1000;            Mid = Area/2;       
        ResX = 1;            ResY = 1;
        OffsetX = Mid/ResX;   OffsetY = 250;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
        
    case '2'
        PlumeFinal = flipud(PlumeD(:,:)); 
        Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
        T = 5;          
        Area = 1000;            Mid = Area/2;       
        ResX = 1;            ResY = 1;
        OffsetX = Mid/ResX;   OffsetY = 250;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
        
    case '3'
        PlumeFinal = flipud(PlumeD(:,:)); 
        Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
        T = 5;          
        Area = 1000;            Mid = Area/2;       
        ResX = 1;            ResY = 1;
        OffsetX = Mid/ResX;   OffsetY = 250;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
        
    case '4'
        PlumeFinal = flipud(PlumeD(:,:)); 
        Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
        T = 5;          
        Area = 1000;            Mid = Area/2;       
        ResX = 1;            ResY = 1;
        OffsetX = Mid/ResX;   OffsetY = 250;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
        
    case '5'
        PlumeFinal = flipud(PlumeD(:,:)); 
        Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
        T = 5;          
        Area = 1000;            Mid = Area/2;       
        ResX = 1;            ResY = 1;
        OffsetX = Mid/ResX;   OffsetY = 250;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
        
    case '6'
        PlumeFinal = flipud(PlumeD(:,:)); 
        Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
        T = 5;          
        Area = 1000;            Mid = Area/2;       
        ResX = 1;            ResY = 1;
        OffsetX = Mid/ResX;   OffsetY = 250;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
        
    case '7' 
        PlumeFinal = flipud(PlumeD(:,:)); 
        Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
        T = 5;          
        Area = 700;            Mid = Area/2;       
        ResX = 1;            ResY = 1;
        OffsetX = Mid/ResX;   OffsetY = 25;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
        
    case '8' 
        PlumeFinal = flipud(PlumeD(:,:)); 
        Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
        T = 5;          
        Area = 700;            Mid = Area/2;       
        ResX = 1;            ResY = 1;
        OffsetX = Mid/ResX;   OffsetY = 25;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
        
    case '9' 
        PlumeFinal = flipud(PlumeD(:,:)); 
        Vf = PlumeFinal/(MaxC);  % Normalized starting and ending plume visual
        T = 5;          
        Area = 700;            Mid = Area/2;       
        ResX = 1;            ResY = 1;
        OffsetX = Mid/ResX;   OffsetY = 25;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
        
    otherwise
        
end

end
        