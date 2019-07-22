function J_head = J_head_fun(q)

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
q5 = q(5);
q6 = q(6);

J_head =  [ sin(q1 + q2) - cos(q1 + q2 + q6 - pi/4) - cos(q1 - pi/3), sin(q1 + q2) - sin(q1 + q2 + q6 + pi/4), 0, 0, 0, -sin(q1 + q2 + q6 + pi/4);
 cos(q1 + q2 + q6 + pi/4) - cos(q1 + q2) + cos(q1 + pi/6), cos(q1 + q2 + q6 + pi/4) - cos(q1 + q2), 0, 0, 0,  cos(q1 + q2 + q6 + pi/4);
                                                        0,                                       0, 0, 0, 0,                         0];
 

end