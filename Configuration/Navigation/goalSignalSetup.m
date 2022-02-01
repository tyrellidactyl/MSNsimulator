
goal = Simulink.Signal;
goal.DataType = 'double';
goal.Complexity = 'real';
goal.Dimensions = '[1 2]'
goal.StorageClass = 'ExportedGlobal';

y = Simulink.Signal;
y.DataType = 'double';
y.Complexity = 'real';
y.Dimensions = '[1 2]'
y.StorageClass = 'SimulinkGlobal';

M = Simulink.Signal;
M.DataType = 'double';
M.Complexity = 'real';
M.Dimensions = '[1 2]'
M.StorageClass = 'SimulinkGlobal';

PeakP = Simulink.Signal;
PeakP.DataType = 'double';
PeakP.Complexity = 'real';

finalP = Simulink.Signal;
finalP.DataType = 'double';
finalP.Complexity = 'real';

In = Simulink.Signal;
In.DataType = 'boolean';

