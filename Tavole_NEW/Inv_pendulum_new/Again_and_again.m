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

x = sym('x', [7 1], 'real');
%x = x y  theta alpha d_alpha v d_theta  

H = 0.5*Mb*(R^2)*Izz+Iwa*Izz-Mw*R^2*Ixx-Iwa*Ixx-Mb*cz^2*Mw*R^2-Mb*cz^2*Iwa-0.5*Mb*R^2*Ixx+Mw*R^2*Izz;
Ka = (-4*Iyy*Mb*R^2*cz-3*R^2*Mb^2*cz^3+Mb*R^2*cz*(Ixx-Izz))*sin(x(4))+(Mb*R^2*cz*(Ixx-Izz)+R^2*Mb^2*cz^3)*sin(3*x(4));
D = (Mb*cos(x(4))*cz*R)^2+((-Mb^2-2*Mw*Mb)*cz^2-2*Iyy*Mw-Iyy*Mb)*R^2-2*Mb*cz^2*Iwa-2*Iyy*Iwa;
G = (-Mb*cz^2+Izz-Ixx)*(R*cos(x(4)))^2+(Mb*cz^2+Ixx+2*Iwd+2*b^2*Mw)*R^2+2*b^2*Iwa;

g15 = Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(4))*cz*R;
g16 = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2);

g1 = [0;0;0;0;g15;g16;0];
g2 = [0;0;0;0;0;0;1];

f1 = [x(6)*cos(x(3));
         x(6)*sin(x(3));
         x(7);
         x(5)];

f2(1,1) = sin(2*x(4))*((x(7))^2)*H/D + (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2,1) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(2*x(4))*x(5)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

f = [f1;f2];
y = [x(3); x(4)];
h1 = y(1,1);
h2 = y(2,1);


%% 
h = h1(1);

Lg1_h1 = jacobian(h,x)*g1; % 0
Lg2_h1 = jacobian(h,x)*g2; % 0

Lf1_h1 = jacobian(h,x)*f;  % diverzo da zero

Lg1_Lf1_h1 = jacobian(Lf1_h1,x)*g1; % 1
Lg2_Lf1_h1 = jacobian(Lf1_h1,x)*g2; % 0
%il grado relativo è 2  
Lf2_h1 = jacobian(Lf1_h1,x)*f;

% il grado relativo è 2.

h = h2(1);

Lg1_h2 = jacobian(h,x)*g1; % 0
Lg2_h2 = jacobian(h,x)*g2; % 0

Lf1_h2 = jacobian(h,x)*f;  % diverzo da zero

Lg1_Lf1_h2 = jacobian(Lf1_h2,x)*g1; % 1
Lg2_Lf1_h2 = jacobian(Lf1_h2,x)*g2; % 0
%il grado relativo è 2

Lf2_h2 = jacobian(Lf1_h2,x)*f;

Gamma = vpa([Lf2_h1;Lf2_h2]);
E = vpa([Lg1_Lf1_h1,Lg2_Lf1_h1;
     Lg1_Lf1_h2,Lg2_Lf1_h2]);
