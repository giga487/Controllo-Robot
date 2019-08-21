%Init

close all
clc
clear
addpath('Utils');
addpath('traj')

m1 = 1;
m2 = 1;
m3 = 1;
m4 = 3;
m5 = 3;
m_head = 1;
m_mot = 0.25;

a1 = 1;
a2 = 1;
a3 = 1;
a4 = 1;
a5 = 1;
a_head = 1;

param = [a1,a2,a3,a4,a5,a_head,0;
         m1,m2,m3,m4,m5,m_head,m_mot];

param = param';
