% pendolo3d_3TRY_SEMPLIFICATO ABBESTIA

%pendolo 2 formulazione breve

close all
clear
clc
addpath('utils');


syms Jx Jy Jz taux tauy tauz m_asta m_telaio m_Rx m_Ry m_Rz R L_asta x1 LCM x2 x3 x4 x5 x6 L a dx1 dx2 dx3 real

%% Presi da SolidWorks

% CM1_Asta = [m_asta*L_asta^2/12,0,0;   %ASTA
%             0, 0,0;
%             0, 0,0];
CM = [Jx,0,0;0,Jy,0;0,0,Jz];
% CONTIENE GIA L'INERZIA SVILUPPATA RISPETTO AL PUNTO 0
% I_sfera = 2/5*m_telaio*0.10^2;
% CM2_Telaio = [I_sfera,0,0;   %TELAIO
%               0, I_sfera,0;
%               0, 0, I_sfera];
    
CM3_RotX = [m_Rx*R^2,0,0;   %ROTOREX
            0, 0,0;
            0, 0, 0];   
        
CM4_RotY = [0,0,0;   %ROTOREY
            0,m_Ry*R^2,0;
            0,0,0];   
CM5_RotZ = [0,0,0;   %ROTOREY
            0,0,0;
            0,0,m_Rz*R^2];   

A1 = A1_3D(x1,x2,x3,LCM); 

%% 
p = A1(1:3,4);

JpCM = simplify([jacobian(p(1),[x1,x2,x3]);
                 jacobian(p(2),[x1,x2,x3]);
                 jacobian(p(3),[x1,x2,x3])]);
             
R = A1(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);


TOR1vee = simplify(dR_x1*R');
TOR2vee = simplify(dR_x2*R');
TOR3vee = simplify(dR_x3*R');


TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];


Jo1 = simplify([TOR1,TOR2,TOR3]);

I_CM = simplify((Jo1')*CM*(Jo1));
