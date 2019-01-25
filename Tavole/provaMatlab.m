% prova
clc
clear 
close all

syms Jzz_1 Jzz_2 m1 m2 L1 L2 a1 q2 q1 dq1 dq2 h real
B11 = Jzz_1+Jzz_2 + m1*(L1)^2+m2*(a1^2+L2^2+2*a1*L2*cos(q2));
B12 = Jzz_2+m2*L2*(L2+a1*cos(q2));
B21 = B12;
B22 = Jzz_2+m2*L2^2;

B = [B11,B12;B21,B22];

C = CoriolisMatrix(B,[q1;q2],[dq1;dq2])

C = subs(C,a1*m2*L2*sin(q2),h)