
clear
clc
close all

% syms g Mw m r l Jw Jtheta Jdelta D Tw Tv real %x1 x2 x3 x4 x5 x6 

x = sym('x', [6 1], 'real'); % state

g = 9.8;
Mw = 0.03;
m = 2;
r = 0.04;
l = 0.1;
Jw = 3.17*10^-5;
Jtheta = 0.003;
Jdelta = 0.002;
D = 0.17;

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

g1 = [0;
      D/(r*(alfa+m*(l^2)*(sin(x(5))^2)));
      0;
      0;
      0;
      0];

g2 = [0;
      0;
      0;
      (P + m*l*r*cos(x(5)))/(B*r);
      0;
      -(Q*r + m*l*cos(x(5)))/(B*r)];
  
  
% tau = [Tw;Tv];


% sys = f + g1*Tw + g2*Tv;

%% Studio controllabilità;

ad_fng1 = liebracket(f,g1,x,6);

%%
ad_fng2 = liebracket(f,g2,x,7);

 
     