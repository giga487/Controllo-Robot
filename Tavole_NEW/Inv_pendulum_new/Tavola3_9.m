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
%x = x y  theta alpha d_alpha v d_theta  
% TUTTO IN z

H = 0.5*Mb*(R^2)*Izz+Iwa*Izz-Mw*R^2*Ixx-Iwa*Ixx-Mb*cz^2*Mw*R^2-Mb*cz^2*Iwa-0.5*Mb*R^2*Ixx+Mw*R^2*Izz;
Ka = (-4*Iyy*Mb*R^2*cz-3*R^2*Mb^2*cz^3+Mb*R^2*cz*(Ixx-Izz))*sin(x(4))+(Mb*R^2*cz*(Ixx-Izz)+R^2*Mb^2*cz^3)*sin(3*x(4));
D = (Mb*cos(x(4))*cz*R)^2+((-Mb^2-2*Mw*Mb)*cz^2-2*Iyy*Mw-Iyy*Mb)*R^2-2*Mb*cz^2*Iwa-2*Iyy*Iwa;
G = (-Mb*cz^2+Izz-Ixx)*(R*cos(x(4)))^2+(Mb*cz^2+Ixx+2*Iwd+2*b^2*Mw)*R^2+2*b^2*Iwa;

g15 = (Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(3))*cz*R)/D;
g16 = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2)/D;
g17 = R*b/G;

g25 = (Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(3))*cz*R)/D;
g26 = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2)/D;
g27 = -R*b/G;


g1 = vpa([0;0;0;0;g15;g16;g17]);
g2 = vpa([0;0;0;0;g25;g26;g27]);

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

%% Controllo matrici per la feedback linearization

Lf_h1 = jacobian(h1,x)*f;
Lg1h1 = jacobian(h1,x)*g1;
Lg2h1 = jacobian(h1,x)*g2;
Lf_h2 = jacobian(h2,x)*f;
Lg1h2 = jacobian(h2,x)*g1;
Lg2h2 = jacobian(h2,x)*g2;

Lf2_h1 = jacobian(Lf_h1,x)*f;
Lf2_h2 = jacobian(Lf_h2,x)*f;
Lg1_Lf_h1 = jacobian(Lf_h1,x)*g1;
Lg2_Lf_h1 = jacobian(Lf_h1,x)*g2;
Lg1_Lf_h2 = jacobian(Lf_h2,x)*g1;
Lg2_Lf_h2 = jacobian(Lf_h2,x)*g2;

E = [Lg1_Lf_h1,Lg2_Lf_h1;
     Lg1_Lf_h2,Lg2_Lf_h2;];
 
%% Mi rendo conto che devo fare una feedback linearization dinamica

Lf3_h1 = jacobian(Lf2_h1,x)*f;
Lg1_Lf2_h1 = jacobian(Lf2_h1,x)*g1;
Lg2_Lf2_h1 = jacobian(Lf2_h1,x)*g2;
Lf3_h2 = jacobian(Lf2_h2,x)*f;
Lg1_Lf2_h2 = jacobian(Lf2_h2,x)*g1;
Lg2_Lf2_h2 = jacobian(Lf2_h2,x)*g2;

E1 = [Lg1_Lf2_h1,Lg2_Lf2_h1;
     Lg1_Lf2_h2,Lg2_Lf2_h2];
 
syms detE1_f(x1,x2,x3,x4,x5,x6,x7)

detE1_f(x1,x2,x3,x4,x5,x6,x7) = det(E1);
detE1_critico = vpa(detE1_f(0,0,0,x4,x5,x6,0))

%%

psi = [h1;Lf_h1;Lf2_h1;h2;Lf_h2;Lf2_h2;x5;x7]

d_psi = (jacobian(psi,x));
syms d_psi_f(x1,x2,x3,x4,x5,x6,x7)

d_psi_f(x1,x2,x3,x4,x5,x6,x7,x8) = d_psi;
d_psi_0 = d_psi_f(0,0,0,0,0,x6,0,0)
rank(d_psi_0)

%%
x = sym('x', [8 1], 'real');
f_tilde = [f;0]+[g1;0]*x(8)
g1_tilde = [0;0;0;0;0;0;0;1];
g2_tilde = [g2;0]

Lf_h1 = jacobian(h1,x)*f_tilde;
Lf_h2 = jacobian(h2,x)*f_tilde;
Lg1_h1 = jacobian(h1,x)*g1_tilde;
Lg2_h1 = jacobian(h1,x)*g2_tilde;
Lg1_h2 = jacobian(h2,x)*g1_tilde;
Lg2_h2 = jacobian(h2,x)*g2_tilde;

Lf2_h1 = jacobian(Lf_h1,x)*f_tilde
Lf2_h2 = jacobian(Lf_h2,x)*f_tilde
Lg1_Lf_h1 = jacobian(Lf_h1,x)*g1_tilde
Lg2_Lf_h1 = jacobian(Lf_h1,x)*g2_tilde
Lg1_Lf_h2 = jacobian(Lf_h2,x)*g1_tilde
Lg2_Lf_h2 = jacobian(Lf_h2,x)*g2_tilde

Lf3_h1 = jacobian(Lf2_h1,x)*f_tilde
Lf3_h2 = jacobian(Lf2_h2,x)*f_tilde
Lg1_Lf2_h1 = jacobian(Lf2_h1,x)*g1_tilde
Lg2_Lf2_h1 = jacobian(Lf2_h1,x)*g2_tilde
Lg1_Lf2_h2 = jacobian(Lf2_h2,x)*g1_tilde
Lg2_Lf2_h2 = jacobian(Lf2_h2,x)*g2_tilde

E = [Lg1_Lf2_h1,Lg2_Lf2_h1;
     Lg1_Lf2_h2,Lg2_Lf2_h2]

Gamma = [Lf3_h1;
         Lf3_h2]
rank(E)


