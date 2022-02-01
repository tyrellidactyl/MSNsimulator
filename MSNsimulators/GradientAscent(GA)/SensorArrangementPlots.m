
f5 = figure(5);
set(f5,'Position',[842 131 1079 843]);
clf;
hold on
grid on
xlabel('X')
ylabel('Y')
title('Sensor Arrangements')
axis equal

for n = 3:12
    
M = n; % total number of sensors

m = [];
for i = 0:(M-1)
    m = [m; i*(2*pi/M)];
end

rad = n/12;
th = 0:pi/500:2*pi;
xunit = rad * cos(th);
yunit = rad * sin(th);
h = plot(xunit, yunit, '.');

sz = 100;
for i = 1:size(m)
    scatter(rad*cos(m(i)),rad*sin(m(i)),sz,'rd','filled');
end

end


