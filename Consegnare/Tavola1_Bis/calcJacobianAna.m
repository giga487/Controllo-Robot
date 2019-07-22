

syms q1 q2 q3 q4 q5 q6 real

q = [q1,q2,q3,q4,q5,q6];

[p,com,head] = Direct_Kinematics(param,q);
hand = p(6,:)';
collo = p(4,:)';
collo_start = p(3,:)';
J_com = simplify(jacobian(com,q));
J_hand = simplify(jacobian(hand,q));
J_head = simplify(jacobian(head,q));
J_collo = simplify(jacobian(collo,q));
J_collo_start = simplify(jacobian(collo_start,q));