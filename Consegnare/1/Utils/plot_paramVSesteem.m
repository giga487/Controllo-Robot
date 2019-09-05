
function plot_paramVSesteem(param_true,data,time)

data_plot = data.signals.values(:,:);

figure;
hold on;
plot(time, data_plot,'k');
plot(time, ones(size(time,1))*param_true,'b-');
hold off;
legend('esteem parameter','true parameter');
xlabel('time [s]');ylabel('mass [kg]');
title('True vs Esteem parameter');
grid;
end