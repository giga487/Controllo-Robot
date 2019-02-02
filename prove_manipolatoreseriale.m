
clear
clc

syms x1 x2 a1 a2 L1 L2 Kr1 Kr2 IL1 IL2 Im1 Im2 ml1 ml2 m1 m2 ...
     dx1 dx2 g0 real

q = [x1,x2];
dq = [dx1,dx2];

T1 = [Rz_rad(x1),Rz_rad(x1)*[a1,0,0]';
     0,0,0,1];
 
T2 = [Rz_rad(x2),Rz_rad(x2)*[a2,0,0]';
      0,0,0,1];
 
T12 = simplify(T1*T2);

TG1 = [Rz_rad(x1),Rz_rad(x1)*[L1,0,0]';
     0,0,0,1];
 
%% Primo Braccio

pG1 = TG1(1:3,4);
R = TG1(1:3,1:3);

JpG1 = [jacobian(pG1(1),[x1,x2]);
        jacobian(pG1(2),[x1,x2]);
        jacobian(pG1(3),[x1,x2]);];

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];

JoG1 =  [TOR1,TOR2];               
J_G1 = [JpG1;JoG1];

%% Primo motore
T1_m1 = [Rz_rad(Kr1*x1),Rz_rad(Kr1*x1)*[0,0,0]'; 
     0,0,0,1];
%perchè il motore è posizionato sul punto [0,0,0]

pM1 = T1_m1(1:3,4);
R = T1_m1(1:3,1:3);

JpM1 = [jacobian(pM1(1),[x1,x2]);
        jacobian(pM1(2),[x1,x2]);
        jacobian(pM1(3),[x1,x2]);];

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];

JoM1 =  [TOR1,TOR2];               
J_M1 = [JpM1;JoM1];


%% Secondo Braccio

TG2 = [Rz_rad(x2),Rz_rad(x2)*[L2,0,0]';
       0,0,0,1];

tg12 = simplify(T1*TG2); 
%sarebbe la matrice che serve a valutare il centro di massa G2

pG2 = tg12(1:3,4);
JpG2 = [jacobian(pG2(1),[x1,x2]);
        jacobian(pG2(2),[x1,x2]);
        jacobian(pG2(3),[x1,x2]);];

R = tg12(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];

JoG2=  [TOR1,TOR2];               
J_G2 = [JpG2;JoG2];

%% Secondo motore

T2_m2 = [Rz_rad(Kr2*x2),Rz_rad(Kr2*x2)*[0,0,0]'; 
     0,0,0,1];
 
T = T1*T2_m2;

pM2 = T(1:3,4);
R = T(1:3,1:3);

JpM2 = [jacobian(pM2(1),[x1,x2]);
        jacobian(pM2(2),[x1,x2]);
        jacobian(pM2(3),[x1,x2]);];

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];

JoM2 =  [TOR1,TOR2];               
J_M2 = [JpM2;JoM2];

%% 
B = simplify(ml1*(JpG1')*JpG1 + JoG1'*Rz_rad(x1)*IL1*(Rz_rad(x1)')*JoG1+...
    ml2*(JpG2')*JpG2 + JoG2'*Rz_rad(x2)*IL2*(Rz_rad(x2)')*JoG2+...
    m1*(JpM1')*JpM1 + (JoM1')*Rz_rad(x1)*Im1*(Rz_rad(x1)')*JoM1+...
    m2*(JpM2')*JpM2 + (JoM2')*Rz_rad(x2)*Im2*(Rz_rad(x2)')*JoM2)

C = CoriolisMatrix(B,q',dq');

g = [0,-g0,0]';

G = -ml1*(JpG1')*g-m2*(JpM1')*g-ml2*(JpG2')*g-m2*(JpM2')*g;