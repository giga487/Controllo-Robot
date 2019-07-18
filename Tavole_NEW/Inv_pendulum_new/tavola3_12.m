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
x = sym('x', [8 1], 'real');
f2 = sym('f2', [3,1], 'real');
syms G H D Ka
%x = x y  theta alpha d_alpha v d_theta  
% TUTTO IN z
% 
H = 0.5*Mb*(R^2)*Izz+Iwa*Izz-Mw*R^2*Ixx-Iwa*Ixx-Mb*cz^2*Mw*R^2-Mb*cz^2*Iwa-0.5*Mb*R^2*Ixx+Mw*R^2*Izz;
Ka = (-4*Iyy*Mb*R^2*cz-3*R^2*Mb^2*cz^3+Mb*R^2*cz*(Ixx-Izz))*sin(x(4))+(Mb*R^2*cz*(Ixx-Izz)+R^2*Mb^2*cz^3)*sin(3*x(4));
D = (Mb*cos(x(4))*cz*R)^2+((-Mb^2-2*Mw*Mb)*cz^2-2*Iyy*Mw-Iyy*Mb)*R^2-2*Mb*cz^2*Iwa-2*Iyy*Iwa;
G = (-Mb*cz^2+Izz-Ixx)*(R*cos(x(4)))^2+(Mb*cz^2+Ixx+2*Iwd+2*b^2*Mw)*R^2+2*b^2*Iwa;

g15 = Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(3))*cz*R;
g16 = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2);

g1 = [0;0;0;0;1;g16/g15;0];
g2 = [0;0;0;0;0;0;1];

f1 = [x(6)*cos(x(3));
      x(6)*sin(x(3));
      x(7);
      x(5)];

f2(1,1) = sin(2*x(4))*((x(7))^2)*H/D + (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2,1) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(2*x(4))*x(5)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

f = vpa([f1;0;f2(2,1)-g1(6,1)/g1(5,1)*f2(1,1);0]);
y = [x(1);x(2)];
h1 = y(1,1);
h2 = y(2,1);

%%
f_tilde = [f;0]+[g1;0]*x(8);
g1_tilde = [zeros(7,1);1];
g2_tilde = [g2;0];

h1
Lf_h1 = jacobian(h1,x)*f_tilde
Lf_h2 = jacobian(h2,x)*f_tilde
Lf2_h1 = jacobian(Lf_h1,x)*f_tilde
Lf2_h2 = jacobian(Lf_h2,x)*f_tilde
Lf3_h1 = jacobian(Lf2_h1,x)*f_tilde
Lf3_h2 = jacobian(Lf2_h2,x)*f_tilde

Lg1_h1 = jacobian(h1,x)*g1_tilde
Lg2_h1 = jacobian(h1,x)*g2_tilde
Lg1_h2 = jacobian(h2,x)*g1_tilde
Lg2_h2 = jacobian(h2,x)*g2_tilde
Lg1_Lf_h1 = jacobian(Lf_h1,x)*g1_tilde
Lg2_Lf_h1 = jacobian(Lf_h1,x)*g2_tilde
Lg1_Lf_h2 = jacobian(Lf_h2,x)*g1_tilde
Lg2_Lf_h2 = jacobian(Lf_h2,x)*g2_tilde
Lg1_Lf2_h1 = jacobian(Lf2_h1,x)*g1_tilde
Lg2_Lf2_h1 = jacobian(Lf2_h1,x)*g2_tilde
Lg1_Lf2_h2 = jacobian(Lf2_h2,x)*g1_tilde
Lg2_Lf2_h2 = jacobian(Lf2_h2,x)*g2_tilde

E = [Lg1_Lf2_h1,Lg2_Lf2_h1;
     Lg1_Lf2_h2,Lg2_Lf2_h2];

%% 
syms E_fun(x1,x2,x3,x4,x5,x6,x7,x8)
E_fun(x1,x2,x3,x4,x5,x6,x7,x8) = E;
E_00 = vpa(E_fun(0,0,0,0,0,x6,0,0));

%% Zery Dynamic

psi = [h1;Lf_h1;Lf2_h1;h2;Lf_h1;Lf2_h2]
eta = [x3;x5] 

d_psi = jacobian([psi],x);

syms d_psi_fun(x1,x2,x3,x4,x5,x6,x7,x8)
d_psi_fun(x1,x2,x3,x4,x5,x6,x7,x8) = d_psi;
d_psi_00 = vpa(d_psi_fun(0,0,0,0,0,x6,0,0))

rank(d_psi_00)
