function q_out = find_solution_joint(param,position)

    xd = position(1);
    yd = position(2);
    zd = position(3);
    
    des_com = [xd,yd,zd]';
    
    q_out = zeros(6,1);
    dq = zeros(6,1);
    
    Ts = 0.1;
    Kcom = 0.1;
    
    q0 = [0;0; 0; 0;0; 0];

    [p,com,head] = Direct_Kinematics(param,q0);
    
while norm(des_com-com) > 0.02
    
    [p,com,head] = Direct_Kinematics(param,q_out);
    
    J_com = J_com_fun(q_out);
    pinv_J_com = pinv(J_com);
    
    PJ_c = eye(6) - pinv_J_com*J_com;
    
    dq = pinv_J_com*Kcom*(des_com-com)
    
    q_out = [q_out, q_out(:,end) + Ts*dq];    

end