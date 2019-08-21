
function plot_error_spaceTask(error,time)

    figure;
    hold on;
    grid on;
    subplot(3,1,1);
    plot(time(:),error(:,1));
    title('Error x');
    subplot(3,1,2);
    plot(time(:),error(:,2));
    title('Error y');
    subplot(3,1,3);
    plot(time(:),error(:,3));
    title('Error z');
    hold off;
%     title(sprintf("%s",string_title));
    

end