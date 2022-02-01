% create signals for simulink
wpts = Simulink.Signal;
wpts.DataType = 'double';
wpts.Complexity = 'real';
wpts.Dimensions = '[15 2]'
wpts.StorageClass = 'ExportedGlobal';

y = Simulink.Signal;
y.DataType = 'double';
y.Complexity = 'real';
y.Dimensions = '[15 2]'
y.StorageClass = 'SimulinkGlobal';

M = Simulink.Signal;
M.DataType = 'double';
M.Complexity = 'real';
M.Dimensions = '[15 2]'
M.StorageClass = 'SimulinkGlobal';

PeakP = Simulink.Signal;
PeakP.DataType = 'double';
PeakP.Complexity = 'real';

finalP = Simulink.Signal;
finalP.DataType = 'double';
finalP.Complexity = 'real';

In = Simulink.Signal;
In.DataType = 'boolean';

