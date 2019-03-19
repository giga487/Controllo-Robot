function plot_robot_fix(param,q_out,time,string_text)       
    
    str = ["1","2","3","4","5","Hand"];

    figure;     
    x_L = -6;
    x_R = 2;
    y_L = 0;
    y_U = 8;
    x_traj = [];
    y_traj = [];
    x_com_traj = [];
    y_com_traj = [];
    
    [r c] = size(q_out(:,:));
    
    for i = 1:1:c-1
        subplot(2,1,1);
        clf;
%         axis([x_L x_R y_L y_U]);
        axis equal;
        hold on;
        [p,com,head_r] = Direct_Kinematics(param,q_out(:,i));
        plot(p(1:6,1),p(1:6,2),'o-');
            
        x_traj(end+1,1) = p(6,1);
        y_traj(end+1,2) = p(6,2);
        x_com_traj(end+1,1) = com(1);
        y_com_traj(end+1,2) = com(2);
        
        for ii = 1:size(p,1)
             text(p(ii,1),p(ii,2)," "+str(ii),'Color','r')
        end
        
        text(0,0.5,"t: "+string(time(i)),'Color','r')
        plot([p(3,1) head_r(1,1)],[p(3,2) head_r(2,1)],'k');
        plot(x_traj(:,1),y_traj(:,2),'k');
        plot(x_com_traj(:,1),y_com_traj(:,2),'r');
        viscircles([head_r(1,1),head_r(2,1)],0.3);
        viscircles([com(1),com(2)],0.01);    
        title(sprintf("%s",string_text));
        
        pause(time(i+1)-time(i));

%         pause(0.0008);

    end

    hold off;
    
    
end