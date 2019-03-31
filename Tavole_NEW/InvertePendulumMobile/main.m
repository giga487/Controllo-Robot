
%Dinamica
clear
close all
clc

syms m l r D g Jtheta Jw Jdelta Mw theta dq ddelta real

P = m*l^2 +Jtheta;
Q = 2*Mw + 2*Jw/r^2 + m;
a = D^2*(2*Mw + 2*Jw/r^2) + Jdelta;

B = [a+m*l^2*(sin(theta))^2,0,0;
     0 , Q*r, m*l*r*cos(theta);
     0, m*l*r*cos(theta), P];

C = [-m*l^2*sin(2*theta)*dq,0,0;
      0,0,-m*l*r*sin(theta);
     -0.5*m*(l^2)*sin(2*theta)*ddelta,0,0];
 
G = [0;
     0;
    -m*g*l*sin(theta)];


F = [-D/r,D/r;
      r/2,r/2;
       -1, -1];

