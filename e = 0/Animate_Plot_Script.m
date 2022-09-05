%% Ciaran O'Brien - 6714221
%  Low-Thrust Trajectory Design for Satellite Mega-Constellation Deployment
%  Fuel Optimal Transfer Animated Plot
clear;
clc;
clf;
close all;
format longG;

%% Inputs
[inp,pars] = Constants;
LU = pars.Unit.LU;

r2d = 180/pi;

%% X Values from PSO
Lambda = [0.022014257918561,-0.335439605397943,-0.112049974579854,-0.030092526068178,-0.173238983161717,0.432929967806845,0.011228738205019,0.809918946423966]';

%% Trajectory Plotter
[X,Trajectory] = F_Solve_Plot(Lambda,pars);

%% Animation Orbit

figure('Name','Animated Transfer','NumberTitle','off')
for k =  1:length(X)
    plot3(X(k,1)*LU,X(k,2)*LU,X(k,3)*LU,'b+')
    hold on
    plot3(X(1:k,1)*LU,X(1:k,2)*LU,X(1:k,3)*LU,'k')
    grid on
    box on
    xlabel('X (km)'); ylabel('Y (km)'); zlabel('Z (km)'); 
    title('Fuel Optimal Transfer')
    legend('Starlink-2398','Trajectory Path')
    pause(1e-200)
    if k ~= length(X)
        clf
    end
end