% spawn Pioneer model in Gazebo

%% load
gazebo = ExampleHelperGazeboCommunicator; %% Gazebo object
models = getSpawnedModels(gazebo)

%% access model
%resetSim(gazebo);
%resumeSim(gazebo);
%kobuki = ExampleHelperGazeboSpawnedModel('pioneer3at',gazebo)
%[kobukiLinks, kobukiJoints] = getComponents(kobuki);


%% Spawn Model
botmodel = ExampleHelperGazeboModel('pioneer3at','gazeboDB');
bot = spawnModel(gazebo,botmodel,[initX,initY,0]);
pauseSim(gazebo);
setState(bot,'orientation',[0 0 pi]);
%resumeSim(gazebo);
 