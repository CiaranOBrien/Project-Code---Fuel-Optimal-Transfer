function [X] = TrajectoryCalc(a,n,e,inc,RAAN,omega,M0,mu)

%n Mean Motion of the Satellite
%e  Eccentricity
%inc Degrees - Inclination Angle
%RAAN  Degrees - Right Ascension of the Ascentding Node
%omega  Degrees - Argument of the Perigee
%M0 Degrees - Mean Anomaly at the initial epoch (t0)

tol = 10^-10; %Tolerance

t0 = 0; %Intial Time
P = 2*pi*sqrt((a^3)/mu); %Orbit Period

t = linspace(t0,P,1000); %1000 Time Steps

%Preallocating for Speed
E = zeros(length(t),1);
x = zeros(length(t),1);
theta3 = zeros(length(t),1);
Mr = zeros(6,length(t));
M = zeros(6,length(t));
X = zeros(6,length(t));

%Finding the position and velocity vector
for i = 1:length(t) %Runs for all 1000 values of t
    Mr(i) = (M0*(pi/180))+(n*(t(i)-t0)); % M for each value of time- rad/s
    M(i) = Mr(i)*(180/pi);% deg/s
    E(i) = Kepler(e,M(i),tol); % Running Kepler Funtion 1000 times for all values of M
    x(i)= sqrt(1+e)*tan(E(i)/2); % For atan2
    y = sqrt(1-e);% For atan2
    theta3(i) = 2*atan2(x(i),y); % All Values of the true anomoly
    coe = [a,e,inc,RAAN,omega,theta3(i)]; % Classic Orbit Elements for whole orbit
    X(:,i) = COE2RV(coe,mu); % Position and Velocity vector for whole orbit
end