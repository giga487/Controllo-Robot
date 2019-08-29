
clc
clear
close all

digits(3);

% Inverted Pendulum 

syms Mb R Mw Iwa cz Iyy g Ka Ixx Izz Iwd b
syms G H D Ka

v = sym('v', [2 1], 'real');
xi = sym('xi', [3 1], 'real');
n = sym('n', [4 1], 'real');


H = 0.5*Mb*(R^2)*Izz+Iwa*Izz-Mw*R^2*Ixx-Iwa*Ixx-Mb*cz^2*Mw*R^2-Mb*cz^2*Iwa-0.5*Mb*R^2*Ixx+Mw*R^2*Izz;
Ka = (-4*Iyy*Mb*R^2*cz-3*R^2*Mb^2*cz^3+Mb*R^2*cz*(Ixx-Izz))*sin(n(3))+(Mb*R^2*cz*(Ixx-Izz)+R^2*Mb^2*cz^3)*sin(3*n(3));
D = (Mb*cos(n(3))*cz*R)^2+((-Mb^2-2*Mw*Mb)*cz^2-2*Iyy*Mw-Iyy*Mb)*R^2-2*Mb*cz^2*Iwa-2*Iyy*Iwa;
G = (-Mb*cz^2+Izz-Ixx)*(R*cos(n(3)))^2+(Mb*cz^2+Ixx+2*Iwd+2*b^2*Mw)*R^2+2*b^2*Iwa;

g15 = (Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(n(3))*cz*R)/D;
g16 = -R*(Mb*cos(n(3))*cz*R + Iyy + Mb*cz^2)/D;
g17 = R*b/G;

g25 = (Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(n(3))*cz*R)/D;
g26 = -R*(Mb*cos(n(3))*cz*R + Iyy + Mb*cz^2)/D;
g27 = -R*b/G;

g1 = vpa([0;0;0;0;g15;g16;g17]);
g2 = vpa([0;0;0;0;g25;g26;g27]);

g2_b = (g1-g2)/2;
g1_b = (g1+g2)/2;

% 
f2(1,1) = sin(2*n(3))*(xi(2))^2*H/D + (1/2)*(Mb*cz*R*n(4))^2*sin(2*n(3))/D+(1/2)*(-2*(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(n(3))/D;
f2(2,1) = Ka*(xi(2))^2 + (1/2)*g*sin(2*n(3))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(n(3))*n(3)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*n(3))*n(4)*xi(2)/G - sin(n(3))*R^2*Mb*cz*xi(3)*xi(2)/G;

z = [xi(2);
     f2(3,1);
     f2(2,1);
     xi(3)*cos(xi(1));
     xi(3)*sin(xi(1));
     n(4);
     f2(1,1)];
  
gz_2 = [0;g2_b(7);0;0;0;0;0];
gz_1 = [0;0;g1_b(6);0;0;0;g1_b(5)];
sys = z + gz_1*v(1) + gz_2*v(2);
y = [xi(1);xi(3)];

%%
clc
syms sys_fun(xi1,xi2,xi3,n1,n2,n3,n4,v1,v2) lin_fun(Mb,Mw,R,cz,b,Ixx,Iyy,Izz,Iwa,Iwd,g,n1,n2,n3,n4)

sys_fun(xi1,xi2,xi3,n1,n2,n3,n4,v1,v2) = sys;

%se xi(1) = xi(2) = xi(3) = 0 allora n(1) = 0 e n(2) = 0
zero_dynamics_study = vpa(sys_fun(0,0,0,0,0,n3,n4,v1,0));

eqn = zero_dynamics_study(3)

v1_sol = vpa(solve(eqn,v1))

sys_fin = vpa(sys_fun(0,0,0,0,0,n3,n4,v1_sol,0))
%%
lin_fun(Mb,Mw,R,cz,b,Ixx,Iyy,Izz,Iwa,Iwd,g,n1,n2,n3,n4) = jacobian(sys_fin,[n(1),n(2),n(3),n(4)]);

%%
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

F = lin_fun(Mb,Mw,R,cz,b,Ixx,Iyy,Izz,Iwa,Iwd,g,0,0,0,0)

EIG_F = simplify(eig(F(4:7,:)));








