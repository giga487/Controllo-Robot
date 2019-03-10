clear;
clc
close all
addpath('utils')
syms theta(t) beta(t)
% f = cos(theta)+sin(beta)+diff(theta) ;
% f_dot = diff(f,t) % first derivative of wrt t
% f_dot = subs(f_dot,diff(theta(t), t, t),'theta_dot') ;
% f_dot = subs(f_dot,diff(beta(t), t),'beta_dot') 
% 
% syms x1(t) x2(t) x3(t)
% A1 = A1_3D(x1,x2,x3dA1 = subs(dA1,diff(x1(t), t),'dx1');,L/2); 
% dA1 = diff(A1,t);
syms x1 L x2 x3 x4 x5 x6 dx1 dx2 L a real

B = [cos(x1) x2; x1 sin(x1)];

C = CoriolisMatrix(B,[x1;x2],[dx1;dx2]);

