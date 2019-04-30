
clc
clear
close all

x = sym('x', [7 1], 'real'); % state
% f2 = sym('f2', [3 1], 'real'); % f
g1 = sym('g1', [6 1], 'real'); % state

g_1 = [0;0;0;0;0;0;0];
g_2 = [0;0;0;0;0;0;1];

syms H D cz Mb R g Iwa Mw Ka Iyy Ixx Izz G real
f2(1) = sin(2*x(4))*((x(7))^2)*H/D+ (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(2*x(4))*x(5)^2/D;
f2(3) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

A = Mb*R^2 + 2*Mw*R^2 + 2*Iwa + Mb*cos(x(4))*cz*R;
B = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2);

g_1 = [0;0;0;0;A;B;0];

f = [x(6)*cos(x(3));
     x(6)*sin(x(3));
     x(7);
     x(5);
     f2(:)];    
     

%% Studio Controllabilità

D0 = rank([g_1,g_2]);

adfg1 = liebracket(f,g_1,x,1);
adfg2 = liebracket(f,g_2,x,1);

Delta = [adfg1(:,2),adfg2(:,2)];

dimDelta = rank([adfg1,adfg2]);
disp ([ 'la dim. di Delta4 è: '  num2str(dimDelta)]);

%%Osservabilità