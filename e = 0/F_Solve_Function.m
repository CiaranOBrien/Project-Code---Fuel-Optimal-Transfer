function [Phi] = F_Solve_Function(Lambda)

%% Inputs

[~,pars] = Constants;

LambdaX = Lambda(1:7);
Lambda0 = Lambda(8);

mi = pars.Starlink.mi;
RVi = pars.Orbit.RVi;
RVf = pars.Orbit.RVf;

epsi = 0;

ToF = pars.Orbit.ToF_E;

%% ODE
X_Int = [RVi;mi;LambdaX];
t_ODE = linspace(0,1,1001);

opt = odeset('RelTol',3e-12,'AbsTol',1e-14);
[~,X] = ode113(@(t,Xaug)DynamicEquations(t,Xaug,epsi,Lambda0,ToF,pars),t_ODE,X_Int,opt);

Phi = [X(end,1:6)'-RVf; X(end,14);(norm(Lambda)-1)];
end