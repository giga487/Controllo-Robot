

syms q1(t) d_q1 q2(t) d_q2(t) q3(t) q4(t) q5(t) d_q2 d_q3 d_q4 d_q5


f = cos(q1 + q2)

d_f = diff(f,t)

d_f = subs(diff(f,t),diff(q1(t), t),d_q1)
d_f = subs(d_f, diff(q2(t), t),d_q2)


J_hand = [ - sin(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)) - sin(q1(t) + q2(t) + q3(t)) - sin(q1(t) + q2(t) + q3(t) + q4(t)) - sin(q1(t) + q2(t)) - sin(q1(t)), - sin(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)) - sin(q1(t) + q2(t) + q3(t)) - sin(q1(t) + q2(t) + q3(t) + q4(t)) - sin(q1(t) + q2(t)), - sin(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)) - sin(q1(t) + q2(t) + q3(t)) - sin(q1(t) + q2(t) + q3(t) + q4(t)), - sin(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)) - sin(q1(t) + q2(t) + q3(t) + q4(t)), -sin(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)), 0;
             cos(q1(t) + q2(t) + q3(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t)) + cos(q1(t) + q2(t)) + cos(q1(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)),   cos(q1(t) + q2(t) + q3(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t)) + cos(q1(t) + q2(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)),   cos(q1(t) + q2(t) + q3(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)),   cos(q1(t) + q2(t) + q3(t) + q4(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)),  cos(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)), 0;
                                                                                                   0,                                                                                         0,                                                                          0,                                                      0,                            0, 0];

d_q = [d_q1,d_q2,d_q3, d_q4, d_q5]
d_q_da_sost = [diff(q1(t), t),diff(q2(t), t),diff(q3(t), t), diff(q4(t), t), diff(q5(t), t)]

d_1 = diff(- sin(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)),t)
d_1 = subs(d_1, d_q_da_sost,d_q)

J_hand = [ - sin(q1 + q2 + q3 + q4 + q5) - sin(q1 + q2 + q3) - sin(q1 + q2 + q3 + q4) - sin(q1 + q2) - sin(q1), - sin(q1 + q2 + q3 + q4 + q5) - sin(q1 + q2 + q3) - sin(q1 + q2 + q3 + q4) - sin(q1 + q2), - sin(q1 + q2 + q3 + q4 + q5) - sin(q1 + q2 + q3) - sin(q1 + q2 + q3 + q4), - sin(q1 + q2 + q3 + q4 + q5) - sin(q1 + q2 + q3 + q4), -sin(q1 + q2 + q3 + q4 + q5), 0;
   cos(q1 + q2 + q3) + cos(q1 + q2 + q3 + q4) + cos(q1 + q2) + cos(q1) + cos(q1 + q2 + q3 + q4 + q5),   cos(q1 + q2 + q3) + cos(q1 + q2 + q3 + q4) + cos(q1 + q2) + cos(q1 + q2 + q3 + q4 + q5),   cos(q1 + q2 + q3) + cos(q1 + q2 + q3 + q4) + cos(q1 + q2 + q3 + q4 + q5),   cos(q1 + q2 + q3 + q4) + cos(q1 + q2 + q3 + q4 + q5),  cos(q1 + q2 + q3 + q4 + q5), 0;
                                                                                                   0,                                                                                         0,                                                                          0,                                                      0,                            0, 0];
                                                                                              
d_J = diff(J_hand,t);
d_J = subs(d_J, d_q_da_sost, d_q);
 
d_J = subs(d_J, [q1(t),q2(t),q3(t),q4(t),q5(t)] , [q1,q2,q3,q4,q5])