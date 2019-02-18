function plot_robot_fix(p,com,head,hand)
    
    
    figure;
    hold on;
    plot(p(1:6,1),p(1:6,2),'o-');grid on; axis equal
    plot([p(3,1) head(1,1)],[p(3,2) head(2,1)],'k');
    viscircles([head(1,1),head(2,1)],0.3);
    viscircles([com(1),com(2)],0.01);
    hold off;
end