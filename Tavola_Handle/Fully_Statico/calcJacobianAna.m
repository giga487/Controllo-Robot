

syms q1 q2 q3 q4 q5 q6 real

q = [q1,q2,q3,q4,q5,q6];

[p,com,head] = Direct_Kinematics(param,q);

J_com = simplify(jacobian(com,q));
J_p = simplify(jacobian(p(6,:),q));
J_head = simplify(jacobian(head,q));