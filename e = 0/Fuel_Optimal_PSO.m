function J = Fuel_Optimal_PSO(X_PSO,pars)

%% Inputs
g0 = pars.Earth.g0;

mi = pars.Starlink.mi;
Tmax = pars.Starlink.Tmax;
Isp = pars.Starlink.Isp;

RVi = pars.Orbit.RVi;
RVf = pars.Orbit.RVf;
ToF_E = pars.Orbit.ToF_E;
    

epsi = 0;
pars.pf = 1e4;


%% Calculate Initial Costates 
[LambdaX,Lambda0] = XValues2Costate(X_PSO);

%% Calculate ToF
ToF = ToF_E*X_PSO(1);

%% ODE
X_Int = [RVi;mi;LambdaX];
t_ODE = linspace(0,1,1001);

opt = odeset('RelTol',3e-12,'AbsTol',1e-14);
[t_PSO,X] = ode113(@(t,Xaug)DynamicEquations(t,Xaug,epsi,Lambda0,ToF,pars),t_ODE,X_Int,opt);


%% Calculate Cost
if ( abs(t_PSO(end)-1)>1e-12 )
    J = Inf;

else
    %% Shooting Function
    Phi = [X(end,1:6)'-RVf; X(end,14)];

    %% Hamiltonian
    [~,u,~,~] = EnergyHamiltonian(X,Lambda0,epsi,pars);

    u_J = zeros(1,length(u));
    for i = 1:length(u)
    u_J(i) = u(i) -(epsi*u(i)*(1-u(i)));
    end

    %% Cost Function
    J = ToF*Lambda0*Tmax/(g0*Isp)*trapz(t_PSO',u_J.^2)+pars.pf*dot(Phi,Phi);

end

end

