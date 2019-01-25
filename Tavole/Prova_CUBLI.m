%CUBLI
clear
clc 
close all

addpath('utils');

syms x1 L x2 x3 x4 x5 x6 dx1 dx2 dx3 dx4 dx5 dx6 m_c m_r R_r L I_cubli a real

q = [x1,x2,x3,x4,x5,x6]'; %w1 w2 w3 x y z
dq = [dx1,dx2,dx3,dx4,dx5,dx6]';
A1 = A1_3D(x1,x2,x3,0);

R = A1(1:3,1:3);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);

TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR3vee = simplify(R'*dR_x3);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];

Jo = simplify([TOR1,TOR2,TOR3]);

CM1_Telaio = [m_c*(a^2+a^2)/12,0,0;   %TELAIO
              0, m_c*(a^2+a^2)/12,0;
              0, 0, m_c*(a^2+a^2)/12];
          
CM2_Rx = [m_r*R_r^2,0,0;   %Rx
          0, 0,0;
          0, 0,0];
          
CM3_Ry = [0,0,0;   %Rx
          0, m_r*R_r^2,0;
          0, 0,0];
      
CM4_Rz = [0,0,0;   %Rx
          0,0,0;
          0,0,m_r*R_r^2];
          
%%Caratteristiche cubli

Gc = [a/2 a/2 a/2]';
Gx = [0 a/2 a/2]';
Gy = [a/2 0 a/2]';
Gz = [a/2 a/2 0]';

Gc_vee = [0,-a/2,a/2;a/2,0,-a/2;-a/2,a/2,0];
Gx_vee = [0,-a/2,a/2;a/2,0,0;-a/2,0,0];
Gy_vee = [0,-a/2,0;a/2,0,-a/2;0,a/2,0];
Gz_vee = [0,0,a/2;0,0,-a/2;-a/2,a/2,0];

%% 
Jw = [Jo,zeros(3,3)];
Jwx = [Jo,[1,0,0;0,0,0;0,0,0]];
Jwy = [Jo,[0,0,0;0,1,0;0,0,0]];
Jwz = [Jo,[0,0,0;0,0,0;0,0,1]];
w = Jw*dq;
wx = Jwx*dq;
wy = Jwy*dq;
wz = Jwz*dq;

B = m_c*(Jw)'*(Gc_vee')*Gc_vee*Jw + (Jw)'*CM1_Telaio*Jw+...
    m_r*(Jwx)'*(Gx_vee')*Gx_vee*Jwx + (Jwx)'*CM2_Rx*Jwx +...
    m_r*(Jwy)'*(Gy_vee')*Gy_vee*Jwy + (Jwy)'*CM3_Ry*Jwy +...
    m_r*(Jwz)'*(Gz_vee')*Gz_vee*Jwx + (Jwz)'*CM4_Rz*Jwz;

C = CoriolisMatrix(B,q,dq);

%% Calcolo matrice G

g = [0,0,-9.81]';
Rcs = Rz_rad(-x3)*Ry_rad(-x2)*Rx_rad(-x1);
g_C = Rcs*g
%% 
U = -g_C'*(m_c*Gc+m_r*Gx+m_r*Gy+m_r*Gz);

for i = 1:1:size(q,1)
    G(i,1) = diff(U,q(i));
end

G

%% Q
syms Tx Ty Tz
Q = [0,0,0,Tx,Ty,Tz]'
