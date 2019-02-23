function plot_robot_fix(param,q_out,com_d,hand_d,head_d)       
    
    [p,com,head_r] = Direct_Kinematics(param,q_out(:,end));
    
    figure;
    axis([-1 1 -1 4]);
    hold on;
    viscircles([hand_d(1),hand_d(2)],0.1,'Color','b');
    viscircles([com_d(1),com_d(2)],0.1,'Color','b');
    viscircles([head_d(1),head_d(2)],0.1,'Color','b');
    plot(p(1:6,1),p(1:6,2),'o-');grid on; axis equal
    plot([p(3,1) head_r(1,1)],[p(3,2) head_r(2,1)],'k');
    viscircles([head_r(1,1),head_r(2,1)],0.3);
    viscircles([com(1),com(2)],0.01);    
    hold off;
    
end