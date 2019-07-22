function plot_configurazione(param,q,com_d,hand_d ,head_d)

    [p,com,head_r] = Direct_Kinematics(param,q);

    x_L = -2;
    x_R = 2;
    y_L = 0;
    y_U = 4;
    
    str = ["1","2","3","4","5","Hand","Com_D", "Head_D", "Hand_D"];
    
    e_com_norm = norm(com_d-com) 
    e_hand_norm = norm(p(6,:)'-hand_d) 
    e_head_norm = norm(head_r-head_d) 
    
    figure;
    hold on;
    %plot robot
    plot([p(3,1) head_r(1,1)],[p(3,2) head_r(2,1)],'k');
    plot(p(1:6,1),p(1:6,2),'o-');
    viscircles([head_r(1,1),head_r(2,1)],0.3);
    viscircles([com(1),com(2)],0.01); 
    
    %plot punti desiderativiscircles([hand_d(1),hand_d(2)],0.1,'Color','b');
    text(hand_d(1),hand_d(2)," "+str(9),'Color','r')
    viscircles([com_d(1),com_d(2)],0.1,'Color','b');
    text(com_d(1),com_d(2)," "+str(7),'Color','r')
    viscircles([head_d(1),head_d(2)],0.1,'Color','b');
    text(head_d(1),head_d(2)," "+str(8),'Color','r')
    viscircles([hand_d(1),hand_d(2)],0.1,'Color','b');
    text(hand_d(1),hand_d(2)," "+str(9),'Color','r')
    axis([x_L x_R y_L y_U]);
    str_e = sprintf('e_{com} %f',e_com_norm)
    text(x_L,y_L+3," "+str_e,'Color','r')
    str_e = sprintf('e_{hand} %f',e_hand_norm)
    text(x_L,y_L+2.8," "+str_e,'Color','r')
    str_e = sprintf('e_{head} %f',e_head_norm)
    text(x_L,y_L+2.6," "+str_e,'Color','r')
    hold off;
    

end