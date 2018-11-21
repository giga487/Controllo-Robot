%% il primo controllo che devo fare il PD

clear;
close all;
clc;

addpath('utils');
%% Esempio RR planare 2. Scemissimo.
syms x1 x2 x3 L1 L2 L3

A01 = [Rz_rad(x1),[L1*cos(x1);L1*sin(x1);0];
      0,0,0, 1];

A12 = [Rz_rad(x2),[L2*cos(x2);L2*sin(x2);0];
      0,0,0, 1];
  
T02 = A01*A12;

x = T02(1,4);
y = T02(2,4);

J1 = jacobian(x,[x1,x2])
J2 = jacobian(y,[x1,x2])

J = [J1;J2]

%% SLIDE 38 di 101 05 Gabiccini

syms theta psi phi

A01 = Rz_rad(theta);
A02 = Rx_rad(psi);
A03 = Rz_rad(phi);

T = A01*A02*A03

J1 =  jacobian(T(1,:),[theta,psi,phi])
J2 =  jacobian(T(2,:),[theta,psi,phi])





