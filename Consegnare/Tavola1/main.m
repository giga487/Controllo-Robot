%% All'interno di questo file viene:
%1) generata la dinamica del sistema con le matrici B C G
%2) generata la cinematica diretta
%3) generata la configurazione dei giunti che portano il robot in una
%   configurazione dello spazio operativo desiderata attraverso
%   l'inversione differenziale della cinematica
%4) Plot della configurazione che deve avere il robot



%% il problema viene visto attualmente come statico, non c'è ruota.

param = [a1,a2,a3,a4,a5,a_head,0;
         m1,m2,m3,m4,m5,m_head,m_mot];

param = param';



%% JacobianCorretto

JacobianCorretto

%% 
calcJacobianAna

%%

x_com = 0;
y_com = 1;
z_com = 0;
com_des = [x_com,y_com,z_com]';

x_head = 1;
y_head = 1.866;
z_head = 0;
head_des = [x_head,y_head,z_head]';

x_hand = -1;
y_hand = 1;
z_hand = 0;
hand_des = [x_hand,y_hand,z_hand]';

x1 = 30*pi/180;
x2 = 120*pi/180;
x3 = -60*pi/180;
x4 = 90*pi/180;
x5 = 90*pi/180;
x6 = -90*pi/180;

cond_init = [x1,x2,x3,x4,x5,x6]';

plot_configurazione(param,[x1,x2,x3,x4,x5,x6]',com_des,hand_des,head_des);

%% Utilizzo della cinematica inversa per trovare q_d
% Task Secondari Mediante Proiezione nel Null Space

q_now = find_solution_joint(param,com_des,head_des,hand_des);

% plot_robot_fix(param,qd,com_des,hand_des,head_des);
%% plotto la posizione

plot_configurazione(param,q_now(:,end),com_des,hand_des,head_des);

%%
q_position = 1.0e+03 *[1.5097;
    0.3701;
   -3.4740;
   -0.0791;
   -0.1196;
   -1.8346];

% q_position_2 = mod(q_position(:),2*pi);
% q_position_2 = [x1,x2,x3,x4,pi/3,x6]';
q_position_2 = [x1+pi/3*0.5,x2-pi/3,x3+pi/3*0.5,x4+pi/3*0.5,pi/3,x6]';

[p,com_d,head_r_d] = Direct_Kinematics(param,q_position_2);

hand_des = p(6,:)';

plot_configurazione(param,q_position_2,com_d,hand_des,head_r_d);

%%

t0 = 0;
tf = 10;
v_zero = zeros(size(q_position,1),1)

[a3,a2,a1,a0] = createTraj3(cond_init(:),q_position_2(:),v_zero,v_zero,t0,tf);
N_sample = 200;
p = [a3,a2,a1,a0];
% Create time vector
t = linspace(t0,tf,N_sample);

Ts = (tf-t0)/N_sample

for i = 1:1:size(p,1)
    % Evaluate the polynomial : Position
    pos(i,:) = polyval(p(i,:),t);
    % calculate the first derivative : Velocity
    pd = polyder(p(i,:));
    % Evaluate the velocity
    vel(i,:) = polyval(pd,t);
    % calculate the second derivative : Acceleration
    pdd = polyder(pd);
    % Evaluate the acceleration
    acc(i,:) = polyval(pdd,t);
    
    str_e = sprintf('q%i',i);
    
    figure;
    plot(t,pos(i,:),'--+r'); hold on
    plot(t,vel(i,:),'--og'); 
    plot(t,acc(i,:),'--xb'); 
    title(str_e)
    legend('q','dq','ddq');
    grid
    hold off;

end
% plot

Law = [100,5]


%% 

q_position_sim = q_sim.signals.values(:,:);
q_error_sim = error_sim.signals.values(:,:);

% q_position_2 = mod(q_position(1),2*pi);

plot_robot_fix(param,q_position_sim',com_d,hand_des,head_r_d);



