function plot_robot_fix_pickPlace(param,q_out,pos0,posF)       
    
    str = ["1","2","3","4","5","pos0","posF"];

    
    figure;       

    [r c] = size(q_out(:,:));
    for i = 1:1:ca1
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
        viscircles([pos0(1),pos0(2)],0.1,'Color','b');
        text(pos0(1),pos0(2)," "+str(9),'Color','r')
        viscircles([posF(1),posF(2)],0.1,'Color','b');
        text(posF(1),posF(2)," "+str(7),'Color','r')
        pause(0.01);
    end

    hold off;
    
    
end