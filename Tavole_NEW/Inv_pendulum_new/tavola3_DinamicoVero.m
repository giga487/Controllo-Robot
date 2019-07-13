%Dinamic Feed

%Tavola 3 Amato, no articolo

clc
clear
close all

% Inverted Pendulum 

% syms Mb R Mw Iwa cz Iyy g Ka Ixx Izz Iwd b

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
gA = sym('g1', [3,1], 'real');
gB = sym('g2', [3,1], 'real');
%x = x y  theta alpha d_alpha v d_theta  
% TUTTO IN z

H = 0.5*Mb*(R^2)*Izz+Iwa*Izz-Mw*R^2*Ixx-Iwa*Ixx-Mb*cz^2*Mw*R^2-Mb*cz^2*Iwa-0.5*Mb*R^2*Ixx+Mw*R^2*Izz;
Ka = (-4*Iyy*Mb*R^2*cz-3*R^2*Mb^2*cz^3+Mb*R^2*cz*(Ixx-Izz))*sin(x(4))+(Mb*R^2*cz*(Ixx-Izz)+R^2*Mb^2*cz^3)*sin(3*x(4));
D = (Mb*cos(x(4))*cz*R)^2+((-Mb^2-2*Mw*Mb)*cz^2-2*Iyy*Mw-Iyy*Mb)*R^2-2*Mb*cz^2*Iwa-2*Iyy*Iwa;
G = (-Mb*cz^2+Izz-Ixx)*(R*cos(x(4)))^2+(Mb*cz^2+Ixx+2*Iwd+2*b^2*Mw)*R^2+2*b^2*Iwa;

gA(1) = (Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(3))*cz*R)/D;
gA(2) = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2)/D;
gA(3) = R*b/G;

gB(1) = (Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(3))*cz*R)/D;
gB(2) = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2)/D;
gB(3) = -R*b/G;


g1 = vpa([0;0;0;0;gA]);
g2 = vpa([0;0;0;0;gB]);

f1 = [x(6)*cos(x(3));
      x(6)*sin(x(3));
      x(7);
      x(5)];

f2(1,1) = sin(2*x(4))*((x(7))^2)*H/D + (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2,1) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(2*x(4))*x(5)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

f = vpa([f1;f2]);
y = [x(1);x(2)];
h1 = y(1,1);
h2 = y(2,1);

%% Ricavo le matrici Gamma ed E

Lfh1 = jacobian(h1,x)*f;
Lf2h1 = jacobian(Lfh1,x)*f;
Lfh2 = jacobian(h2,x)*f;
Lf2h2 = jacobian(Lfh2,x)*f;
Lg1h1 = jacobian(h1,x)*g1;
Lg2h1 = jacobian(h1,x)*g2;
Lg1h2 = jacobian(h2,x)*g1;
Lg2h2 = jacobian(h2,x)*g2;

Lg1Lfh1 = jacobian(Lfh1,x)*g1;
Lg2Lfh1 = jacobian(Lfh1,x)*g2;
Lg1Lfh2 = jacobian(Lfh2,x)*g1;
Lg2Lfh2 = jacobian(Lfh2,x)*g2;

Lf3h1 = jacobian(Lf2h1,x)*f;
Lf3h2 = jacobian(Lf2h2,x)*f;
Lg1Lf2h1 = jacobian(Lf2h1,x)*g1;
Lg2Lf2h1 = jacobian(Lf2h1,x)*g2;
Lg1Lf2h2 = jacobian(Lf2h2,x)*g1;
Lg2Lf2h2 = jacobian(Lf2h2,x)*g2;


Lf4h1 = jacobian(Lf3h1,x)*f;
Lf4h2 = jacobian(Lf3h2,x)*f;
Lg1Lf3h1 = jacobian(Lf3h1,x)*g1;
Lg2Lf3h1 = jacobian(Lf3h1,x)*g2;
Lg1Lf3h2 = jacobian(Lf3h2,x)*g1;
Lg2Lf3h2 = jacobian(Lf3h2,x)*g2;

%%

%non ottengo le uscite con questo grado
E = [Lg1h1,Lg2h1;
     Lg1h2,Lg2h2];
%La matrice ha rank 1
E1 = [Lg1Lfh1,Lg2Lfh1;
      Lg1Lfh2,Lg2Lfh2]
rank(E1)
det(E1)
%
E2 = [Lg1Lf2h1,Lg2Lf2h1;
      Lg1Lf2h2,Lg2Lf2h2]
rank(E2)
det(E2)

syms E2_f(x1,x2,x3,x4,x5,x6,x7)
E2_f(x1,x2,x3,x4,x5,x6,x7) = E2;
E2_0 = E2_f(0,0,0,x4,x5,x6,0)
rank(E2_0)

Gamma = [Lf3h1;
         Lf3h2]

%% 

psi = [h1;
       Lfh1;
       Lf2h1;
       h2;
       Lfh2;
       Lf2h2;
       x4]

d_psi = jacobian(psi,x)

rank(d_psi)