%% Simulation

%L'obiettivo è riuscire a fare muovere il robot dalla posizione zero,
%portarlo in una posizione di place e poi riportarlo in condizione
%iniziale.

kp = 20000;
kd = 20;

Law = [kp, kd];


%%
sim('BACKSTEPPING_Amato',50)


%% Simulation Result

q_position_sim = q_out_CompT.signals.values(:,:);
% p_error_sim = p_error.signals.values(:,:);
% tau_sim = tau.signals.values(:,:);
time = q_out_CompT.time(:,:);

% plot_error(p_error_sim,time);
% plot_tau(tau_sim,time);

string_text = 'ComputedTorque';
plot_robot_fix(param,q_position_sim',time,string_text);
