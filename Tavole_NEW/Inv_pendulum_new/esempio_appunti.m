
%esempio

clear 
close all
clc

x = sym('x', [3 1], 'real');

syms adf(x1,x2,x3) g_x(x1,x2,x3)

f = [x(3)*(1+x(2));
     x(1);
     x(2)*(1+x(1))];
g = [0;1+x(2);-x(3)];

g_x(x1,x2,x3) = g;
g_x0 = g_x(0,0,0);

adf2g = liebracket(f,g,x,2); %span generico 
adf(x1,x2,x3) = adf2g;

adf_0 = adf(0,0,0); %span in x0

last = jacobian(g,x)*adf2g(:,2)-jacobian(adf2g(:,2),x)*g;
matrix = [g,adf2g(:,2),last]
rank(matrix)

%devo controllare il rank della matrice g adfg [g,adfg] che deve essere
%uguale al rank di span(f,g)





