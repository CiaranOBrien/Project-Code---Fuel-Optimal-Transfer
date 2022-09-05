function [COE] = RV2COE(X,pars)

%% Inputs
R = [X(1),X(2),X(3)];
V = [X(4),X(5),X(6)];


%% Constants
I = [1 0 0];
J = [0 1 0];
K = [0 0 1];

r2d = 180/pi;

mu = pars.Earth.mu;

%% Calculations

r = norm(R);
v = norm(V);

H = cross(R,V);
h = norm(H);
n = (cross(K,H))/norm((cross(K,H)));

E = ((cross(V,H))/mu)-(R/r); % Eccentricity Vector
e = norm(E);

ir = acos(H(3)/h);
i = ir*r2d;

if n(2) > 0
    RAANr = acos(dot(n,I));
    RAAN = RAANr*r2d;
elseif n(2) <= 0
    RAANr = (2*pi)-acos(dot(n,I));
    RAAN = RAANr*r2d;
end

a = mu/(2*((mu/r)-((v^2)/2)));

if E(3) > 0
    wr = acos(dot(n,E)/((norm(E)*norm(n))));
    w = wr*r2d;
elseif E(3) <= 0
    wr = (2*pi)-acos(dot(n,E)/((norm(E)*norm(n))));
    w = wr*r2d;
end

n_t = sqrt(mu/(a^3));

ra = r/a;

Ea = acos((1-ra)/e); % Eccentric Anomaly
%M = norm(Ea-(e*sin(Ea))); % Mean Anomaly
M = atan2(X(2),X(1));

COE = [a,e,i,RAAN,w,M];
end