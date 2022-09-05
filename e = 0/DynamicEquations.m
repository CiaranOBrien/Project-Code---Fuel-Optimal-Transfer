function dXdt = DynamicEquations(t,X,epsi,Lambda0,ToF,pars)

%% Inputs
mu = pars.Earth.mu;
g0 = pars.Earth.g0;
Tmax = pars.Starlink.Tmax;
Isp = pars.Starlink.Isp;

R = X(1:3);
V = X(4:6);
m = X(7);

LambdaR = X( 8:10);
LambdaV = X(11:13);
LambdaM = X(14);

r = norm(R);

%% Unit Vector of Thrust
alpha = -(LambdaV/(norm(LambdaV)));

%% Swithcing Function & Engine Thrust Ratio
SF = 1-(Isp*g0*norm(LambdaV))/(Lambda0*m)-LambdaM/Lambda0;
if (SF > epsi) 
    u = 0;
elseif (SF < -epsi)
    u = 1;
else
    u = 1/2-SF/(2*epsi);
end


%% Equations of Motion
R_Dot = V;
V_Dot = -mu/(r^3)*R+(Tmax*u/m)*alpha;
M_Dot = -Tmax*u/(Isp*g0);


%% Adjoint Equations
LR_Dot = mu/(r^3)*LambdaV-3*mu/(r^5)*dot(R,LambdaV)*R;
LV_Dot = -LambdaR;
LM_Dot = -Tmax*u*norm(LambdaV)/(m^2);

StateDot = [R_Dot;V_Dot;M_Dot];
AdjDot = [LR_Dot;LV_Dot;LM_Dot];

%% Output
dXdt = ToF*[StateDot;AdjDot];

end