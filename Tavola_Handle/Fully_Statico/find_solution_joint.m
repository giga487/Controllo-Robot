function q_out = find_solution_joint(param,position)

    xd = position(1);
    yd = position(2);
    zd = position(3);
    
    des_com = [xd,yd,zd]';
    
    q_out = zeros(6,1);
    dq = zeros(6,1);
    
    Ts = 0.1;
    Kcom = 1;
    
    angle0_1 = pi/6;
    angle0_2 = 5*pi/6;
    angle0_3 = -3*pi/5;
    angle0_4 = 4*pi/5;
    angle0_5 = pi/10;
    angle0_head = -3*pi/4;
    
    q0 = [angle0_1;angle0_2; angle0_3;angle0_4;angle0_5;angle0_head];

    [p,com,head] = Direct_Kinematics(param,q0);
    q_out = q0;
    
    d = norm(des_com-com);
    
    i = 1;
    while d > 0.02
        
        [p,com,head] = Direct_Kinematics(param,q_out);
        
        d = norm(des_com-com);
        
        J_com = J_com_fun(q_out);
        pinv_J_com = pinv(J_com);

        PJ_c = eye(6) - pinv_J_com*J_com;

        dq = pinv_J_com*Kcom*(des_com-com);

        q_out = [q_out, q_out(:,end) + Ts*dq];  
        
        i = i+1;
        

    end
    
    figure;
    hold on;
    viscircles([xd,yd],0.1,'Color','b');
    
    for i = 1:1:size(q_out,2)

        [p,com,head] = Direct_Kinematics(param,q_out(:,i));
%         pause(0.1);
%         clf
        
        plot(p(1:6,1),p(1:6,2),'o-');grid on; axis equal
        plot([p(3,1) head(1,1)],[p(3,2) head(2,1)],'k');
        viscircles([head(1,1),head(2,1)],0.3);
        viscircles([com(1),com(2)],0.01);
    end
    
    hold off;
end
