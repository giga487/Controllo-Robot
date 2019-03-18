function J_com = J_com_fun(q)

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
q5 = q(5);
q6 = q(6);

J_com =  [ - (3*sin(q1 + q2 + q3 + q4 + q5))/20 - (7*sin(q1 + q2 + q3))/20 - sin(q1 + q2 + q6)/10 - (3*sin(q1 + q2 + q3 + q4))/10 - (9*sin(q1 + q2))/20 - sin(q1)/2, - (3*sin(q1 + q2 + q3 + q4 + q5))/20 - (7*sin(q1 + q2 + q3))/20 - sin(q1 + q2 + q6)/10 - (3*sin(q1 + q2 + q3 + q4))/10 - (9*sin(q1 + q2))/20, - (3*sin(q1 + q2 + q3 + q4 + q5))/20 - (7*sin(q1 + q2 + q3))/20 - (3*sin(q1 + q2 + q3 + q4))/10, - (3*sin(q1 + q2 + q3 + q4 + q5))/20 - (3*sin(q1 + q2 + q3 + q4))/10, -(3*sin(q1 + q2 + q3 + q4 + q5))/20, -sin(q1 + q2 + q6)/10;
   (7*cos(q1 + q2 + q3))/20 + cos(q1 + q2 + q6)/10 + (3*cos(q1 + q2 + q3 + q4))/10 + (9*cos(q1 + q2))/20 + cos(q1)/2 + (3*cos(q1 + q2 + q3 + q4 + q5))/20,   (7*cos(q1 + q2 + q3))/20 + cos(q1 + q2 + q6)/10 + (3*cos(q1 + q2 + q3 + q4))/10 + (9*cos(q1 + q2))/20 + (3*cos(q1 + q2 + q3 + q4 + q5))/20,   (7*cos(q1 + q2 + q3))/20 + (3*cos(q1 + q2 + q3 + q4))/10 + (3*cos(q1 + q2 + q3 + q4 + q5))/20,   (3*cos(q1 + q2 + q3 + q4))/10 + (3*cos(q1 + q2 + q3 + q4 + q5))/20,  (3*cos(q1 + q2 + q3 + q4 + q5))/20,  cos(q1 + q2 + q6)/10;
                                                                                                                                                       0,                                                                                                                                            0,                                                                                               0,                                                                    0,                                   0,                     0];
 
end