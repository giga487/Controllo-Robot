%% Simulation

%L'obiettivo è riuscire a fare muovere il robot dalla posizione zero,
%portarlo in una posizione di place e poi riportarlo in condizione
%iniziale.

K_lambda = 0.7;
K_d = 15;
K_r = 500;

pi_vec = [8;1];

Law = [K_lambda, K_d, K_r];


%%
sim('BACKSTEPPING_Amato_Adattivo2',50)


%% Simulation Result

q_position_sim = q_out_Backstepping_Ada.signals.values(:,:);
% p_error_sim = p_error.signals.values(:,:);
% tau_sim = tau.signals.values(:,:);
time = q_out_Backstepping_Ada.time(:,:);

% plot_error(p_error_sim,time);
% plot_tau(tau_sim,time);

string_text = 'Back Stepping Adaptative';
plot_robot_fix(param,q_position_sim',time,string_text);
