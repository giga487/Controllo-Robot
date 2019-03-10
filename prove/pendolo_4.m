close all
clear
clc
addpath('utils');

syms c a h t taux tauy tauz m_asta m_telaio m_Rx m_Ry m_Rz R  x1 x2 x3 real

CM1_Asta = [m_asta*(c+h)^2/12,0,0;   %ASTA
            0, m_asta*(a+h)^2/12,0;
            0, 0,0];
        
CM2_Pendolo = [2/5*m_telaio*R^2,0,0;   %ASTA
                 0, m_asta*(a+h)^2/12,0;
                 0, 0,0];

A1 = A1_3D(x1,x2,x3,h/2); 
A2 = A2_3D(x1,x2,x3,h);

p = A1(1:3,4);

JpASTA = simplify([jacobian(p(1),[x1,x2,x3]);
                   jacobian(p(2),[x1,x2,x3]);
                   jacobian(p(3),[x1,x2,x3])]);
