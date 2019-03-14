function plot_error(error,time)
    
    ex = error(:,1);
    ey = error(:,2);
    
    figure;
    subplot(2,1,1)
    plot(time,ex,'k');
    title('Error x');
    subplot(2,1,2);
    plot(time,ey,'k');
    title('Error y');

end