function [Expand,LimitSize,InitSize] = APSmetrics(trial)

trial = num2str(trial);

switch(trial)

    % Case 0: Default test
    case '0'
        Expand = 2;
        LimitSize = 3;
        InitSize = 10;
        
    % Path Expansion
    case '1'
        Expand = 1.5;
        LimitSize = 3;
        InitSize = 10;
        
    case '2'
        Expand = 1.75;
        LimitSize = 3;
        InitSize = 10;
        
    case '3'
        Expand = 2.25;
        LimitSize = 3;
        InitSize = 10;
        
    case '4'
        Expand = 2.5;
        LimitSize = 3;
        InitSize = 10;
       
    % Initial Size 
    case '5'
        Expand = 2;
        LimitSize = 3;
        InitSize = 7.5;
        
    case '6'
        Expand = 2;
        LimitSize = 3;
        InitSize = 12.5;
        
    case '7'
        Expand = 2;
        LimitSize = 3;
        InitSize = 15;
        
    otherwise
        
end
        
        