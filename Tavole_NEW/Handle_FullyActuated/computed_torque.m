
%computed torque in operative frame


dq = [0,0,0,0,0,0]';

q = cond_init;
dd_p = [0,0,0]';

[B,C,G] = Dinamica(param,q,dq);


J_hand = J_hand_fun(q);
J_lessT = pinv(J_hand');
d_J_hand = jacobian_derivative(q,dq);
Mx = J_lessT*B*pinv(J_hand);
Hx = J_lessT*(C*dq+G)-Mx*d_J_hand*dq;
F = Mx*(dd_p) + Hx;
tau = (J_hand')*F