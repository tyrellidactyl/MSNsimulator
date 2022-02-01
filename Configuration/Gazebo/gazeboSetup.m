% set up Gazebo simulation
gazebo = ExampleHelperGazeboCommunicator; %% Gazebo object

%models = getSpawnedModels(gazebo);
%wpt = ExampleHelperGazeboModel('wpt');
%wpt_models = 'wpt';
%source = ExampleHelperGazeboModel('source');
%source_models = 'source';

resetWorld(gazebo);

resumeSim(gazebo);



