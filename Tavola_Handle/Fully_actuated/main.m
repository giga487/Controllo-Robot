% main Handle

clc
clear
close all
addpath('Utils');

syms R_ruota x1 x2 x3 x4 x5 x6 a1 a2 a3 a4 a5 a6 I_ruota m_ruota m_asta I_asta ...
     dx1 dx2 dx3 dx4 dx5 dx6 g0 real
 
R_ruota = 0.02;


q = [x1,x2,x3,x4,x5,x6]';
dq = [dx1,dx2,dx3,dx4,dx5,dx6]';
% A1 = matrixDH(0,0,0,x1);
% A2 = matrixDH(a2,0,0,x2);
% A3 = matrixDH(a3,0,0,x3);
% A4 = matrixDH(a4,0,0,x4);
% A5 = matrixDH(a5,0,0,x5);
% A6 = matrixDH(a6,0,0,x6);
% 
% T = simplify(A1*A2*A3*A4*A5*A6);


%% 
p = Direct_Kinematics(pi,pi,0,0,0,0);

figure;
hold on;
plot(p(:,1),p(:,2),'o-');grid on; axis equal
viscircles([p(1,1),p(1,2)],R_ruota);
hold off;
%% 

JacobianCalc

%% Energia
B = simplify(m_ruota*(Jp_ruota')*Jp_ruota + Jo_ruota'*I_ruota*Jo_ruota...
               + m_asta*(Jp_asta1')*Jp_asta1+(Jo_asta1')*I_asta*Jo_asta1+...
               + m_asta*(Jp_asta2')*Jp_asta2+(Jo_asta2')*I_asta*Jo_asta2+...
               + m_asta*(Jp_asta3')*Jp_asta3+(Jo_asta3')*I_asta*Jo_asta3+...
               + m_asta*(Jp_asta4')*Jp_asta4+(Jo_asta4')*I_asta*Jo_asta4+...
               + m_asta*(Jp_asta5')*Jp_asta1+(Jo_asta5')*I_asta*Jo_asta5);
               
%% C

C = CoriolisMatrix(B,q,dq);
%% G
g = [0,-g0,0]';
G = -(m_ruota*(Jp_ruota')*g+m_asta*(Jp_asta1)'*g+m_asta*(Jp_asta2)'*g + m_asta*(Jp_asta3)'*g...
    + m_asta*(Jp_asta4)'*g + m_asta*(Jp_asta5)'*g);


