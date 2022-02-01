
% stability class:
stability = 'C'; % A,B,C,D,E,F from most unstable to most stable
terrain = 'rural'; % rural or urban
x = linspace(10,1000);

[sigmay,sigmaz] = stabilityClass(stability,terrain,x);