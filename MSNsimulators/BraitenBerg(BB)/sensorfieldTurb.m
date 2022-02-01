function [sensor,peak] = sensorfieldTurb(x, y)

    xc = 1; yc = 25;
    
    peak = [xc, yc];


    sensor = 200 ./ ((x-xc).^2 + (y-yc).^2 + 200);