%% CONTROLLO DI COPPIA
% DEFINIZIONE DEI PARAMETRI DELLA SIMULAZIONE

param = [a1,a2,a3,a4,a5,a_head,0;
         m1,m2,m3,m4,m5,m_head,m_mot];

param = param';

% Condizioni iniziali dei giunti del robot
x1 = 30*pi/180;
x2 = 120*pi/180;
x3 = -60*pi/180;
x4 = 90*pi/180;
x5 = 90*pi/180;
x6 = -90*pi/180;
cond_init = [x1,x2,x3,x4,x5,x6]';

% Costruzione del punto desiderato da raggiungere.
q_position_2 = [x1+pi/3*0.5,x2-pi/3,x3+pi/3*0.5,x4+pi/3*0.5,pi/3,x6]';

[p,com_d,head_r_d] = Direct_Kinematics(param,q_position_2);
hand_des = p(6,:)';

Law_param = [0.2 2];
q_desiderata = q_position_2;

T = 100;

%% TRAIETTORIA

A = [1,0,0,0,0,0];
f = [10,10,10,10,10,10];


%% SIMULAZIONE

sim('controlloCoppia_handle_statico',T)

%% 

q_position_sim = q_sim_CompTorque.signals.values(:,:);
time = q_sim_CompTorque.time;
q_error_sim = error_sim_CompTorque.signals.values(:,:);

% plot_robot_fix(param,q_position_sim',com_d,hand_des,head_r_d);
plot_error(q_error_sim,time);