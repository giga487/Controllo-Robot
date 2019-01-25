%PENDOLO 
close all
clear
clc
addpath('utils');

syms h t taux tauy tauz m_asta m_telaio m_Rx m_Ry m_Rz R L_asta x1 L x2 x3 x4 x5 x6 g L a real

CM1_Asta = [m_asta*h^2/12,0,0;   %ASTA
            0, 0,0;
            0, 0,0];
        
I_sfera = 2/5*m_telaio*0.10^2;
CM2_Telaio = [I_sfera,0,0;   %TELAIO
              0, I_sfera,0;
              0, 0, I_sfera];
          
          
A1 = A1_3D(x1,x2,x3,0)'
A2 = A2_3D(x1,x2,x3,0)'
