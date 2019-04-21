
g = (9.8);
Mw = (0.03);
m = (2);
r = (0.04);
l = (0.1);
Jw = (3.17*10^-5);
Jtheta = (0.003);
Jdelta = (0.002);
D = (0.17);

syms g Mw m r l Jw Jtheta Jdelta D Tw Tv alfa Q P Beta real

% P = m*l^2 +Jtheta;
% Q = 2*Mw + 2*Jw/r^2 + m;
% alfa = D^2*(2*Mw + 2*Jw/r^2) + Jdelta;
% Beta = P*Q-(m*l*cos(x(3)))^2;


x = sym('x', [6 1], 'real'); % state
dx = sym('dx', [6 1], 'real'); % state
% x(3) = 0;

B = ([alfa+m*l^2*(sin(x(3)))^2,0,0;
     0 , Q*r, m*l*r*cos(x(3));
     0, m*l*r*cos(x(3)), P]);

C = ([-m*l^2*sin(2*x(3))*x(6),0,0;
      0,0,-m*l*r*sin(x(3))*x(6);
     -0.5*m*(l^2)*sin(2*x(3))*x(4),0,0]);
 
G = [0;
     0;
    -m*g*l*sin(x(3))];


F = [-D/r,D/r;
      r/2,r/2;
       -1, -1];

%% Sys

F_sys = simplify(vpa([x(4);x(5);x(6);-B\(C*[x(4);x(5);x(6)]+G)],2));
G_sys = simplify(vpa([zeros(3,2);B\F]*[Tw;Tv],2));
