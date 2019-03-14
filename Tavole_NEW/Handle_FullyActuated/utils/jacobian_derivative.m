
function d_J = jacobian_derivative()

    syms q1(t) q2(t) q3(t) q4(t) q5(t)

    J_hand = [ - sin(q1(t) + q2(t) + q3(t) + q4(t) + q5) - sin(q1(t) + q2(t) + q3(t)) - sin(q1(t) + q2(t) + q3(t) + q4(t)) - sin(q1(t) + q2(t)) - sin(q1(t)), - sin(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)) - sin(q1(t) + q2(t) + q3(t)) - sin(q1(t) + q2(t) + q3(t) + q4(t)) - sin(q1(t) + q2(t)), - sin(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)) - sin(q1(t) + q2(t) + q3(t)) - sin(q1(t) + q2(t) + q3(t) + q4(t)), - sin(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)) - sin(q1(t) + q2(t) + q3(t) + q4(t)), -sin(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)), 0;
                 cos(q1(t) + q2(t) + q3(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t)) + cos(q1(t) + q2(t)) + cos(q1(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)),   cos(q1(t) + q2(t) + q3(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t)) + cos(q1(t) + q2(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)),   cos(q1(t) + q2(t) + q3(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)),   cos(q1(t) + q2(t) + q3(t) + q4(t)) + cos(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)),  cos(q1(t) + q2(t) + q3(t) + q4(t) + q5(t)), 0;
                                                                                                   0,                                                                                         0,                                                                          0,                                                      0,                            0, 0];
                                                                                               
    J_dot = diff(J_hand,t)
end