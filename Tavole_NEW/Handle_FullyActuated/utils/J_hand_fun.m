function J_hand = J_hand_fun(q)

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
q5 = q(5);
q6 = q(6);

J_hand = [ - sin(q1 + q2 + q3 + q4 + q5) - sin(q1 + q2 + q3) - sin(q1 + q2 + q3 + q4) - sin(q1 + q2) - sin(q1), - sin(q1 + q2 + q3 + q4 + q5) - sin(q1 + q2 + q3) - sin(q1 + q2 + q3 + q4) - sin(q1 + q2), - sin(q1 + q2 + q3 + q4 + q5) - sin(q1 + q2 + q3) - sin(q1 + q2 + q3 + q4), - sin(q1 + q2 + q3 + q4 + q5) - sin(q1 + q2 + q3 + q4), -sin(q1 + q2 + q3 + q4 + q5), 0;
   cos(q1 + q2 + q3) + cos(q1 + q2 + q3 + q4) + cos(q1 + q2) + cos(q1) + cos(q1 + q2 + q3 + q4 + q5),   cos(q1 + q2 + q3) + cos(q1 + q2 + q3 + q4) + cos(q1 + q2) + cos(q1 + q2 + q3 + q4 + q5),   cos(q1 + q2 + q3) + cos(q1 + q2 + q3 + q4) + cos(q1 + q2 + q3 + q4 + q5),   cos(q1 + q2 + q3 + q4) + cos(q1 + q2 + q3 + q4 + q5),  cos(q1 + q2 + q3 + q4 + q5), 0;
                                                                                                   0,                                                                                         0,                                                                          0,                                                      0,                            0, 0];
 

end