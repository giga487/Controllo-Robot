%% il problema viene visto attualmente come statico, non c'è ruota.

x1 = 0;
x2 = 0;
x3 = 0;
x4 = 0;
x5 = 0;
x6 = 0;

param = [a1,a2,a3,a4,a5,a_head;
         m1,m2,m3,m4,m5,m_head];

[p,com,head] = Direct_Kinematics(param',x1,x2,x3,x4,x5,x6);

plot_robot_fix(p,com,head);

