function [inp,pars] = Constants
%% Earth Constants
mu = 398600.4418; %km3/s2 - Earth's Gravational Potential
g0 = 9.8065e-3; % km/s2 - Gravity at Sea Level
Re  = 6378.137; % km -  Radius of Earth

%% Starlink Constants
Tmax = 3e-3; % kN
Isp  = 1568; % s
mi = 260; % kg

%% Orbit Inital and Target COE
[Xi,~,COEi] = DeploymentOrbitStarlink(mu);
[Xf,~,COEf] = FinalStarlinkOrbit(mu);

RVi = Xi(:,1);
RVf = Xf(:,end);

%% Estimating Time of Flight
ToF_Estimate_Hours = 8.931708362514050; % Hours
ToF_E = ToF_Estimate_Hours*3600;

%% Input
inp.Earth.mu = mu; 
inp.Earth.g0 = g0;
inp.Earth.Re = Re;
inp.Starlink.Tmax = Tmax;
inp.Starlink.Isp = Isp;
inp.Starlink.mi = mi;
inp.Orbits.Inital = Xi; inp.Orbits.RVi = RVi; inp.Orbits.COEi = COEi;
inp.Orbits.Target = Xf; inp.Orbits.RVf = RVf; inp.Orbits.COEf = COEf;
inp.Orbits.ToF_E = ToF_E;

%% Normalizing Inputs
LU = Re; % km
TU = sqrt(Re^3/mu); % s
VU = LU/TU; % km/s
MU = mi; % kg
Norm_Vector = [LU;LU;LU;VU;VU;VU]; % Used to Normalise the state vector 

pars.Earth.mu = inp.Earth.mu/(LU^3/TU^2);
pars.Earth.g0 = inp.Earth.g0/(LU/TU^2);
pars.Earth.Re = inp.Earth.Re/LU;
pars.Starlink.Tmax = Tmax/(MU*LU/TU^2);
pars.Starlink.Isp = Isp/TU;
pars.Starlink.mi = mi/MU;
pars.Orbit.RVi = RVi./Norm_Vector; pars.Orbit.RVf = RVf./Norm_Vector;
pars.Orbit.ToF_E = ToF_E/TU;
pars.Unit.LU = LU; pars.Unit.TU = TU; pars.Unit.VU = VU; pars.Unit.MU = MU;
pars.Unit.NormX = Norm_Vector;

end