% tavola2_LAST

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

g2_b = (g1-g2)/2;
g1_b = (g1+g2)/2;

f1 = [x(6)*cos(x(3));
      x(6)*sin(x(3));
      x(7);
      x(5)];
% 
f2(1,1) = sin(2*x(4))*((x(7))^2)*H/D + (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-2*(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2,1) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(x(4))*x(5)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

f = vpa([f1;f2]);
y = [x(3);x(4)];
% y = [x(1);x(2)+cz*sin(x(3))*sin(x(4))];
h1 = y(1,1);
h2 = y(2,1);

syms f_fun(x1,x2,x3,x4,x5,x6,x7)
f_fun(x1,x2,x3,x4,x5,x6,x7) = f;
f_00 = f_fun(0,0,0,x4,0,x6,x7);

Lf_h1 = jacobian(h1,x)*f;
Lg1_h1 = jacobian(h1,x)*g1_b;
Lg2_h1 = jacobian(h1,x)*g2_b;
Lf_h2 = jacobian(h2,x)*f;
Lg1_h2 = jacobian(h2,x)*g1_b;
Lg2_h2 = jacobian(h2,x)*g2_b;

Lf2_h1 = jacobian(Lf_h1,x)*f;
Lg1_Lf_h1 = jacobian(Lf_h1,x)*g1_b;
Lg2_Lf_h1 = jacobian(Lf_h1,x)*g2_b;
Lf2_h2 = jacobian(Lf_h2,x)*f;
Lg1_Lf_h2 = jacobian(Lf_h2,x)*g1_b;
Lg2_Lf_h2 = jacobian(Lf_h2,x)*g2_b;


%% ACCESSIBILITA

% adfg1 = jacobian(g1_b,x)*f-jacobian(f,x)*g1_b
% adfg2 = jacobian(g1_b,x)*f-jacobian(f,x)*g2_b
% adf2g1 = jacobian(g1_b,x)*f-jacobian(f,x)*g1_b
% adf2g2 = jacobian(g1_b,x)*f-jacobian(f,x)*g2_b

GammaG1 = liebracket(f,g1_b,x,3);
GammaG2 = liebracket(f,g2_b,x,3);

Gamma0 = liebracket(g2_b,g1_b,x,1)

C = [Gamma0,GammaG1,GammaG2];

RankC = rank(C)

% IL sistema � accessibile solo se x6 diversa da 0.
%% CONTROLLABILTA
%se l'accessibilit� � garantita tramite il teorema di Chow
%devo trovare una delle condizione che garantiscono l'accessibilit� in caso
%di controllabilit�.

syms C_f(x1,x2,x3,x4,x5,x6,x7) fFunc(x1,x2,x3,x4,x5,x6,x7)
C_f(x1,x2,x3,x4,x5,x6,x7) = C;
fFunc(x1,x2,x3,x4,x5,x6,x7) = f;

f_zero = fFunc(0,0,0,0,0,0,0);
DeltaL = C_f(0,0,0,0,0,x6,0);

Rank_Test_Controllabilita = rank(DeltaL);
%E' CONTROLLABILE SE x6 � diverso da zero.

%%
% 1 NO
% 2 NO
% 3 NO si con x6 diverso da zero
% 4 NO non cambia niente rispetto alle 3
% 5 NO 
% 6 NO


%% OBS x3 x4

O = y;

for i = 3:2:11
    O = [O;jacobian(O(i-2:i-1),x)*f];
end

Og1 = jacobian(O(1:2),x)*g1;

for i=3:2:11
Og1 = [Og1;jacobian(O(i:i+1),x)*g1_b];
end

Og2 = jacobian(O(1:2),x)*g2;

for i=3:2:11
Og2 = [Og2;jacobian(O(i:i+1),x)*g2_b];
end

O = [O; Og1; Og2];
dO = jacobian(O,x);

Rank_dO = rank(dO)
%Il rank della codistribuzione � 5 con le uscite prese per la feedback
%linearization.

%% OBS x1 x2

O = [x1;x2];
iteration = 5;

for i = 3:2:iteration
    O = [O;jacobian(O(i-2:i-1),x)*f];
end

Og1 = jacobian(O(1:2),x)*g1;

for i=3:2:iteration
Og1 = [Og1;jacobian(O(i:i+1),x)*g1];
end

Og2 = jacobian(O(1:2),x)*g2;

for i=3:2:iteration
Og2 = [Og2;jacobian(O(i:i+1),x)*g2];
end

O = [O; Og1; Og2];
dO = jacobian(O,x)

syms dO_fun(x1,x2,x3,x4,x5,x6,x7)

dO_fun(x1,x2,x3,x4,x5,x6,x7) = dO;
dO_fun(0,0,0,0,0,0,0)

Rank_dO = rank(dO)

%Il rank della codistribuzione � 7 per tutti i valori di x
%con le uscite x1 x2, il sistema � osservabile


