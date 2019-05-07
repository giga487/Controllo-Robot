clc
clear
close all

z = sym('z', [7 1], 'real'); % state

g = sym(9.8);
Mb = sym(3.9);
Mw = sym(0.375);
R = sym(0.10);
cz = sym(0.1);
b = sym(0.1620);
Ix = sym(0.02);
Iy = sym(0.015);
Iz = sym(0.01);
Iw = sym(0.002);
Iwa = sym(0.001);
Iwd = sym(Iwa/2);

b1 = Mb*cz^2 + Ix - Iz;
b2 = Mb*cz^2 + Iy;
b3 = (Mb*(R^2)+2*(Iwa+Mw*(R^2)))/(R^2);
b4 = ((R^2)*(Iz+2*Iwd+2*(b^2)*Mw)+2*Iwa*(b^2))/(R^2);
b5 = Mb*cz;

fu = (b2+R*b5*cos(z(6)))/(b1*R+b5*cos(z(6)));
fz = (sin(2*z(6))*(-b1*b5*((z(4))^2)*cos(z(6))-b5^2*g)+2*(b2*b5*z(7)^2*sin(z(6))))/(2*b2*b3-(b5*cos(z(6)))^2)+fu*(sin(2*z(6))*(b3*b1*((z(4))^2)-(b5*z(7))^2)+2*b5*b3*g*sin(z(6)))/(2*(b2*b3-(b5*cos(z(6))^2)));

f = [z(4);
     z(5)-z(3)*z(4);
     z(4)*z(2);
     0;
     fz;
     z(7);
     0];
g1 = [0;0;0;1;0;0;0];
g2 = [0;0;0;0;-fu;0;1];


