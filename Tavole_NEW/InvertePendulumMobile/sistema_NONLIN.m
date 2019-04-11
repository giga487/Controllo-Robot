
clear
clc
close all

syms g Mw m r l Jw Jtheta Jdelta D x1 x2 x3 x4 x5 x6 Tw Tv real


P = m*l^2 +Jtheta;
Q = 2*Mw + 2*Jw/r^2 + m;
alfa = D^2*(2*Mw + 2*Jw/r^2) + Jdelta;
B = P*Q-(m*l*cos(x5))^2;

f = [ x2;
     -m*(l^2)*sin(2*x5)*x6*x2/(alfa+m*(l^2)*sin(x5));
     x4;
     1/(2*B)*(-(m^2)*g*(l^2)*sin(2*x5)-(m^2)*(l^3)*sin(2*x5)*cos(x5)*x2^2+2*P*m*l*sin(x5)*x6^2);
     x6;
     1/(2*B)*(-(m^2)*(l^2)*sin(2*x5)*(x6)^2+Q*m*(l^2)*sin(2*x5)*(x2)^2+2*Q*m*g*l*sin(x5))];

g1 = [0;
      D/(r*(alfa+m*(l^2)*(sin(x5)^2)));
      0;
      0;
      0;
      0];

g2 = [0;
      0;
      0;
      (P + m*l*r*cos(x5))/(B*r);
      0;
      -(Q*r + m*l*cos(x5))/(B*r)];
  
  
tau = [Tw;Tv];
      


f + g1*Tw + g2*Tv
 
     