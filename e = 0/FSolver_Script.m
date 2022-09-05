%% Ciaran O'Brien - 6714221
%  Low-Thrust Trajectory Design for Satellite Mega-Constellation Deployment
%  Fuel Optimal Transfer FSolver
clear
clc
close all
format longG

X_PSO = [0.467058868754989,0.468000126553969,0.014266851266737,0.333415981144625,0.235321630497460,0.937615417136195,0.804624962319976,0.979202413641042]';
[LambdaX,Lambda0] = XValues2Costate(X_PSO);

X0 = [LambdaX;Lambda0];

options = optimoptions('fsolve','Display','none','PlotFcn',@optimplotfirstorderopt);
[Cos_Opt,FVal,exitflag,output] = fsolve(@F_Solve_Function,X0(:),options);
XOpt = Cos_Opt';