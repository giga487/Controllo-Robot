
clc
clear
close all

% Inverted Pendulum 

syms Mb R Mw Iwa cz Iyy H D g Ka Ixx Izz G
x = sym('x', [7 1], 'real');
%x = x y  theta alpha d_alpha v d_theta  

g15 = Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(4))*cz*R;
g16 = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2);

g1 = [0;0;0;0;g15;g16;0];
g2 = [0;0;0;0;0;0;1];

f1 = [x(6)*cos(x(3));
         x(6)*sin(x(3));
         x(7);
         x(5)];

f2(1,1) = sin(2*x(4))*((x(7))^2)*H/D + (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2,1) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(2*x(4))*x(5)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

f = [f1;f2]
y = [x(3); x(4)];

%% FeedBack Linearization

f_feedbackLaw = [f(1,1);
                 f(2,1);
                 f(3,1);
                 f(4,1);
                 0;
                 f2(2,1)-g16/g15*f2(1,1);
                 0];

g1_feedbackLaw = [0;0;0;0;0;0;1];
g2_feedbackLaw = [0;0;0;0;1;g16/g15;0];

adf2g = liebracket(f_feedbackLaw,g1_feedbackLaw,x,1)     



