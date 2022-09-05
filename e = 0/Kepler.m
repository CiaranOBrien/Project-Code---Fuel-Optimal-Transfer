function [Ea] = Kepler(e,M,tol)
 format longG
 
Mr = M*(pi/180); %M in Radians
E = zeros(10,1); %Set Values for E
E(1) = Mr(1); %Inital Value of E

for i=1:10
    
    f = E(i)-e*sin(E(i))-Mr; %Function for E
    fd = 1-(e*cos(E(i))); %Differential of f
   
    E(i+1) = E(i)-(f/fd); %Newton's Method
    err = abs(E(i)-E(i+1)); %Absolute error between the two itterations
    
    if abs(err)<tol

        Ea = E(i+1); %Value of E
    break
    end
end