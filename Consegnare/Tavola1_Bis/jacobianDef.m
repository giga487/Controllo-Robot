%Jacobian definition

clc

syms t real
x = sym('x',[6,1],'real');
syms x1(t) x2(t) x3(t) x4(t) x5(t) x6(t) real
syms d_x1 d_x2 d_x3 d_x4 d_x5 d_x6 real
syms y1 y2 real

% x = [x1(t),x2(t),x3(t),x4(t),x5(t),x6(t)]'

[p,com,head] = Direct_Kinematics(param,x);

xt = [x1(t),x2(t),x3(t),x4(t),x5(t),x6(t)];

J_hand = jacobian(p(6,1:3),x);

pinvJh = pinv(J_hand)

J_hand = subs(J_hand,x',xt);
d_Jhand = diff(J_hand,t);
d_Jhand = subs(d_Jhand,diff(x1(t), t),d_x1);
d_Jhand = subs(d_Jhand,diff(x2(t), t),d_x2);
d_Jhand = subs(d_Jhand,diff(x3(t), t),d_x3);
d_Jhand = subs(d_Jhand,diff(x4(t), t),d_x4);
d_Jhand = subs(d_Jhand,diff(x5(t), t),d_x5);
d_Jhand = subs(d_Jhand,diff(x6(t), t),d_x6);
d_Jhand = subs(d_Jhand,xt,x');