%% Simulation
kp = 100;
kd = 10;

Law = [kp, kd];

%%
sim('COMPTORQUE_Amato',10)

%% Simulation Result

q_position_sim = q_out_CompT.signals.values(:,:);
% p_error_sim = p_error.signals.values(:,:);
% tau_sim = tau.signals.values(:,:);
time = q_out_CompT.time(:,:);

% plot_error(p_error_sim,time);
% plot_tau(tau_sim,time);

string_text = 'ComputedTorque';
plot_robot_fix(param,q_position_sim',time,string_text);
