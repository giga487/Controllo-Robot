
clear
syms q1 q2 q3 q4 a1 a2 a3 a4 alfa4 alfa1 alfa2 alfa3 L1 L2 L3 d1 d2 d3 d4real

alfa1 = sym(pi/2);
a1 = 0;
d1 = 0;
A01 = [cos(q1), -sin(q1)*cos(alfa1), sin(q1)*sin(alfa1), a1*cos(q1);
     sin(q1), cos(q1)*cos(alfa1), -cos(q1)*sin(alfa1), a1*sin(q1);
        0   , sin(alfa1), cos(alfa1), d1;
        0 , 0,0,1]
    
alfa2 = 0;
d2 = 0;
%a2 è la distanza fra i 2 giunti.

A12 = [cos(q2), -sin(q2)*cos(alfa2), sin(q2)*sin(alfa2), a2*cos(q2);
       sin(q2), cos(q2)*cos(alfa2), -cos(q2)*sin(alfa2), a2*sin(q2);
        0   , sin(alfa2), cos(alfa2), d2;
        0 , 0,0,1];
    
alfa3 = 0;
d3 = 0;
A23 = [cos(q3), -sin(q3)*cos(alfa3), sin(q3)*sin(alfa3), a3*cos(q3);
       sin(q3), cos(q3)*cos(alfa3), -cos(q3)*sin(alfa3), a3*sin(q3);
        0   , sin(alfa3), cos(alfa3), d3;
        0 , 0,0,1];
    
alfa4 = 0;
d4 = 0;

A34 = [cos(q4), -sin(q4)*cos(alfa4), sin(q4)*sin(alfa4), a4*cos(q4);
       sin(q4), cos(q4)*cos(alfa4), -cos(q4)*sin(alfa4), a4*sin(q4);
        0   , sin(alfa4), cos(alfa4), d4;
        0 , 0,0,1];


A = simplify(A01*A12*A23*A34)
    