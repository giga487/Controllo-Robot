% observability

clc
clear 

x = sym('x', [7 1], 'real'); % state

syms g D_a G_a b1 b2 b3 b4 b5 g5 g6 T1 T2 R b

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

     
%% Analisi Osservabilità

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

