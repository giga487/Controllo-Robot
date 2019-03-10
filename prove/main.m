close all
clear
clc
addpath('utils');

             
%% Jacobiano
syms tau g ddx1 ddx2 dx1 dx2 x1 x2 L  Ixx1 Iyy1 Izz1  Ixx2 Iyy2 Izz2  Ixx3 Iyy3 Izz3 m_1 m_3 m_2 real

T_1 = T1(x1) %Rispetto a G1
T_3 = T3(x1) %Rispetto alla massa motore
T_2 = T2(x1,x2) %Rispetto al rotore, collegato al motore.

%% Presi da SolidWorks

CM1_I = [Ixx1,0,0;   
        0, Iyy1,0;
        0, 0, Izz1];
CM2_I = [Ixx2,0,0;   
        0, Iyy2,0;
        0, 0, Izz2];
CM3_I = [Ixx3,0,0;   
        0, Iyy3,0;
        0, 0, Izz3];   


%% Calcolo Jacobiano Lineare

%Jacobiano del centro di massa asta        
p = T_1(1:3,4);

Jp1 = simplify([jacobian(p(1),[x1,x2]);
                jacobian(p(2),[x1,x2]);
                jacobian(p(3),[x1,x2])]);
            
%Jacobiano del centro di massa motore           
p = T_3(1:3,4);           
Jp3 = simplify([jacobian(p(1),[x1,x2]);
                jacobian(p(2),[x1,x2]);
                jacobian(p(3),[x1,x2])]);
            
%Jacobiano del centro di massa rotore     
p = T_2(1:3,4);      

Jp2 = simplify([jacobian(p(1),[x1,x2]);
                jacobian(p(2),[x1,x2]);
                jacobian(p(3),[x1,x2])]);
            
%% Jo rispetto al cm asta
R = T_1(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);

TOR1vee = simplify(dR_x1*R');
TOR2vee = simplify(dR_x2*R');

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];

Jo1 = [TOR1,TOR2];

I_0_asta = (Jo1')*CM1_I*(Jo1);

%% Jo rispetto al cm motore
R = T_3(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);

TOR1vee = simplify(dR_x1*R');
TOR2vee = simplify(dR_x2*R');

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];

Jo3 = [TOR1,TOR2];
I_0_motore = (Jo3')*CM3_I*(Jo3);

%% Jo rispetto al cm rotore
R = T_2(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);

TOR1vee = simplify(dR_x1*R');
TOR2vee = simplify(dR_x2*R');

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];

Jo2 = [TOR1,TOR2];

I_0_rotore = (Jo2')*CM2_I*(Jo2);

%% CALCOLO B
Bp1 = simplify(m_1*Jp1'*Jp1);
Bp3 = simplify(m_3*Jp3'*Jp3);
Bp2 = simplify(m_2*Jp2'*Jp2);
Bo1 = I_0_asta;
Bo2 = I_0_rotore;
Bo3 = I_0_motore;

B = Bp1+Bp2+Bp3+Bo1+Bo2+Bo3

%% Calcolo C
%Simbolo di Christoffel

C11 = 0.5*((diff(B(1,1),x1)+diff(B(1,1),x1)-diff(B(1,1),x1))*dx1 + (diff(B(1,1),x2)+diff(B(1,2),x1)-diff(B(1,2),x1))*dx2);
C12 = 0.5*((diff(B(1,2),x1)+diff(B(1,1),x2)-diff(B(2,1),x1))*dx1 + (diff(B(1,1),x2)+diff(B(1,2),x2)-diff(B(2,2),x1))*dx2);
C21 = 0.5*((diff(B(2,1),x1)+diff(B(2,1),x1)-diff(B(1,1),x2))*dx1 + (diff(B(2,1),x2)+diff(B(1,2),x1)-diff(B(2,2),x2))*dx2);
C22 = 0.5*((diff(B(2,2),x1)+diff(B(2,1),x2)-diff(B(2,1),x2))*dx1 + (diff(B(2,2),x2)+diff(B(2,2),x2)-diff(B(2,2),x2))*dx2);

C = [C11,C12;
     C21,C22]
 
 %% Calcolo G
 
 g_0 = [0,-g,0]';
 
 G = simplify(-(m_1*Jp1'*g_0 + m_2*Jp2'*g_0 + m_3*Jp3'*g_0))
 
