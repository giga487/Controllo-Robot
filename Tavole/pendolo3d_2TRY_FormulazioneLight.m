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

Ax = A1*[Ry_rad(x4),[0,0,0]';
     0,0,0,1];
Ay = A1*[Rx_rad(x5),[0,0,0]';
     0,0,0,1];
Az = A1*[Rz_rad(x6),[0,0,0]';
     0,0,0,1];
 
%% 
p = A1(1:3,4);

JpCM = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                 jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                 jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
             
R = A1(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);
dR_x6 = diff(R,x6);

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

Jo1 = simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR6]);

I_CM = simplify((Jo1')*CM*(Jo1));
               
%% Ruota X
p = Ax(1:3,4);

JpRX = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                 jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                 jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
             
R = Ax(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);
dR_x6 = diff(R,x6);

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

JoX = simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR6]);

I_CMRX = simplify((JoX')*CM3_RotX*(JoX));
%% Ruota Y
p = Ay(1:3,4);

JpRY = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                 jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                 jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
             
R = Ay(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);
dR_x6 = diff(R,x6);

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

JoY = simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR6]);

I_CMRY = simplify((JoY')*CM4_RotY*(JoY));

%% Ruota Z
p = Az(1:3,4);

JpRZ = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                 jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                 jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
             
R = Az(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);
dR_x6 = diff(R,x6);

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

JoZ = simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR6]);

I_CMRZ = simplify((JoZ')*CM5_RotZ*(JoZ));

%%
B = I_CMRZ + I_CMRY + I_CMRZ + I_CM
% in pratica stò studiando il sistema come se le ruote fossero poggiate sul CM
