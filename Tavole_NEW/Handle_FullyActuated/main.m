
close all
clc
clear

addpath('utils');

Init

syms q1 q2 q3 q4 q5 q6 real
q = [q1,q2,q3,q4,q5,q6];

[p,com,head] = Direct_Kinematics(param,q);
hand = p(6,:)';

J_com = simplify(jacobian(com,q));
J_hand = simplify(jacobian(hand,q));
J_head = simplify(jacobian(head,q));

%% funzioni per il calcolo del regressore
symDynamic

%% Regressore
compute_regressor