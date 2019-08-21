
function plot_error_spaceTask(error,time)

    figure;
    hold on;
    grid on;
    subplot(6,1,1);
    plot(time(:),error(:,1));
    title('Error 1');
    subplot(6,1,2);
    plot(time(:),error(:,2));
    title('Error 2');
    subplot(6,1,3);
    plot(time(:),error(:,3));
    title('Error 3');
    subplot(6,1,4);
    plot(time(:),error(:,4));
    title('Error 4');
    subplot(6,1,5);
    plot(time(:),error(:,5));
    title('Error 5');
    subplot(6,1,6);
    plot(time(:),error(:,6));
    title('Error Hand');
    hold off;
%     title(sprintf("%s",string_title));
    

end