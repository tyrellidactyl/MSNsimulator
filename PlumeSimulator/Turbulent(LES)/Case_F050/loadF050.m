% load Case 1 Data
% Eulerian Data:
Case_T        = load('MSNsimulator/TurbulentPlumeSimulator/Case_F050/NBL_3D_T_F050.mat'); 
Case_U        = load('MSNsimulator/TurbulentPlumeSimulator/Case_F050/NBL_3D_U_F050.mat'); 
Case_V        = load('MSNsimulator/TurbulentPlumeSimulator/Case_F050/NBL_3D_V_F050.mat'); 
Case_W        = load('MSNsimulator/TurbulentPlumeSimulator/Case_F050/NBL_3D_W_F050.mat'); 
Case_dataT   = Case_T.data; % <- Temperature difference
Case_dataU   = Case_U.data;
Case_dataV   = Case_V.data;
Case_dataW   = Case_W.data;

% High frequency data:
Case        = load('MSNsimulator/TurbulentPlumeSimulator/Case_F050/Center_TUVW_F050.mat'); 
Case_data   = Case.data;
Case_T_data = Case_data{1,1}; % <- Temperature difference 
Case_u_data = Case_data{2,1}; % <- Cross stream velocity in X 
Case_v_data = Case_data{3,1}; % <- Cross stream velocity in Y 
Case_w_data = Case_data{4,1}; % <- Axial velocity component 

caseF = "F050";