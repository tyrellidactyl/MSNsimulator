
function [wpts,finalPoint] = initWaypoints(path,init)
% initialize waypoints for selected APS algorithm path shape (path) centered at starting location (init)
%wptReset;
% 1: circle (Radius,x,y)  2: square (Size,x,y)  3: spiral inward  4: spiral outward          
% 5: straight lines  6: sine wave (Amplitude,x,y)
% 7: Area Scan (Size,x,y)   8: Local Scan (Size,x,y)

wpts = [];

waypoints = num2str(path);

    switch(waypoints)
            
    case '1'
            wpts = circleScan(10,init(1),init(2));
            
    case '2'
            wpts = SquareScan(10,init(1),init(2));
            
    case '3'
            wpts = LineScan(10,init(1),init(2));
            
    case '4'
            wpts = LocalScan(10,init(1),init(2));
            
    case '5'
            wpts = AreaScan(10,init(1),init(2));
            
    case '6'
            wpts = SpiralScan(init(1),init(2));
     
    case '7'
            wpts = HexScan(10,init(1),init(2));
            
        otherwise
        
    end
    
    finalPoint = size(wpts,1);
    
end


    
    