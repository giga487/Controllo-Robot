% Sistema dinamico pendolo inverso.

clear;
close all;
clc;

addpath('utils');

%% Cinematica

syms x1 x2 x3 L %sono i 3 angoli

 
A01 = [Rx_rad(x1),[0;0;0];
      0,0,0, 1];

A12 = [Ry_rad(x2),[0;0;0];
      0,0,0, 1];
  
A13 = [Rz_rad(x3),[0;0;0];
      0,0,0, 1];

A00 = [eye(3),[0;0;L];
      0,0,0, 1];
  
  
T02 = simplify(A01*A12*A13*A00)

p = T02(1:3,4);
R = T02(1:3,1:3);

%% 
syms x1 x2 x3 L %sono i 3 angoli

 
A01 = [Rx_rad(x1),[0;L*cos(x1);L*sin(x1)];
        0,0,0, 1];
A11 = [Rz_rad(x2),[L*cos(x2);L*sin(x2);0];
      0,0,0, 1];
  
T = A01*A11
