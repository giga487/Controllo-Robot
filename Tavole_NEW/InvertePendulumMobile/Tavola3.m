clc
clear
close all

x = sym('x', [7 1], 'real'); % state
% f2 = sym('f2', [3 1], 'real'); % f
g1 = sym('g1', [6 1], 'real'); % state

g_1 = [0;0;0;0;0;0;0];
g_2 = [0;0;0;0;0;0;1];

% syms b H D cz Mb R g Iwa Mw Ka Iyy Ixx Izz G v1 v2 u1 u2 real
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
Ka = (-4*Iyy*Mb*R^2*cz-3*R^2*Mb^2*cz^3+Mb*R^2*cz*(Ixx-Izz))*sin(x(4))+(Mb*R^2*cz*(Ixx-Izz)+R^2*Mb^2*cz^3)*sin(3*x(4));
D = (Mb*cos(x(4))*cz*R)^2+((-Mb^2-2*Mw*Mb)*cz^2-2*Iyy*Mw-Iyy*Mb)*R^2-2*Mb*cz^2*Iwa-2*Iyy*Iwa;
G = (-Mb*cz^2+Izz-Ixx)*(R*cos(x(4)))^2+(Mb*cz^2+Ixx+2*Iwd+2*b^2*Mw)*R^2+2*b^2*Iwa;
syms v1 v2

f2(1) = sin(2*x(4))*((x(7))^2)*H/D+ (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(2*x(4))*x(5)^2/D;
f2(3) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

g15 = (Mb*R^2 + 2*Mw*R^2 + 2*Iwa + Mb*cos(x(4))*cz*R)/D;
g16 = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2)/D;
g17 = R*b/G;

g25 = g15;
g26 = g16;
g27 = -g17;

g_1 = [0;0;0;0;g15;g16;g17];
g_2 = [0;0;0;0;g25;g26;g27];

%Cambio ingressi

% v1 = (u1+u2)/D;
% v2 = (u1-u2)*R*b/G;

%Ottengo quindi
g1_hat = [0;0;0;0;(Mb*R^2 + 2*Mw*R^2 + 2*Iwa + Mb*cos(x(4))*cz*R);-R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2);0];
g2_hat = [0;0;0;0;0;0;1];

f = vpa([x(6)*cos(x(3));
     x(6)*sin(x(3));
     x(7);
     x(5);
     f2(:)],2);   
 
y = [x(3);x(4)];

f_tot = vpa(f + g1_hat*v1 + g2_hat*v2,2);

%l'equilibrio lo pongo in [x,y,tetha,0,0,0,0]

%% Studio
syms f_fun(x1,x2,x3,x4,x5,x6,x7) g1_fun(x1,x2,x3,x4,x5,x6,x7) g2_fun(x1,x2,x3,x4,x5,x6,x7)

f_fun(x1,x2,x3,x4,x5,x6,x7) = f;
g1_fun(x1,x2,x3,x4,x5,x6,x7) = g1_hat*v1;
g2_fun(x1,x2,x3,x4,x5,x6,x7) = g2_hat*v2;
% 
% syms x1 x2 x3 x4 x5 x6 x7 real
syms x1 x2 x3 
x4 = 0;
x5 = 0;
x6 = 0;
x7 = 0;

f_now = f_fun(x1,x2,x3,x4,x5,x6,x7);
g1_now = vpa(g1_fun(x1,x2,x3,x4,x5,x6,x7),2);
g2_now = g2_fun(x1,x2,x3,x4,x5,x6,x7);

% Il sistema non è controllabile attorno ad il suo punto di equilibrio ma è
% Small time locally controllable e strongly accessible


%% Gestione feedback linearization

syms f_fun(x1,x2,x3,x4,x5,x6,x7) g1_fun(x1,x2,x3,x4,x5,x6,x7) g2_fun(x1,x2,x3,x4,x5,x6,x7)

f_fun(x1,x2,x3,x4,x5,x6,x7) = f;

syms x1 x2 x3 x4 x5 x6 x7 real

f_now = vpa(f_fun(x1,x2,x3,x4,x5,x6,x7),2);
% D0 = [g_1,g_2];
% D = [f,g_1,g_2];


y1 = y(1);
Lf_h1 = jacobian(y1(1),x)*f;
L2f_h1 = jacobian(Lf_h1,x)*f;
Lg1_Lf_h1 = jacobian(Lf_h1,x)*g1_hat*v1;
Lg2_Lf_h1 = jacobian(Lf_h1,x)*g2_hat*v2;
ddy1 = vpa(L2f_h1 + Lg1_Lf_h1 + Lg2_Lf_h1,2);

y2 = y(2);
Lf_h2 = jacobian(y2,x)*f;
L2f_h2 = jacobian(Lf_h2,x)*f;
Lg1_Lf_h2 = jacobian(Lf_h2,x)*g1_hat*v1;
Lg2_Lf_h2 = jacobian(Lf_h2,x)*g2_hat*v2;
ddy2 = vpa(L2f_h2 + Lg1_Lf_h2 + Lg2_Lf_h2,2);
%il grado relativo è 2 per entrambe le uscite.
%partial feedback linearization

Gamma = (vpa([L2f_h1;L2f_h2],2));
E = [Lg1_Lf_h1,Lg2_Lf_h1;Lg1_Lf_h2,Lg2_Lf_h2];

invE = inv(E);

e(1,1) = y(1);
e(2,1) = Lf_h1;
e(3,1) = y(2);
e(4,1) = Lf_h2;
eta(1,1) = x1;
eta(2,1) = x2;
eta(3,1) = -x(5)*g16 + x(6)*g15;

Tx = vpa([e;eta],2);

PROVA = vpa([jacobian(Tx(1,1),x);
         jacobian(Tx(2,1),x);
         jacobian(Tx(3,1),x);
         jacobian(Tx(4,1),x);
         jacobian(Tx(5,1),x);
         jacobian(Tx(6,1),x);
         jacobian(Tx(7,1),x)],2)

rank(PROVA)



