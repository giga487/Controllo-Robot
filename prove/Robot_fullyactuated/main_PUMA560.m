%%Puma 560 

clc
clear
close all
addpath('C:\Users\giga4\OneDrive\Documenti\Git\Controllo-Robot\Tavole')
addpath('C:\Users\giga4\OneDrive\Documenti\Git\Controllo-Robot\Tavole\Utils');

% esempio slide 04 pag 22 Gabiccini
% syms a1 theta1 a2 theta2 a3 theta3
% T = simplify(matrixDH(a1,0,0,theta1)*matrixDH(a2,0,0,theta2)*matrixDH(a3,0,0,theta3))

syms theta1 theta2 theta3 theta4 theta5 theta6 a2 a3 d2 d4 d3 d6 alfa1 alfa3 alfa4 alfa5 real

T01 = matrixDH(0,sym(pi/2),0,theta1);
T12 = matrixDH(a2,0,0,theta2);
T23 = matrixDH(0,sym(pi/2),-d3,theta3);
T34 = matrixDH(0,-sym(pi/2),d4,theta4);
T45 = matrixDH(0,sym(pi/2),0,theta5);
T56 = matrixDH(0,0,d6,theta6);

T = T01*T12*T23*T34*T45*T56;

[R,p] = Kinematic(theta1,theta2,theta3,theta4,theta5,theta6);

%% JacobianP

JacobianP = simplify([jacobian(p(1),[ theta1 theta2 theta3 theta4 theta5 theta6]);
             jacobian(p(2),[ theta1 theta2 theta3 theta4 theta5 theta6]);
             jacobian(p(3),[ theta1 theta2 theta3 theta4 theta5 theta6])]);
         
%% JacobianO
dR_x1 = diff(R,theta1);
dR_x2 = diff(R,theta2);
dR_x3 = diff(R,theta3);
dR_x4 = diff(R,theta4);
dR_x5 = diff(R,theta5);
dR_x6 = diff(R,theta6);

TOR1vee = simplify(dR_x1*R');
TOR2vee = simplify(dR_x2*R');
TOR3vee = simplify(dR_x3*R');
TOR4vee = simplify(dR_x4*R');
TOR5vee = simplify(dR_x5*R');
TOR6vee = simplify(dR_x6*R');

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR6 = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

JacobianO = [TOR1,TOR2,TOR3,TOR4,TOR5,TOR6];

%% 
