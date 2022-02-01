function [T,ResX,ResY,OffsetX,OffsetY,gasMap] = plumeParameters(plumecase,PlumeD)
  
% plumeFinal default: PlumeD(:,:,end)
%m = max(setdiff(PlumeFinal(:),max(PlumeFinal(:))));     
%M = max(max(PlumeFinal(:))); % Maximum concentration 
%PlumeStart = PlumeD(:,:,25);    PlumeFinal = flipud(PlumeD(:,:,45)); 
%Vo = PlumeStart/1000;   Vf = PlumeFinal/1000;  % Normalized starting and ending plume visual

plumecase = num2str(plumecase);

switch(plumecase)

    case '1'
        PlumeStart = PlumeD(:,:,25);    PlumeFinal = flipud(PlumeD(:,:,end)); 
        Vo = PlumeStart/1000;   Vf = PlumeFinal/1000;  % Normalized starting and ending plume visual
        T = 5;          
        Area = 50;            Mid = Area/2;       
        ResX = .5;            ResY = .5;
        OffsetX = Mid/ResX;   OffsetY = Mid/ResY;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [-Mid,-Mid]; % Create map for robot visualizer
        
    case '2'
        PlumeStart = PlumeD(:,:,25);    PlumeFinal = flipud(PlumeD(:,:,end)); 
Vo = PlumeStart/1000;   Vf = PlumeFinal/1000;  % Normalized starting and ending plume visual
        T = 5;          
        Area = 50;            Mid = Area/2;       
        ResX = .5;            ResY = .5;
        OffsetX = Mid/ResX;   OffsetY = Mid/ResY;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [-Mid,-Mid]; % Create map for robot visualizer
        
    case '3'
        PlumeStart = PlumeD(:,:,25);    PlumeFinal = flipud(PlumeD(:,:,end)); 
Vo = PlumeStart/1000;   Vf = PlumeFinal/1000;  % Normalized starting and ending plume visual
        T = 5;          
        Area = 50;            Mid = Area/2;       
        ResX = .5;            ResY = .5;
        OffsetX = Mid/ResX;   OffsetY = Mid/ResY;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [-Mid,-Mid]; % Create map for robot visualizer
        
    case '4'
        PlumeStart = PlumeD(:,:,25);    PlumeFinal = flipud(PlumeD(:,:,45)); 
Vo = PlumeStart/1000;   Vf = PlumeFinal/1000;  % Normalized starting and ending plume visual
        T = 90;   
        Area = 50;      Mid = Area/2;       
        ResX = .25;      ResY = 1;       
        OffsetX = 0;    OffsetY = Mid;
        gasMap = robotics.OccupancyGrid(Vf,1);      
        gasMap.GridLocationInWorld = [0,-Mid]; % Create map for robot visualizer
        %gasMap.show;
        
    case '5'
        PlumeStart = PlumeD(:,:,25);    PlumeFinal = flipud(PlumeD(:,:,45)); 
Vo = PlumeStart/1000;   Vf = PlumeFinal/1000;  % Normalized starting and ending plume visual
        T = 90;   
        Area = 50;      Mid = Area/2;       
        ResX = .25;      ResY = 1;       
        OffsetX = 0;    OffsetY = Mid;
        gasMap = robotics.OccupancyGrid(Vf,1);      
        gasMap.GridLocationInWorld = [0,-Mid]; % Create map for robot visualizer
        
    case '6'
        PlumeStart = PlumeD(:,:,25);    PlumeFinal = flipud(PlumeD(:,:,45)); 
Vo = PlumeStart/1000;   Vf = PlumeFinal/1000;  % Normalized starting and ending plume visual
        T = 90;   
        Area = 50;      Mid = Area/2;       
        ResX = .25;      ResY = 1;       
        OffsetX = 0;    OffsetY = Mid;
        gasMap = robotics.OccupancyGrid(Vf,1);      
        gasMap.GridLocationInWorld = [0,-Mid]; % Create map for robot visualizer
        
    case '7'
        PlumeStart = PlumeD(:,:,25);    PlumeFinal = flipud(PlumeD(:,:,45)); 
Vo = PlumeStart/1000;   Vf = PlumeFinal/1000;  % Normalized starting and ending plume visual
        T = 90;   
        Area = 50;      Mid = Area/2;       
        ResX = .25;      ResY = 1;       
        OffsetX = 0;    OffsetY = Mid;
        gasMap = robotics.OccupancyGrid(Vf,1);      
        gasMap.GridLocationInWorld = [0,-Mid]; % Create map for robot visualizer
        
    case '8'
        PlumeStart = PlumeD(:,:,25);    PlumeFinal = flipud(PlumeD(:,:,45)); 
Vo = PlumeStart/1000;   Vf = PlumeFinal/1000;  % Normalized starting and ending plume visual
        T = 90;   
        Area = 50;      Mid = Area/2;       
        ResX = .25;      ResY = 1;       
        OffsetX = 0;    OffsetY = Mid;
        gasMap = robotics.OccupancyGrid(Vf,1);      
        gasMap.GridLocationInWorld = [0,-Mid]; % Create map for robot visualizer
        
    case '9'
        PlumeStart = PlumeD(:,:,25);    PlumeFinal = flipud(PlumeD(:,:,45)); 
Vo = PlumeStart/1000;   Vf = PlumeFinal/1000;  % Normalized starting and ending plume visual
        T = 90;   
        Area = 50;      Mid = Area/2;       
        ResX = .25;      ResY = 1;       
        OffsetX = 0;    OffsetY = Mid;
        gasMap = robotics.OccupancyGrid(Vf,1);      
        gasMap.GridLocationInWorld = [0,-Mid]; % Create map for robot visualizer
        
   case '10'
        PlumeFinal = flipud(PlumeD(:,:)); 
        Vf = PlumeD/(1.0e+09);  % Normalized starting and ending plume visual
        T = 5;          
        Area = 1000;            Mid = Area/2;       
        ResX = 1;            ResY = 1;
        OffsetX = Mid/ResX;   OffsetY = 250;
        gasMap = robotics.OccupancyGrid(Vf,1/ResX);      
        gasMap.GridLocationInWorld = [0,-OffsetY]; % Create map for robot visualizer
        
    otherwise
        
end

end
        