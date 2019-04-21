
clear
clc
close all

% syms g Mw m r l Jw Jtheta Jdelta D Tw Tv real %x1 x2 x3 x4 x5 x6 

x = sym('x', [6 1], 'real'); % state

g = sym(9.8);
Mw = sym(0.03);
m = sym(2);
r = sym(0.04);
l = sym(0.1);
Jw = sym(3.17*10^-5);
Jtheta = sym(0.003);
Jdelta = sym(0.002);
D = sym(0.17);

P = m*l^2 +Jtheta;
Q = 2*Mw + 2*Jw/r^2 + m;
alfa = D^2*(2*Mw + 2*Jw/r^2) + Jdelta;
B = P*Q-(m*l*cos(x(5)))^2;

f = [ x(2);
     -m*(l^2)*sin(2*x(5))*x(6)*x(2)/(alfa+m*(l^2)*sin(x(5)));
     x(4);
     1/(2*B)*(-(m^2)*g*(l^2)*sin(2*x(5))-(m^2)*(l^3)*sin(2*x(5))*cos(x(5))*(x(2))^2+2*P*m*l*sin(x(5))*(x(6))^2);
     x(6);
     1/(2*B)*(-(m^2)*(l^2)*sin(2*x(5))*(x(6))^2+Q*m*(l^2)*sin(2*x(5))*(x(2))^2+2*Q*m*g*l*sin(x(5)))];

f = vpa(f,2); 

g1 = [0;
      D/(r*(alfa+m*(l^2)*(sin(x(5))^2)));
      0;
      0;
      0;
      0];
  
g1 = vpa(g1,2); 

g2 = [0;
      0;
      0;
      (P + m*l*r*cos(x(5)))/(B*r);
      0;
      -(Q*r + m*l*cos(x(5)))/(B*r)];
  
g2 = vpa(g2,2);   
  
% tau = [Tw;Tv];


% sys = f + g1*Tw + g2*Tv;

%% Studio controllabilità;

ad_fng1 = liebracket(f,g1,x,6);

%%
ad_fng2 = liebracket(f,g2,x,6);

 
     