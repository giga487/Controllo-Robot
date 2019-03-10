close all
clear
clc
addpath('utils');

syms t taux tauy tauz m_asta m_telaio m_Rx m_Ry m_Rz R L_asta x1 L x2 x3 x4 x5 x6 g L a real

% m_asta = 0.05;
% m_telaio = 0.50;
% m_Rx = 0.50;
% m_Rz = m_Rx;
% m_Ry = m_Rx;
% R = 0.10;
% L_asta = 0.15;
% L = 2*L_asta;
%% Presi da SolidWorks

CM1_Asta = [m_asta*L_asta^2/12,0,0;   %ASTA
            0, 0,0;
            0, 0,0];
        
I_sfera = 2/5*m_telaio*0.10^2;
CM2_Telaio = [I_sfera,0,0;   %TELAIO
              0, I_sfera,0;
              0, 0, I_sfera];
    
CM3_RotX = [m_Rx*R^2,0,0;   %ROTOREX
            0, 0,0;
            0, 0, 0];   
        
CM4_RotY = [0,0,0;   %ROTOREY
            0,m_Ry*R^2,0;
            0,0,0];   
        
CM5_RotZ = [0,0,0;   %ROTOREY
            0,0,0;
            0,0,m_Rz*R^2];   

A1 = A1_3D(x1,x2,x3,L/2); 
A2 = A2_3D(x1,x2,x3,L);
Ax = A2*[Ry_rad(x4),[0,0,0]';
     0,0,0,1];
Ay = A2*[Rx_rad(x5),[0,0,0]';
     0,0,0,1];
Az = A2*[Rz_rad(x6),[0,0,0]';
     0,0,0,1];
 
%% Calcolo Jacobiano Lineare
%Jacobiano del centro di massa asta        
p = A1(1:3,4);

JpASTA = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                   jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                   jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
               
p = A2(1:3,4);              
JpTelaio = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                     jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                     jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);

p =  Ay(1:3,4);
JpRY= simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
            
p =  Ax(1:3,4);
JpRX= simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
p =  Ay(1:3,4);
JpRY= simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
p =  Az(1:3,4);
JpRZ= simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
%% Jo1 Rispetto all'asta
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

I_asta = (Jo1')*CM1_Asta*(Jo1);

%% Jo2 Rispetto al telaio
R = A2(1:3,1:3);

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

Jo2 = simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR6]);

I_telaio = (Jo2')*CM2_Telaio*(Jo2);

%% Jo3 Rispetto al rotore Rx

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

Jo3 = simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR6]);

I_Rx = (Jo3')*CM3_RotX*(Jo3);

%% Jo5 Rispetto al rotore Rx

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

Jo4 = simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR6]);

I_Ry = (Jo4')*CM4_RotY*(Jo4);

%% Jo6 Rispetto al rotore Rx

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

Jo5 = simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR6]);

I_Rz = (Jo5')*CM5_RotZ*(Jo5);

%% B

B_asta = simplify(m_asta*(JpASTA)'*JpASTA + I_asta);
B_telaio =  simplify(m_telaio*(JpTelaio)'*JpTelaio + I_telaio);
B_Rx = simplify(m_Rx*(JpRX)'*JpRX + I_Rx);
B_Ry = simplify(m_Ry*(JpRY)'*JpRY + I_Ry);
B_Rz = simplify(m_Rz*(JpRZ)'*JpRZ + I_Rz);

B = simplify(B_asta+B_telaio+B_Rx+B_Ry+B_Rz);

% B11 = B(1,1);B12 = B(1,2);B13 = B(1,3);B14 = B(1,4);B15 = B(1,5);B16 = B(1,6);
% B21 = B(2,1);B22 = B(2,2);B23 = B(2,3);B24 = B(2,4);B25 = B(2,5);B26 = B(2,6);
% B31 = B(3,1);B32 = B(3,2);B33 = B(3,3);B34 = B(3,4);B35 = B(3,5);B36 = B(3,6);
% B41 = B(4,1);B42 = B(4,2);B43 = B(4,3);B44 = B(4,4);B45 = B(4,5);B46 = B(4,6);
% B51 = B(5,1);B52 = B(5,2);B53 = B(5,3);B14 = B(5,4);B55 = B(5,5);B16 = B(5,6);
% B61 = B(6,1);B62 = B(6,2);B63 = B(6,3);B64 = B(6,4);B65 = B(6,5);B66 = B(6,6);


%% C
syms dx1 dx2 dx3 dx4 dx5 dx6 real
q = [x1,x2,x3,x4,x5,x6];
dq = [dx1,dx2,dx3,dx4,dx5,dx6];
C = CoriolisMatrix(B,q',dq');

%% G
g = [0,0,-9.81]';
G = simplify(-JpASTA'*m_asta*g-JpTelaio'*m_telaio*g-JpRY'*m_Ry*g-JpRX'*m_Rx*g-JpRZ'*m_Rz*g)

%% TAU

syms Tx Ty Tz real

Q(1:3) = 0;
Q(4) = simplify(Tx*Ax(1:3,1:3)'*Jo3(:,3));
Q(5) = simplify(Ty*Jo4(:,4)');
Q(6) = simplify(Tz*Jo5(:,5)');


