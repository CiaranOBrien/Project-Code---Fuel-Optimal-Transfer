function [SF,u,alpha,H,SFc] = EnergyHamiltonian(X,Lambda0,Epsilon,pars)

%% Inputs
g0 = pars.Earth.g0;
mu = pars.Earth.mu;

Tmax = pars.Starlink.Tmax;
Isp = pars.Starlink.Isp;

%% Swithcing Function & Engine Thrust Ratio
u = zeros(length(X),1); SF = zeros(length(X),1); alpha = zeros(length(X),3);
H1 = zeros(length(X),1); H2 = zeros(length(X),1); H21 = zeros(length(X),3);H22 = zeros(length(X),3); H3 = zeros(length(X),1); H4 = zeros(length(X),1); H = zeros(length(X),1);
R = zeros(length(X),3); V = zeros(length(X),3); m = zeros(length(X),1);
r = zeros(length(X),1);
LambdaR = zeros(length(X),3); LambdaV = zeros(length(X),3); LambdaM = zeros(length(X),1);

for i = 1:length(X)

    R(i,:) = [X(i,1);X(i,2);X(i,3)];
    V(i,:) = [X(i,4);X(i,5);X(i,6)];
    m(i) = X(i,7);

    r(i) = norm(R(i,:));
     
    LambdaR(i,:) = [X(i,8);X(i,9);X(i,10)];
    LambdaV(i,:) = [X(i,11);X(i,12);X(i,13)];
    LambdaM(i) = X(i,14);
     
    alpha(i,:) = -(LambdaV(i,:)/(norm(LambdaV(i,:))));

    SF(i) = 1-((Isp*g0*norm(LambdaV(i,:))/(Lambda0*m(i))))-(LambdaM(i)/Lambda0);
    
    if (SF(i) > -Epsilon) && (SF(i) < Epsilon)
        u(i) = 0.5-(SF(i)/(2*Epsilon));
    elseif (SF(i) < -Epsilon)
        u(i) = 1;
    end

 H1(i) = dot(LambdaR(i,:),V(i,:));
 H21(i,:) = LambdaV(i,:);
 H22(i,:) = ((-(mu/(r(i)^3))*R(i,:)))+(((Tmax*u(i)))/m(i))*alpha(i,:);
 H2(i) = dot(H21(i,:),H22(i,:));
 H3(i) = -(LambdaM(i)*((Tmax*u(i))/(Isp*g0)));
 H4(i) = Lambda0*(Tmax/(Isp*g0))*(u(i)-(Epsilon*u(i)*(1-u(i))));

 H(i) = H1(i)+H2(i)-H3(i)+H4(i);
end

end

