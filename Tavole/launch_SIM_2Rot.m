%Pendolo Classico

close all
clear
clc
addpath('Utils');
addpath('Funzioni_Dinamica');

syms x1 L x2 x3 x4 x5 x6 dx1 dx2 dx3 dx4 dx5 dx6 m_c m_r a R_r I_cubli a real

q = [x1,x2,x3,x4,x5]'; %w1 w2 w3 x y z
dq = [dx1,dx2,dx3,dx4,dx5]';

R = Rx_rad(x1)*Ry_rad(x2)*Rz_rad(x3);

T = [R, R*[0,0,L]';
     0,0,0,1];
 
%gli angoli x1 x2 x3 sono legati all'orientazione della massa mentre gli
%angoli x4 x5 x6 sono il vettore posizione (grazie al cazzo)

%% Jacobian

p = T(1:3,4);

JpCM = simplify([jacobian(p(1),[x1,x2,x3,x4,x5]);
                   jacobian(p(2),[x1,x2,x3,x4,x5]);
                   jacobian(p(3),[x1,x2,x3,x4,x5])]);
               
R = T(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);

TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR3vee = simplify(R'*dR_x3);
TOR4vee = simplify(R'*dR_x4);
TOR5vee = simplify(R'*dR_x5);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];

JoCM = simplify([TOR1,TOR2,TOR3,TOR4,TOR5]);

%% Inerzie

CM1_Telaio = [m_c*(a^2+a^2)/12,0,0;   %TELAIO
              0, m_c*(a^2+a^2)/12,0;
              0, 0, m_c*(a^2+a^2)/12];
          
CM2_Rx = [m_r*R_r^2,0,0;   %Rx
          0, 0,0;
          0, 0,0];
          
CM3_Ry = [0,0,0;   %Ry
          0, m_r*R_r^2,0;
          0, 0,0];
%% Posizione Elementi
%in assi locali
syms L real
G_CM1 = [a/2 a/2 L]';  
SKEW_G_CM1 = S(G_CM1);

G_CM2 = [0 a/2 L]';  
SKEW_G_CM2 = S(G_CM2);

G_CM3 = [a/2 0 L]';  
SKEW_G_CM3 = S(G_CM3);

Jo_X = [JoCM(:,1:3),[1,0;0,0;0,0]];
Jo_Y = [JoCM(:,1:3),[0,0;0,1;0,0]];

%% Energia Rispetto alla terna C

B_CM1 = simplify(m_c*(JoCM')*(SKEW_G_CM1')*SKEW_G_CM1*JoCM + (JoCM')*CM1_Telaio*JoCM);
B_CMRX =  simplify(m_r*(Jo_X')*(SKEW_G_CM2')*SKEW_G_CM2*Jo_X + (Jo_X')*CM2_Rx*Jo_X);
B_CMRY =  simplify(m_r*(Jo_Y')*(SKEW_G_CM3')*SKEW_G_CM3*Jo_Y + (Jo_Y')*CM3_Ry*Jo_Y);

B = B_CM1+B_CMRX+B_CMRY;

%% Coriolis Matrix

C = CoriolisMatrix(B,q,dq);

%% Calcolo U
g = [0,0,-9.81]';
Rcs = Rz_rad(-x3)*Ry_rad(-x2)*Rx_rad(-x1);
g_C = Rcs*g;

U = -g_C'*(m_c*G_CM1+m_r*G_CM2+m_r*G_CM3);

for i = 1:1:size(q,1)
    G(i,1) = diff(U,q(i));
end

%% Q
syms TauX TauY Q real
Tau_attuatori = [0,0,0,TauX,TauY]';
Q(4,1) = TauX;
Q(5,1) = TauY;

%% prove
q = [0,0,0,0,0]';
dq = q;
m_r = 0.3;
m_c = 1;
R_r = 0.05;
L = 0.3;
a = 0.05;

parametri = [m_r,m_c,R_r,L,a]';
parametri_stimati = parametri.*1.01;
B = gen_dinamica_B(q,parametri);
C = gen_dinamica_C(q,dq,parametri);
G = gen_dinamica_G(q,parametri);
Q;

Kp = -950;
Kd = -250;


%% SIM

sim('PID_2Rotori',9)
%%
x3.data = mod(x3.data,2*pi);

figure;
subplot(3,1,1);
plot(x1*180/pi); ylabel('x1');
subplot(3,1,2);
plot(x2*180/pi); ylabel('x2');
subplot(3,1,3);
plot(x3*180/pi); ylabel('x3');

figure;
subplot(3,1,1);
plot(X);ylabel('Coord X');
subplot(3,1,2);
plot(Y);ylabel('Coord Y');
subplot(3,1,3);
plot(Z);ylabel('Coord Z');

