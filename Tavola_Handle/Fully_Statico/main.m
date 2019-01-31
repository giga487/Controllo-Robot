%% il problema viene visto attualmente come statico, non c'è ruota.

close all
clc
clear all
addpath('Utils');


x1 = 0;
x2 = 0;
x3 = 0;
x4 = 0;
x5 = 0;
x6 = 0;

[p,com,head] = Direct_Kinematics(x1,x2,x3,x4,x5,x6);

figure;
hold on;
plot(p(1:6,1),p(1:6,2),'o-');grid on; axis equal
plot([p(3,1) head(1,1)],[p(3,2) head(2,1)],'k');
viscircles([head(1,1),head(2,1)],0.3);
viscircles([com(1),com(2)],0.1);
hold off;