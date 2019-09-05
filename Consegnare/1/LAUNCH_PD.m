%%PID LAUNCH
% DEFINIZIONE DEI PARAMETRI DELLA SIMULAZIONE
init

%% LAW PARAM

Kp = 100;
Kd = 10;

Legge = [Kp Kd];

%% SIMULAZIONE

sim('pid_handle_statico',tfinal)

%% 

q_position_sim = q_sim_PID.signals.values(:,:);
time = q_sim_PID.time;
q_error_sim = error_sim_PID.signals.values(:,:);

% plot_robot_fix(param,q_position_sim',com_d,hand_des,head_r_d,time,'PD');
plot_error(q_error_sim,time);

%%
tau = tau_PD.signals.values(:,:);
time = tau_PD.time;

figure;
plot(time,tau)
title('Torque PD');
xlabel('time [s]');
ylabel('\tau [Nm]');
grid on;