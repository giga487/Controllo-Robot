%% il problema viene visto attualmente come statico, non c'è ruota.

x1 = 0;
x2 = 0;
x3 = 0;
x4 = 0;
x5 = 0;
x6 = 0;

param = [a1,a2,a3,a4,a5,a_head,0;
         m1,m2,m3,m4,m5,m_head,m_mot];

param = param';




%% JacobianCorretto

JacobianCorretto

%% 
calcJacobianAna

%% Utilizzo della cinematica inversa per trovare q_d
x_com = -0.266;
y_com = 0.574;
z_com = 0;
com_des = [x_com,y_com,z_com];

x_head = 0;
y_head = 0.5;
z_head = 0;
head_des = [x_head,y_head,z_head];

x_hand = -1;
y_hand = 1;
z_hand = 0;
hand_des = [x_hand,y_hand,z_hand];

qd = find_solution_joint(param,com_des,head_des,hand_des);

%% launch sim
Law_param = [-0.1, -0.5];

sim('pid_handle_statico',9)

%% 

x1 = 30*pi/180;
x2 = 120*pi/180;
x3 = -60*pi/180;
x4 = 90*pi/180;
x5 = 90*pi/180;
x6 = -90*pi/180;

[p,com,head] = Direct_Kinematics(param,[x1,x2,x3,x4,x5,x6]');
plot_robot_fix(p,com,head);
