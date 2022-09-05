function [Xi,Pi,COEi] = DeploymentOrbitStarlink(mu)

inci = 52.4033; % Degrees - Inclination Angle
RAANi = 269.0244; % Degrees - Right Ascension of the Ascentding Node
ei = 0.0228149; % Eccentricity
omegai = 255.2325; % Degrees - Argument of the Perigee
M0i = 266.6565; % Degrees - Mean Anomaly at the initial epoch (t0)
ni = (16.05238701)*((2*pi)/86400); % Mean Motion of the Satellite

ai = (mu^(1/3))/((ni)^(2/3)); %km - Semi-Major Axis
Pi = 2*pi*sqrt((ai^3)/mu); %Orbit Period

[Xi] = TrajectoryCalc(ai,ni,ei,inci,RAANi,omegai,M0i,mu);

COEi = [ai,ei,inci,RAANi,omegai,ni];

end