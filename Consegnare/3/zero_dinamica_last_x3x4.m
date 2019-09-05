% zerodinamica_last

clc
clear
close all

% Inverted Pendulum 

syms Mb R Mw Iwa cz Iyy g Ka Ixx Izz Iwd b
syms G H D Ka
digits(3);

v = sym('v', [2 1], 'real');
xi = sym('xi', [4 1], 'real');
n = sym('n', [3 1], 'real');


H = 0.5*Mb*(R^2)*Izz+Iwa*Izz-Mw*R^2*Ixx-Iwa*Ixx-Mb*cz^2*Mw*R^2-Mb*cz^2*Iwa-0.5*Mb*R^2*Ixx+Mw*R^2*Izz;
Ka = (-4*Iyy*Mb*R^2*cz-3*R^2*Mb^2*cz^3+Mb*R^2*cz*(Ixx-Izz))*sin(xi(3))+(Mb*R^2*cz*(Ixx-Izz)+R^2*Mb^2*cz^3)*sin(3*xi(3));
D = (Mb*cos(xi(3))*cz*R)^2+((-Mb^2-2*Mw*Mb)*cz^2-2*Iyy*Mw-Iyy*Mb)*R^2-2*Mb*cz^2*Iwa-2*Iyy*Iwa;
G = (-Mb*cz^2+Izz-Ixx)*(R*cos(xi(3)))^2+(Mb*cz^2+Ixx+2*Iwd+2*b^2*Mw)*R^2+2*b^2*Iwa;

g15 = (Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(xi(3))*cz*R)/D;
g16 = -R*(Mb*cos(xi(3))*cz*R + Iyy + Mb*cz^2)/D;
g17 = R*b/G;

g25 = (Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(xi(3))*cz*R)/D;
g26 = -R*(Mb*cos(xi(3))*cz*R + Iyy + Mb*cz^2)/D;
g27 = -R*b/G;

g1 = vpa([0;0;0;0;g15;g16;g17]);
g2 = vpa([0;0;0;0;g25;g26;g27]);

g2_b = (g1-g2)/2;
g1_b = (g1+g2)/2;

f2(1,1) = sin(2*xi(3))*((xi(2))^2)*H/D + (1/2)*(Mb*cz*R*xi(4))^2*sin(2*xi(3))/D+(1/2)*(-2*(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(xi(3))/D;
f2(2,1) = Ka*(xi(2))^2 + (1/2)*g*sin(2*xi(3))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(xi(3))*xi(4)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*xi(3))*xi(4)*xi(2)/G - sin(xi(3))*R^2*Mb*cz*n(3)*xi(2)/G;


z = [xi(2);
     f2(3,1) + g2_b(7)*v(2);
     xi(4);
     f2(2,1) + g1_b(5)*v(1);
     n(3)*cos(xi(1));
     n(3)*sin(xi(1));
     f2(1,1) + g1_b(6)*v(1)];
 
sys = z;
 
%%

clc
syms sys_fun(xi1,xi2,xi3,xi4,n1,n2,n3,v1,v2) lin_fun(Mb,Mw,R,cz,b,Ixx,Iyy,Izz,Iwa,Iwd,g,n1,n2,n3)

sys_fun(xi1,xi2,xi3,xi4,n1,n2,n3,v1,v2) = sys;

%se xi(1) = xi(2) = xi(3) = 0 allora n(1) = 0 e n(2) = 0
zero_dynamics_study = vpa(sys_fun(0,0,0,0,n1,n2,n3,v1,v2))

%% 
eqn = zero_dynamics_study(4);

v1_sol = vpa(solve(eqn,v1)) %%LA SOLUZIONE e' ZERO quindi gli input che devo lasciare sono nulli.

sys_fin = vpa(sys_fun(0,0,0,0,n1,n2,n3,v1_sol,0))

%% 
Mat = jacobian(sys_fin,[n(1),n(2),n(3)]);

eig(Mat(5:7,:))

% F = vpa(lin_fun(Mb,Mw,R,cz,b,Ixx,Iyy,Izz,Iwa,Iwd,g,0,0,0));
% 
% eig(F(6:7,:))
%  
%  
 
 
 
 
 
 
 
 
 
 