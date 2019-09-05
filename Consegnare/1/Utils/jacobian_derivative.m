
function d_J = jacobian_derivative(q,dq)

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
q5 = q(5);

d_q1 = dq(1);
d_q2 = dq(2);
d_q3 = dq(3);
d_q4 = dq(4);
d_q5 = dq(5);

 
d_J = ...
    [ - d_q1*cos(q1) - cos(q1 + q2)*(d_q1 + d_q2) - cos(q1 + q2 + q3)*(d_q1 + d_q2 + d_q3) - cos(q1 + q2 + q3 + q4)*(d_q1 + d_q2 + d_q3 + d_q4) - cos(q1 + q2 + q3 + q4 + q5)*(d_q1 + d_q2 + d_q3 + d_q4 + d_q5), - cos(q1 + q2)*(d_q1 + d_q2) - cos(q1 + q2 + q3)*(d_q1 + d_q2 + d_q3) - cos(q1 + q2 + q3 + q4)*(d_q1 + d_q2 + d_q3 + d_q4) - cos(q1 + q2 + q3 + q4 + q5)*(d_q1 + d_q2 + d_q3 + d_q4 + d_q5), - cos(q1 + q2 + q3)*(d_q1 + d_q2 + d_q3) - cos(q1 + q2 + q3 + q4)*(d_q1 + d_q2 + d_q3 + d_q4) - cos(q1 + q2 + q3 + q4 + q5)*(d_q1 + d_q2 + d_q3 + d_q4 + d_q5), - cos(q1 + q2 + q3 + q4)*(d_q1 + d_q2 + d_q3 + d_q4) - cos(q1 + q2 + q3 + q4 + q5)*(d_q1 + d_q2 + d_q3 + d_q4 + d_q5), -cos(q1 + q2 + q3 + q4 + q5)*(d_q1 + d_q2 + d_q3 + d_q4 + d_q5), 0;
      - sin(q1 + q2 + q3 + q4 + q5)*(d_q1 + d_q2 + d_q3 + d_q4 + d_q5) - d_q1*sin(q1) - sin(q1 + q2)*(d_q1 + d_q2) - sin(q1 + q2 + q3)*(d_q1 + d_q2 + d_q3) - sin(q1 + q2 + q3 + q4)*(d_q1 + d_q2 + d_q3 + d_q4), - sin(q1 + q2 + q3 + q4 + q5)*(d_q1 + d_q2 + d_q3 + d_q4 + d_q5) - sin(q1 + q2)*(d_q1 + d_q2) - sin(q1 + q2 + q3)*(d_q1 + d_q2 + d_q3) - sin(q1 + q2 + q3 + q4)*(d_q1 + d_q2 + d_q3 + d_q4), - sin(q1 + q2 + q3 + q4 + q5)*(d_q1 + d_q2 + d_q3 + d_q4 + d_q5) - sin(q1 + q2 + q3)*(d_q1 + d_q2 + d_q3) - sin(q1 + q2 + q3 + q4)*(d_q1 + d_q2 + d_q3 + d_q4), - sin(q1 + q2 + q3 + q4 + q5)*(d_q1 + d_q2 + d_q3 + d_q4 + d_q5) - sin(q1 + q2 + q3 + q4)*(d_q1 + d_q2 + d_q3 + d_q4), -sin(q1 + q2 + q3 + q4 + q5)*(d_q1 + d_q2 + d_q3 + d_q4 + d_q5), 0;
    0,0,0,0,0,0];
 
                                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                   
end