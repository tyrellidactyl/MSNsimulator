clear all; clc;
%open_system('rlPointFollower')
%https://www.mathworks.com/help/reinforcement-learning/ref/rlsimulinkenv.html
%{
Order of program execution:
1) Start Xming (if using Gazebo GUI)
2) In bash terminal: roslaunch nre_p3at p3at.gazebo.launch
                    (alias: msn)
3) In Matlab: run rlPointFollowerAgent.m
%}
%% Create Environment Interface
mdl = 'rlPointFollower';
open_system(mdl)
%Obtain the observation and action specification from the environment interface.
obsInfo = rlNumericSpec([5 1]); % vector of 3 observations: x, y, theta, disp
% vector of 2 actions: linear velocity, angular velocity
actInfo = rlFiniteSetSpec({
    [0.25 0.0]
    [0.25 0.5]
    [0.25 -0.5]
    [0.5 0.0]
    [0.5 1.0]
    [0.5 -1.0]});
obsInfo.Name = 'state';
actInfo.Name = 'actions';
numObservations = obsInfo.Dimension(1);
numActions = numel(actInfo);
%Create a predefined environment interface.
agentBlk = [mdl '/RL Agent'];
env = rlSimulinkEnv(mdl,agentBlk,obsInfo,actInfo)
%Validate the environment by performing a short simulation for two sample times.
%validateEnvironment(env)

%% Create DDPG Agent
% Reset the random seed to improve reproducibility
rng(0)

% Critic networks
criticNetwork = [...
    featureInputLayer(obsInfo.Dimension(1),'Normalization','none','Name','observation')
    fullyConnectedLayer(128,'Name','CriticFC1','WeightsInitializer','he')
    reluLayer('Name','CriticRelu1')
    fullyConnectedLayer(64,'Name','CriticFC2','WeightsInitializer','he')
    reluLayer('Name','CriticRelu2')
    fullyConnectedLayer(32,'Name','CriticFC3','WeightsInitializer','he')
    reluLayer('Name','CriticRelu3')
    fullyConnectedLayer(1,'Name','CriticOutput')];

% Critic representations
criticOpts = rlRepresentationOptions('LearnRate',1e-4);
critic = rlValueRepresentation(criticNetwork,obsInfo,'Observation',{'observation'},criticOpts);

% Actor networks
actorNetwork = [...
    featureInputLayer(obsInfo.Dimension(1),'Normalization','none','Name','observation')
    fullyConnectedLayer(128,'Name','ActorFC1','WeightsInitializer','he')
    reluLayer('Name','ActorRelu1')
    fullyConnectedLayer(64,'Name','ActorFC2','WeightsInitializer','he')
    reluLayer('Name','ActorRelu2')
    fullyConnectedLayer(32,'Name','ActorFC3','WeightsInitializer','he')
    reluLayer('Name','ActorRelu3')
    fullyConnectedLayer(numel(actInfo.Elements),'Name','Action')
    softmaxLayer('Name','SM')];

% Actor representations
actorOpts = rlRepresentationOptions('LearnRate',1e-4);
actor = rlStochasticActorRepresentation(actorNetwork,obsInfo,actInfo,...
    'Observation',{'observation'},actorOpts);

Ts = 0.1;
Tf = 90;
% Agent representation
agentOptions = rlPPOAgentOptions(...
    'ExperienceHorizon',256,...
    'ClipFactor',0.125,...
    'EntropyLossWeight',0.001,...
    'MiniBatchSize',64,...
    'NumEpoch',10,...
    'AdvantageEstimateMethod','gae',...
    'GAEFactor',0.95,...
    'SampleTime',Ts,...
    'DiscountFactor',0.9995);
agent = rlPPOAgent(actor,critic,agentOptions);

%% Train Agent
trainOpts = rlTrainingOptions(...
    'MaxEpisodes', 1000, ...
    'MaxStepsPerEpisode', 2500, ...
    'Verbose', false, ...
    'Plots','training-progress');
%'StopTrainingCriteria','AverageReward'
%'StopTrainingValue',-250

% visualize
%plot(env)

% train
doTraining = true;
if doTraining
    % Train the agent.
    trainingStats = train(agent,env,trainOpts);
else
    % Load the pretrained agent for the example.
    load('rlPointFollowerDDPGAgent.mat','agent');
end

%% Simulate DDPG Agent for Performance Validation
% train
doTesting = false;
if doTesting
    % Test the agent.
    simOptions = rlSimulationOptions('MaxSteps',2500);
    experience = sim(env,agent,simOptions);
    totalReward = sum(experience.Reward);
else
    % end program
end

