function plot_robot_fix(param,q_out,com_d,hand_d,head_d,time)       
    
    str = ["1","2","3","4","5","Hand","Com_D", "Head_D", "Hand_D"];

    figure;       

    [r c] = size(q_out(:,:));
    for i = 1:1:c-1
        subplot(2,1,1);
        clf;
        axis([-2 2 0 4]);
        hold on;
        [p,com,head_r] = Direct_Kinematics(param,q_out(:,i));
        plot(p(1:6,1),p(1:6,2),'o-');
        
        for ii = 1:size(p,1)
             text(p(ii,1),p(ii,2)," "+str(ii),'Color','r')
        end
        
        plot([p(3,1) head_r(1,1)],[p(3,2) head_r(2,1)],'k');
        viscircles([head_r(1,1),head_r(2,1)],0.3);
        viscircles([com(1),com(2)],0.01);    
        viscircles([hand_d(1),hand_d(2)],0.1,'Color','b');
        text(hand_d(1),hand_d(2)," "+str(9),'Color','r')
        viscircles([com_d(1),com_d(2)],0.1,'Color','b');
        text(com_d(1),com_d(2)," "+str(7),'Color','r')
        viscircles([head_d(1),head_d(2)],0.1,'Color','b');
        text(head_d(1),head_d(2)," "+str(8),'Color','r')

        pause(time(i+1)-time(i));

%         pause(0.001);

    end

    hold off;
    
    
end