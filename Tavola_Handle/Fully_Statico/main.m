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

% [p,com,head] = Direct_Kinematics(param,x1,x2,x3,x4,x5,x6);


%% JacobianCorretto

JacobianCorretto
calcJacobianAna

%% Utilizzo della cinematica inversa per trovare q_d
x = 1;
y = 1;
z = 0;

position = [x,y,z];

qd = find_solution_joint(param,position);

%% launch sim
Law_param = [-0.1, -0.5];

sim('pid_handle_statico',9)

%% 
plot_robot_fix(p,com,head,hand);
