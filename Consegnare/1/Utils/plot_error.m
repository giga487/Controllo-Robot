
function plot_error(error,time)

    figure;
    grid on;
    subplot(6,1,1);
    hold on;
    plot(time(:),error(:,1));
    plot(time(:),zeros(size(error,1)),'k');
    hold off;
    ylabel('\epsilon [deg]')
    xlabel('time [s]');
    title('Error 1');
    subplot(6,1,2);
    plot(time(:),error(:,2));
    hold on;
    plot(time(:),zeros(size(error,1)),'k');
        ylabel('\epsilon [deg]')
    xlabel('time [s]');
    hold off;
    title('Error 2');
    subplot(6,1,3);
    plot(time(:),error(:,3));
    hold on;
    plot(time(:),zeros(size(error,1)),'k');
        ylabel('\epsilon [deg]')
    xlabel('time [s]');
    hold off;
    title('Error 3');
    subplot(6,1,4);
    plot(time(:),error(:,4));
    hold on;
    plot(time(:),zeros(size(error,1)),'k');
        ylabel('\epsilon [deg]')
    xlabel('time [s]');
    hold off;
    title('Error 4');
    subplot(6,1,5);
    plot(time(:),error(:,5));
    hold on;
    plot(time(:),zeros(size(error,1)),'k');
        ylabel('\epsilon [deg]')
    xlabel('time [s]');
    hold off;
    title('Error 5');
    subplot(6,1,6);
    plot(time(:),error(:,6));
    hold on;
    plot(time(:),zeros(size(error,1)),'k');
        ylabel('\epsilon [deg]')
    xlabel('time [s]');
    hold off;
    title('Error Hand');
    hold off;
%     title(sprintf("%s",string_title));
    

end