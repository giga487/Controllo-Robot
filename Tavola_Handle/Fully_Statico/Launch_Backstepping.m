%%PID LAUNCH
% DEFINIZIONE DEI PARAMETRI DELLA SIMULAZIONE
init

%Config robot
param = [a1,a2,a3,a4,a5,a_head,0;
         m1,m2,m3,m4,m5,m_head,m_mot];

param = param';

% Condizioni iniziali dei giunti del robot
x1 = 30*pi/180;
x2 = 120*pi/180;
x3 = -60*pi/180;
x4 = 90*pi/180;
x5 = 90*pi/180;
x6 = -90*pi/180;
cond_init = [x1,x2,x3,x4,x5,x6]';

%Script

% Costruzione del punto desiderato da raggiungere.
q_position_2 = [x1+pi/3*0.5,x2-pi/3,x3+pi/3*0.5,x4+pi/3*0.5,pi/3,x6]';

% q_position_2 = 1.0e+03 *[1.5097;
%     0.3701;
%    -3.4740;
%    -0.0791;
%    -0.1196;
%    -1.8346];

[p,com_d,head_r_d] = Direct_Kinematics(param,q_position_2);
hand_des = p(6,:)';

%% LAW PARAM
Law_param = [10000,10000,10000,10000,10000,10000;
             1000,1000,1000,1000,950,1000];
         
I = eye(6);
                  
Kp = Law_param(1,:).*I
Kd = Law_param(2,:).*I

Legge = [Kp,Kd];
q_desiderata = q_position_2;


%% TRAJECTORY
thetad0 = zeros(size(q_desiderata,1));
thetadf = zeros(size(q_desiderata,1));

tstart = 0;
tfinal = 0.5;

% find the tfinalcoefficient of the 3rd order polynomial trajectory
[a3,a2,a1,a0] = createTraj3(cond_init,q_desiderata,thetad0,thetadf,tstart,tfinal);
% [a3,a2,a1,a0] = createTraj3(theta0,thetaf,thetad0,thetadf,tstart,tfinal);
% make a polynomial

p = [a3,a2,a1,a0];

% Create time vector
t = linspace(tstart,tfinal,100);

[q,dq,ddq] = generatore_traiettorie(p,t);

plot_trajectory(t,q,dq,ddq);

%%
q_traj.time = t;
q_traj.signals.values = q';
q_traj.signals.dimensions = 6;

dq_traj.time = t;
dq_traj.signals.values = dq';
dq_traj.signals.dimensions = 6;

ddq_traj.time = t;
ddq_traj.signals.values = ddq';
ddq_traj.signals.dimensions = 6;
%% SIMULAZIONE

sim('controlloCoppia_handle_statico',tfinal)

%% 
string_title = 'BackStepping';
close all
q_position_sim = q_sim_backStepping.signals.values(:,:);
time = q_sim_backStepping.time;
q_error_sim = error_sim_backStepping.signals.values(:,:);

plot_robot_fix(param,q_position_sim',com_d,hand_des,head_r_d,time,string_title);
plot_error(q_error_sim,time); %error in degree