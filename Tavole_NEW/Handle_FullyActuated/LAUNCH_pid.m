%% Simulation

sim('PID_Amato',10)

%% Simulation Result

q_position_sim = q_out.signals.values(:,:);
p_error_sim = p_error.signals.values(:,:);
tau_sim = tau.signals.values(:,:);
time = q_out.time(:,:);

plot_error(p_error_sim,time);
plot_tau(tau_sim,time);

string_text = 'PD';
plot_robot_fix(param,q_position_sim',time,string_text);
