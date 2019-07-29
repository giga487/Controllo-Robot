%Tavola 3 Amato, no articolo

clc
clear
close all

% Inverted Pendulum 

syms Mb R Mw Iwa cz Iyy g Ka Ixx Izz Iwd b
syms G H D Ka
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

v = sym('v', [2 1], 'real');
x = sym('x', [7 1], 'real');
f2 = sym('f2', [3,1], 'real');
syms g15 g16 g17 g25 g26 g27 real
%x = x y  theta alpha d_alpha v d_theta  
% TUTTO IN z

H = 0.5*Mb*(R^2)*Izz+Iwa*Izz-Mw*R^2*Ixx-Iwa*Ixx-Mb*cz^2*Mw*R^2-Mb*cz^2*Iwa-0.5*Mb*R^2*Ixx+Mw*R^2*Izz;
Ka = (-4*Iyy*Mb*R^2*cz-3*R^2*Mb^2*cz^3+Mb*R^2*cz*(Ixx-Izz))*sin(x(4))+(Mb*R^2*cz*(Ixx-Izz)+R^2*Mb^2*cz^3)*sin(3*x(4));
D = (Mb*cos(x(4))*cz*R)^2+((-Mb^2-2*Mw*Mb)*cz^2-2*Iyy*Mw-Iyy*Mb)*R^2-2*Mb*cz^2*Iwa-2*Iyy*Iwa;
G = (-Mb*cz^2+Izz-Ixx)*(R*cos(x(4)))^2+(Mb*cz^2+Ixx+2*Iwd+2*b^2*Mw)*R^2+2*b^2*Iwa;

g15 = (Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(4))*cz*R)/D;
g16 = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2)/D;
g17 = R*b/G;

g25 = (Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(4))*cz*R)/D;
g26 = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2)/D;
g27 = -R*b/G;


g1 = vpa([0;0;0;0;g15;g16;g17]);
g2 = vpa([0;0;0;0;g25;g26;g27]);

f1 = [x(6)*cos(x(3));
         x(6)*sin(x(3));
         x(7);
         x(5)];
% 
f2(1,1) = sin(2*x(4))*((x(7))^2)*H/D + (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-2*(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2,1) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(x(4))*x(5)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

f = vpa([f1;f2]);
y = [x(1);x(2)];
h1 = y(1,1);
h2 = y(2,1);

%% 
% Esiste una configurazione delle uscite che mi permette di avere 
% la linearizzazione esatta?


GammaG1 = liebracket(f,g1,x,3);
GammaG2 = liebracket(f,g2,x,3);
Gamma = [GammaG1,GammaG2];
RankSpan = rank(Gamma);
%Se RankSpan = 7 allora è accessibile

%% 
syms vecFunc(x1,x2,x3,x4,x5,x6,x7) fFunc(x1,x2,x3,x4,x5,x6,x7)
vecFunc(x1,x2,x3,x4,x5,x6,x7) = Gamma;
fFunc(x1,x2,x3,x4,x5,x6,x7) = f;

fFunc(0,0,0,0,0,0,0);
DeltaL = vecFunc(0,0,0,0,0,0,0);
rank(DeltaL)
