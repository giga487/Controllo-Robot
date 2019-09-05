
function plot_trajectory(t,q,dq,ddq)
    
    for i = 1:1:size(q,1)
        figure;
        hold on;
        plot(t,q(i,:),'k');
        plot(t,dq(i,:),'r');
        plot(t,ddq(i,:),'b');
        xlabel('time [s]');
        title(sprintf('q_%i',i));
        legend('q_d [rad]','dq_d [rad/s]','ddq_d [rad/s^2]');
        hold off;
        grid on;
    end
    
    
end