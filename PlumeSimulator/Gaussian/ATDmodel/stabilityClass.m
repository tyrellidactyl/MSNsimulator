function [sigma_y,sigma_z] = stabilityClass(stability,terrain,x_grid)

x_grid = x_grid(1,:);

% Compute the dispersion coefficients
switch(terrain)
    case 'rural'
        % Pasquill-Gifford curves
        switch(stability)            
            case 'A' % very unstable
                U = 2; % wind speed [m/s]
                % [c, d] coefficients
                coeffs_y=[24.1670, 2.5334];
                % [x a b] matrix
                coeffs_z=[0.10 122.800 0.94470;
                          0.16 158.080 1.05420;
                          0.21 170.220 1.09320;
                          0.26 179.520 1.12620;
                          0.31 217.410 1.26440;
                          0.41 258.890 1.40940;
                          0.51 346.750 1.72830;
                          3.11 453.850 2.11660;
                          inf  nan     nan];
                      
            case 'B' % unstable
                U = 2; % wind speed [m/s]
                coeffs_y=[18.3330, 1.8096];
                coeffs_z=[0.20 90.673 0.93198;
                          0.40 98.483 0.98332;
                          inf  109.300 1.09710];
                      
            case 'C' % slightly unstable
                U = 2; % wind speed [m/s]
                coeffs_y=[12.5000, 1.0857];
                coeffs_z=[inf 61.141 0.91465];
                
            case 'D' % neutral
                U = 2; % wind speed [m/s]
                coeffs_y=[8.3330, 0.72382];
                coeffs_z=[0.31 34.459 0.86974;
                          1.01 32.093 0.81066;
                          3.01 32.093 0.64403;
                          10.01 33.504 0.60486;
                          30.00 36.650 0.56589;
                          inf   44.053 0.51179];
                      
            case 'E' % slightly stable
                U = 2; % wind speed [m/s]
                coeffs_y=[6.2500, 0.54287];
                coeffs_z=[0.10 24.260 0.83660;
                          0.31 23.331 0.81956;
                          1.01 21.628 0.75660;
                          2.01 21.628 0.63077;
                          4.01 22.534 0.57154;
                          10.01 24.703 0.50527;
                          20.01 26.970 0.46713;
                          40.00 35.420 0.37615;
                          inf 47.618 0.29592];
                      
            case 'F' % stable
                U = 2; % wind speed [m/s]
                coeffs_y=[4.1667, 0.36191];
                coeffs_z=[0.21 15.209 0.81558;
                          0.71 14.457 0.78407;
                          1.01 13.953 0.68465;
                          2.01 13.953 0.63227;
                          3.01 14.823 0.54503;
                          7.01 16.187 0.46490;
                          15.01 17.836 0.41507;
                          30.01 22.651 0.32681;
                          60.00 27.074 0.27436;
                          inf   34.219 0.21716];
            otherwise
                error('gaussianPlume:stability', ['Unknown stability class ', stability]);                
        end
        % Construct sigma_y vector along the x-axis
        % Note that x should be in kilometers (x_grid/1.e3)
       
        sigma_y=465.11628.*(x_grid./1e3).*tan(0.017453293.*(coeffs_y(1)-coeffs_y(2).*log(x_grid./1e3))); % m
        % Construct sigma_z vector along the x-axis
        prev_boundary=0; % in km    
        % Pre-allocate (should be same size as x_grid since all tables end
        % with 'inf')
        sigma_z=nan(size(x_grid));
        for section=1:size(coeffs_z, 1)
            idx=find(prev_boundary<=(x_grid./1e3) & (x_grid./1e3)<coeffs_z(section, 1));
            sigma_z(idx)=coeffs_z(section, 2).*(x_grid(idx)./1e3).^coeffs_z(section, 3);
            prev_boundary=coeffs_z(section, 1);
        end
        % Move the vector into the proper dimension (cols=x)
        %sigma_y=shiftdim(sigma_y, -1);
        % Clip all values>5e3 for stability classes A-C
        switch(stability)
            case {'a', 'b', 'c'}
                sigma_y(sigma_y>5e3)=5e3;
        end        
        %sigma_z=shiftdim(sigma_z, -1);        
    case 'urban'
        % Pasquill-Gifford with urban fit (McElroy-Pooler)
        switch(stability)
            case 'A'
                coeffs_y=0.32;
                coeffs_z=[0.24 1 0.001 0.5];
            case 'B'
                coeffs_y=0.32;
                coeffs_z=[0.24 1 0.001 0.5];
            case 'C'
                coeffs_y=0.22;
                coeffs_z=[0.20 1 0 0];
            case 'D'
                coeffs_y=0.16;
                coeffs_z=[0.14 1 0.0003 -0.5];
            case 'E'
                coeffs_y=0.11;
                coeffs_z=[0.08 1 0.0015 -0.5];
            case 'F'
                coeffs_y=0.11;
                coeffs_z=[0.08 1 0.0015 -0.5];
            otherwise
                error('gaussianPlume:stability', ['Unrecognized stability class ', stability]);
        end
        % Construct sigma_y along x-axis
        sigma_y=coeffs_y(1).*x_grid.*(1+0.0004.*x_grid).^(-0.5);
        %sigma_y=shiftdim(sigma_y, -1);
        % Construct sigma_z along x-axis
        sigma_z=coeffs_z(1).*x_grid.*(coeffs_z(2)+coeffs_z(3).*x_grid).^coeffs_z(4);        
        %sigma_z=shiftdim(sigma_z, -1);
    otherwise
        error('gaussianPlume:terrain', ['Unrecognized terrain option ', terrain]);        
end

end
