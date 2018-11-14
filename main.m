%% il primo controllo che devo fare il PD

clear;
close all;
clc;

addpath('utils');

%%Manipolatore Antroporfo del libro Robotica, modellistica, pianificazione
%%e controllo.

L1 = 1;
L2 = L1;
L3 = L2;
syms a1 a2 a3 

T = [c(a1)*c(a2+a3), -c(a1)*s(a2+a3), s(a1), c(a1)*(L2*c(a2)+L3*c(a2+a3));
     s(a1)*c(a2+a3), -s(a1)*s(a2+a3), -c(a1), s(a1)*(L2*c(a2)+L3*c(a2+a3));
     s(a2+a3), c(a2+a3), 0 , L2*s(a2)+L3*s(a2+a3);
     0,0,0,1];

%% Calcolo del Jacobiano

J = jacobian(T,[a1,a2,a3]);



