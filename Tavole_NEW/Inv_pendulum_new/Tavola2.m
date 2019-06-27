% Obs
clc
clear
close all

digits(3)
%% spazio degli stati
x = sym('x', [7 1], 'real');


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

g1 = [0;0;0;0;g15;g16;0];
g2 = [0;0;0;0;0;0;1];

f1 = [x(6)*cos(x(3));
         x(6)*sin(x(3));
         x(7);
         x(5)];

f2(1,1) = sin(2*x(4))*((x(7))^2)*H/D + (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-2*(Mb*R)^2*cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2,1) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(x(4))*x(5)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

f = [f1;f2];
y = [x(3); x(4)];
h1 = y(1,1);
h2 = y(2,1);

%% semplificazione problema con cambio di variabile.

f_feedbackLaw = [f(1,1);
                 f(2,1);
                 f(3,1);
                 f(4,1);
                 0;
                 f2(2,1)-g16/g15*f2(1,1);
                 0];

g1_feedbackLaw = [0;0;0;0;0;0;1];
g2_feedbackLaw = [0;0;0;0;1;g16/g15;0];

adf2g = liebracket(f_feedbackLaw,g1_feedbackLaw,x,1);

% %% Studio la Osservabilità del sistema
% 
% Lfh1 = jacobian(h1,x)*f_feedbackLaw;
% Lfh2 = jacobian(h2,x)*f_feedbackLaw;
% % Lg1Lfh1 = jacobian(Lfh1,x)*g1_feedbackLaw;
% % Lg2Lfh1 = jacobian(Lfh1,x)*g2_feedbackLaw;
% % Lg1Lfh2 = jacobian(Lfh2,x)*g1_feedbackLaw;
% % Lg2Lfh2 = jacobian(Lfh2,x)*g2_feedbackLaw
% Lg1h1 = jacobian(h1,x)*g1_feedbackLaw;
% Lg2h1 = jacobian(h1,x)*g2_feedbackLaw;
% Lg1h2 = jacobian(h2,x)*g1_feedbackLaw;
% Lg2h2 = jacobian(h2,x)*g2_feedbackLaw;
% LfLg1h1 = jacobian(Lg1h1,x)*f_feedbackLaw;
% LfLg2h1 = jacobian(Lg2h1,x)*f_feedbackLaw;
% LfLg1h2 = jacobian(Lg1h2,x)*f_feedbackLaw;
% LfLg2h2 = jacobian(Lg2h2,x)*f_feedbackLaw;
% O = [h1,h2,Lfh1,Lfh2,Lg1h1,Lg2h1,Lg1h2,Lg2h2,LfLg1h1,LfLg2h1,LfLg1h2,LfLg2h2];
% dO = jacobian(O,x);
% 
% rank_dO = rank(dO);
% string_Obs = sprintf('Il rango della matrice di observabilità è %i', rank_dO)
%% 
Lfh1 = jacobian(h1,x)*f;
Lfh2 = jacobian(h2,x)*f;
% Lg1Lfh1 = jacobian(Lfh1,x)*g1_feedbackLaw;
% Lg2Lfh1 = jacobian(Lfh1,x)*g2_feedbackLaw;
% Lg1Lfh2 = jacobian(Lfh2,x)*g1_feedbackLaw;
% Lg2Lfh2 = jacobian(Lfh2,x)*g2_feedbackLaw
Lg1h1 = jacobian(h1,x)*g1;
Lg2h1 = jacobian(h1,x)*g2;
Lg1h2 = jacobian(h2,x)*g1;
Lg2h2 = jacobian(h2,x)*g2;
LfLg1h1 = jacobian(Lg1h1,x)*f;
LfLg2h1 = jacobian(Lg2h1,x)*f;
LfLg1h2 = jacobian(Lg1h2,x)*f;
LfLg2h2 = jacobian(Lg2h2,x)*f;
O = [h1,h2,Lfh1,Lfh2,Lg1h1,Lg2h1,Lg1h2,Lg2h2,LfLg1h1,LfLg2h1,LfLg1h2,LfLg2h2];
dO = jacobian(O,x);
rank_dO = rank(dO);
string_Obs = sprintf('Il rango della matrice di observabilità è %i', rank_dO)


%% Studio la controllabilità del sistema
syms adfg1_fun(x1,x2,x3,x4,x5,x6,x7) adfg2_fun(x1,x2,x3,x4,x5,x6,x7) real
% Delta0 = vpa([g1_feedbackLaw,g2_feedbackLaw]);
% 
% rank(Delta0)
%chow: if dimension of span delle 2 distribuzioni = n, alora il sistema è
%small time locally accessibile.

n = 7;

% adfg1 = vpa(liebracket(f_feedbackLaw,g1_feedbackLaw,x,n-1));
% adfg2 = vpa(liebracket(f_feedbackLaw,g2_feedbackLaw,x,n-1));
adfg1 = vpa(liebracket(f,g1,x,n-1));b
adfg2 = vpa(liebracket(f,g2,x,n-1));
rank([adfg1,adfg2])

adfg1_fun(x1,x2,x3,x4,x5,x6,x7) = adfg1;
adfg2_fun(x1,x2,x3,x4,x5,x6,x7) = adfg2;

%% 
ad1 = adfg1_fun(0,0,0,0,0,x6,0);
ad2 = adfg2_fun(0,0,0,0,0,x6,0);
Q = [ad1,ad2];
rank(Q)

%il rank della Q è 7 solo se la velocità è diversa da 0.



