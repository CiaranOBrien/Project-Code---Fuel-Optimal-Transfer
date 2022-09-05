function [LambdaX,Lambda0] = XValues2Costate(X)

%% Calculate Beta Values
B1 = (pi/2)*X(2);
B2 = (pi/2)*X(3);
B3 = (pi/2)*X(4);
B4 = pi*(X(5)-0.5);
B5 = pi*(X(6)-0.5);
B6 = 2*pi*X(7);
B7 = 2*pi*X(8);


%% Calculate Costates
Lambda0 = sin(B1);
LR = cos(B1)*cos(B2)*cos(B3)*[(cos(B4)*cos(B6));(cos(B4)*sin(B6));sin(B4)];
LV = cos(B1)*cos(B2)*sin(B3)*[(cos(B5)*cos(B7));(cos(B5)*sin(B7));sin(B5)];
LM = cos(B1)*sin(B2);

LambdaX = [LR;LV;LM];

end

