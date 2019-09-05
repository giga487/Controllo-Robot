%%PID LAUNCH
% DEFINIZIONE DEI PARAMETRI DELLA SIMULAZIONE
init

%% LAW PARAM
Kp = 10000;
Kd = 100;

Legge = [Kp,Kd];

%% SIMULAZIONE

sim('controlloCoppia_handle_statico',tfinal)

%% 
string_title = 'Computed Torque';
close all
q_position_sim = q_sim_CompTorque.signals.values(:,:);
time = q_sim_CompTorque.time;
q_error_sim = error_sim_CompTorque.signals.values(:,:);
% plot_robot_fix(param,q_position_sim',com_d,hand_des,head_r_d,time,string_title);
plot_error(q_error_sim,time); %error in degree

%%
tau = tau_CT.signals.values(:,:);
time = tau_CT.time;

figure;
plot(time,tau)
title('Torque CT');
xlabel('time [s]');
ylabel('\tau [Nm]');
grid on;