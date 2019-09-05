%%PID LAUNCH
% DEFINIZIONE DEI PARAMETRI DELLA SIMULAZIONE

init

% plot_configurazione(param,q_position_f,com_d,hand_des,head_r_d);

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

param_true = m5;
plot_paramVSesteem(param_true,param_esteem,time); %error in degree

%%
tau = t_BS_ada.signals.values(:,:);
time = t_BS_ada.time;

figure;
plot(time,tau)
title('Torque BS Adapt');
xlabel('time [s]');
ylabel('\tau [Nm]');
grid on;