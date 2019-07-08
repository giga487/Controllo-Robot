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
    
    Ts = 0.1;
    K_com = 10;
    K_hand = 10;
    K_head = 0;


    d_com = [];
    d_hand = [];
    d_head = [];
    
    angle0_1 = pi/6;
    angle0_2 = 5*pi/6;
    angle0_3 = -3*pi/5;
    angle0_4 = 4*pi/5;
    angle0_5 = pi/10;
    angle0_head = -3*pi/4;
    
    q0 = [angle0_1;angle0_2; angle0_3;angle0_4;angle0_5;angle0_head];

    [p,com,head_r] = Direct_Kinematics(param,q0);
    q_out = q0;
    
    min_now = zeros(6,1);
    
    p_hand = (p(6,:))';
    i = 0;
   
    % il ciclo continua finchè la distanza è maggiore di 0.2 m
    while (norm(des_com-com) > 0.1 norm(des_hand-p_hand) > 0.5)% ||  norm(des_head-head_r) > 0.8) % && i < 10000
       
        e_com = des_com-com;
        e_hand = des_hand-p_hand;
        e_head = des_head-head_r;   

        J_com = J_com_fun(q_out);
        pinv_J_com = pinv(J_com);

        PJN_com = eye(6) - pinv_J_com*J_com;
        
        J_hand = J_hand_fun(q_out(:,end));
        pinv_J_hand = pinv(J_hand);
        PJN_hand = eye(6) - pinv_J_hand*J_hand;
        
        J_head = J_head_fun(q_out(:,end));
        pinv_J_head = pinv(J_head);
        
        projN_J_com_hand = PJN_com*PJN_hand;

        dq = pinv_J_com*K_com*(e_com);
        dq_hand = PJN_com*pinv_J_hand*K_hand*(e_hand);
        dq_head = projN_J_com_hand*pinv_J_head*K_head*(e_head);
        
%         dq__com_gradiente = K_com*J_com'*e_com;
%         dq_hand_gradiente
        %d_qd = (pinv_J_c*erroc_com) + (I - pinv_J_c*J_c)*J2tilde_pinv*((pd_hand-hand)-J_ha*pinv_J_c*erroc_com);
        
        q_out = [q_out, q_out(:,end) + Ts*(dq+dq_hand+dq_head)];  
        
        %q_out = [q_out, q_out(:,end) + Ts*dq_gradiente];  
        i = i+1;
        
        [p,com,head_r] = Direct_Kinematics(param,q_out(:,end));
        p_hand = (p(6,:))';
    end
    

end
