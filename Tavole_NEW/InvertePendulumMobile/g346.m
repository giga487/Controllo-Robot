

clc
clear 

x = sym('x', [7 1], 'real'); % state

% syms Mz cz Ix Iz Iy R Iwa Mw Iwd Mb b g tr tl  real

g = sym(9.8);
Mb = sym(3.9);
Mw = sym(0.375);
R = sym(0.10);
cz = sym(0.1);
b = sym(0.1620);
Ix = sym(0.02);
Iy = sym(0.015);
Iz = sym(0.01);
Iw = sym(0.002);
Iwa = sym(0.001);
Iwd = sym(Iwa/2);

syms D_a G_a b1 b2 b3 b4 b5 g5 g6 T1 T2 R b

% b1 = Mb*cz^2 + Ix - Iz;
% b2 = Mb*cz^2 + Iy;
% b3 = (Mb*(R^2)+2*(Iwa+Mw*(R^2)))/(R^2);
% b4 = ((R^2)*(Iz+2*Iwd+2*(b^2)*Mw)+2*Iwa*(b^2))/(R^2);
% b5 = Mb*cz;
% 
% % x(4) = 0;
% T1 = b2*b3 - (b5*cos(x(4)))^2;
% T2 = b4 + b1*(sin(x(4)))^2;
g5 = b3*R + b5*cos(x(4));
g6 = b2 + R*b5*cos(x(4));


% x y tetha alfa d_alfa v d_tetha

den = (2*(b2*b3-(b5*cos(x(4)))^2));
f5 = (sin(2*x(4))*(b3*b1*((x(7))^2)-(b5*(x(5))^2))+2*b5*b3*g*sin(x(4)))/den;
f6 = (sin(2*x(4))*(-b1*b5*((x(7))^2)*cos(x(4))-g*(b5)^2)+2*b2*b5*((x(5))^2)*sin(x(4)))/den;
f7 = (-b1*x(5)*x(7)*sin(2*x(4)))/(b4+b1*sin(x(4))^2);


f = vpa(simplify([x(6)*cos(x(3));
         x(6)*sin(x(3));
         x(7);
         x(5);
         f5;
         f6;
         f7]),2);
     
g1 = simplify([0;0;0;0;-g5/(R*T1);g6/(R*T1);b/(R*T2)]); %tr u1
g2 = simplify([0;0;0;0;-g5/(R*T1);g6/(R*T1);-b/(R*T2)]); %tl u2
% 
% g1(5) = subs(g1(5),(R*(Mb^2*cz^2*cos(x(4))^2 - ((Mb*cz^2 + Iy)*(2*Iwa + Mb*R^2 + 2*Mw*R^2))/R^2)), D_a);
% g1(6) = subs(g1(6),(R*(Mb^2*cz^2*cos(x(4))^2 - ((Mb*cz^2 + Iy)*(2*Iwa + Mb*R^2 + 2*Mw*R^2))/R^2)), D_a);
% g1(7) = subs(g1(7),(R*(sin(x(4))^2*(Mb*cz^2 + Ix - Iz) + (2*Iwa*b^2 + R^2*(2*Mw*b^2 + 2*Iwd + Iz))/R^2)), G_a);
% 
% g2(5) = subs(g2(5),(R*(Mb^2*cz^2*cos(x(4))^2 - ((Mb*cz^2 + Iy)*(2*Iwa + Mb*R^2 + 2*Mw*R^2))/R^2)), D_a);
% g2(6) = subs(g2(6),(R*(Mb^2*cz^2*cos(x(4))^2 - ((Mb*cz^2 + Iy)*(2*Iwa + Mb*R^2 + 2*Mw*R^2))/R^2)), D_a);
% g2(7) = subs(g2(7),(R*(sin(x(4))^2*(Mb*cz^2 + Ix - Iz) + (2*Iwa*b^2 + R^2*(2*Mw*b^2 + 2*Iwd + Iz))/R^2)), G_a);

%mentre
% v1 = (u1+u2)/D_a;
% v2 = (u1-u2)*2*b/G_a

%Il sistema diviene quindi:

% g1 =                                     vpa(simplify(  [0;
%                                                          0;
%                                                          0;
%                                                          0;
%      (2*((2*Iwa + Mb*R^2 + 2*Mw*R^2)/R + Mb*cz*cos(x(4))));
%                    -(2*(Mb*cz^2 + Mb*R*cos(x(4))*cz + Iy));
%                                                        0]),2);
% g2 = [0;0;0;0;0;0;1];

%lo span di g1 g2 ha dimensione 2
%% Cambio l'ingresso e semplifico
% v1 = (u1+u2)*(-2/(R*T1));
% v2 = (u1-u2)*(2/(R*T2));

g1 = [0;0;0;0;g5;g6;0];
g2 = [0;0;0;0;0;0;1];


%% Calcolo il rank della distribuzione

n = 7;

ad_fg1 = vpa(liebracket(f,g1,x,(n-1)),2);
ad_fg2 = vpa(liebracket(f,g2,x,(n-1)),2);

% ad_g1g2 = vpa(liebracket(g1,g2,x,(n-1)),2);

syms g1g2_f m1_f(x1,x2,x3,x4,x5,x6,x7) m2_f(x1,x2,x3,x4,x5,x6,x7) g1_f(x1,x2,x3,x4,x5,x6,x7) g2_f(x1,x2,x3,x4,x5,x6,x7)

m1_f(x1,x2,x3,x4,x5,x6,x7) = ad_fg1;
m2_f(x1,x2,x3,x4,x5,x6,x7) = ad_fg2;
% g1_f(x1,x2,x3,x4,x5,x6,x7) = g1;
% g2_f(x1,x2,x3,x4,x5,x6,x7) = g2;
% g0(x1,x2,x3,x4,x5,x6,x7) = ad_g1g2;
%% 
% x1 = 0;
% x2 = 0;
% x3 = 0;
% x4 = 0;
syms x4
x5 = 0;
% x6 = 0;
x7 = 0;

% G1 = vpa(g1_f(x1,x2,x3,x4,x5,x6,x7),2);
% G2 = vpa(g2_f(x1,x2,x3,x4,x5,x6,x7),2);
M1 = vpa(m1_f(x1,x2,x3,x4,x5,x6,x7),2);
M2 = vpa(m2_f(x1,x2,x3,x4,x5,x6,x7),2);
% G0 = vpa(g0(x1,x2,x3,x4,x5,x6,x7),2);
% 
% G0
DIST = vpa([M2,M1],2);

% Il sistema ha rango 4

%% Osservabilità

n = 7;
x = sym('x', [n 1], 'real'); % state

h = [x(1),0,0,0,0,0,0;
     0,x(2),0,0,0,0,0;
     0,0,x(3),0,0,0,0;
     0,0,0,x(4),0,0,0]

Lf_h1 = vpa(liebracket(f,h(1,:),x,1),2);
Lf_h2 = vpa(liebracket(f,h(2,:),x,1),2);
Lf_h3 = vpa(liebracket(f,h(3,:),x,1),2);
Lf_h4 = vpa(liebracket(f,h(4,:),x,1),2);

Lg1_h1 = vpa(liebracket(g1,h(1,:),x,1),2);
Lg1_h2 = vpa(liebracket(g1,h(2,:),x,1),2);
Lg1_h3 = vpa(liebracket(g1,h(3,:),x,1),2);
Lg1_h4 = vpa(liebracket(g1,h(4,:),x,1),2);

Lg2_h1 = vpa(liebracket(g2,h(1,:),x,1),2);
Lg2_h2 = vpa(liebracket(g2,h(2,:),x,1),2);
Lg2_h3 = vpa(liebracket(g2,h(3,:),x,1),2);
Lg2_h4 = vpa(liebracket(g2,h(4,:),x,1),2);

O = vpa([h(1,:)',h(2,:)',h(3,:)',h(4,:)',Lf_h1(:,2),Lf_h2(:,2),Lf_h3(:,2),Lf_h4(:,2),Lg1_h4(:,2)],2)





