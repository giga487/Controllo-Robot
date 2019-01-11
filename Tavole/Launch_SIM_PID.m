clc
clear
close all
addpath('PID');

Kp = -50;
Kd = -200;
setpoint = 0;

parameter_true(1) = 0.45; %Lunghezza asta
parameter_true(2) = 0.05; %ASTA
parameter_true(3) = 0.40; %m ruota
parameter_true(4) = 0.30; %m motore
parameter_true(5) = 0.12; %diametro

noise1 = 0.1;

parameter_estimated = parameter_true + noise1;


sim('PD',15)

plot_for_invertedPendulumWheel;
