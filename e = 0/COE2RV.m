function [X] = COE2RV(coe,mu)

d2r = pi/180;

a = coe(1); % Semi-Major Axis
e = coe(2); % Eccentricity
inc = coe(3)*d2r; % Inclination
RAAN = coe(4)*d2r; % Right Ascension Ascenting node
omega = coe(5)*d2r; % Argument of Perigee
theta = coe(6); % True Anomoly 

r = ((a*(1-(e^2)))/(1+(e*cos(theta)))); % Distance from Earth to Satellite
h = sqrt(mu*a*(1-(e^2))); % Angular Momentum of Satellite

e1 = (cos(RAAN)*cos(omega))-(sin(RAAN)*cos(inc)*sin(omega)); 
e2 = (-cos(RAAN)*sin(omega))-(sin(RAAN)*cos(inc)*cos(omega));
e3 = sin(RAAN)*sin(inc);
e4 = (sin(RAAN)*cos(omega))+(cos(RAAN)*cos(inc)*sin(omega));
e5 = (-sin(RAAN)*sin(omega))+(cos(RAAN)*cos(inc)*cos(omega));
e6 = -cos(RAAN)*sin(inc);
e7 = sin(inc)*sin(omega);
e8 = sin(inc)*cos(omega);
e9 = cos(inc);

rm = [e1,e2,e3;e4,e5,e6;e7,e8,e9]; % Rotational Matrix from perifocal frame to the ECI frame

rv = rm*[(r*cos(theta));(r*sin(theta));0]; % Position Vector
vv = rm*[(-((mu/h)*sin(theta)));((mu/h)*(cos(theta)+e));0]; % Velocity Vector

X = [rv;vv]; % Orbit Vector
end

