clc
clear
close all
addpath('PID');

Kp = 150;
Kd = 10;
setpoint = 0;

parameter_true(1) = 0.25;
parameter_true(2) = 0.05;
parameter_true(3) = 0.40;
parameter_true(4) = 0.30;
parameter_true(5) = 0.12;

noise1 = 0;

parameter_estimated(1) = 0.25 + noise1;
parameter_estimated(2) = 0.05 + noise1; %ASTA
parameter_estimated(3) = 0.40 + noise1; %m ruota
parameter_estimated(4) = 0.30 + noise1; %m motore
parameter_estimated(5) = 0.12 + noise1; %diametro


