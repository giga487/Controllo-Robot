function [p,com,head] = Direct_Kinematics(param,x1,x2,x3,x4,x5,xhead)

a1 = param(1,1);
a2 = param(2,1);
a3 = param(3,1);
a4 = param(4,1);
a5 = param(5,1);
a6 = param(6,1);

m1 = param(1,2);
m2 = param(2,2);
m3 = param(3,2);
m4 = param(4,2);
m5 = param(5,2);
m6 = param(6,2);

angle0_1 = pi/6;
angle0_2 = 5*pi/6;
angle0_3 = -3*pi/5;
angle0_4 = 4*pi/5;
angle0_5 = pi/10;
angle0_head = -3*pi/4;
T1 = matrixDH(a1,0,0,x1+angle0_1);
T2 = matrixDH(a2,0,0,x2+angle0_2);
T3 = matrixDH(a3,0,0,x3+angle0_3);
T4 = matrixDH(a4,0,0,x4+angle0_4);
T5 = matrixDH(a5,0,0,x5+angle0_5);
% T6 = matrixDH(a6,0,0,x6+pi/2);

p0 = [0,0,0]';
p1 = T1(1:3,4);
T = T1*T2;
p2 = T(1:3,4);
T = T*T3;
p3 = T(1:3,4);
T = T*T4;
p4 = T(1:3,4);
T = T*T5;
p5 = T(1:3,4);

p = [p0,p1,p2,p3,p4,p5]';

T3_Head = matrixDH(a6,0,0,xhead+angle0_head);
T_HEAD = T1*T2*T3_Head;
head = T_HEAD(1:3,4);

% Com
C1 = matrixDH(a1/2,0,0,x1+angle0_1);
C2 = matrixDH(a2/2,0,0,x2+angle0_2);
C3 = matrixDH(a3/2,0,0,x3+angle0_3);
C4 = matrixDH(a4/2,0,0,x4+angle0_4);
C5 = matrixDH(a5/2,0,0,x5+angle0_5);

%Head
C_HEAD = matrixDH(a6,0,0,xhead+angle0_head);

c1 = C1(1:2,4);
C_m = C1*C2;
c2 = C_m(1:2,4);
C_m = C_m*C3;
c3 = C_m(1:2,4);
C_m = C_m*C4;
c4 = C_m(1:2,4);
C_m = C_m*C5;
c5 = C_m(1:2,4);

C_m = C1*C2*C_HEAD;
c6 = C_m(1:2,4);

com = (m1*c1 + m2*c2 + m3*c3 + m4*c4 + m5*c5 + m6*c6)...
        / (m1+m2+m3+m4+m5+m6);


end