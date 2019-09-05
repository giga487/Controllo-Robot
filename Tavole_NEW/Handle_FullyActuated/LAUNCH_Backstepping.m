%% Simulation

%L'obiettivo è riuscire a fare muovere il robot dalla posizione zero,
%portarlo in una posizione di place e poi riportarlo in condizione
%iniziale.

lambda = 0.1;
kd = 10;

Law = [lambda, kd];


%%
sim('BACKSTEPPING_Amato',50)


%% Simulation Result

q_position_sim = q_out_backstepping.signals.values(:,:);
% p_error_sim = p_error.signals.values(:,:);
% tau_sim = tau.signals.values(:,:);
time = q_out_backstepping.time(:,:);

% plot_error(p_error_sim,time);
% plot_tau(tau_sim,time);

string_text = 'Backstepping control';
plot_robot_fix(param,q_position_sim',time,string_text);

%% 
close all

end_eff_x = p_EndEff.signals.values(:,1);
end_eff_y = p_EndEff.signals.values(:,2);
com_x = p_COM.signals.values(:,1);
com_y = p_COM.signals.values(:,2);
time = q_out_CompT.time(:,:);

com_t_x = com_t.signals.values(:,1);
com_t_y = com_t.signals.values(:,2);
end_eff_t_x = p_EndEff_t.signals.values(:,1);
end_eff_t_y = p_EndEff_t.signals.values(:,2);

figure;
plot(time,com_x(:)-com_t_x(:));
xlabel('time [s]');
ylabel('error distance [m]');
title('error X, com');
grid on;
figure;
plot(time,com_y(:)-com_t_y(:));
xlabel('time [s]');
ylabel('error distance [m]');
title('error Y, com');
grid on;
figure;
plot(time,end_eff_x-end_eff_t_x);
xlabel('time [s]');
ylabel('error distance [m]');
title('error X, end effector');
grid on;
figure;
plot(time,end_eff_y-end_eff_t_y);
xlabel('time [s]');
ylabel('error distance [m]');
title('error Y, end effector');
grid on;
