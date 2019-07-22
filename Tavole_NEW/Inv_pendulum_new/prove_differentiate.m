
clc
clear
close all 

syms x1(t) x2(t) x3(t) x4(t) x5(t) x6(t) x7(t)
u = sym('u', [2 1], 'real');
v = sym('v', [2 1], 'real');

digits(3);
Mb = 35;
Mw = 5;
R = 0.25;
cz = R;
b = 0.2;
Ixx = 2.10;
Iyy = 1.82;
Izz = 0.64;
Iwa = 0.15;
Iwd = 0.08;
g = 9.81;

H = 0.5*Mb*(R^2)*Izz+Iwa*Izz-Mw*R^2*Ixx-Iwa*Ixx-Mb*cz^2*Mw*R^2-Mb*cz^2*Iwa-0.5*Mb*R^2*Ixx+Mw*R^2*Izz;
Ka = (-4*Iyy*Mb*R^2*cz-3*R^2*Mb^2*cz^3+Mb*R^2*cz*(Ixx-Izz))*sin(x4)+(Mb*R^2*cz*(Ixx-Izz)+R^2*Mb^2*cz^3)*sin(3*x4);
D = (Mb*cos(x4)*cz*R)^2+((-Mb^2-2*Mw*Mb)*cz^2-2*Iyy*Mw-Iyy*Mb)*R^2-2*Mb*cz^2*Iwa-2*Iyy*Iwa;
G = (-Mb*cz^2+Izz-Ixx)*(R*cos(x4))^2+(Mb*cz^2+Ixx+2*Iwd+2*b^2*Mw)*R^2+2*b^2*Iwa;

g15 = Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x3)*cz*R;
g16 = -R*(Mb*cos(x4)*cz*R + Iyy + Mb*cz^2);

g1 = [0;0;0;0;g15;g16;0];
g2 = [0;0;0;0;0;0;1];

f1 = [x6*cos(x3);
         x6*sin(x3);
         x7;
         x5];

f2(1,1) = sin(2*x4)*((x7)^2)*H/D + (1/2)*(Mb*cz*R*x5)^2*sin(2*x4)/D+(1/2)*(-(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x4)/D;
f2(2,1) = Ka*(x7)^2 + (1/2)*g*sin(2*x4)/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(2*x4)*x5^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x4)*x5*x7/G - sin(x4)*R^2*Mb*cz*x6*x7/G;

f = vpa([f1;f2]);
y = [x1;x2];

d_x = f+[g1,g2]*u
%% 











