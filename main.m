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

J1 = jacobian(x,[x1,x2]);
J2 = jacobian(y,[x1,x2]);

J = [J1;J2]

%% 
syms v1 v2 v3 theta1 theta2 theta3 d1 d2 d3 real

T01 = [Rz_rad(theta1),[d1*c(theta1);d1*s(theta1);0];
        0,0,0,1];
T12 = [Rz_rad(theta2),[d2*c(theta2);d2*s(theta2);0];
        0,0,0,1];
T23 = [Rz_rad(theta3),[d3*c(theta3);d3*s(theta3);0];
        0,0,0,1];

T = T01*T12*T23;

p = T(1:3,4);
PSI = T(1:3,1:3);


JacobianP = [jacobian(p(1),[theta1,theta2,theta3]);
             jacobian(p(2),[theta1,theta2,theta3]);
             jacobian(p(3),[theta1,theta2,theta3])];
         
JacobianP = simplify(JacobianP)

dR_theta1 = diff(PSI,theta1);
dR_theta2 = diff(PSI,theta2);
dR_theta3 = diff(PSI,theta3);

TOA1vee = simplify(dR_theta1*PSI');
TOA2vee = simplify(dR_theta2*PSI');
TOA3vee = simplify(dR_theta3*PSI');

TOA1 = [TOA1vee(3,2);TOA1vee(1,3);TOA1vee(2,1)];
TOA2 = [TOA2vee(3,2);TOA2vee(1,3);TOA2vee(2,1)];
TOA3 = [TOA3vee(3,2);TOA3vee(1,3);TOA3vee(2,1)];

% skew Matrix = [0 -wz wy;
%                wz 0 -wx;
%               -wy wx 0;];
%l'operatore vee estrae le velocità angolari e le inserisce in modo
%ordinato all'interno di un vettore w = [wx;wy;wz];

JacobianO = [TOA1,TOA2,TOA3];

Jacobiano = [JacobianP;JacobianO]  % OK si fa così.

%% Esempio Euelero ZYZ
syms phi theta psi real
Rzyz = Rz_rad(phi)*Ry_rad(theta)*Rz_rad(psi);

dR_phi = diff(Rzyz,phi)
dR_theta = diff(Rzyz,theta)
dR_psi = diff(Rzyz,psi)

TOA1vee = simplify(dR_phi*Rzyz');
TOA2vee = simplify(dR_theta*Rzyz');
TOA3vee = simplify(dR_psi*Rzyz');

TOA1 = [TOA1vee(3,2);TOA1vee(1,3);TOA1vee(2,1)];
TOA2 = [TOA2vee(3,2);TOA2vee(1,3);TOA2vee(2,1)];
TOA3 = [TOA3vee(3,2);TOA3vee(1,3);TOA3vee(2,1)];

J = [TOA1,TOA2,TOA3] 

%CI SONO RIUSCITO CAZZO





