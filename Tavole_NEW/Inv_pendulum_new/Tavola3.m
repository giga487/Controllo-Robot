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

z = sym('z', [7 1], 'real');
v = sym('v', [2 1], 'real');
x = sym('x', [7 1], 'real');

%x = x y  theta alpha d_alpha v d_theta  
% TUTTO IN z

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

f2_hat = [0;
          f2(2,1)-g16/g15*f2(1,1);
          0;];
f = [f1;f2];
f_hat = [f1;f2_hat];
y = [x(3); x(4)];
h1 = y(1,1);
h2 = y(2,1);

%% 
syms f_fun(x1,x2,x3,x4,x5,x6,x7)

f_fun(x1,x2,x3,x4,x5,x6,x7) = f_hat;

f_fun(0,0,0,0,0,0,0)

%%
rank([g1,g2,f_hat]) %l ipotesi ii non è confermata
%%

Lg1_h1 = jacobian(h1,x)*g1; % 0
Lg2_h1 = jacobian(h1,x)*g2; % 0

Lf1_h1 = jacobian(h1,x)*f;  % diverzo da zero

Lg1_Lf1_h1 = jacobian(Lf1_h1,x)*g1; % 1
Lg2_Lf1_h1 = jacobian(Lf1_h1,x)*g2; % 0
%il grado relativo è 2  
Lf2_h1 = jacobian(Lf1_h1,x)*f;

% il grado relativo è 2.

h = h2(1);

Lg1_h2 = jacobian(h2,x)*g1; % 0
Lg2_h2 = jacobian(h2,x)*g2; % 0

Lf1_h2 = jacobian(h2,x)*f;  % diverzo da zero

Lg1_Lf1_h2 = jacobian(Lf1_h2,x)*g1; % 1
Lg2_Lf1_h2 = jacobian(Lf1_h2,x)*g2; % 0
%il grado relativo è 2

Lf2_h2 = jacobian(Lf1_h2,x)*f;

Gamma = vpa([Lf2_h1;Lf2_h2]);
E = vpa([Lg1_Lf1_h1,Lg2_Lf1_h1;
     Lg1_Lf1_h2,Lg2_Lf1_h2]);

%% Ricerca proprietà
% affinch´e esistano un cambiamento di variabili \psi(x) e le funzioni di retroazione
% statica ?(x) e ?(x) tali da linearizzare il sistema detto

% A) rank[g(x0) adfg(x0) . . . ad^(n-1)g(x0)] = n;
% B) span{g, adfg, . . . , adn?2f g} sia involutivo.

% A distribution is said involutive if the Lie bracket between any of its vector
% fields remains in the distribution: in formulas, D is involutive iff [D,D] ? D.

gg = vpa(liebracket(g1,f,x,6));
gg2 = vpa(liebracket(g2,f,x,6));
% syms gg_f(x1,x2,x3,x4,x5,x6,x7) gg2_f(x1,x2,x3,x4,x5,x6,x7) ;
% gg_f(x1,x2,x3,x4,x5,x6,x7) = gg;
% adfg1 = gg_f(0,0,0,0,0,x6,0);
% gg2_f(x1,x2,x3,x4,x5,x6,x7) = gg2;
% adfg2 = gg2_f(0,0,0,0,0,x6,0);

delta = [gg,gg2];
rank(delta)
% E' involutivo

% mentre la a?

syms gg_f(x1,x2,x3,x4,x5,x6,x7) gg2_f(x1,x2,x3,x4,x5,x6,x7) 
gg_f(x1,x2,x3,x4,x5,x6,x7) = gg;
adf6g1 = gg_f(0,0,0,0,0,x6,0);
gg2_f(x1,x2,x3,x4,x5,x6,x7) = gg2;
adf6g2 = gg2_f(0,0,0,0,0,x6,0);

gg_gg2 = [adf6g1,adf6g2];
rank(gg_gg2)

%% Check Trasformazione Linearmente indipendente

coordinate_trans = [x(3);
                    x(7);
                    x(4);
                    x(5);
                    x(1);
                    x(2);
                    -x(5)*g16+x(6)*g15];
                
rank(jacobian(coordinate_trans,x))
%% Space transformate

x(3) = z(1);
x(7) = z(2);
x(4) = z(3);
x(5) = z(4);
x(1) = z(5);
x(2) = z(6);


fz = vpa([z(2);
      0;
      z(4);
      0;
      (z(7)+g16*z(4))/g15*cos(z(1));
      (z(7)+g16*z(4))/g15*sin(z(1));
      z(4)*(-z(4)*jacobian(g16,z(3))+jacobian(g15,z(3))*(z(7)+g16*z(4)))+g15*(f2(2)-f2(1)*g16/g15);]);
      
g1z = [0;1;0;0;0;0;0];
g2z = [0;0;0;1;0;0;0];
      
w1 = vpa(f2(3,1) + v(1),2);
w2 = vpa(f2(1,1) + g15*v(2),2);




