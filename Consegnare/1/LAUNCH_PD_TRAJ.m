%%PID LAUNCH
% DEFINIZIONE DEI PARAMETRI DELLA SIMULAZIONE
init

%% LAW PARAM

Law_param = [300000,300000,300000,300000,300000,300000;
             50,15,50,50,10,1];
         
I = eye(6);
                  
Kp = Law_param(1,:).*I;
Kd = Law_param(2,:).*I;

Legge = [Kp,Kd];

%% SIMULAZIONE

sim('PD_trajectory_Handle',tfinal)

%%

close all
q_position_sim = q_sim_PID.signals.values(:,:);
time = q_sim_PID.time;
q_error_sim = error_sim_PID.signals.values(:,:);

% plot_robot_fix(param,q_position_sim',com_d,hand_des,head_r_d,time,'PID');
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