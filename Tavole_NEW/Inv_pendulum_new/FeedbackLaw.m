clc
clear
close all

digits(2);

x = sym('x', [7 1], 'real');
u = sym('u', [2 1], 'real');
%x = x y  theta alpha d_alpha v d_theta  
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

g15 = Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(4))*cz*R;
g16 = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2);

f1 = [x(6)*cos(x(3));
         x(6)*sin(x(3));
         x(7);
         x(5)];

f2(1,1) = sin(2*x(4))*((x(7))^2)*H/D + (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-2*(Mb*R)^2*cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2,1) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(x(4))*x(5)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

f = vpa([f1;f2]);
        
g1 =  vpa([0;0;0;0;g15;g16;0]);
g2 =  vpa([0;0;0;0;0;0;1]);

h1 = x(3);
h2 = x(4);

Lf1_h1 = vpa(jacobian(h1,x)*f);
Lf2_h1 = vpa(jacobian(Lf1_h1,x)*f);
Lf3_h1 = vpa(jacobian(Lf2_h1,x)*f);

Lg1_Lf1h1 = vpa(jacobian(Lf1_h1,x)*g1);
Lg2_Lf1h1 = vpa(jacobian(Lf1_h1,x)*g2);
%il grado relativo rispetto a h1 è 2

Lf1_h2 = vpa(jacobian(h2,x)*f)
Lf2_h2 = vpa(jacobian(Lf1_h2,x)*f);
Lf3_h2 = vpa(jacobian(Lf2_h2,x)*f);

Lg1_Lf1h2 = vpa(jacobian(Lf1_h2,x)*g1);
Lg2_Lf1h2 = vpa(jacobian(Lf1_h2,x)*g2);
%il grado relativo rispetto a h2 è 2

E = [Lg1_Lf1h1,Lg2_Lf1h1;
     Lg1_Lf1h2,Lg2_Lf1h2;]
 
T = [Lf2_h1;Lf2_h2]

rank_invE = rank(inv(E));

f_phi = [h1;Lf1_h1;h2;Lf1_h2]

simplify(f+[g1,g2]*[-inv(E)*T+inv(E)*u])









