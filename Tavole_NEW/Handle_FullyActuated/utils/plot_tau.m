function plot_tau(tau,time)
    
    n = size(tau,2)
    for i = 1:1:n
        tau_plot(i,:) = tau(:,i);
    end
    
    figure;
    subplot(2,3,1)
    plot(time,tau_plot(1,:),'k');
    subplot(2,3,2);
    plot(time,tau_plot(2,:),'k');
    subplot(2,3,3)
    plot(time,tau_plot(3,:),'k');
    subplot(2,3,4);
    plot(time,tau_plot(4,:),'k');
    subplot(2,3,5)
    plot(time,tau_plot(5,:),'k');
    subplot(2,3,6);
    plot(time,tau_plot(6,:),'k');

end