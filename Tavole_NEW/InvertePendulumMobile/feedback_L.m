clc
clear 

x = sym('x', [7 1], 'real'); % state

syms g D_a G_a b1 b2 b3 b4 b5 g5 g6 T1 T2 R b

% g = sym(9.8);
% Mb = sym(3.9);
% Mw = sym(0.375);
% R = sym(0.10);
% cz = sym(0.1);
% b = sym(0.1620);
% Ix = sym(0.02);
% Iy = sym(0.015);
% Iz = sym(0.01);
% Iw = sym(0.002);
% Iwa = sym(0.001);
% Iwd = sym(Iwa/2);
% 
% b1 = Mb*cz^2 + Ix - Iz;
% b2 = Mb*cz^2 + Iy;
% b3 = (Mb*(R^2)+2*(Iwa+Mw*(R^2)))/(R^2);
% b4 = ((R^2)*(Iz+2*Iwd+2*(b^2)*Mw)+2*Iwa*(b^2))/(R^2);
% b5 = Mb*cz;

% g5 = b3*R + b5*cos(x(4));
% g6 = b2 + R*b5*cos(x(4));

den = (2*(b2*b3-(b5*cos(x(4)))^2));
f5 = (sin(2*x(4))*(b3*b1*((x(7))^2)-(b5*(x(5))^2))+2*b5*b3*g*sin(x(4)))/den;
f6 = (sin(2*x(4))*(-b1*b5*((x(7))^2)*cos(x(4))-g*(b5)^2)+2*b2*b5*((x(5))^2)*sin(x(4)))/den;
f7 = (-b1*x(5)*x(7)*sin(2*x(4)))/(b4+b1*sin(x(4))^2);

f = vpa(simplify([x(6)*cos(x(3));
         x(6)*sin(x(3));
         x(7);
         x(5);
         f5;
         f6;
         f7]),2);
     
g1 = [0;0;0;0;g5;g6;0];
g2 = [0;0;0;0;0;0;1];

% sono x,y,tetha,alfa
h = [x(1);
     x(2);
     x(3);
     x(4)];
 
 
