%NewModel
clc
clear
close all

syms x y theta psi gammaL gammaR

q = sym('q', [6 1], 'real');

syms mb mw L I1 I2 I3 d R K J b real

A = [-sin(q(3)),cos(q(3)),0,0,0,0;
     cos(q(3)),sin(q(3)),b,0,-R,0;
     cos(q(3)),sin(q(3)),-b,0,0,-R];
 

S1 = [0,cos(q(3)),0;
      0,sin(q(3)),0;
      0,0,1;
      1,0,0;
      0,1/R,b/R;
      0,1/R,-b/R];

M = [mb+2*mw,0,mb*L*cos(q(3))*cos(q(4)),-mb*L*sin(q(3))*sin(q(4)),0,0;
     0,mb+2*mw,mb*L*cos(q(3))*sin(q(4)),mb*L*sin(q(3))*cos(q(4)),0,0;
     mb*L*cos(q(4))*cos(q(3)),mb*L*sin(q(4))*cos(q(3)),I2+mb*L^2,0,0,0;
     -mb*L*sin(q(3))*sin(q(4)),mb*L*sin(q(3))*cos(q(4)),0,I3+1/2*mw*d^2+2*K+(I1-I3)*(sin(q(3)))^2,0,0;
     0,0,0,0,J,0;
     0,0,0,0,0,J]


dS11 = jacobian(S1(1,1),q)*S1(1,1)

     