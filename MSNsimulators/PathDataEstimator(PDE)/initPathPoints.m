
function [wpts,finalPoint] = initPathPoints(path,init,InitSize)



wpts = [];

waypoints = num2str(path);

    switch(waypoints)

            
    case '1'
            wpts = circleScan(InitSize,init(1),init(2));
            
    case '2'
            wpts = SquareScan(InitSize,init(1),init(2));
            
    case '3'
            wpts = LineScan(InitSize,init(1),init(2));
            
    case '4'
            wpts = LocalScan(InitSize,init(1),init(2));
            
    case '5'
            wpts = AreaScan(InitSize,init(1),init(2));
            
    case '6'
            wpts = SpiralScan(InitSize,init(1),init(2));
     
    case '7'
            wpts = HexScan(InitSize,init(1),init(2));
            
            %{
            
    case '8'
            wpts = circleScan(8,init(1),init(2));
            
    case '9'
            wpts = SquareScan(8,init(1),init(2));
            
    case '10'
            wpts = LocalScan(8,init(1),init(2));
            
    case '11'
            wpts = AreaScan(8,init(1),init(2));
                
    case '12'
            wpts = HexScan(8,init(1),init(2));
            
    case '13'
            wpts = circleScan(12,init(1),init(2));
            
    case '14'
            wpts = circleScan(15,init(1),init(2));
            
%}
            
        otherwise
            
            wpts = circleScan(10,init(1),init(2));
        
    end
    
    finalPoint = size(wpts,1);
    
end


    
    