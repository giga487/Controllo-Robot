%%PID LAUNCH
% DEFINIZIONE DEI PARAMETRI DELLA SIMULAZIONE
close all
init

%Config robot
param = [a1,a2,a3,a4,a5,a_head,0;
         m1,m2,m3,m4,m5,m_head,m_mot];

parameter = param';

True_parameter = param';

% Costruzione del punto desiderato da raggiungere.

cond_init = [0, 150/180*pi, pi/3, -pi/2, -3*pi/4,-150/180*pi]';
q_position_2 = [45/180*pi, 30*pi/180, 60*pi/180 ,90*pi/180, -45*pi/180, 330*pi/180]';

[p,com_d,head_r_d] = Direct_Kinematics(parameter,q_position_2);
hand_des = p(6,:)';

plot_configurazione(parameter,cond_init,com_d,hand_des,head_r_d);
% plot_configurazione(param,q_position_2,com_d,hand_des,head_r_d);
q_desiderata = q_position_2;

%% TRAJECTORY
thetad0 = zeros(size(q_desiderata,1));
thetadf = zeros(size(q_desiderata,1));

tstart = 0;
tfinal = 10;

% find the tfinalcoefficient of the 3rd order polynomial trajectory
[a3,a2,a1,a0] = createTraj3(cond_init,q_desiderata,thetad0,thetadf,tstart,tfinal);
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

%% LAW PARAM

kp = 100; 
kd = 15;
kr = 15;

pi_0 = 1;

Law_param = [kp,kp,kp,kp,kp,kp;
             kd,kd,kd,kd,kd,kd;
             kr,kr,kr,kr,kr,kr];

% pi_vec = parameter(1:6,2);
% Law_param = [K_lambda, K_d, K_r];

%% SIMULAZIONE
% 
sim('BS_Adaptive',tfinal)

%% 
close all

string_title = 'Backstepping Adaptative';
q_position_sim = q_sim_BS_ada.signals.values(:,:);

time = q_sim_BS_ada.time;

q_error_sim = error_sim_BS_ada.signals.values(:,:);
% plot_robot_fix(param,q_position_sim',com_d,hand_des,head_r_d,time,string_title);
plot_error(q_error_sim,time); %error in degree



