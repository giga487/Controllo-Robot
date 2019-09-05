%Init

close all
clc
clear
addpath('Utils');
addpath('Utils/traj')

m1 = 1;
m2 = 1;
m3 = 1;
m4 = 3;
m5 = 3;
m_head = 1;
m_mot = 0.25;

L1 = 1;
L2 = 1;
L3 = 1;
L4 = 1;
L5 = 1;
L_head = 1;

param = [L1,L2,L3,L4,L5,L_head,0;
         m1,m2,m3,m4,m5,m_head,m_mot];

param = param';

cond_init = [0, 150/180*pi, pi/3, -pi/2, -3*pi/4,-150/180*pi]';
q_position_f = [45/180*pi, 30*pi/180, 60*pi/180 ,90*pi/180, -45*pi/180, 330*pi/180]';

%%TRAJECTORY
thetad0 = zeros(size(q_position_f,1));
thetadf = zeros(size(q_position_f,1));

tstart = 0;
tfinal = 10;

% find the tfinalcoefficient of the 3rd order polynomial trajectory
[a3,a2,a1,a0] = createTraj3(cond_init,q_position_f,thetad0,thetadf,tstart,tfinal);
% [a3,a2,a1,a0] = createTraj3(theta0,thetaf,thetad0,thetadf,tstart,tfinal);
% make a polynomial

p = [a3,a2,a1,a0];

% Create time vector
t = linspace(tstart,tfinal,100);

[q,dq,ddq] = generatore_traiettorie(p,t);

% plot_trajectory(t,q,dq,ddq);

q_traj.time = t;
q_traj.signals.values = q';
q_traj.signals.dimensions = 6;

dq_traj.time = t;
dq_traj.signals.values = dq';
dq_traj.signals.dimensions = 6;

ddq_traj.time = t;
ddq_traj.signals.values = ddq';
ddq_traj.signals.dimensions = 6;

[p,com_d,head_r_d] = Direct_Kinematics(param,q_position_f);
hand_des = p(6,:)';
