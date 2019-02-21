function q_out = find_solution_joint(param,com_des,head_des,hand_des)

    xd_com = com_des(1);
    yd_com = com_des(2);
    zd_com = com_des(3);
    des_com = [xd_com,yd_com,zd_com]';
    
    xd_head = head_des(1);
    yd_head = head_des(2);
    zd_head = head_des(3);    
    des_head = [xd_head,yd_head,zd_head]';
    
    xd_hand = hand_des(1);
    yd_hand = hand_des(2);
    zd_hand = hand_des(3);    
    des_hand = [xd_hand,yd_hand,zd_hand]';
    
    q_out = zeros(6,1);
    dq = zeros(6,1);
    
    Ts = 0.01;
    Kcom = 1;
    Khand = 0.5;
    
    angle0_1 = pi/6;
    angle0_2 = 5*pi/6;
    angle0_3 = -3*pi/5;
    angle0_4 = 4*pi/5;
    angle0_5 = pi/10;
    angle0_head = -3*pi/4;
    
    q0 = [angle0_1;angle0_2; angle0_3;angle0_4;angle0_5;angle0_head];

    [p,com,head_r] = Direct_Kinematics(param,q0);
    q_out = q0;
    
    p_hand = (p(6,:))';
    
    while norm(des_com-com) > 0.01 || norm(des_hand-p_hand) > 0.01
        
        [p,com,head_r] = Direct_Kinematics(param,q_out(:,end));
        
        J_com = J_com_fun(q_out);
        pinv_J_com = pinv(J_com);

        PJ_c = eye(6) - pinv_J_com*J_com;
        
        J_hand = J_hand_fun(q_out(:,end));
        pinv_J_hand = pinv(J_hand);
               
        e_com = des_com-com;
        p_hand = (p(6,:))';
        e_hand = des_hand-p_hand;
        
        dq = pinv_J_com*Kcom*(e_com) + PJ_c*pinv_J_hand*Khand*(e_hand) + ;
        
        q_out = [q_out, q_out(:,end) + Ts*dq];  
       
        
    end
    
    figure;
    hold on;
    axis([-1 1 -1 4]);
%         
%     for i = 1:1:size(q_out,2)
% 
%         [p,com,head_r] = Direct_Kinematics(param,q_out(:,i));
%                         
%         viscircles([xd,yd],0.1,'Color','b');
%         plot(p(1:6,1),p(1:6,2),'o-');grid on; axis equal
%         plot([p(3,1) head_r(1,1)],[p(3,2) head_r(2,1)],'k');
%         viscircles([head_r(1,1),head_r(2,1)],0.3);
%         viscircles([com(1),com(2)],0.01);
% 
%         
%     end

    
    [p,com,head_r] = Direct_Kinematics(param,q_out(:,end));
    viscircles([xd_hand,yd_hand],0.1,'Color','b');
    viscircles([xd_com,yd_com],0.1,'Color','b');
    plot(p(1:6,1),p(1:6,2),'o-');grid on; axis equal
    plot([p(3,1) head_r(1,1)],[p(3,2) head_r(2,1)],'k');
    viscircles([head_r(1,1),head_r(2,1)],0.3);
    viscircles([com(1),com(2)],0.01);    
    hold off;
end
