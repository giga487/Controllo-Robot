% observability
clc
clear 

x = sym('x', [7 1], 'real'); % state

syms g D_a G_a b1 b2 b3 b4 b5 g5 g6 T1 T2 R b

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

b1 = Mb*cz^2 + Ix - Iz;
b2 = Mb*cz^2 + Iy;
b3 = (Mb*(R^2)+2*(Iwa+Mw*(R^2)))/(R^2);
b4 = ((R^2)*(Iz+2*Iwd+2*(b^2)*Mw)+2*Iwa*(b^2))/(R^2);
b5 = Mb*cz;

g5 = b3*R + b5*cos(x(4));
g6 = b2 + R*b5*cos(x(4));

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
     
g1 = [0;0;0;0;g5;g6;0];
g2 = [0;0;0;0;0;0;1];

% sono x,y,tetha,alfa
h = [x(1);
     x(2);
     x(3);
     x(4)];
 

%% Controllability

ad_fg1 = liebracket(f,g1,x,3);
ad_fg2 = liebracket(f,g2,x,3);

syms adf1(x1,x2,x3,x4,x5,x6,x7) adf2(x1,x2,x3,x4,x5,x6,x7)

adfg1(x1,x2,x3,x4,x5,x6,x7) = ad_fg1;
adfg2(x1,x2,x3,x4,x5,x6,x7) = ad_fg2;

x1 = 0;
x2 = 0;
x5 = 0;
x6 = 0;
x7 = 0;
syms x3 x4 real

M1 = adfg1(x1,x2,x3,x4,x5,x6,x7);
M2 = adfg2(x1,x2,x3,x4,x5,x6,x7);

Delta = vpa([ad_fg1(:,1),ad_fg2(:,1),ad_fg1(:,2),ad_fg2(:,2),ad_fg1(:,3),ad_fg2(:,3),ad_fg1(:,4),ad_fg2(:,4)],2);
Delta2 = vpa(simplify([M1,M2]),2);

dimDelta = rank(Delta2);
disp ([ 'la dim. di Delta4 è:'  num2str(dimDelta)]);

%% Osservabilità

x = sym('x', [7 1], 'real'); % state

ad_fh1 = vpa(liebracket(f,h(1,:),x,1),2);
ad_fh2 = vpa(liebracket(f,h(2,:),x,1),2);
ad_fh3 = vpa(liebracket(f,h(3,:),x,1),2);
ad_fh4 = vpa(liebracket(f,h(4,:),x,1),2);

ad_g1h1 = vpa(liebracket(g1,h(1,:),x,1),2);
ad_g1h2 = vpa(liebracket(g1,h(2,:),x,1),2);
ad_g1h3 = vpa(liebracket(g1,h(3,:),x,1),2);
ad_g1h4 = vpa(liebracket(g1,h(4,:),x,1),2);

ad_g2h1 = vpa(liebracket(g2,h(1,:),x,1),2);
ad_g2h2 = vpa(liebracket(g2,h(2,:),x,1),2);
ad_g2h3 = vpa(liebracket(g2,h(3,:),x,1),2);
ad_g2h4 = vpa(liebracket(g2,h(4,:),x,1),2);

O = [ad_fh1(:,1),ad_fh2(:,1),ad_fh3(:,1),ad_fh4(:,1)]

%% Again obs

% Filtrazione1

O = [h(1);h(2);h(3);h(4)];

Lf_h1 = jacobian(h(1),x)*f;
Lf_h2 = jacobian(h(2),x)*f;
Lf_h3 = jacobian(h(3),x)*f;
Lf_h4 = jacobian(h(4),x)*f;

Lg1_h1 = jacobian(h(1),x)*g1;
Lg1_h2 = jacobian(h(2),x)*g1;
Lg1_h3 = jacobian(h(3),x)*g1;
Lg1_h4 = jacobian(h(4),x)*g1;

Lg2_h1 = jacobian(h(1),x)*g2;
Lg2_h2 = jacobian(h(2),x)*g2;
Lg2_h3 = jacobian(h(3),x)*g2;
Lg2_h4 = jacobian(h(4),x)*g2;

Lf_Lf_h1 = jacobian(Lf_h1,x)*f;
Lf_Lf_h2 = jacobian(Lf_h2,x)*f;
Lf_Lf_h3 = jacobian(Lf_h3,x)*f;
Lf_Lf_h4 = jacobian(Lf_h4,x)*f;

O = [O;
     Lf_h1;Lf_h2;Lf_h3;Lf_h3;
     Lg1_h1;Lg1_h2;Lg1_h3;Lg1_h4;
     Lg2_h1;Lg2_h2;Lg2_h3;Lg2_h4;
     Lf_Lf_h1;Lf_Lf_h2;Lf_Lf_h3;Lf_Lf_h4];
 
dO = vpa(jacobian(O,x),2);

dimDelta = rank(dO);
disp ([ 'la dim. di dO è:'  num2str(dimDelta)]);
