
%%Parametri del problema
t_c = 0.01;

pulsazione_circolare = 1;
A_circolare_hand = 0.5;
A_circolare_com = 0.1;
% plot
x0 = -2;
y0 = 2;
xL = -5;
xR = 2;
yD = 0;
yU = 4;

% PID parameter

kp = 500;
kd = 50;

Law = [kp, kd];

%Initial Condition

x1 = 30*pi/180;
x2 = 120*pi/180;
x3 = -60*pi/180;
x4 = 90*pi/180;
x5 = 90*pi/180;
x6 = -90*pi/180;

cond_init = [x1,x2,x3,x4,x5,x6]';

%Param

m1 = 1;
m2 = 1;
m3 = 1;
m4 = 3;
m5 = 3;
m_head = 10;
m_mot = 0.25;

a1 = 1;
a2 = 1;
a3 = 1;
a4 = 1;
a5 = 1;
a_head = 1;

%For sim
param = [a1,a2,a3,a4,a5,a_head,0;
         m1,m2,m3,m4,m5,m_head,m_mot];

param = param';

