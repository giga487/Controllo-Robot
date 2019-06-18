
%esempio

clear 
close all
clc

x = sym('x', [4 1], 'real');
syms m g L I k J v a real
syms adf(x1,x2,x3) g_x(x1,x2,x3)

f = [x(2);
     -m*g*L/I*sin(x(1))-k/I*(x(1)-x(3));
     x(4);
     k/J*(x(1)-x(3));];
 
g = [0;0;0;1/J];

ad4fg = liebracket(f,g,x,3)

rank(ad4fg)

phi1 = x(1);

Lf1 = jacobian(phi1,x)*f;
Lf2 = jacobian(Lf1,x)*f;
Lf3 = jacobian(Lf2,x)*f;
Lf4 = jacobian(Lf3,x)*f;
Lf4 = a;

LgLf3 = jacobian(Lf3,x)*g;

alfa = -Lf4/LgLf3;
beta = 1/LgLf3;

u = alfa + beta*v


