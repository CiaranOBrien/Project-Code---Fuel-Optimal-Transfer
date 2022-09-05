function [Xf,Pf,COEf] = FinalStarlinkOrbit(mu)

incf = 53.0527; % Degrees - Inclination Angle
RAANf = 269.0244; % Degrees - Right Ascension of the Ascentding Node
ef =  0.0001564; % Eccentricity
omegaf = 63.3328; % Degrees - Argument of the Perigee
M0f = 16.4202; % Degrees - Mean Anomaly at the initial epoch (t0)
nf = (15.064)*((2*pi)/86400); % Mean Motion of the Satellite converted to rad/s

af = (mu^(1/3))/((nf)^(2/3)); %km - Semi-Major Axis
Pf = 2*pi*sqrt((af^3)/mu); %Orbit Period

[Xf] = TrajectoryCalc(af,nf,ef,incf,RAANf,omegaf,M0f,mu);

COEf = [af,ef,incf,RAANf,omegaf,nf];
end