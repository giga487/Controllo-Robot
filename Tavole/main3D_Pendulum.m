close all
clear
clc
addpath('utils');


syms taux tauy m_asta m_telaio m_Rx m_Ry x1 x2 x3 L Ixx1 Iyy1 Izz1 Ixx2 Iyy2 Izz2 Ixx3 Iyy3 Izz3 Ixx4 Iyy4 Izz4 a dx1 dx2 dx3 real

%% Presi da SolidWorks

CM1_Asta = [Ixx1,0,0;   %ASTA
            0, Iyy1,0;
            0, 0, Izz1];
        
CM2_Telaio = [Ixx2,0,0;   %TELAIO
              0, Iyy2,0;
              0, 0, Izz2];
    
CM3_RotX = [Ixx3,0,0;   %ROTOREX
        0, Iyy3,0;
        0, 0, Izz3];   
CM4_RotY = [Ixx4,0,0;   %ROTOREY
            0, Iyy4,0;
            0, 0, Izz4];   

A1 = A1_3D(x1,x2,x3,L); 
A2 = A2_3D(x1,x2,x3,L+a/2);
 
Ax = A2*[eye(3), [0,a/2,0]'; %CM DEL ROTORE 1 IN CM 3
      0,0,0,1];
Ay = A2*[eye(3), [a/2,0,0]'; %CM DEL ROTORE 1 IN CM 3
      0,0,0,1];

%% Calcolo Jacobiano Lineare

%Jacobiano del centro di massa asta        
p = A1(1:3,4);

JpASTA = simplify([jacobian(p(1),[x1,x2,x3]);
                   jacobian(p(2),[x1,x2,x3]);
                   jacobian(p(3),[x1,x2,x3])]);
               
p = A2(1:3,4);              
JpTelaio = simplify([jacobian(p(1),[x1,x2,x3]);
                   jacobian(p(2),[x1,x2,x3]);
                   jacobian(p(3),[x1,x2,x3])]);

p = Ax(1:3,4);              
JpVolanoX = simplify([jacobian(p(1),[x1,x2,x3]);
                      jacobian(p(2),[x1,x2,x3]);
                      jacobian(p(3),[x1,x2,x3])]);

p = Ay(1:3,4);              
JpVolanoY = simplify([jacobian(p(1),[x1,x2,x3]);
                      jacobian(p(2),[x1,x2,x3]);
                      jacobian(p(3),[x1,x2,x3])]);                    

%% Calcolo Jacobiano orientazione Asta
R = A1(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);

TOR1vee = simplify(dR_x1*R');
TOR2vee = simplify(dR_x2*R');
TOR3vee = simplify(dR_x3*R');

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR2vee(2,1)];

Jo1 = simplify([TOR1,TOR2,TOR3])

I_asta = (Jo1')*CM1_Asta*(Jo1)

%% Jo rispetto al cm Telaio
R = A2(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);

TOR1vee = simplify(dR_x1*R');
TOR2vee = simplify(dR_x2*R');
TOR3vee = simplify(dR_x3*R');

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];

Jo2 = simplify([TOR1,TOR2,TOR3])

I_telaio = (Jo2')*CM2_Telaio*(Jo2)

%% Jo rispetto al cm RotX

R = Ax(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);

TOR1vee = simplify(dR_x1*R');
TOR2vee = simplify(dR_x2*R');
TOR3vee = simplify(dR_x3*R');

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR2vee(2,1)];

Jo3 = simplify([TOR1,TOR2,TOR3])

I_Rx = (Jo3')*CM3_RotX*(Jo3);

%% Jo rispetto al cm RotY

R = Ay(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);

TOR1vee = simplify(dR_x1*R');
TOR2vee = simplify(dR_x2*R');
TOR3vee = simplify(dR_x3*R');

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];

Jo4 = simplify([TOR1,TOR2,TOR3])

I_Ry = (Jo4')*CM4_RotY*(Jo4);

%% B
B_asta = simplify(m_asta*(JpASTA')*(JpASTA) + I_asta);
B_telaio = simplify(m_telaio*(JpTelaio')*(JpTelaio) + I_telaio);
B_Rx = simplify(m_Rx*(JpVolanoX')*(JpVolanoX) + I_Rx);
B_Ry = simplify(m_Ry*(JpVolanoY')*(JpVolanoY) + I_Ry);

B = B_asta+B_telaio+B_Rx+B_Ry

%% G
g = [0,0,9.81]';

G = simplify(-(m_asta*(JpASTA')+m_telaio*(JpTelaio')+m_Rx*(JpVolanoX')+m_Ry*(JpVolanoY'))*g)

%% C
% simboli di Cristo

C11 = simplify(0.5*(diff(B(1,1),x1)+diff(B(1,1),x1)-diff(B(1,1),x1))*dx1 + 0.5*(diff(B(1,1),x2)+diff(B(1,2),x1)-diff(B(2,1),x1))*dx2 + 0.5*(diff(B(1,1),x3)+diff(B(1,3),x1)-diff(B(3,1),x1))*dx3);
C12 = simplify(0.5*(diff(B(1,2),x1)+diff(B(1,1),x2)-diff(B(1,2),x1))*dx1 + 0.5*(diff(B(1,2),x2)+diff(B(1,2),x2)-diff(B(2,2),x1))*dx2 + 0.5*(diff(B(1,2),x3)+diff(B(1,3),x2)-diff(B(3,2),x1))*dx3);
C13 = simplify(0.5*(diff(B(1,3),x1)+diff(B(1,1),x3)-diff(B(1,3),x1))*dx1 + 0.5*(diff(B(1,3),x2)+diff(B(1,2),x3)-diff(B(2,3),x1))*dx2 + 0.5*(diff(B(1,3),x3)+diff(B(1,3),x3)-diff(B(3,3),x1))*dx3);
C21 = simplify(0.5*(diff(B(2,1),x1)+diff(B(2,1),x1)-diff(B(1,1),x2))*dx1 + 0.5*(diff(B(2,1),x2)+diff(B(2,2),x1)-diff(B(2,1),x2))*dx2 + 0.5*(diff(B(2,1),x3)+diff(B(2,3),x1)-diff(B(3,1),x2))*dx3);
C22 = simplify(0.5*(diff(B(2,2),x1)+diff(B(2,1),x2)-diff(B(1,2),x2))*dx1 + 0.5*(diff(B(2,2),x2)+diff(B(2,2),x2)-diff(B(2,2),x2))*dx2 + 0.5*(diff(B(2,2),x3)+diff(B(2,3),x2)-diff(B(3,2),x2))*dx3);
C23 = simplify(0.5*(diff(B(2,3),x1)+diff(B(2,1),x3)-diff(B(1,3),x2))*dx1 + 0.5*(diff(B(2,3),x2)+diff(B(2,2),x3)-diff(B(2,3),x2))*dx2 + 0.5*(diff(B(2,3),x3)+diff(B(2,3),x3)-diff(B(3,3),x2))*dx3);
C31 = simplify(0.5*(diff(B(3,1),x1)+diff(B(3,1),x1)-diff(B(1,1),x3))*dx1 + 0.5*(diff(B(3,1),x2)+diff(B(3,2),x1)-diff(B(2,1),x3))*dx2 + 0.5*(diff(B(3,1),x3)+diff(B(3,3),x1)-diff(B(3,1),x3))*dx3);
C32 = simplify(0.5*(diff(B(3,2),x1)+diff(B(3,1),x2)-diff(B(1,2),x3))*dx1 + 0.5*(diff(B(3,2),x2)+diff(B(3,2),x2)-diff(B(2,2),x3))*dx2 + 0.5*(diff(B(3,2),x3)+diff(B(3,3),x2)-diff(B(3,2),x3))*dx3);
C33 = simplify(0.5*(diff(B(3,3),x1)+diff(B(3,1),x3)-diff(B(1,3),x3))*dx1 + 0.5*(diff(B(3,3),x2)+diff(B(3,2),x3)-diff(B(2,3),x3))*dx2 + 0.5*(diff(B(3,3),x3)+diff(B(3,3),x3)-diff(B(3,3),x3))*dx3);

C = [C11,C12,C13;
     C21,C22,C23;
     C31,C32,C33];


%% Q

% Q1 = taux*Ax(1,1:3)'*Jo3(:,1)+tauy*Ay(2,1:3)'*Jo4(:,1);
% Q2 = taux*Ax(1,1:3)'*Jo3(:,2)+tauy*Ay(2,1:3)'*Jo4(:,2);
% Q3 = taux*Ax(1,1:3)'*Jo3(:,3)+tauy*Ay(2,1:3)'*Jo4(:,3);

Q1 = taux*Ax(1:3,1)'*Jo3(:,1)+tauy*Ay(1:3,2)'*Jo4(:,1);
Q2 = taux*Ax(1:3,1)'*Jo3(:,2)+tauy*Ay(1:3,2)'*Jo4(:,2);
Q3 = taux*Ax(1:3,1)'*Jo3(:,3)+tauy*Ay(1:3,2)'*Jo4(:,3);

Q = simplify([Q1;Q2;Q3]);