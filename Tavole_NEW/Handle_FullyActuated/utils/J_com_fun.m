function J_com = J_com_fun(q)

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
q5 = q(5);
q6 = q(6);

J_com = [ - (3*sin(q1 + q2 + q3 + q4 + q5))/38 - (7*sin(q1 + q2 + q3))/38 - (10*sin(q1 + q2 + q6))/19 - (3*sin(q1 + q2 + q3 + q4))/19 - (9*sin(q1 + q2))/19 - sin(q1)/2, - (3*sin(q1 + q2 + q3 + q4 + q5))/38 - (7*sin(q1 + q2 + q3))/38 - (10*sin(q1 + q2 + q6))/19 - (3*sin(q1 + q2 + q3 + q4))/19 - (9*sin(q1 + q2))/19, - (3*sin(q1 + q2 + q3 + q4 + q5))/38 - (7*sin(q1 + q2 + q3))/38 - (3*sin(q1 + q2 + q3 + q4))/19, - (3*sin(q1 + q2 + q3 + q4 + q5))/38 - (3*sin(q1 + q2 + q3 + q4))/19, -(3*sin(q1 + q2 + q3 + q4 + q5))/38, -(10*sin(q1 + q2 + q6))/19;
   (7*cos(q1 + q2 + q3))/38 + (10*cos(q1 + q2 + q6))/19 + (3*cos(q1 + q2 + q3 + q4))/19 + (9*cos(q1 + q2))/19 + cos(q1)/2 + (3*cos(q1 + q2 + q3 + q4 + q5))/38,   (7*cos(q1 + q2 + q3))/38 + (10*cos(q1 + q2 + q6))/19 + (3*cos(q1 + q2 + q3 + q4))/19 + (9*cos(q1 + q2))/19 + (3*cos(q1 + q2 + q3 + q4 + q5))/38,   (7*cos(q1 + q2 + q3))/38 + (3*cos(q1 + q2 + q3 + q4))/19 + (3*cos(q1 + q2 + q3 + q4 + q5))/38,   (3*cos(q1 + q2 + q3 + q4))/19 + (3*cos(q1 + q2 + q3 + q4 + q5))/38,  (3*cos(q1 + q2 + q3 + q4 + q5))/38,  (10*cos(q1 + q2 + q6))/19;
                                                                                                                                                             0,                                                                                                                                                 0,                                                                                               0,                                                                    0,                                   0,                          0];
 
end