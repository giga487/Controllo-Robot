% Sistema dinamico pendolo inverso.

clear;
close all;
clc;

addpath('utils');

%% Cinematica

syms x1 x2 x3 L real

 
A01 = [Rx_rad(x1),[0;0;0];
      0,0,0, 1];

A12 = [Ry_rad(x2),[0;0;0];
      0,0,0, 1];
  
A13 = [Rz_rad(x3),[0;0;0];
      0,0,0, 1];

A00 = [eye(3),[0;0;L];
      0,0,0, 1];
  
  
T02 = simplify(A01*A12*A13*A00);

p = T02(1:3,4);
R = T02(1:3,1:3);

JacobianP = simplify([jacobian(p(1),[x1,x2,x3]);
             jacobian(p(2),[x1,x2,x3]);
             jacobian(p(3),[x1,x2,x3])]);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);

TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR3vee = simplify(R'*dR_x3);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];


JacobianO = [TOR1,TOR2,TOR3];

Jacobian = [JacobianP;JacobianO]
