
%Dinamica
clear
close all
clc

syms delta x theta dd_delta dd_x dd_theta d_theta d_x d_delta tau1 tau2 real

tau = [tau1,tau2]';
d_z = [d_delta,d_x,d_theta]';
dd_z = [dd_delta,dd_x,dd_theta]';

g = 9.8;
Mw = 0.03;
m = 2;
r = 0.04;
l = 0.1;
Jw = 3.17*10^-5;
Jtheta = 0.003;
Jdelta = 0.002;
D = 0.17;

P = m*l^2 +Jtheta;
Q = 2*Mw + 2*Jw/r^2 + m;
a = D^2*(2*Mw + 2*Jw/r^2) + Jdelta;
Beta = P*Q-(m*l*cos(theta))^2;


B = ([a+m*l^2*(sin(theta))^2,0,0;
     0 , Q*r, m*l*r*cos(theta);
     0, m*l*r*cos(theta), P]);

C = ([-m*l^2*sin(2*theta)*d_theta,0,0;
      0,0,-m*l*r*sin(theta)*d_theta;
     -0.5*m*(l^2)*sin(2*theta)*d_delta,0,0]);
 
G = [0;
     0;
    -m*g*l*sin(theta)];


F = [-D/r,D/r;
      r/2,r/2;
       -1, -1];

%lo spazio degli stati è
% q = [delta,d_delta,xv,d_xv,theta,d_theta]';

tw = tau2 - tau1; %velocità di rotazione
tv = tau2 + tau1; %velocità di avanzamento

u = [tw,tv]';

f_x1 = -(m*(l^2)*sin(2*theta)*d_theta*d_delta)/(a + m*(l^2)*(sin(theta))^2);
g1 = D/(r*(a+m*(l^2)*(sin(theta)^2)));
f_x2 = 1/(2*Beta)*(-((m*l)^2)*g*sin(2*theta)-(m^2)*(l^3)*sin(2*theta)*cos(theta)*(d_delta)^2+2*P*m*l*sin(theta)*d_theta^2);
g2 = (P + m*l*r*cos(theta))/(Beta*r);
f_x3 = 1/(2*Beta)*(-((m*l)^2)*sin(2*theta)*d_theta^2 + Q*m*(l^2)*sin(2*theta)*d_delta^2 + 2*Q*m*g*l*sin(theta));
g3 = -(Q*r + m*l*cos(theta))/(Beta*r);

sys = [f_x1;f_x2;f_x3]+[g1,0;0,g2;0,g3]*u;





