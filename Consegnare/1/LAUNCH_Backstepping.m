%%PID LAUNCH
% DEFINIZIONE DEI PARAMETRI DELLA SIMULAZIONE

init

%% LAW PARAM
kd = 50; 
L = 2;

Law_param = [kd,kd,kd,kd,kd,kd;
             L,L,L,L,L,L];
         
% SIMULAZIONE

sim('backstepping_handle_statico_last',tfinal)

%% 
string_title = 'Backstepping';
q_position_sim = q_sim_BS.signals.values(:,:);

time = q_sim_BS.time;

q_error_sim = error_sim_BS.signals.values(:,:);
% plot_robot_fix(param,q_position_sim',com_d,hand_des,head_r_d,time,string_title);
plot_error(q_error_sim,time); %error in degree

%%
tau = t_BS.signals.values(:,:);
time = t_BS.time;

figure;
plot(time,tau)
title('Torque BS');
xlabel('time [s]');
ylabel('\tau [Nm]');
grid on;